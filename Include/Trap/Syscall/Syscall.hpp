#ifndef __SYSCALL_HPP__
#define __SYSCALL_HPP__

#include <Trap/Syscall/SyscallID.hpp>
#include <Trap/Trap.hpp>


bool TrapFunc_Syscall(TrapFrame* tf);
inline void Syscall_Exit(int re);
inline int Syscall_getpid();
inline int Syscall_getppid();
inline Uint64 Syscall_times(tms* tms);

#endif
