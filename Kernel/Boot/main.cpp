#include "Arch/Riscv.hpp"
#include "Driver/Virtio.hpp"
#include "File/FAT32.hpp"
#include <Driver/VirtioDisk.hpp>
#include <File/FileObject.hpp>
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
    for (int i = 0; i < 20000; i++) {
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
        // pm.immSchedule();
    }
}

void pm_test()
{
    kout << "__________________________----" << endl;
    CreateKernelThread(hello1, "Hello1");
    kout << "__________________________----" << endl;
    CreateKernelThread(hello, "Hello");
    kout << "__________________________----" << endl;
    // CreateUserImgProcess(0xffffffff88200000, 0xffffffff88200076, F_User);

    // pm.show();
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
void new_test()
{
    char* a = new char[5001];
    kout << (void*)a << "end" << (void*)&a[5000] << endl;

    char* b = new char[4000];
    kout << (void*)b << endl;
}

void VFSM_test()
{
    FAT32FILE* file;

    vfsm.create_file("/", "/", "test_unlink");

    file = vfsm.get_next_file(vfsm.get_root());
    file_object* fo = new file_object();
    while (file) {
        // if (file->table.size == 0) {
        // file = vfsm.get_next_file(vfsm.get_root(), file);
        // continue;
        // }
        if (file->TYPE == FAT32FILE::__DIR) {
            file = vfsm.get_next_file(vfsm.get_root(), file);
            continue;
        }
        fom.set_fo_file(fo, file);
        fom.set_fo_pos_k(fo, 0);
        // kout[Info] << "____________________1___________________--" << endl;

        // kout << "file name" << file << " " << file->name << endl;
        // ;

        file = vfsm.get_next_file(vfsm.get_root(), file);
        // kout << file;
    }
    FAT32FILE* f = vfsm.open("test_unlink", "/");
    if (f) {
        kout << "test_unlink find:" << f->name << endl;
    } else {
        kout[Fault] << "can't open" << endl;
    }
}

bool VFSM_test1(char i)
{
    char  fn[20];
    char t[20]={i,0};
    strcpy(fn,"fuck_fuck_you");
    strcat(fn,t);
    kout<<"____________________CREATE____________________"<<endl;
    
    vfsm.create_file("/", "/", fn);
    kout<<"____________________Find________________"<<endl;
    FAT32FILE* f = vfsm.open(fn, "/");
     if (f) {
        kout << "test_unlink find:" << f->name << endl;
    } else {
        kout[Fault] << "can't open" << endl;
    }
    
}

void final_test()
{


// VFSM_test();
    FAT32FILE* file;
    file = vfsm.get_next_file(vfsm.get_root());
    file_object* fo = new file_object();
    // kout << file;
    char ch='A';
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
        fom.set_fo_file(fo, file);
        fom.set_fo_pos_k(fo, 0);
        // kout[Info] << "____________________1___________________--" << endl;
        
        // VFSM_test1(ch++);

        Process* task;
        if (strcmp(file->name, "pipe") == 0) {

            task = CreateProcessFromELF(fo, "/");
            while (1) {
                if (task->getStatus() == S_Terminated) {
                    goto FinalTestEnd;
                }
            }
            kout << "END" << endl;
        }
        file = vfsm.get_next_file(vfsm.get_root(), file);
        // kout << file;
    }

FinalTestEnd:
    kout << "finish test" << endl;

// VFSM_test();

    while (1) {
        delay(1e7);
        Putchar('.');
    }
}

void test_final1()
{
    file_object* fo = (file_object*)kmalloc(sizeof(file_object));
    FAT32FILE* file;
    Process* test;
    int test_cnt = 0;

    file = vfsm.get_next_file(vfsm.get_root());
    while (file) {
        // file->show();
        if (file->table.size == 0) {
            file = vfsm.get_next_file(vfsm.get_root(), file);
            continue;
        }
        if (file->TYPE == FAT32FILE::__DIR) {
            file = vfsm.get_next_file(vfsm.get_root(), file);
            continue;
        }

        fom.set_fo_file(fo, file);
        fom.set_fo_pos_k(fo, 0);
        kout << file->name << endl;
        
        kout.SwitchTypeOnoff(Fault, true);

        file->show();
        kout[Debug]<<"start errrorrrrrrrrrrrrrrrrr"<<endl;
        test = CreateProcessFromELF(fo, "/"); // 0b10的标志位表示不让调度器进行回收 在主函数手动回收

        kout[Debug]<<"errrorrrrrrrrrrrrrrrrr"<<endl;
        if (test != nullptr) {
            while (1) {
                if (test->getStatus() == S_None) {
                    kout << pm.getCurProc()->getName() << " main free Proc" << test->getName();
                    // pm.freeProc(test);
                    // delay(1e8);
                    // pm.show();
                    // test = nullptr;
                    break;
                } else {
                    pm.immSchedule();
                }
            }
        }
        // kout.SetEnabledType(-1);

        file = vfsm.get_next_file(vfsm.get_root(), file);
    }
    // kout.SetEnabledType(-1);
    kout << "test finish" << endl;
}

unsigned VMMINFO;
unsigned NEWINFO;
int main()
{
    VMMINFO = kout.RegisterType("VMMINFO", KoutEX::Green);
    NEWINFO = kout.RegisterType("NEWINFO", KoutEX::Red);

    // kout.SwitchTypeOnoff(VMMINFO, false); // kout调试信息打印
    // kout.SetEnableEffect(false);
     kout.SetEnabledType(0);

    kout.SwitchTypeOnoff(NEWINFO,false);

    TrapInit();
    ClockInit();

    kout[Info] << "System start success!" << endl;
    pmm.Init();
    // pmm.show();
    slab.Init();
    // pmm_test();
    VirtualMemorySpace::InitStatic();

    pm.init();

    Disk.DiskInit();
    kout[Info] << "Diskinit finish" << endl;
    vfsm.init();
    kout[Info] << "vfsm finish" << endl;

    // Driver_test();
    InterruptEnable();
    // new_test();
    // VFSM_test();
    // pm_test();

    // char * a="/";
    // char * b="/";
    // char * c="test_unlink";
    // vfsm.create_file(a, b, c);
    // FAT32FILE* f = vfsm.open(c, a);
    // if (f) {
    //     kout << "test_unlink find:" << f->name << endl;
    // } else {
    //     kout << "can't open" << endl;
    // }

// for (char ch='A';ch<'Z'+1;ch++) {
// VFSM_test1(ch);
// }
    // final_test();
    test_final1();
    // pm_test();
    SBI_SHUTDOWN();

    // kout << "1" << endl;

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
