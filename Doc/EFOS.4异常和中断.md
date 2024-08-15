## 异常和中断
### 中断入口和出口
中断的入口和出口均由TrapEntry.S汇编负责，此汇编中有两个函数，分别负责中断的初步处理和中断的退出。
我们设定了一个TrapFrame用于保护现场,定义如下
```cpp
struct RegisterContext // 通用寄存器的上下文
{
    union // 使用联合体，这样既可以按名字访问寄存器，也可以按编号访问寄存器
    {
        RegisterData x[32];
        struct // 按照Risc-V64规范定义的32个寄存器
        {
            RegisterData zero,
                ra, sp, gp, tp,
                t0, t1, t2,
                s0, s1,
                a0, a1, a2, a3, a4, a5, a6, a7,
                s2, s3, s4, s5, s6, s7, s8, s9, s10, s11,
                t3, t4, t5, t6;
        };
    };

    inline RegisterData& operator[](int index)
    {
        return x[index];
    }
};

struct TrapFrame // 一次中断/异常所需要保存的上下文/帧
{
    RegisterContext reg;
    RegisterData status, // 原先的CPU状态
        epc, // 原先的PC寄存器的值，表示程序执行的位置
        tval, // 地址例外中出错的地址、发生非法指令例外的指令本身、其他异常为0
        cause; // 中断/异常原因
};


```
汇编中的SAVE_ALL负责将当前的TrapFrame存到栈中，并且将栈指针传递给Trap.cpp的Trap函数
而RESTORE_ALL则负责从sp中将TrapFrame恢复成为运行的进程。而这是我们调度进程的核心，传入一个TrapFrame传出另一个TrapFrame，这点将在进程处详细讲解。
而TrapEntry.S的另一个特点就是会判断当前中断是在谁处发生的，如果在用户态中断，则将TrapFrame存储到用户对应的内核的栈，防止爆了用户的栈。
### 中断处理核心
中断服务函数的核心则是在Trap.cpp中的Trap函数，这个函数在每次进入的时候记录一个是否要调度的变量（needSchedule），对传入的TrapFrame中的a7，判断当前应该响应什么服务，最后返回的时候查看needSchedule变量去判断是否要进行调度。
这个函数最核心的思想是将所有中断和异常均使用相同的入口去处理，而使用switch统一管理，极大的简化了中断处理的流程，为后期处理syscall建立的基础

<p align="right">By:郭伟鑫</p>