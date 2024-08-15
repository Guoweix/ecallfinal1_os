## 进程管理
进程的状态由Process结构体定义，充分利用C++面向对象的理念，针对单个进程的操作都尽可能由方法实现。
### Process
```cpp
class Process {
    friend ProcessManager;
    friend Semaphore;
    friend FileObjectManager;
public:
    ClockTime timeBase; // Round Robin时间片轮转调度实现需要 计时起点
    ClockTime runTime; // 进程运行的时间
    ClockTime
        trapSysTimeBase; // 为用户进程设计的 记录当前陷入系统调用时的起始时刻
    ClockTime sysTime; // 为用户设计的时间 进行系统调用陷入核心态的时间
    ClockTime sleepTime; // 挂起态等待时间 wait系统调用会更新
                         // 其他像时间等系统调用会使用
    ClockTime waitTimeLimit; // 进程睡眠需要 设置睡眠时间的限制
                             // 当sleeptime达到即可自唤醒
    ClockTime readyTime; // 就绪态等待时间(保留设计 暂不使用)
    Uint32 SemRef; // wait的进程数

    PID id;//pid 从0开始计数
    ProcessManager* pm;//与之相关联的进程管理器
    ProcStatus status;//进程状态
    void* stack;//进程的内核栈
    Uint32 stacksize;
    VirtualMemorySpace* VMS;//虚拟内存管理
    file_object* fo_head;//文件object拥有通过文件描述符管理文件，实际是一个打开文件的链表

public:
    // 关于父节点及子节点的链接
    Process* father;
    Process* broPre;
    Process* broNext;
    Process* fstChild;

private:
    
    char* curWorkDir;//工作路径
    Semaphore* waitSem;//进程专属信号量
    HeapMemoryRegion* Heap;//进程的堆区
    TrapFrame* context;//上下文
    Uint64 flags;//表示进程的状态，如用户态还是内核态，同时可以实现自动内存回收
    char name[PROC_NAME_LEN];//进程名称
    Uint32 nameSpace;
    Uint32 exitCode;//结束返回值
//... 剩余方法就不再赘述了
}

```
其中进程分为8个状态，用于描述进程的生命周期
```cpp 
enum ProcStatus : Uint32 {
    S_None = 0,
    S_Allocated,
    S_Initing,
    S_Ready,
    S_Running,
    S_UserRunning,
    S_Sleeping,
    S_Terminated,

};
```
进程获得空间为allocated状态，initing为正在初始化状态，防止其他进程打断该状态。start和init函数会使进程转化为Ready为可调度状态，schedule会调度ready状态的进程，被调度的进程转化为Running态， UerRunning为用户运行态用于和内核进程区分。wait操作后转为Sleep挂起态，进程exit后则为Terminal僵死态，最后再次被回收资源destroy后回归None的状态.
### ProcessManager
在管理众多进程中Process暂时使用了数组进行管理，使得分配进程和释放进程都变得极为简单。
在进程管理的核心则是调度算法，使用了简单的时间片流转算法。

```cpp
TrapFrame* ProcessManager::Schedule(TrapFrame* preContext)
{
    Process* tar;

    kout[Debug] << "Schedule NOW  "<< curProc->getName() << endl;
    curProc->context = preContext;//记录当前状态，防止只有一个进程但是触发调度，导致进程号错乱
    // kout<<Blue<<procCount<<endl;
    if (curProc != nullptr && procCount >= 2) {
        int i, p;
        ClockTime minWaitingTarget = -1;
    RetrySchedule:
        for (i = 1, p = curProc->id; i < MaxProcessCount; ++i) {
            tar = &Proc[(i + p) % MaxProcessCount];
            // if (tar->status == S_Sleeping && NotInSet(tar->SemWaitingTargetTime, 0ull, (Uint64)-1)) {//Sleep的休眠时间管理，目前还未实现
            //     minWaitingTarget = minN(minWaitingTarget, tar->SemWaitingTargetTime);
            //     if (GetClockTime() >= tar->SemWaitingTargetTime)
            //         tar->SwitchStat(Process::S_Ready);
            // }
            // kout<<p<<"P+i "<<(p+i)%MaxProcessCount<<tar->status<<endl;
            // pm.show();
            if (tar->status == S_Ready) {//如果是ready态则进行切换
                tar->getVMS()->showVMRCount();
                tar->run();
                return tar->context;
            } else if (tar->status == S_Terminated && (tar->flags & F_AutoDestroy))//如果为自动销毁且为僵死态则进行销毁
                tar->destroy();
        }
    }

    return pm.getKernelProc()->context;//如果没有任何调度则进入内核态，防止出错
}

```
此进程管理器的精髓在与传入TrapFrame和返回TrapFrame,使用同样的a0去修改TrapFrame,对于中断来说，如果不去更改a0则是中断，而更改a0则是调度，使用了相同的接口去实现不同的状态
<p align="right">By:郭伟鑫</p>