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
    switch ((Sint64)tf->reg.a7) {
    case 1:
        Putchar(tf->reg.a0);
        break;
    case SYS_Exit:
        Syscall_Exit(tf, tf->reg.a0);
        break;
    }

    return true;
}