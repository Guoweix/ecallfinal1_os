#include <Process/Process.hpp>
#include <Library/Kstring.hpp>
#include <Trap/Clock.hpp>
#include <Library/KoutSingle.hpp>

void ProcessManager::init()
{

    procCount = 1;
    curProc = &Proc;


    ////初始化系统进程
    Proc.setName("idle_0");
    Proc.initForKernelProc0(0);

}

bool Process::setName(const char * _name )
{
    strcpy(name,_name);
    return 0;
}

void Process::initForKernelProc0(int _id)
{
    id = _id;
    switchStatus(S_Allocated);
    init(F_Kernel);
    stack=boot_stack;
    stacksize=PAGESIZE;
    
     
    switchStatus(S_Running);
}

void Process::init(ProcFlag _flags)
{
    switchStatus(S_Initing);
    timeBase=GetClockTime();
    timeBase=runTime=trapSysTimeBase=sysTime=sleepTime=waitTimeLimit=readyTime=0;
    stack=nullptr;
    stacksize=0;
    father=broNext=broPre=fstChild=nullptr;
    memset(&context,0,sizeof(context));
    flags=_flags;
    name[0]=0;


    flags=_flags;

}

void Process::switchStatus(ProcStatus tarStatus)
{
    ClockTime t = GetClockTime();
    ClockTime d = t - timeBase;
    timeBase = t;
        switch (status)
        {

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
            sleepTime+=d;
            break;
        case S_Zombie:
        case S_Terminated:
            break;
        default:
            break;
        }
    status = tarStatus;
    
}

ProcessManager pm;