#include "Arch/Riscv.hpp"
#include "File/FAT32.hpp"
#include "File/lwext4_include/ext4.h"
#include "Library/DebugCounter.hpp"
#include "Trap/Syscall/Syscall.hpp"
#include "Trap/Syscall/SyscallID.hpp"
#include <Driver/VirtioDisk.hpp>
#include <File/FileObject.hpp>
#include <File/myext4.hpp>
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
#include <Trap/Syscall/Syscall.hpp>
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

    int i = 0;
    while (1) {
        i++;
        kmalloc(20);
        kout << i << endl;
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
}

void Semaphore_test()
{
    Semaphore* SemTest(0);
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
    kout[Info] << "++++++++++++++++++=" << endl;
    Sector* sec = (Sector*)pmm.malloc(1468006, t);
    Disk.readSector(527215, sec, 1468006 / 512);
    // kout << DataWithSizeUnited(sec, sizeof(Sector), 16);
    // memset(sec,0,512);
    // kout<<DataWithSizeUnited(sec,sizeof(Sector),16);
    // Disk.writeSector(0, sec);
    // Disk.readSector(0, sec);
    kout << DataWithSizeUnited(sec, 1468006, 32);
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
    ext4node* file = new ext4node;
    // ext4node* file_next = new ext4node;

    vfsm.create_file("/", "/", "test_unlink");

    EXT4* t = (EXT4*)vfsm.get_root()->vfs;
    // ext4node * next=new ext4node;
    ASSERTEX(t, "vfs is nullptr");

    // file->close();
    t->get_next_file((ext4node*)vfsm.get_root(), nullptr, file);

    file_object* fo = new file_object();
    int i = 0;
    // kout.SetEnabledType(-1);
    while (file->offset != -1) {
        kout << i++ << " " << file->name << endl;

        t->get_next_file((ext4node*)vfsm.get_root(), file, file);
        kout[Info] << "VFSM_test" << endl;
        // kout <<"file-offset"<<file->offset<<endl;
        // kout[Error] << endl;
    }
    ext4node* f = (ext4node*)vfsm.open("busybox", "/");

    if (f) {
        kout << f->name << " find:" << endl;
        f->show();
    } else {
        kout[Fault] << "can't open" << endl;
    }
}

bool VFSM_test1(char i)
{

    char fn[20];
    char t[20] = { i, 0 };
    strcpy(fn, "fuck_fuck_you");
    // strcat(fn, t);
    kout << "____________________CREATE____________________" << endl;

    vfsm.create_file("/", "/", fn);
    kout << "____________________Find________________" << endl;
    ext4node* f = (ext4node*)vfsm.open("/fuck_fuck_you", "/");

    if (f) {
        kout << "test_unlink find:" << f->name << endl;
    } else {
        kout[Fault] << "can't open" << endl;
    }
    char* src = new char[8292];
    char* src1 = new char[8292];
    for (int i = 0; i < 8192; i++) {
        src[i] = (i % 256);
    }

    // kout<<DataWithSizeUnited(src,8192,32);
    f->write(src, 8292);
    f->show();
    f->read(src1, 10, 8292);
    kout << DataWithSizeUnited(src1, 8292, 32);
    /*
        f->write(src, 11, 8292);
        f->show();
        f->read(src1, 8292);
        kout << DataWithSizeUnited(src1, 8292, 32); */
}

bool VFSM_test2()
{
    FAT32* f = (FAT32*)vfsm.get_root()->vfs;

    FAT32FILE* file = (FAT32FILE*)vfsm.open("/bin", "/");
    f->show_all_file_in_dir(file);
}

