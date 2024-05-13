#ifndef __SYSCALL_HPP__
#define __SYSCALL_HPP__

#include  <Trap/Trap.hpp>
#include <Trap/Syscall/SyscallID.hpp>

bool TrapFunc_Syscall(TrapFrame *tf);

#endif
