# Futex
Futex（Fast Userspace Mutex）是一种用户态和内核态混合的同步机制，对于我们的操作系统来说，Futex起到了关键的同步与并发控制的作用。
## Futex应用场景
Futex主要用于进程间的同步。在这种情况下，需要同步的进程通过共享一段内存，futex变量就位于这段共享的内存中并且其操作是原子的。当进程试图进入或退出临界区的时候，会先去查看共享内存中的futex变量。
如果没有竞争发生（例如没有其他进程试图修改这个futex变量），那么进程只需要修改futex变量，而不必执行系统调用。这样可以避免系统调用带来的开销，从而在没有竞争的情况下提高了效率。
如果有竞争发生（例如有其他进程也试图修改这个futex变量），那么进程会执行系统调用，陷入内核态，由内核来处理竞争。简单的说，Futex通过在用户态的检查，避免了不必要的内核态切换，大大提高了低竞争时的效率。
## Futex系统调用
在我们的操作系统中，futex系统调用是通过`sys_futex()`函数实现的。该函数根据futex操作的类型进行相应的处理，这些类型可以是FUTEX_WAIT、FUTEX_WAKE或FUTEX_REQUEUE。接下来，我们详细介绍这个函数。

### sys_futex函数定义

Uint64 Syscall_futex(Uint64 *uaddr, int op, Uint64 val,struct timespec2 *timeout, Uint64 *uaddr2, Uint64 val3)

这个函数的返回类型是`uint64`，表明它返回一个64位的整型值。它没有任何参数，所有参数通过系统调用接口来传递。

### sys_futex函数参数

`sys_futex()`函数的参数通过系统调用接口来获取，这些参数包括：

1. `uaddr`：这是一个指向futex变量的指针。
2. `futex_op`：这是一个整型数，表示futex操作的类型。
3. `val`：这个参数在不同的futex操作中有不同的含义。在FUTEX_WAIT操作中，它是期望的futex变量的值；在FUTEX_WAKE操作中，它是最多唤醒的线程数；在FUTEX_REQUEUE操作中，它是最多唤醒和重新排队的线程数。
4. `timeout`：这是一个指向`TimeSpec2`结构的指针，表示等待的最大时间。只有在FUTEX_WAIT操作中才使用这个参数。
5. `uaddr2`：这是一个指向futex变量的指针，只有在FUTEX_REQUEUE操作中才使用这个参数。
6. `val3`：这个参数只有在某些特殊的futex操作中才使用，我们的`sys_futex()`函数没有使用这个参数。

### sys_futex函数行为

`sys_futex()`函数首先获取用户态传递来的参数。如果任何一个参数获取失败，那么它会立即返回-1。

然后，它根据futex操作的类型来进行相应的处理：

1. 如果是FUTEX_WAIT操作，那么就调用`futexWait()`函数，让当前线程等待futex变量的值变为期望的值。
2. 如果是FUTEX_WAKE操作，那么就调用`futexWake()`函数，唤醒等待futex变量的线程。
3. 如果是FUTEX_REQUEUE操作，那么就调用`futexRequeue()`函数，将等待一个futex变量的线程重新排队到另一个futex变量上。

如果操作类型不是以上三种，那么`sys_futex()`函数会产生panic，因为它不支持其他类型的操作。

在所有操作完成之后，`sys_futex()`函数返回0，表示系统调用成功。

### sys_futex函数的异常处理

`sys_futex()`函数对各种可能出现的异常进行了处理。如果参数获取失败，那么它会立即返回-1。在FUTEX_WAIT操作中，如果futex变量的值不等于期望的值，那么它也会返回-1。如果操作类型不是支持的类型，那么它会产生panic。这样的异常处理使得`sys_futex()`函数在各种异常情况下都能有正确的行为。

总的来说，`sys_futex()`函数是我们的操作系统AVX512OS中实现futex机制的核心函数。它将复杂的futex操作封装在一个简单的接口中，使得在用户态的进程可以方便地使用futex机制进行同步。
## futex具体实现
在AVX512OS中，我们针对FUTEX_WAIT、FUTEX_WAKE和FUTEX_REQUEUE三种类型的操作进行了处理。在代码实现中，我们定义了一个FutexQueue的队列结构，用于存放处于等待状态的线程信息。

- `addr`: 等待的Futex变量的地址。
- `thread`: 需要等待的线程。
- `valid`: 该队列项是否有效。

```
struct FutexQueue
{
    uint64 addr;
    thread* thread;
    uint8 valid;
} FutexQueue;
```

FutexQueue队列的长度是FUTEX_COUNT，这是我们设定的最大等待线程数量。当线程需要等待一个Futex变量时，它会被加入到这个队列中。

以下是三个函数的具体实现：

### futexWait()

``` c
void futexWait(uint64 addr, thread* th, TimeSpec2* ts);
```

在futexWait函数中，线程首先会在FutexQueue队列中找到一个未被使用的项，然后将自己的信息填入这个项中，并将项标记为已使用。然后根据是否有timeout参数来决定线程的状态。如果有timeout，那么线程的状态将被设为S_Sleeping，并计算出应当唤醒的时间。如果没有timeout，那么线程的状态将被设为S_Sleeping。最后，线程会切换到可运行状态，并调度下一个线程运行。

### futexWake()

``` c
void futexWake(uint64 addr, int n);
```

在futexWake函数中，我们会遍历FutexQueue队列，找到等待给定地址的Futex变量的线程，并将其唤醒，直到唤醒的线程数量达到n个。唤醒一个线程的操作是将其状态设为S_Ready，并将返回值设为0。同时我们还需要将这个FutexQueue队列项标记为未使用。

### futexRequeue()

``` c
void futexRequeue(uint64 addr, int n, uint64 newAddr);
```

futexRequeue函数首先会执行和futexWake一样的操作，唤醒n个等待给定地址的Futex变量的线程。然后，它会遍历FutexQueue队列，找到所有还在等待原来地址的Futex变量的线程，并将它们等待的地址改为newAddr。这样，这些线程在被唤醒时，将会操作newAddr指向的Futex变量。

最后，我们实现了一个futexClear函数，用于清理一个线程的所有等待状态。当线程退出时，我们需要调用这个函数，来避免其他线程在等待一个已经不存在的线程。

``` c
void futexClear(thread* thread);
```

在这个函数中，我们会遍历FutexQueue队列，找到所有等待给定线程的项，并将它们标记为未使用。
总的来说，Futex在EcallFinal1中提供了一种高效的进程同步机制，能够在用户态解决大部分的竞争情况，从而避免了频繁的内核态切换。只有在竞争情况下，才会切换到内核态，由内核来完成竞争的解决。