void busybox_execve(char (*argvv)[20])
{

    file_object* fo = new file_object;
    ext4node* file = new ext4node;
    Process* test;
    int test_cnt = 0;
    EXT4* t = (EXT4*)vfsm.get_root()->vfs;
    t->get_next_file((ext4node*)vfsm.get_root(), nullptr, file);

    // kout << file;
    while (file->offset != -1) {
        if (file->fileSize == 0) {
            t->get_next_file((ext4node*)vfsm.get_root(), file, file);
            continue;
        }
        if (file->TYPE == FileType::__DIR) {
            t->get_next_file((ext4node*)vfsm.get_root(), file, file);
            continue;
        }
        fom.set_fo_file(fo, file);
        fom.set_fo_pos_k(fo, 0);
        Process* task;
        // if (strcmp(file->name, "runtest.exe") == 0) {
        // if (strcmp(file->name, "pipe2") == 0) {
        if (strcmp(file->name, argvv[0]) == 0) {
            // char argvv[20][100] = { "busybox","echo","hello",">","test.txt","\0" };
            // char argvv[20][100] = { "busybox","sh","busybox_testcode.sh","\0" };
            // char argvv[20][100] = { "busybox","expr","1","+","1","\0" };
            // char argvv[20][100] = {"runtest.exe", "-w","entry-static.exe","pthread_tsd" };
            // char argvv[20][100] = { "busybox", "cut","-c","3","test.txt" };
            // char argvv[20][100] = { "./busybox", "du" };
            // char argvv[20][100] = { "./busybox", "sh","test_all.sh" };
            // char argvv[20][100] = {"pipe2", "\0" };
            char* argv[20];
            int j = 0;
            while (argvv[j][0] != '\0') {
                argv[j] = argvv[j];
                j++;
            }
            argv[j] = nullptr;

            int argc = 0;
            while (argv[argc] != nullptr)
                argc++;
            // kout[Info] << "argc" << argc << endl;
            char** argv1 = new char*[argc];
            for (int i = 0; i < argc; i++) {
                // kout[Info] << "argv[" << i << "]" << argv[i] << endl;
                argv1[i] = strdump(argv[i]);
            }

            task = CreateProcessFromELF(fo, "/", argc, argv1);
            while (1) {
                if (task->getStatus() == S_Terminated) {
                    goto FinalTestEnd;
                }
            }
            kout << "END" << endl;
        }
        t->get_next_file((ext4node*)vfsm.get_root(), file, file);
    }

FinalTestEnd:
    kout << "finish test" << endl;
}

void final_test()
{

    file_object* fo = new file_object;
    ext4node* file = new ext4node;
    Process* test;
    int test_cnt = 0;
    EXT4* t = (EXT4*)vfsm.get_root()->vfs;
    t->get_next_file((ext4node*)vfsm.get_root(), nullptr, file);

    // kout << file;
    while (file->offset != -1) {
        if (file->fileSize == 0) {
            t->get_next_file((ext4node*)vfsm.get_root(), file, file);
            continue;
        }
        if (file->TYPE == FileType::__DIR) {
            t->get_next_file((ext4node*)vfsm.get_root(), file, file);
            continue;
        }
        fom.set_fo_file(fo, file);
        fom.set_fo_pos_k(fo, 0);
        Process* task;
        // if (strcmp(file->name, "runtest.exe") == 0) {
        // if (strcmp(file->name, "pipe2") == 0) {
        if (strcmp(file->name, "pipe2") == 0) {
            // char argvv[20][100] = { "busybox","echo","hello",">","test.txt","\0" };
            char argvv[20][100] = { "pipe2", "\0", "busybox_testcode.sh", "\0" };
            // char argvv[20][100] = { "busybox","expr","1","+","1","\0" };
            // char argvv[20][100] = {"runtest.exe", "-w","entry-static.exe","pthread_tsd" };
            // char argvv[20][100] = { "busybox", "cut","-c","3","test.txt" };
            // char argvv[20][100] = { "./busybox", "du" };
            // char argvv[20][100] = { "./busybox", "sh","test_all.sh" };
            // char argvv[20][100] = {"pipe2", "\0" };
            char* argv[20];
            int j = 0;
            while (argvv[j][0] != '\0') {
                argv[j] = argvv[j];
                j++;
            }
            argv[j] = nullptr;

            int argc = 0;
            while (argv[argc] != nullptr)
                argc++;
            // kout[Info] << "argc" << argc << endl;
            char** argv1 = new char*[argc];
            for (int i = 0; i < argc; i++) {
                // kout[Info] << "argv[" << i << "]" << argv[i] << endl;
                argv1[i] = strdump(argv[i]);
            }

            task = CreateProcessFromELF(fo, "/", argc, argv1);
            while (1) {
                if (task->getStatus() == S_Terminated) {
                    goto FinalTestEnd;
                }
            }
            kout << "END" << endl;
        }
        t->get_next_file((ext4node*)vfsm.get_root(), file, file);
    }

FinalTestEnd:
    kout << "finish test" << endl;
}

void test_final1()
{
    kout[Info] << "test_final1()" << endl;

    file_object* fo = (file_object*)kmalloc(sizeof(file_object));
    ext4node* file = new ext4node;
    Process* test;
    int test_cnt = 0;
    EXT4* t = (EXT4*)vfsm.get_root()->vfs;

    t->get_next_file((ext4node*)vfsm.get_root(), nullptr, file);
    // file->show();

    while (file->offset != -1) {
        kout[Info] << file->name << endl;
        if (file->fileSize == 0) {
            kout[Error] << "fileSize is 0" << endl;
            t->get_next_file((ext4node*)vfsm.get_root(), file, file);
            continue;
        }
        if (file->TYPE & FileType::__DIR) {
            kout[Error] << "fileType dir" << endl;
            t->get_next_file((ext4node*)vfsm.get_root(), file, file);
            continue;
        }

        fom.set_fo_file(fo, file);
        fom.set_fo_pos_k(fo, 0);
        // kout[Error] << file->name << endl;

        test = CreateProcessFromELF(fo, "/"); // 0b10的标志位表示不让调度器进行回收 在主函数手动回收

        if (test != nullptr) {
            while (1) {
                if (test->getStatus() == S_Terminated) {
                    kout << pm.getCurProc()->getName() << " main free Proc" << test->getName();
                    break;
                } else {
                    pm.immSchedule();
                }
            }
        }
        kout[Error] << file->name << endl;
        t->get_next_file((ext4node*)vfsm.get_root(), file, file);
    }
    // vfsm.show_all_opened_child(vfsm.get_root(), 1);
    // kout.SetEnabledType(-1);
    kout << "test finish" << endl;
}

