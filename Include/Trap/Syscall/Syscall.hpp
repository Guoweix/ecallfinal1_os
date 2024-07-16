#ifndef __SYSCALL_HPP__
#define __SYSCALL_HPP__

#include "Types.hpp"
#include <Trap/Syscall/SyscallID.hpp>
#include <Trap/Trap.hpp>

bool TrapFunc_Syscall(TrapFrame* tf);
inline void Syscall_Exit(int re);

struct kstat {
    Uint64 st_dev; // 文件存放的设备ID
    Uint64 st_ino; // 索引节点号
    Uint32 st_mode; // 文件的属性掩码
    Uint32 st_nlink; // 硬链接的数量
    Uint32 st_uid; // 文件拥有者的用户ID
    Uint32 st_gid; // 文件拥有者的组ID
    Uint64 st_rdev; // 设备ID 仅对部分特殊文件有效
    unsigned long __pad;
    int st_size; // 文件大小 单位为字节
    Uint32 st_blksize; // 文件使用的存储块大小
    int __pad2;
    Uint64 st_blocks; // 文件占用的存储块数量
    long st_atime_sec; // 最后一次访问时间 秒
    long st_atime_nsec; // 纳秒
    long st_mtime_sec; // 最后一次修改时间 秒
    long st_mtime_nsec; // 纳秒
    long st_ctime_sec; // 最后一次改变状态的时间 秒
    long st_ctime_nsec; // 纳秒
    unsigned __unused[2];
};

PtrSint Syscall_brk(PtrSint pos);
int Syscalll_mkdirat(int fd, char* filename, int mode);
int Syscalll_chdir(const char* path);
char* Syscall_getcwd(char* buf, Uint64 size);
int Syscall_clone(TrapFrame* tf, int flags, void* stack, int ptid, int tls, int ctid);
int Syscall_wait4(int pid, int* status, int options);
int Syscall_sched_yeild();
int Syscall_fstat(int fd, kstat* kst);

int Syscall_getdents64(int fd, RegisterData _buf, Uint64 bufSize);

int Syscall_umount2(const char* special, int flags);
int Syscall_mount(const char* special, const char* dir, const char* fstype, Uint64 flags, const void* data);

int Syscall_munmap(void* start, Uint64 len);

struct timespec {
    long tv_sec; // 秒
    long tv_nsec; // 纳秒 范围0~999999999
};

int Syscall_nanosleep(timespec* req, timespec* rem);

struct tms {
    long tms_utime; // user time
    long tms_stime; // system time
    long tms_cutime; // user time of children
    long tms_sutime; // system time of children
};

Uint64 Syscall_times(tms* tms);

int Syscall_openat(int fd, const char* filename, int flags, int mode);
int Syscall_linkat(int olddirfd, char* oldpath, int newdirfd, char* newpath, unsigned flags);
int Syscall_unlinkat(int dirfd, char* path, int flags);
inline int Syscall_getpid();
inline int Syscall_getppid();



enum SIGNUM : int {
    SIGHUP = 1,
    SIGINT,
    SIGQUIT,
    SIGILL,
    SIGTRAP,
    SIGABRT,
    SIGFPE,
    SIGKILL,
    SIGUSR1,
    SIGSEGV,
    SIGUSR2,
    SIGPIPE,
    SIGALRM,
    SIGTERM,
    SIGCHLD,
    SIGCONT,
    SIGSTOP,
    SIGTSTP,
    SIGTTIN,
    SIGTTOU,
    SIGURG,
    SIGXCPU,
    SIGXFSZ,
    SIGVTALRM,
    SIGPROF,
    SIGWINCH,
    SIGIO,
    SIGPWR,
    SIGSYS,
};


union sigval {
    int   sival_int;  /* Integer signal value */
    void *sival_ptr;  /* Pointer signal value */
};

typedef union sigval sigval_t;


typedef struct siginfo {
    int si_signo;     /* Signal number */
    int si_errno;     /* An errno value */
    int si_code;      /* Signal code */
    int si_trapno;    /* Trap number that caused hardware-generated signal (unused on most architectures) */
    PID si_pid;     /* Sending process ID */
    UID si_uid;     /* Real user ID of sending process */
    int si_status;    /* Exit value or signal */
    ClockTime si_utime; /* User time consumed */
    ClockTime si_stime; /* System time consumed */
    sigval_t si_value;/* Signal value */
    int si_int;       /* POSIX.1b signal */
    void *si_ptr;     /* POSIX.1b signal */
    int si_overrun;   /* Timer overrun count; POSIX.1b timers */
    int si_timerid;   /* Timer ID; POSIX.1b timers */
    void *si_addr;    /* Memory location which caused fault */
    int si_band;      /* Band event (used for SIGPOLL) */
    int si_fd;        /* File descriptor (used for SIGPOLL) */
} siginfo_t;

struct sigaction {
    void (*sa_handler)(int);    // 信号处理函数指针
    SIGNUM * sa_mask;          // 在信号处理期间要阻塞的其他信号集合
    int sa_flags;              // 信号处理选项标志
    void (*sa_sigaction)(int, siginfo_t *, void *);  // 备用信号处理函数指针
};

int Syscall_sigaction(int signum, const struct sigaction* act, struct sigaction* oldact);

int Syscall_execve(const char* path, char* const argv[], char* const envp[]);

struct iovec {
    void* base;
    Uint64 len;
};

enum class ModeRW {
    Read = 0,
    Write = 1,
    R = 0,
    W = 1
};

#endif
