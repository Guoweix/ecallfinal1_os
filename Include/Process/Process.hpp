#ifndef __PROCESS_HPP__
#define __PROCESS_HPP__

// #include <File/FileObject.hpp>
#include <Library/KoutSingle.hpp>
#include <Memory/pmm.hpp>
#include <Memory/vmm.hpp>
#include <Synchronize/Sigaction.hpp>
#include <Synchronize/SpinLock.hpp>
#include <Trap/Syscall/Syscall.hpp>
#include <Trap/Trap.hpp>
#include <Types.hpp>

#define PROC_NAME_LEN 50 // 进程名字
#define UserPageSize 12 * PAGESIZE // 用户页大小

const Uint32 MaxProcessCount = 128; // 最大进程数量
const PtrSint InnerUserProcessLoadAddr = 0x800020, // 进程加载地址
    InnerUserProcessStackSize = PAGESIZE * 32, // 所有进程栈空间大小
    InnerUserProcessStackAddr = 0x80000000 - InnerUserProcessStackSize; // 栈起始地址

// class VMM;
class Semaphore; // 信号量
class FileObjectManager;

// struct RegContext { //     RegisterData ra, sp, s[12]; // };
class file_object;

inline RegisterData GetCPUID() // 读取CPU ID到寄存器
{
    RegisterData id;
    asm volatile("mv %0,tp" : "=r"(id)); // 汇编并且不能被编译器优化
    return id;
}

class ProcessManager;

// 退出的状态（如何退出
enum ExitType : Sint32 {
    Exit_Destroy = -1,
    Exit_Normal = 0,
    Exit_BadSyscall,
    Exit_Execve,
    Exit_SegmentationFault,
};

// 进程状态
enum ProcStatus : Uint32 {
    S_None = 0,
    S_Allocated, // 已经被分配
    S_Initing, // 正在初始化
    S_Ready, // 已经准备好了
    S_Running, // 正在运行
    S_UserRunning, // 好像没用现在
    S_Sleeping, // 正在休眠
    S_Terminated, // 终结
};

// 进程标记位信息
enum ProcFlag : Uint64 {
    F_User = 0,
    F_Kernel = 1ull << 0,
    F_AutoDestroy = 1ull << 1,
    F_GeneratedStack = 1ull << 2,
    F_OutsideName = 1ull << 3,
};

// 存储每个进程的结构体
class Process {
    friend ProcessManager; // 管理打开的进程（目前数组）
    friend Semaphore; // 进程需要某信号，需要信号中断
    friend FileObjectManager;

private:
    ProcStatus status; // 进程状态
public:
    ClockTime timeBase; // Round Robin时间片轮转调度实现需要 计时起点
    ClockTime runTime; // 进程运行的时间
    ClockTime
        trapSysTimeBase; // 为用户进程设计的 记录当前陷入系统调用时的起始时刻
    ClockTime sysTime; // 为用户设计的时间 进行系统调用陷入核心态的时间
    ClockTime sleepTime; // 挂起态等待时间 wait系统调用会更新
    // 其他像时间等系统调用会使用
    ClockTime waitTimeLimit; // 进程睡眠需要 设置睡眠时间的限制
                             // 当sleeptime达到即可自唤醒
    ClockTime readyTime; // 就绪态等待时间(保留设计 暂不使用)
    Uint32 SemRef; // wait的进程数

