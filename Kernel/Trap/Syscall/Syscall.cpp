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
    default:;
    }

    return true;
}