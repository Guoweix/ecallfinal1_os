#include "Types.hpp"
#include <Library/KoutSingle.hpp>
#include <Library/Kstring.hpp>
#include <Process/Process.hpp>
#include <Library/KoutSingle.hpp>
#include <Library/Kstring.hpp>
#include <Trap/Clock.hpp>

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

void Process::show()
{
    kout[Debug] << "proc pid : " << id << endline
                << "proc name : " << name << endline
                << "proc state : " << status << endline
                << "proc flags : " << flags << endline
                << "proc kstack : " << (void*)stack << endline
                << "proc kstacksize : " << stacksize << endline
                << "proc pid_fa : " << (void*)father << endline
                << "proc pid_bro_pre : " << (void*)broPre << endline
                << "proc pid_bro_next : " << (void*)broNext << endline
                << "proc pid_fir_child : " << (void*)fstChild << endl;
    kout[Debug] << "___________________________________________________" << endl;
}

void ProcessManager::show()
{
    for (int i = 0; i < MaxProcessCount; i++) {
        if (Proc[i].status != S_None) {
            Proc[i].show();
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

void Process::initForKernelProc0()
{
    init(F_Kernel);
    setFa(nullptr);
    stack = boot_stack;
    stacksize = PAGESIZE;

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
    stacksize = 0;
    father = broNext = broPre = fstChild = nullptr;
    SemRef=0;
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
    stack = nullptr;
    stacksize = 0;
    pm->freeProc(this);
    return;
}

bool Process::exit(int re)
{
    if (status != S_Terminated) {
        kout[Fault] << "Process ::Exit:status is not S_Terminated" << id << endl;
    }
    if (re != Exit_Normal) {
        kout[Warning] << "Process ::Exit:" << id << "exit with return value" << re << endl;
    }
    return true;
}

bool Process::run()
{
    Process* cur = pm->getCurProc();
    if (this != cur) {
        if (cur->status == S_Running) {
            cur->switchStatus(S_Ready);
        }
        switchStatus(S_Running);
        pm->curProc = this;
        ProcessSwitchContext(&cur->context, &this->context);
    }
    return 0;
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


void KernelThreadExit(int re)
{
// 	RegisterData a0=re,a7=SYS_Exit;
// 	asm volatile("ld a0,%0; ld a7,%1; ebreak"::"m"(a0),"m"(a7):"memory");
// //	ProcessManager::Current()->Exit(re);//Multi cpu need get current of that cpu??
// //	ProcessManager::Schedule();//Need improve...
// 	kout[Fault]<<"KernelThreadExit: Reached unreachable branch!"<<endl;
}

void SwitchToUserStat()
{
	pm.getCurProc()->switchStatus(S_UserRunning);
}
ProcessManager pm;