    PID id; // 进程号pid 从0开始计数
    ProcessManager* pm; // 与之相关联的进程管理器
    void*  stack; // 进程的内核栈（保证更安全，用户态不会访问到它不该访问的）
    Uint32 stacksize;
    VirtualMemorySpace* VMS; // 虚拟内存管理，所有用一个
    file_object* fo_head; // 文件object拥有通过文件描述符管理文件，实际是一个打开文件的链表
                          //
    SigactionQueue sigQueue;

public:
    // 关于父节点及子节点的链接
    Process* father;
    Process* broPre;
    Process* broNext;
    Process* fstChild;

private:
    char* curWorkDir; // 工作路径
    Semaphore* waitSem; // 进程专属信号量
    HeapMemoryRegion* Heap; // 进程的堆区
    TrapFrame* context; // 进程上下文
    Uint64 flags; // 表示进程的状态，如用户态还是内核态，同时可以实现自动内存回收
    char name[PROC_NAME_LEN]; // 进程名称
    Uint32 nameSpace;
    Uint32 exitCode; // 结束返回值

public:
    void show(int level = 0);
    bool start(TrapFrame* tf, bool isNew);
    bool start(void* func, void* funcData, PtrUint useraddr = 0, int argc = 0, char** argv = nullptr);
    bool run();
    bool exit(int re);
    bool setName(const char* _name);

    bool copyFromProc(Process* src);

    void initForKernelProc0();

    inline void setChild(Process* firstChild)
    {
        if (fstChild) {
            fstChild->broPre = firstChild;
        }
        firstChild->broNext=fstChild;
        fstChild = firstChild;

    }
    
    ProcFlag GetFlags(){return  (ProcFlag)flags;}
    bool isKernel(){return flags&F_Kernel;}
    void setFa(Process* fa);
    inline void setID(Uint32 _id) { id = _id; }
    inline PID getID() { return id; }
    inline char* getName() { return name; }
    inline Semaphore* getSemaphore() { return waitSem; }
    void setStack(void* _stack, Uint32 _stacksize);
    inline Uint32 getStackSize() { return stacksize; };
    inline void setStack() { stack = kernel_end + 0xffffffff + 0x6400000; };
    inline void setVMS(VirtualMemorySpace* _VMS) { VMS = _VMS; }
    inline HeapMemoryRegion* setHMS() { return Heap; }
    inline void setHeap(HeapMemoryRegion* _HMS) { Heap = _HMS; }
    inline VirtualMemorySpace* getVMS() { return VMS; }
    inline void* getStack() { return stack; }
    inline TrapFrame* getContext() { return context; }
    inline void setContext(TrapFrame* _context) { context = _context; }
    inline ProcStatus getStatus() { return status; }
    inline Uint32 getExitCode() { return exitCode; }
    inline void setSysTime(ClockTime t) { sysTime = t; }
    inline ClockTime getSysTime() { return sysTime; }

    bool initFds();
    bool destroyFds();
    file_object* getSpecFds(int fd_num);
    inline file_object* getFoHead() { return fo_head; };
    bool copyFds(Process* a);
    bool setProcCWD(const char* cwd);
    inline const char* getCWD() { return curWorkDir; };

    void switchStatus(ProcStatus tarStatus);

    void init(ProcFlag _flags);
    void destroy();
};

// 进程管理器
class ProcessManager {
    friend Process;
    friend Semaphore;

protected:
    Process Proc[MaxProcessCount]; // 数组管理
    Process* curProc; // 当前正在调用执行的进程

    Uint32 procCount; // 进程数量
    SpinLock lock; // 锁，为了正确性和安全

public:
    void init();
    void destroy();

    Process* allocProc();
    bool freeProc(Process* proc);
    Process* getProc(PID id);

    void show(int j = 0);
    void simpleShow();

    TrapFrame* Schedule(TrapFrame* preContext);
    void immSchedule();

    inline Process* getidle() { return &Proc[0]; }
    // static TrapFrame* procScheduler(TrapFrame* context);
    // void waitRefProc(Process* proc);
    // void immTriggerSchedule();
    // void waitUnrefProc(Process* proc);
    // bool isSignal(Process* proc);

    inline Process* getCurProc() { return curProc; }
    inline Process* getKernelProc() { return &Proc[0]; }
    inline PID getProcCount() { return procCount; }
};

extern ProcessManager pm; // 全局变量

extern "C" {
extern void KernelProcessEntry(int re);
extern void UserProcessEntry();
void KernelProcessExit(int re); // 用来进程执行完返回
// void UserProcessExit(Process * proc);
};

#endif