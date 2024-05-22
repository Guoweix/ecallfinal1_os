#ifndef __PROCESS_HPP__
#define __PROCESS_HPP__

// #include <File/FileObject.hpp>
#include <Library/KoutSingle.hpp>
#include <Memory/pmm.hpp>
#include <Synchronize/SpinLock.hpp>
// #include <Synchronize/Synchronize.hpp>
#include <Memory/vmm.hpp>
#include <Trap/Syscall/Syscall.hpp>
#include <Trap/Trap.hpp>
#include <Types.hpp>

#define PROC_NAME_LEN 50
#define UserPageSize 12 * PAGESIZE

const Uint32 MaxProcessCount = 128;
const PtrSint InnerUserProcessLoadAddr = 0x800020,
              InnerUserProcessStackSize = PAGESIZE * 32,
              InnerUserProcessStackAddr = 0x80000000 - InnerUserProcessStackSize;

// class VMM;
class Semaphore;
class FileObjectManager;

// struct RegContext { //     RegisterData ra, sp, s[12]; // };
class file_object;

inline RegisterData GetCPUID()
{
    RegisterData id;
    asm volatile("mv %0,tp" : "=r"(id));
    return id;
}

class ProcessManager;

enum ExitType : Sint32 {
    Exit_Destroy = -1,
    Exit_Normal = 0,
    Exit_BadSyscall,
    Exit_Execve,
    Exit_SegmentationFault,

};
enum ProcStatus : Uint32 {
    S_None = 0,
    S_Allocated,
    S_Initing,
    S_Ready,
    S_Running,
    S_UserRunning,
    S_Sleeping,
    S_Terminated,

};
enum ProcFlag : Uint64 {
    F_User = 0,
    F_Kernel = 1ull << 0,
    F_AutoDestroy = 1ull << 1,
    F_GeneratedStack = 1ull << 2,
    F_OutsideName = 1ull << 3,
};

class Process {
    friend ProcessManager;
    friend Semaphore;
    friend FileObjectManager;

private:
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

    PID id;
    ProcessManager* pm;
    ProcStatus status;
    void* stack;
    Uint32 stacksize;

public:
    // 关于父节点及子节点的链接
    Process* father;
    Process* broPre;
    Process* broNext;
    Process* fstChild;

private:
    file_object* fo_head;
    char* curWorkDir;

    Semaphore* waitSem;

    VirtualMemorySpace* VMS;
    HeapMemoryRegion* Heap;

    TrapFrame* context;

    Uint64 flags;
    char name[PROC_NAME_LEN];
    Uint32 nameSpace;

    Uint32 exitCode;

public:
    void show(int level = 0);
    bool start(TrapFrame* tf, bool isNew);
    bool start(void* func, void* funcData, PtrUint useraddr = 0);
    bool run();
    bool exit(int re);
    bool setName(const char* _name);

    bool copyFromProc(Process * src);

    void initForKernelProc0();

    inline void setChild(Process* firstChild) { fstChild = firstChild; }
    void setFa(Process* fa);
    inline void setID(Uint32 _id) { id = _id; }
    inline PID getID() { return id; }
    inline Semaphore* getSemaphore() { return waitSem; }
    void setStack(void* _stack, Uint32 _stacksize);
    inline Uint32 getStackSize() { return stacksize; };
    inline void setStack() { stack = kernel_end + 0xffffffff + 0x6400000; };
    inline void setVMS(VirtualMemorySpace* _VMS) { VMS = _VMS; }
    inline HeapMemoryRegion* setHMS() { return Heap; }
    inline void setHeap(HeapMemoryRegion* _HMS) { Heap = _HMS; }
    inline VirtualMemorySpace* getVMS() { return VMS; }
    inline void * getStack(){return  stack;}
    inline TrapFrame * getContext(){return  context;}
    inline void setContext(TrapFrame * _context){ context=_context; }
    inline ProcStatus getStatus(){return  status;}
    inline Uint32 getExitCode(){return  exitCode;}

 
    bool initFds();
    bool destroyFds();
    file_object* getSpecFds(int fd_num);
    inline file_object* getFoHead() { return fo_head; };
    bool copyFds(Process* a);
    bool setProcCWD(const char* cwd);
    inline char* getCWD() { return curWorkDir; };

    void switchStatus(ProcStatus tarStatus);

    void init(ProcFlag _flags);
    void destroy();
};

class ProcessManager {
    friend Process;
    friend Semaphore;

protected:
    Process Proc[MaxProcessCount];
    Process* curProc;

    Uint32 procCount;
    SpinLock lock;

public:
    void init();
    void destroy();

    Process* allocProc();
    bool freeProc(Process* proc);
    Process* getProc(PID id);

    void show(int j=0);
    void simpleShow();

    TrapFrame* Schedule(TrapFrame* preContext);
    void immSchedule();

    inline Process * getidle(){return  &Proc[0];}
    // static TrapFrame* procScheduler(TrapFrame* context);
    // void waitRefProc(Process* proc);
    // void immTriggerSchedule();
    // void waitUnrefProc(Process* proc);
    // bool isSignal(Process* proc);

    inline Process* getCurProc() { return curProc; }
    inline Process* getKernelProc() { return &Proc[0]; }
    inline PID getProcCount() { return procCount; }
};

extern ProcessManager pm;
extern "C" {
extern void KernelProcessEntry(int re);
extern void UserProcessEntry();
void KernelProcessExit(int re);
// void UserProcessExit(Process * proc);
};

#endif