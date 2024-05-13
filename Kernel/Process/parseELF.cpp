#include "Library/KoutSingle.hpp"
#include "Memory/pmm.hpp"
#include "Memory/vmm.hpp"
#include "Process/Process.hpp"
#include "Trap/Interrupt.hpp"
#include "Types.hpp"
#include <Process/ParseELF.hpp>

Process* CreateKernelThread(int (*func)(void*), char* name, void* arg, ProcFlag _flags)
{
    bool t = _interrupt_save();
    Process* kPorcess = pm.allocProc();
    kPorcess->init(F_Kernel);
    kPorcess->setName(name);
    kPorcess->setVMS(VirtualMemorySpace::Kernel());
    kPorcess->setStack(nullptr, UserPageSize);
    // kPorcess->setStack();

    kPorcess->start((void *)func, arg);
    _interrupt_restore(t);

    return kPorcess;
}

Process* CreateUserImgProcess(PtrUint start, PtrUint end, ProcFlag Flag)
{
    bool t = _interrupt_save();
    kout[Info] << "CreateUserImgProcess" << (void*)start << (void*)end << endl;
    if (start > end) {
        kout[Fault] << "CreateUserImgProcess:: start>end" << endl;
    }
    VirtualMemorySpace* vms = new VirtualMemorySpace;
    vms->Init();
    vms->Create();

    PtrUint loadsize = (char *)end - (char *)start;
    // kout<<loadsize<<endl<<endl;
    PtrUint loadstart = InnerUserProcessLoadAddr;

    VirtualMemoryRegion *vmr_bin = new VirtualMemoryRegion(loadstart, loadstart + loadsize, VirtualMemoryRegion::VM_RWX),
                        *vmr_stack = new VirtualMemoryRegion(InnerUserProcessStackAddr, InnerUserProcessStackAddr + InnerUserProcessStackSize, VirtualMemoryRegion::VM_USERSTACK);
                        // *vmr_kernel = new VirtualMemoryRegion(PhysicalMemoryStart() + PhysicalMemorySize(),
                            // PhysicalMemorySize() + PhysicalMemoryStart() + loadsize, VirtualMemoryRegion::VM_RWX );
    
    vms->InsertVMR(vmr_bin);
    // vms->InsertVMR(vmr_kernel);
    vms->InsertVMR(vmr_stack);
    
    Process* proc = pm.allocProc();
    proc->init(Flag);
    proc->setVMS(vms);

    {
        proc->getVMS()->Enter();
        proc->getVMS()->EnableAccessUser();
        kout[Info]<<DataWithSize((void *)start,loadsize)<<endl;
        memcpy((char*)InnerUserProcessLoadAddr, (const char*)start, loadsize);
        // while (1) ;
        kout[Info]<<DataWithSize((void *)InnerUserProcessLoadAddr,loadsize)<<endl;
        proc->getVMS()->DisableAccessUser();
        proc->getVMS()->Leave();
    }
    proc->setStack(nullptr, PAGESIZE*4);
    if (!(Flag & F_AutoDestroy)) {
        proc->setFa(pm.getCurProc());
    }

    proc->start((void*)nullptr, nullptr,InnerUserProcessLoadAddr);
    kout[Test] << "CreateUserImgProcess" << (void*)start << " " << (void*)end << "with  PID " << proc->getID() << endl;

    _interrupt_restore(t);
    return proc;
}

int start_process_formELF(void* userdata)
{
}