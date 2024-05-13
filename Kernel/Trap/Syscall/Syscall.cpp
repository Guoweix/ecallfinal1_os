#include "Library/KoutSingle.hpp"
#include "Trap/Syscall/SyscallID.hpp"
#include <Trap/Syscall/Syscall.hpp>

bool TrapFunc_Syscall(TrapFrame* tf)
{
    switch (tf->reg.a7) {
    case 1:
        Putchar(tf->reg.a0);
    }

    return true;
}