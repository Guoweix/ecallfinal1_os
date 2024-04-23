#ifndef __PROCESS_HPP__
#define __PROCESS_HPP__

#include <Types.hpp>
#include <Trap/Trap.hpp>
#include <Synchronize/SpinLock.hpp>
#include <Memory/pmm.hpp>

#define PROC_NAME_LEN 50

const Uint32 MaxProcessCount = 128;

class VMM;
class Semaphore;

struct RegContext
{
    RegisterData ra, sp, s[12];
};

inline RegisterData GetCPUID()
{
    RegisterData id;
    asm volatile("mv %0,tp" : "=r"(id));
    return id;
}

class ProcessManager;

enum ProcStatus : Uint32
{
    S_None = 0,
    S_Allocated,
    S_Initing,
    S_Ready,
    S_Running,
    S_UserRunning,
    S_Sleeping,
    S_Zombie,
    S_Terminated,

};
enum ProcFlag:Uint64
{
    F_Kernel = 1ull<<0,
    F_AutoDestroy = 1ull<<1,
    F_GeneratedStack = 1ull<<2,
    F_OutsideName = 1ull<<3,
};

class Process
{

private:
    ClockTime timeBase;          // Round Robin时间片轮转调度实现需要 计时起点
    ClockTime runTime;           // 进程运行的时间
    ClockTime trapSysTimeBase; // 为用户进程设计的 记录当前陷入系统调用时的起始时刻
    ClockTime sysTime;           // 为用户设计的时间 进行系统调用陷入核心态的时间
    ClockTime sleepTime;         // 挂起态等待时间 wait系统调用会更新 其他像时间等系统调用会使用
    ClockTime waitTimeLimit;    // 进程睡眠需要 设置睡眠时间的限制 当sleeptime达到即可自唤醒
    ClockTime readyTime;         // 就绪态等待时间(保留设计 暂不使用)

    PID id;
    ProcessManager *pm;
    ProcStatus status;
    void *stack;
    Uint32 stacksize;

    // 关于父节点及子节点的链接
    Process *father;
    Process *broPre;
    Process *broNext;
    Process *fstChild;

    RegContext context;

    Uint64 flags;
    char name[PROC_NAME_LEN];
    Uint32 nameSpace;

public:
    bool start(TrapFrame * tf,bool isNew);
    bool run();
    bool exit();
    bool setName(const char * _name);

    void initForKernelProc0(int _id); 
    void init(ProcFlag _flags); 

    inline void setChild(Process * firstChild)
    {
        fstChild=firstChild;
    }
    inline void setID(Uint32 _id)
    {
        id=_id;
    }
    void switchStatus(ProcStatus tarStatus);


    
};

class ProcessManager
{
    friend Process;
    friend Semaphore;

protected:
    Process Proc;
    Process *curProc;

    Uint32 procCount;
    SpinLock lock;
    


    void addNode(Process *proc);
    void removeNode(Process *proc);

public:
    void init();
    void destroy();
    void show(Process *cur);


    Process *allocProc();
    Process *getProc(PID id);
    bool freeProc(Process * proc);
    static void Schedule();

    static TrapFrame *procScheduler(TrapFrame *context);

    inline Process *getCurProc()
    {
        return curProc;
    }
    inline PID getProcCount()
    {
        return procCount;
    }
    

};

extern ProcessManager pm;

#endif