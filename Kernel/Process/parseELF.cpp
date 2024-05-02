#include "Library/KoutSingle.hpp"
#include "Memory/pmm.hpp"
#include "Memory/vmm.hpp"
#include "Process/Process.hpp"
#include "Trap/Interrupt.hpp"
#include <Process/ParseELF.hpp>

Process* CreateKernelThread(int (*func)(void*), char* name, void* arg, ProcFlag _flags)
{
    bool t = _interrupt_save();
    Process* kPorcess = pm.allocProc();
    kPorcess->init(F_Kernel);
    kPorcess->setName(name);
    kPorcess->setVMS(VirtualMemorySpace::Kernel());
    // kPorcess->setStack(nullptr, PAGESIZE);
    kPorcess->setStack();
    
    kPorcess->start(func, arg);
    _interrupt_restore(t);

    return kPorcess;
}
Process* CreateUserImgFromFunc(int (*func)(void*), void* arg, char* name)
{
}
Process* CreateUserImgProcess(int (*func)(void*), void* arg, char* name)
{
}
int start_process_formELF(void* userdata)
{
}