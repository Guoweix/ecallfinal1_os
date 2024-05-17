#include "Types.hpp"
#include <Arch/Riscv.h>
#include <Library/KoutSingle.hpp>
#include <Library/Kstring.hpp>
#include <Library/SBI.h>
#include <Memory/pmm.hpp>
#include <Memory/vmm.hpp>
#include <Process/Process.hpp>
#include <Synchronize/Synchronize.hpp>
#include <Trap/Clock.hpp>
#include <Trap/Interrupt.hpp>
#include <Trap/Trap.hpp>

void ProcessManager::init()
{

    for (int i = 0; i < MaxProcessCount; i++) {
        Proc[i].flags = S_None;
        Proc[i].pm = this;
    }
    procCount = 0;
    Process* idle0 = allocProc();
    curProc = idle0;

    ////初始化系统进程
    idle0->initForKernelProc0();
}

void Process::show(int level)
{
    kout[Debug] << "proc pid : " << id << endline
                << "proc name : " << name << endline
                << "proc state : " << status << endline
                << "proc flags : " << flags << endline
                << "proc VMS : " << (void*)VMS << endline
                << "proc kstack : " << (void*)stack << endline
                << "proc kstacksize : " << stacksize << endl;
    if (level == 1) {
        kout[Debug] << "proc pid_fa : " << (void*)father << endline
                    << "proc pid_bro_pre : " << (void*)broPre << endline
                    << "proc pid_bro_next : " << (void*)broNext << endline
                    << "proc pid_fir_child : " << (void*)fstChild << endl;
    }
    kout << endl;
}

void ProcessManager::show()
{
    for (int i = 0; i < MaxProcessCount; i++) {
        if (Proc[i].status != S_None) {
            Proc[i].show();
        }
    }
    kout << endl;
}

void ProcessManager::simpleShow()
{
    for (int i = 0; i < MaxProcessCount; i++) {
        if (curProc->id == i) {
            kout[Debug] << "Cur====>" << endl;
        }
        if (Proc[i].status != S_None) {
            kout[Debug] << Proc[i].name << endline
                        << Proc[i].id << endl;
        }
    }
}

bool Process::setName(const char* _name)
{
    if (_name == nullptr) {
        name[0] = 0;
        return 0;
    }
    strcpy(name, _name);

    return 0;
}

void Process::setStack(void* _stack, Uint32 _stacksize)
{
    if (_stack == nullptr) {
        flags |= F_GeneratedStack;
        _stack = kmalloc(_stacksize);
        if (_stack == nullptr) {
            kout[Fault] << "ERR_Kmalloc stack" << endl;
        }
    }
    memset(_stack, 0, _stacksize);
    stack = _stack, stacksize = _stacksize;
}

void Process::initForKernelProc0()
{
    init(F_Kernel);
    setFa(nullptr);
    stack = boot_stack;
    stacksize = PAGESIZE;

    VMS = VirtualMemorySpace::Boot();

    setName("idle_0");
    switchStatus(S_Running);
}

void Process::init(ProcFlag _flags)
{
    if (status != S_Allocated) {

        kout[Fault] << "Process Init :status is not S_Allocated" << endl;
    }

    switchStatus(S_Initing);
    id = this - pm->Proc;
    timeBase = GetClockTime();
    timeBase = runTime = trapSysTimeBase = sysTime = sleepTime = waitTimeLimit = readyTime = 0;
    stack = nullptr;
    VMS = nullptr;
    stacksize = 0;
    father = broNext = broPre = fstChild = nullptr;
    waitSem = new Semaphore(0);
    SemRef = 0;
    memset(&context, 0, sizeof(context));
    flags = _flags;
    name[0] = 0;
}

void Process::destroy()
{
    kout[Debug] << "Process destroy:" << id << endl;
    if (status == S_None) {
        return;
    } else if (status != S_Initing || status != S_Terminated) {
        exit(Exit_Normal);
    }
    while (fstChild) {
        fstChild->destroy();
    }
    if (broPre) {
        broPre->broNext = broNext;
    } else {
        if (father) {
            father->fstChild = broNext;
        }
    }
    if (broNext) {
        broNext->broPre = broPre;
    }
    setFa(nullptr);
    setName(nullptr);
    if (stack != nullptr) {
        Kfree(stack);
    }
    stack = nullptr;
    stacksize = 0;
    pm->freeProc(this);
    return;
}

bool Process::exit(int re)
{
    // kout<<"exit"<<re;
    switchStatus(S_Terminated);
    if (status != S_Terminated) {
        kout[Fault] << "Process ::Exit:status is not S_Terminated" << id << endl;
    }
    if (re != Exit_Normal) {
        kout[Warning] << "Process ::Exit:" << id << "exit with return value" << re << endl;
    }
    VMS->Leave();
    if (!(flags & F_AutoDestroy) && father != nullptr) {
        father->waitSem->signal();
    }
    return true;
}

bool Process::run()
{
    Process* cur = pm->getCurProc();
    // cur->show();
    // kout[Debug] << "switch from " << cur->name << " to " << name << endl;
    if (this != cur) {
        if (cur->status == S_Running) {
            cur->switchStatus(S_Ready);
        }
        switchStatus(S_Running);
        pm->curProc = this;
        VMS->Enter();
    }
    // kout[Debug] << "switch finish" << endl;
    return true;
}

