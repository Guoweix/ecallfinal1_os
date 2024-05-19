#include "Arch/Riscv.hpp"
#include "Driver/Virtio.hpp"
#include "File/FAT32.hpp"
#include <Driver/VirtioDisk.hpp>
#include <File/vfsm.hpp>
#include <Library/Easyfunc.hpp>
#include <Library/KoutSingle.hpp>
#include <Library/Kstring.hpp>
#include <Memory/pmm.hpp>
#include <Memory/slab.hpp>
#include <Memory/vmm.hpp>
#include <Process/ParseELF.hpp>
#include <Process/Process.hpp>
#include <Trap/Clock.hpp>
#include <Trap/Interrupt.hpp>
#include <Trap/Trap.hpp>

extern "C" {
void Putchar(char ch)
{
    SBI_PUTCHAR(ch);
}
};

namespace POS {
KOUT kout;
};

void pmm_test()
{
    pmm.show();

    int i = 0;
    while (1) {
        i++;
        kmalloc(20);
        kout << i << endl;
        pmm.show();
    }
    // 在 slab 中进行内存分配测试,通过
    void* memory64B = kmalloc(4096);
    if (memory64B)
        kout[Info] << "Allocated 4KB memory successfully!" << (void*)memory64B << endl;
    else
        kout[Error] << "Failed to allocate 4KB memory!" << endl;
    pmm.show();

    kfree(memory64B);

    void* memory64B2 = kmalloc(4096);
    if (memory64B2)
        kout[Info] << "Allocated 4KB memory successfully!" << (void*)memory64B2 << endl;
    else
        kout[Error] << "Failed to allocate 4KB memory!" << endl;
    pmm.show();

    /*void* memory512B = slab.allocate(512);
    if (memory512B)
        kout[Info] << "Allocated 4KB memory successfully!" << endl;
    else
        kout[Error] << "Failed to allocate 4KB memory!" << endl;
    pmm.show();

    void* memory4KB = slab.allocate(4096);
    if (memory4KB)
        kout[Info] << "Allocated 16KB memory successfully!" << endl;
    else
        kout[Error] << "Failed to allocate 16KB memory!" << endl;
        pmm.show();*/
}

void pagefault_test()
{
    VirtualMemorySpace::Current()->InsertVMR(new VirtualMemoryRegion(0x100, 0x200, VirtualMemoryRegion::VM_RW | VirtualMemoryRegion::VM_Kernel)); // 插入新的vmr
    *(char*)0x100 = 'A';

    kout[Test] << "Original VMS:" << (char*)0x100 << endl;

    VirtualMemorySpace* vms = new VirtualMemorySpace();
    vms->Init();
    vms->Create();
    vms->Enter();
    vms->InsertVMR(new VirtualMemoryRegion(0xffffffff88200000, 0xffffffff88400000, VirtualMemoryRegion::VM_RW | VirtualMemoryRegion::VM_Kernel));
    vms->InsertVMR(new VirtualMemoryRegion(InnerUserProcessLoadAddr, InnerUserProcessLoadAddr + 118, VirtualMemoryRegion::VM_RWX | VirtualMemoryRegion::VM_Kernel));
    vms->EnableAccessUser();
    // *(char*)0x100 = 'B';
    memcpy((char*)InnerUserProcessLoadAddr, (const char*)0xffffffff88200000, 118);
    vms->DisableAccessUser();

    // kout[Test] << "New VMS:" << (char*)0x100 << endl;

    kout[Info] << DataWithSize((void*)InnerUserProcessLoadAddr, 118) << endl;
    vms->Leave();
    // kout[Test]<<"Leave New VMS:"<<(char*)0x100<<endl;
    VirtualMemorySpace::Kernel()->Enter();
    VirtualMemorySpace::Kernel()->Enter();
    VirtualMemorySpace::Kernel()->Enter();
    vms->Enter();

    kout[Info] << DataWithSize((void*)InnerUserProcessLoadAddr, 118) << endl;

    //  asm volatile (
    // "li s0, 0x800020\n"   // 将0x800020加载到寄存器t0
    // "j s0\n"             // 使用jr指令跳转到t0寄存器中的地址
    // );
    // kout[Test] << "New VMS:" << (char*)0x100 << endl;
    vms->Leave();

    vms->Destroy();
    delete vms;
}

