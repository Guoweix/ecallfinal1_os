#include "Library/KoutSingle.hpp"
#include "Trap/Trap.hpp"
#include <Process/Process.hpp>
#include <Trap/Syscall/Syscall.hpp>
#include <Trap/Syscall/SyscallID.hpp>
#include <Trap/Clock.hpp>


extern bool needSchedule;

void Syscall_Exit(TrapFrame* tf, int re)
{
    Process* cur = pm.getCurProc();
    // kout<<"SDAD"<<re<<endl;
    cur->exit(re);
    needSchedule=true; 
    // kout[Fault] << "Syscall_Exit: Reached unreachable branch" << endl;
}

int Syscall_getpid(){
    // 获取进程PID的系统调用
    // always successful

    Process* cur_proc = pm.getCurProc();
    return cur_proc->getID();
}

int Syscall_getppid()
{
    // 获取父进程PID的系统调用
    // 直接成功返回父进程的ID
    // 根据系统调用规范此调用 always successful

    Process* cur_proc = pm.getCurProc();
    Process* fa_proc = cur_proc->father;
    if (fa_proc == nullptr)
    {
        // 调用规范总是成功
        // 如果是无父进程 可以认为将该进程挂到根进程的孩子进程下
        return pm.getidle()->getID();
    }
    else
    {
        return fa_proc->getID();
    }
    return -1;
}

struct tms
{
    long tms_utime;                 // user time
    long tms_stime;                 // system time
    long tms_cutime;                // user time of children
    long tms_sutime;                // system time of children
};

Uint64 Syscall_times(tms* tms)
{
    // 获取进程时间的系统调用
    // tms结构体指针 用于获取保存当前进程的运行时间的数据
    // 成功返回已经过去的滴答数 即real time
    // 这里的time基本即指进程在running态的时间
    // 系统调用规范指出为花费的CPU时间 故仅考虑运行时间
    // 而对于running态时间的记录进程结构体中在每次从running态切换时都会记录
    // 对于用户态执行的时间不太方便在用户态记录
    // 这里我们可以认为一个用户进程只有在陷入系统调用的时候才相当于在使用核心态的时间
    // 因此我们在每次系统调用前后记录本次系统调用的时间并加上
    // 进而用总的runtime减去这个时间就可以得到用户时间了
    // 记录这个时间的成员在进程结构体中提供为systime

    Process* cur_proc = pm.getCurProc();
    Uint64 time_unit = 10;  // 填充tms结构体的基本时间单位 在qemu上模拟 以微秒为单位
    if (tms != nullptr)
    {
        Uint64 run_time = cur_proc->runTime;    // 总运行时间
        Uint64 sys_time = cur_proc->sysTime;    // 用户陷入核心态的system时间
        Uint64 user_time = run_time - sys_time;                // 用户在用户态执行的时间
        if ((long long)run_time < 0 || (long long)sys_time < 0 || (long long)user_time < 0)
        {
            // 3个time有一个为负即认为出错调用失败了
            // 返回-1
            return -1;
        }
        cur_proc->VMS->EnableAccessUser();                      // 在核心态操作用户态的数据
        tms->tms_utime = user_time / time_unit;
        tms->tms_stime = sys_time / time_unit;
        // 基于父进程执行到这里时已经wait了所有子进程退出并被回收了
        // 故直接置0
        tms->tms_cutime = 0;
        tms->tms_sutime = 0;
        cur_proc->VMS->DisableAccessUser();
    }
    return GetClockTime();
}

bool TrapFunc_Syscall(TrapFrame* tf)
{
    kout<<tf->reg.a7<<"______"<<endl;
    switch ((Sint64)tf->reg.a7) {
    
    case 1:
        Putchar(tf->reg.a0);
        break;
    case SYS_Exit:
    case SYS_exit:
        Syscall_Exit(tf, tf->reg.a0);
        break;
    case SYS_write:
        if (tf->reg.a0==1) {
            for (int i=0 ;i< tf->reg.a2;i++){
            Putchar(*((char *)tf->reg.a1+i));
            }
        }
        break;
    case SYS_getpid:
        tf->reg.a0 = Syscall_getpid();
        break;
    case SYS_getppid:
        tf->reg.a0 = Syscall_getppid();
        break;
    case SYS_times:
        tf->reg.a0 = Syscall_times((tms*)tf->reg.a0);
        break;
    default:;
    }

    return true;
}