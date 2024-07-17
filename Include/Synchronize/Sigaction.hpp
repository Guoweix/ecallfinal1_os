#ifndef __SIGACTION_HPP__
#define __SIGACTION_HPP__

#include <Types.hpp>



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
    void (*sa_handler)(int); // 信号处理函数指针
    SIGNUM* sa_mask; // 在信号处理期间要阻塞的其他信号集合
    int sa_flags; // 信号处理选项标志
    void (*sa_sigaction)(int, siginfo_t*, void*); // 备用信号处理函数指针
};

void showSigaction(sigaction * t);


struct ListNode_siga {
    sigaction* siga;
    ListNode_siga* next;
};

struct SigactionQueue {
    ListNode_siga* front;
    ListNode_siga* rear;

    void printAllQueue();
    void init();
    void destroy();
    bool isEmpty();
    int length();
    void enqueue(sigaction* insertProc);
    sigaction* getFront();
    void dequeue();
    bool check(sigaction* _check);
};

#endif