int hello(void* t)
{
    int n;

    // VDisk.waitDisk->signal();
    for (int i = 0; i < 20; i++) {
        n = 1e7;
        delay(n);
        SBI_PUTCHAR('A');
    }
    return 0;
}

int hello1(void* t)
{
    int n;

    // delay(5e8);
    // VDisk.waitDisk->wait();

    while (1) {
        n = 1e7;
        while (n) {
            n--;
        }

        SBI_PUTCHAR('B');
    }
}

void pm_test()
{
    kout << "__________________________----" << endl;
    CreateKernelThread(hello1, "Hello1");
    kout << "__________________________----" << endl;
    CreateKernelThread(hello, "Hello");
    kout << "__________________________----" << endl;
    CreateUserImgProcess(0xffffffff88200000, 0xffffffff88200076, F_User);

    pm.show();
    // delay(5e8);
    // pm.getProc(1)->getSemaphore()->wait(pm.getProc(1));
    // kout<<"VMS"<<(void *)pm.getCurProc()->getVMS()<<endl;

    // delay(4e8);
    // kout<<(void *)pm.getProc(1)->getSemaphore()<<endl;
    // kout<<"VMS"<<(void *)pm.getCurProc()->getVMS()<<endl;
    // pm.getProc(1)->getSemaphore()->signal();
}

void Semaphore_test()
{
    Semaphore* SemTest(0);
    kout << "2" << endl;
    SemTest->wait();
    kout << "3" << endl;
    kout << "wait OK" << endl;
    kout << "4" << endl;
    SemTest->signal();
    kout << "5" << endl;
}

void Driver_test()
{
    int t;
    Sector* sec = (Sector*)pmm.malloc(51200, t);
    Disk.readSector(0, sec, 100);
    kout << DataWithSizeUnited(sec, sizeof(Sector), 16);
    // memset(sec,0,512);
    // kout<<DataWithSizeUnited(sec,sizeof(Sector),16);
    // Disk.writeSector(0, sec);
    Disk.readSector(0, sec);
    kout << DataWithSizeUnited(sec, sizeof(Sector), 16);
}

void VFSM_test()
{
    FAT32FILE* file;
    file = vfsm.get_next_file(vfsm.get_root());
    // kout << file;
    while (file) {
        kout << file->name << endl;
        if (file->table.size == 0) {
            file = vfsm.get_next_file(vfsm.get_root(), file);
            continue;
        }
        if (file->TYPE == FAT32FILE::__DIR) {
            file = vfsm.get_next_file(vfsm.get_root(), file);
            continue;
        }

        file = vfsm.get_next_file(vfsm.get_root(), file);
        // kout << file;
    }
}

int main()
{
    TrapInit();
    ClockInit();
    kout[Info] << "System start success!" << endl;
    pmm.Init();
    // pmm.show();
    slab.Init();
    // pmm_test();
    VirtualMemorySpace::InitStatic();

    // pagefault_test();
    // kout[Info] << "hello" << (void*)hello << endl;
    // kout[Info] << "hello1" << (void*)hello1 << endl;
    // kout[Info] << "KernelProcessEntry" << (void*)KernelProcessEntry << endl;

    // kout<<DataWithSize((void *)0xffffffff88200000,118);

    pm.init();

    // kout["kkkkkk"]<<&((VRingAvail*)nullptr)->ring<<endl;

    Disk.DiskInit();
    kout[Info] << "Diskinit finish" << endl;
    vfsm.init();
    kout[Info] << "vfsm finish" << endl;
    // int t;
    // Sector *sec=(Sector *)pmm.malloc(512,t);
    // Disk.readSector(0, sec);
    // kout<<DataWithSize(sec,sizeof(Sector));

    // Driver_test();
    VFSM_test();
    pm_test();
    InterruptEnable();

    kout << "1" << endl;

    // Semaphore_test();

    // Below do nothing...
    auto Sleep = [](int n) {while (n-->0); };
    auto DeadLoop = [Sleep](const char* str) {
        while (1)
            Sleep(1e8),
                kout << str;
    };
    // while(1)
    // {
    // 	kout[Debug]<<"hi"<<endl;
    // }

    DeadLoop(".");

    kout[Info] << "Shutdown!" << endl;
    SBI_SHUTDOWN();
    return 0;
}
