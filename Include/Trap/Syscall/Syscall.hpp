#ifndef __SYSCALL_HPP__
#define __SYSCALL_HPP__

#include "Types.hpp"
#include <Trap/Syscall/SyscallID.hpp>
#include <Trap/Trap.hpp>



bool TrapFunc_Syscall(TrapFrame* tf);
inline void Syscall_Exit(int re);

PtrSint Syscall_brk(PtrSint pos);
int Syscalll_mkdirat(int fd,char * filename,int mode);
int Syscalll_chdir(const char * path);
char * Syscall_getcwd(char * buf,Uint64 size);
int Syscall_clone(TrapFrame* tf,int flags,void * stack,int ptid,int tls,int ctid);
int Syscall_wait4(int pid, int* status, int options);
int Syscall_sched_yeild();
inline int Syscall_getpid();
inline int Syscall_getppid();

int Syscall_execve(const char* path, char* const argv[], char* const envp[]);

#endif