static struct ext4_bcache* bc;
struct ext4_blockdev* ext4_blockdev_get(void);
static struct ext4_blockdev* bd;

void test_vfs()
{
    kout << "open_filedev start:" << endl;
    bd = ext4_blockdev_get();
    if (!bd) {
        kout << "open_filedev: fail" << endl;
        return;
    }

    kout << "ext4_device_register: start:" << endl;
    int r = ext4_device_register(bd, "ext4_fs");
    if (r != EOK) {
        kout << "ext4_device_register: rc = " << r << endl;
        return;
    }

    kout << "ext4_mount: start:" << endl;
    r = ext4_mount("ext4_fs", "/", false);
    if (r != EOK) {
        kout << "ext4_mount: rc =" << r << endl;
        return;
    }

    kout << "ext4_recover: start:" << endl;
    r = ext4_recover("/");
    if (r != EOK && r != ENOTSUP) {
        kout << "ext4_recover: rc =" << r << endl;
        return;
    }

    kout << "ext4_journal_start: start:" << endl;
    r = ext4_journal_start("/");
    if (r != EOK) {
        kout << "ext4_journal_start: rc = " << r << endl;
        return;
    }

    // ext4_cache_write_back("/", 1);

    ext4_dir ed;
    ext4_dir_open(&ed, "/");
    kout << "ext4_dir_open: sucess:" << endl;

    ext4node* temp = new ext4node;
    // temp->show();
    temp->RefCount++;
    EXT4* e1 = new EXT4;
    temp->initdir(ed, (char*)".root", e1);
    // temp->show();
    e1->root = temp;
    kout << "ready!" << endl;

    // e1->create_file(temp, "hello1.txt", __FILE);
    ext4node* t3 = e1->open("/hello1.txt/", temp);
    if (temp->child != nullptr) {
        e1->del(t3);
        if (temp->child == nullptr) {
            kout << "delete success" << endl;
        }
        // kout << temp->child->name << endl;
    }

    /*ext4node *t2 = e1->open("/hello1.txt/", temp);
    if (t2 != nullptr)
    {
        // kout<<"t2 name is:"<<t2->name<<endl;
        char *buf = new char[255];
        // kout<<(void*) t2<<" ";
        t2->read(buf, 9);
        kout << "read buf :" << buf << endl;
        delete[] buf;
    }*/

    ext4_cache_write_back("/", 0);

    r = ext4_journal_stop("/");
    if (r != EOK) {
        kout << "ext4_journal_stop: fail " << r << endl;
        return;
    }

    r = ext4_umount("/");
    if (r != EOK) {
        kout << "ext4_umount: fail " << r << endl;
        return;
    }
    return;
}

unsigned VMMINFO;
unsigned NEWINFO;
unsigned EXT;

extern int test_ext4();

void PreRun()
{
    FileNode* t;
    t = vfsm.open("/test_all.sh", "/");
    ASSERTEX(t, "t is nullptr");
    char* buf = new char[4096];
    char* re = new char[4096];
    memset(re, 0, 4096);
    char* buf1 = new char[512];
    int size, start = 0;
    size = t->read(buf, 4096);

    while ((start = readline(buf, buf1, size, start)) != -1) {
        if (buf1[0] == '#') {
            break;
        }
        if (buf1[strlen(buf1) - 1] == 'h' && buf1[strlen(buf1) - 2] == 's') {
            strcat(re, "busybox sh ");
        }
        strcat(re, buf1);
        strcat(re, "\n");
    }

    kout[Error] << "write back" << re << endl;
    t->write(re, strlen(re));

    vfsm.close(t);
    delete[] buf;
    delete[] buf1;
    delete[] re;
}

void mkdir()
{
    // FileNode * root=vfsm.get_root();
    // vfsm.create_file("/", "/","tmp1" );
    vfsm.create_dir("/", "/", "tmp");

    return;
}

