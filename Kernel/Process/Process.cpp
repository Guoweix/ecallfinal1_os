#include <Process/Process.hpp>
#include <Library/KoutSingle.hpp>
#include <Library/Kstring.hpp>
#include <Trap/Clock.hpp>
#include <Library/KoutSingle.hpp>

void ProcessManager::init()
{

    procCount = 0;
    curProc = &kernelProc;

    kernelProc.setChild(nullptr);
    kernelProc.setID(0);

    ////初始化系统进程
    kernelProc.initAsKernelProc(0);
    kernelProc.setName("idle_0");

}

bool Process::setName(const char * _name )
{
    strcpy(name,_name);
    return 0;
}

void Process::initAsKernelProc(int _id)
{
    id = _id;
    switchStatus(S_New);
    init(F_Kernel);
     
}

void Process::init(ProcFlag _flags)
{

    timeBase=runTime=trapSysTimeBase=sysTime=sleepTime=waitTimeLimit=readyTime=0;
    stack=nullptr;
    stacksize=0;
    father=broNext=broPre=fstChild=nullptr;

    flags=_flags;

}

void Process::switchStatus(ProcStatus tarStatus)
{
    ClockTime t = GetClockTime();
    ClockTime d = t - timeBase;
    timeBase = t;
    if (tarStatus != S_New) // 当新建一个进程的时候不会发生任何情况
    {
        switch (status)
        {

        case S_New:
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
    }
    status = tarStatus;
    
}

ProcessManager pm;