bool Process::start(void* func, void* funcData, PtrUint useraddr)
{

    if (VMS == nullptr) {
        kout[Fault] << "vms is not set" << endl;
    }
    if (stack == nullptr) {
        kout[Fault] << "stack is not set" << endl;
    }
    Uint64 SPP = 1 << 8; // 利用中断 设置sstatus寄存器 Supervisor Previous Privilege(guess)
    Uint64 SPIE = 1 << 5; // Supervisor Previous Interrupt Enable
    Uint64 SIE = 1 << 1; // Supervisor Interrupt Enable

    context = (TrapFrame*)((char*)stack + stacksize) - 1;
    if (flags & F_Kernel) {
        context->epc = (Uint64)KernelProcessEntry; // Exception PC
        context->reg.s0 = (Uint64)func;
        context->reg.s1 = (Uint64)funcData;
        context->status = (read_csr(sstatus) | SPP | SPIE) & (~SIE); // 详见手册
        context->reg.sp = (Uint64)((char*)stack + stacksize);
    } else {
        context->epc = (Uint64)useraddr; // Exception PC
        context->status = (read_csr(sstatus) | SPIE) & (~SPP) & (~SIE); // 详见手册
        context->reg.sp = InnerUserProcessStackAddr + InnerUserProcessStackSize - 512;
    }
    kout[Info] << (void*)context->epc << endl;
    switchStatus(S_Ready);

    return true;
}

void Process::switchStatus(ProcStatus tarStatus)
{
    ClockTime t = GetClockTime();
    ClockTime d = t - timeBase;
    timeBase = t;
    switch (status) {

    case S_Allocated:
    case S_Initing:
        if (tarStatus == S_Ready)
            readyTime = t;
        break;
    case S_Ready:
        waitTimeLimit += d;
        break;
    case S_Running:
        runTime += d;
        break;
    case S_Sleeping:
        sleepTime += d;
        break;
    case S_Terminated:
        break;
    default:
        break;
    }
    status = tarStatus;
}

Process* ProcessManager::allocProc()
{
    for (int i = 0; i < MaxProcessCount; i++) {
        if (Proc[i].status == S_None) {
            procCount++;
            Proc[i].switchStatus(S_Allocated);
            return &Proc[i];
        }
    }
    return nullptr;
}

Process* ProcessManager::getProc(PID _id)
{
    if (_id > 0 && _id < MaxProcessCount) {
        return &Proc[_id];
    }
    if (_id == 0) {
        kout[Fault] << "can't get idle0" << endl;
    }
    kout[Fault] << "PID out of range" << endl;
    return nullptr;
}

bool ProcessManager::freeProc(Process* proc)
{
    if (proc == curProc) {
        kout[Fault] << "freeProcess == curProc" << curProc->id << endl;
    }
    Proc[proc->id].switchStatus(S_None);
    procCount--;
    return false;
}

void ProcessManager::destroy()
{
    for (int i = 0; i < MaxProcessCount; i++) {
        if (Proc[i].status != S_None) {
            Proc[i].destroy();
        }
    }
}

TrapFrame* ProcessManager::Schedule(TrapFrame* preContext)
{
    Process* tar;

    curProc->context = preContext;

    if (curProc != nullptr && procCount >= 2) {
        int i, p;
        ClockTime minWaitingTarget = -1;
    RetrySchedule:
        for (i = 1, p = curProc->id; i < MaxProcessCount; ++i) {
            tar = &Proc[(i + p) % MaxProcessCount];
            // if (tar->status == S_Sleeping && NotInSet(tar->SemWaitingTargetTime, 0ull, (Uint64)-1)) {
            //     minWaitingTarget = minN(minWaitingTarget, tar->SemWaitingTargetTime);
            //     if (GetClockTime() >= tar->SemWaitingTargetTime)
            //         tar->SwitchStat(Process::S_Ready);
            // }
            // kout<<p<<"P+i "<<(p+i)%MaxProcessCount<<tar->status<<endl;
            // pm.show();

            if (tar->status == S_Ready) {

                tar->getVMS()->showVMRCount();
                tar->run();
                // if (tar->getID()==3) {
                //     asm volatile("li s0,0\ncsrw sstatus,s0,li s1,0x80020\ncsrw sepc,s1\nsret");

                // }

                // kout[Debug] << (void*)tar->context->epc;

                // tar->getVMS()->EnableAccessUser();
                // kout[Debug] << DataWithSize((void *)tar->context->epc, 108);
                // tar->getVMS()->DisableAccessUser();

                return tar->context;
            } else if (tar->status == S_Terminated && (tar->flags & F_AutoDestroy))
                tar->destroy();
        }
    }
    return pm.getKernelProc()->context;
}

void ProcessManager::immSchedule()
{
    bool t;
    IntrSave(t);
    sbi_set_time(sbi_get_time());
    IntrRestore(t);
}

extern "C" {
void KernelProcessExit(int re)
{

    kout[Debug] << "FFFFFFFFFF" << re << endl;
    // pm.getCurProc()->switchStatus(S_Terminated);

    RegisterData a0 = re, a7 = SYS_Exit;
    asm volatile("ld a0,%0; ld a7,%1; ebreak" ::"m"(a0), "m"(a7) : "memory");
    //	ProcessManager::Current()->Exit(re);//Multi cpu need get current of that cpu??
    //	ProcessManager::Schedule();//Need improve...
    kout[Fault] << "KernelProcessExit:Reached unreachable branch" << endl;
}

void UserProcessExit(Process* proc)
{

    proc->switchStatus(S_Terminated);
    RegisterData a7 = SYS_Exit;
    kout[Fault] << "KernelProcessExit:Reached unreachable branch" << endl;
}
}

void SwitchToUserStat()
{
    pm.getCurProc()->switchStatus(S_UserRunning);
}
ProcessManager pm;