int Syscall_newfstatat(int dirfd, const char* pathname, kstat* statbuf, int flags);
void test_fstat()
{
    kstat* statbuf = new kstat;
    // char * buf =new char[];
    EXT4* vfs = (EXT4*)vfsm.get_root()->vfs;
    while (1) {
        Syscall_newfstatat(-100, "./ltp/testcases/bin/data", statbuf, 0x1000);
        // ext4node * re = vfs->open("ltp/testcases/bin/data",vfsm.get_root() );
        // vfsm.close(re);
        kout[Debug] << pmm.getPageCount() << endl;
    }
}

int main()
{
    VMMINFO = kout.RegisterType("VMMINFO", KoutEX::Green);
    NEWINFO = kout.RegisterType("NEWINFO", KoutEX::Blue);
    EXT = kout.RegisterType("EXT4", KoutEX::Blue);

    kout.SwitchTypeOnoff(VMMINFO, false); // kout调试信息打印
    // kout.SetEnableEffect(false);
    kout.SetEnabledType(0);
    kout.SwitchTypeOnoff(Info, false);
    kout.SwitchTypeOnoff(Warning, false);
    kout.SwitchTypeOnoff(Fault, true);
    // kout.SwitchTypeOnoff(Test, true);
    // kout.SwitchTypeOnoff(Error, true);
    // kout.SwitchTypeOnoff(Debug, true);
    // kout.SwitchTypeOnoff(Warning, true);
    kout.SwitchTypeOnoff(EXT, false);
    // kout.SwitchTypeOnoff(Info, false);

    // kout.SwitchTypeOnoff(NEWINFO,false);
    TrapInit();
    ClockInit();

    kout[Info] << "System start success!" << endl;
    pmm.Init();
    // pmm.show();
    slab.Init();
    // pmm_test();
    VirtualMemorySpace::InitStatic();

    memCount = 0;

    Disk.DiskInit();
    vfsm.init();
    kout[Info] << "vfsm finish" << endl;

    pm.init();

    // A();

    kout[Info] << "Diskinit finish" << endl;
// #define RECOVER
#ifdef RECOVER
    test_vfs();
    SBI_SHUTDOWN();
#endif
    // new_test();
    // pm_test();
    InterruptEnable();


    // Banned_Syscall[SYS_pipe2]= 1;

    mkdir();
    // ./runtest.exe -w entry-dynamic.exe fdopen
    // char argvv1 [5][20] ={"runtest.exe","-w","entry-dynamic.exe","fscanf","\0"};
    // char argvv1 [5][20] ={"./pipe2","\0"};
    // char argvv1 [5][20] ={"busybox","sh","\0"};
    // busybox_execve(argvv1);

    char argvv1[5][20] = { "busybox", "echo", "run time-test", "\0" };
    busybox_execve(argvv1);
    char argvv2[5][20] = { "time-test", "\0" };
    busybox_execve(argvv2);
    char argvv5[5][20] = { "busybox", "echo", "run lua_testcode.sh", "\0" };
    busybox_execve(argvv5);

    char argvv6[5][20] = { "busybox", "sh", "test.sh", "date.lua", "\0" };
    busybox_execve(argvv6);
    char argvv20[5][20] = { "busybox", "sh", "test.sh", "file_io.lua", "\0" };
    busybox_execve(argvv20);
    char argvv7[5][20] = { "busybox", "sh", "test.sh", "max_min.lua", "\0" };
    busybox_execve(argvv7);
    char argvv8[5][20] = { "busybox", "sh", "test.sh", "random.lua", "\0" };
    busybox_execve(argvv8);
    char argvv11[5][20] = { "busybox", "sh", "test.sh", "sin30.lua", "\0" };
    busybox_execve(argvv11);
    char argvv9[5][20] = { "busybox", "sh", "test.sh", "remove.lua", "\0" };
    busybox_execve(argvv9);
    char argvv10[5][20] = { "busybox", "sh", "test.sh", "round_num.lua", "\0" };
    busybox_execve(argvv10);
    char argvv12[5][20] = { "busybox", "sh", "test.sh", "sort.lua", "\0" };
    busybox_execve(argvv12);
    char argvv13[5][20] = { "busybox", "sh", "test.sh", "strings.lua", "\0" };
    busybox_execve(argvv13);
    char argvv14[5][20] = { "busybox", "echo", "run libc-bench", "\0" };
    busybox_execve(argvv14);
    char argvv15[5][20] = { "busybox", "sh", "run-static.sh", "\0" };
    busybox_execve(argvv15);
    char argvv16[5][20] = { "busybox", "sh", "run-dynamic.sh", "\0" };
    busybox_execve(argvv16);

    Banned_Syscall[SYS_pipe2] = 0;
    char argvv17[5][20] = { "busybox", "sh", "busybox_testcode.sh", "\0" };
    busybox_execve(argvv17);

    vfsm.destory();
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
