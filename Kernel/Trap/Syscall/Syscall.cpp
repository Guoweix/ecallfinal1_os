#include "Library/KoutSingle.hpp"
#include "Trap/Trap.hpp"
#include <Process/Process.hpp>
#include <Trap/Syscall/Syscall.hpp>
#include <Trap/Syscall/SyscallID.hpp>


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
    default:;
    }

    return true;
}