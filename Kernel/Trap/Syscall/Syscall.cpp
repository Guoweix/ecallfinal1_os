#include "Driver/VirtioDisk.hpp"
#include "Error.hpp"
#include "File/lwext4_include/ext4_errno.h"
#include "File/myext4.hpp"
#include "Library/KoutSingle.hpp"
#include "Library/Kstring.hpp"
#include "Library/SBI.h"
#include "Memory/pmm.hpp"
#include "Memory/vmm.hpp"
#include "Synchronize/Sigaction.hpp"
#include "Synchronize/Synchronize.hpp"
#include "Trap/Interrupt.hpp"
#include "Trap/Trap.hpp"
#include "Types.hpp"
#include <File/FileObject.hpp>
#include <File/vfsm.hpp>
#include <Process/ParseELF.hpp>
#include <Process/Process.hpp>
#include <Trap/Clock.hpp>
#include <Trap/Syscall/Syscall.hpp>
#include <Trap/Syscall/SyscallID.hpp>

extern bool needSchedule;

bool Banned_Syscall[300];

void Syscall_Exit(TrapFrame* tf, int re)
{
    Process* cur = pm.getCurProc();
    cur->exit(re);
    kout[DeBug] << "EXit" << endl;
    needSchedule = true;
}

PtrSint Syscall_brk(PtrSint pos)
{
    HeapMemoryRegion* hmr = pm.getCurProc()->setHMS();
    if (hmr == nullptr)
        return -1;
    if (pos == 0)
        return hmr->BreakPoint();

    ErrorType err = hmr->Resize(pos - hmr->BreakPoint());
    if (err == ERR_None)
        return 0;
    else
        kout[Error] << "Syscall_brk failed ";
    return -1;
}

int Syscall_mkdirat(int dirfd, const char* path, int mode)
{
    // 创建目录的系统调用
    // 相关参数的解释可以参考open的系统调用
    // 成功返回0 失败返回-1

    char* rela_wd = new char[200];
    Process* cur_proc = pm.getCurProc();
    // kout<<"S1"<<endl;
    const char* cwd = cur_proc->getCWD();
    // kout<<"S2"<<endl;
    if (dirfd == AT_FDCWD) {
        // kout<<"S3"<<endl;
        // VirtualMemorySpace::Boot()->Enter();
        // kout<<(void *)cur_proc->getCWD()<<endl;
        // kout<<"S3"<<endl;
        strcpy(rela_wd, cur_proc->getCWD());
        // kout<<"S3"<<endl;
    } else {
        file_object* fo = fom.get_from_fd(cur_proc->getFoHead(), dirfd);
        if (fo != nullptr) {

            vfsm.get_file_path(fo->file, rela_wd);
        }
    }
    char* dir_path = new char[200];
    unified_path(rela_wd, rela_wd, dir_path);

    if (dir_path == nullptr) {
        return -1;
    }
    bool rt = vfsm.create_dir(dir_path, cwd, (char*)path);
    delete[] dir_path;
    delete[] rela_wd;
    if (!rt) {
        return -1;
    }
    return 0;
}

int Syscalll_chdir(const char* path)
{
    // 切换工作目录的系统调用
    // 传入要切换的工作目录的参数
    // 成功返回0 失败返回-1

    if (path == nullptr) {
        return -1;
    }
    // kout<<path<<endl;
    Process* cur_proc = pm.getCurProc();
    cur_proc->setProcCWD(path);
    return 0;
}

int Syscall_clone(TrapFrame* tf, int flags, void* stack, int ptid, int tls, int ctid)
{
    // 创建一个子进程系统调用
    // 成功返回子进程的线程ID 失败返回-1
    // 通过stack来进行fork还是clone
    // fork则是赋值父进程的代码空间 clone则是创建一个新的进程
    // tf参数是依赖于实现的 用来启动进程的

    constexpr Uint64 SIGCHLD = 17; // flags参数
    int pid_ret = -1;
    bool intr_flag;
    IntrSave(intr_flag); // 开关中断 操作的原语性
    Process* cur_proc = pm.getCurProc();
    Process* create_proc = pm.allocProc();
    if (create_proc == nullptr) {
        kout[Fault] << "SYS_clone alloc proc Fail!" << endl;
        return pid_ret;
    }
    create_proc->init(F_User);

    pid_ret = create_proc->getID();
    create_proc->setStack(nullptr, cur_proc->getStackSize());
    if (stack == nullptr) {
        // 根据clone的系统调用
        // 当stack为nullptr时 此时的系统调用和fork一致
        // 子进程和父进程执行的一段相同的二进制代码
        // 其实就是上下文的拷贝
        // 子进程的创建
        VirtualMemorySpace* vms = new VirtualMemorySpace;
        vms->Init();
        vms->CreateFrom(cur_proc->getVMS());
        create_proc->setVMS(vms);

        memcpy((void*)((TrapFrame*)((char*)create_proc->getStack() + create_proc->getStackSize()) - 1),
            (const char*)tf, sizeof(TrapFrame));
        create_proc->setContext((TrapFrame*)((char*)create_proc->getStack() + create_proc->getStackSize()) - 1);
        create_proc->getContext()->epc += 4;
        create_proc->getContext()->reg.a0 = 0;
    } else {
        // 此时就是相当于clone
        // 创建一个新的线程 与内存间的共享有关
        // 线程thread的创建
        // 这里其实隐含很多问题 涉及到指令执行流这些 需要仔细体会
        // 在大赛要求和本内核实现下仅仅是充当创建一个函数线程的作用
        create_proc->setVMS(cur_proc->getVMS());
        // pm.getCurProc()->getVMS()->show();
        // kout<<"_____________________________________________________________" <<endl;
        // create_proc->getVMS()->show();
        // kout<<"_____________________________________________________________" <<endl;
        memcpy((void*)((TrapFrame*)((char*)create_proc->getStack() + create_proc->getStackSize()) - 1),
            (const char*)tf, sizeof(TrapFrame));
        create_proc->setContext((TrapFrame*)((char*)create_proc->getStack() + create_proc->getStackSize()) - 1);
        create_proc->getContext()->epc += 4;
        create_proc->getContext()->reg.sp = (Uint64)stack;
        create_proc->getContext()->reg.a0 = 0; // clone里面子线程去执行函数 父线程返回
    }
    // pm.copy_other_proc(create_proc, cur_proc);
    create_proc->copyFromProc(cur_proc);
    if (flags & SIGCHLD) {
        // clone的是子进程
        char* name = new char[50];
        strcpy(name, cur_proc->getName());
        strcat(name, "_child");
        create_proc->setName(name);
        delete[] name;

        create_proc->setFa(cur_proc);
    }
    // pm.switchstat_proc(create_proc, Proc_ready);
    create_proc->switchStatus(S_Ready);
    // pm.show(1);
    IntrRestore(intr_flag);
    return pid_ret;
}

char* Syscall_getcwd(char* buf, Uint64 size)
{
    // 获取当前工作目录的系统调用
    // 传入一块字符指针缓冲区和大小
    // 成功返回当前工作目录的字符指针 失败返回nullptr

    if (buf == nullptr) {
        // buf为空时由系统分配缓冲区
        buf = (char*)kmalloc(size * sizeof(char));
    } else {
        Process* cur_proc = pm.getCurProc();
        const char* cwd = cur_proc->getCWD();

        kout[Warning] << cwd << "_______________________" << endl;

        POS::Uint64 cwd_len = strlen(cwd);
        if (cwd_len > 0 && cwd_len < size) {
            strcpy(buf, cwd);
        } else {
            kout[Warning] << "SYS_getcwd the Buf Size is Not enough to Store the cwd!" << endl;
            return nullptr;
        }
    }
    return buf;
}

int Syscall_getpid()
{
    // 获取进程PID的系统调用
    // always successful

    Process* cur_proc = pm.getCurProc();
    return cur_proc->getID();
}

int Syscall_getppid()
{
    // 获取父进程PID的系统调用
    // 直接成功返回父进程的ID
    // 根据系统调用规范此调用 always successful

    Process* cur_proc = pm.getCurProc();
    Process* fa_proc = cur_proc->father;

    if (fa_proc == nullptr) {
        // kout << Yellow << "getppid::nofather" << endl;
        // 调用规范总是成功
        // 如果是无父进程 可以认为将该进程挂到根进程的孩子进程下
        return pm.getidle()->getID() + 1;
    } else {
        // kout << Yellow << "getppid::father" << fa_proc->getID() << endl;
        return fa_proc->getID() + 1;
    }
    return -1;
}

int Syscall_execve(const char* path, char* const argv[], char* const envp[])
{
    // 执行一个指定的程序的系统调用
    // 关键是利用解析ELF文件创建进程来实现
    // 这里需要文件系统提供的支持
    // argv参数是程序参数 envp参数是环境变量的数组指针 暂时未使用
    // 执行成功跳转执行对应的程序 失败则返回-1
    // pm.show();
    VirtualMemorySpace::EnableAccessUser();
    Process* cur_proc = pm.getCurProc();
    // kout[Info] << "execve" << endl;
    FileNode* file_open = vfsm.open(path, "/");
    // kout[Info] << "execve open finish" << endl;

    if (file_open == nullptr) {
        kout[Error] << "SYS_execve open File Fail!" << endl;
        return -1;
    }

    // kout[Info] << "execve 1 " << endl;
    file_object* fo = new file_object;
    fom.set_fo_file(fo, file_open);
    fom.set_fo_pos_k(fo, 0);
    fom.set_fo_flags(fo, file_flags::RDONLY);

    int argc = 0;
    while (argv[argc] != nullptr)
        argc++;
    kout[Info] << "argc" << argc << endl;
    char** argv1 = new char*[argc];
    for (int i = 0; i < argc; i++) {
        kout[Info] << "argv[" << i << "]" << argv[i] << endl;
        argv1[i] = strdump(argv[i]);
    }

    kout[DeBug] << "creaet_Process ELF" << endl;
    Process* new_proc = CreateProcessFromELF(fo, cur_proc->getCWD(), argc, argv1);
    kout[DeBug] << "creaet_Process ELF finish" << endl;

    new_proc->destroyFds();

    new_proc->copyFds(cur_proc);

    // kout[Info] << "execve 4 " << endl;
    int exit_value = 0;
    if (new_proc == nullptr) {
        kout[Error] << "SYS_execve CreateProcessFromELF Fail!" << endl;
        return -1;
    } else {
        // 这里的new_proc其实也是执行这个系统调用进程的子进程
        // 因此这里父进程需要等待子进程执行完毕后才能继续执行
        Process* child = nullptr;
        while (1) {
            // 去寻找已经结束的子进程
            // 当前场景的执行逻辑上只会有一个子进程
            Process* pptr = nullptr;
            for (pptr = cur_proc->fstChild; pptr != nullptr; pptr = pptr->broNext) {
                if (pptr->getStatus() == S_Terminated && pptr == new_proc) {
                    // kout[DeBug]<<" find death child "<<pptr->id<<endl;
                    child = pptr;
                    break;
                }
            }
            if (child == nullptr) {
                // 说明当前进程应该被阻塞了
                // 触发进程管理下的信号wait条件
                // 被阻塞之后就不会再调度这个进程了 需要等待子进程执行完毕后被唤醒
                cur_proc->getSemaphore()->wait(cur_proc);
                pm.immSchedule();
            } else {
                // 在父进程里回收子进程
                VirtualMemorySpace::EnableAccessUser();
                exit_value = child->getExitCode();
                VirtualMemorySpace::DisableAccessUser();
                child->destroy();
                pm.freeProc(child);
                break;
            }
        }
    }
    // 顺利执行了execve并回收了子进程
    // 当前进程就执行完毕了 直接退出
    // VirtualMemorySpace::DisableAccessUser();
    // pm.exit_proc(cur_proc, exit_value);
    cur_proc->exit(exit_value);
    kfree(fo);
    pm.immSchedule();
    kout[Fault] << "SYS_execve reached unreacheable branch!" << endl;
    return -1;
}

/*
int Syscall_execve(const char* path, char* const argv[], char* const envp[])
{
    // 执行一个指定的程序的系统调用
    // 关键是利用解析ELF文件创建进程来实现
    // 这里需要文件系统提供的支持
    // argv参数是程序参数 envp参数是环境变量的数组指针 暂时未使用
    // 执行成功跳转执行对应的程序 失败则返回-1
    // pm.show();
    VirtualMemorySpace::EnableAccessUser();
    Process* cur_proc = pm.getCurProc();
    FileNode* file_open = vfsm.open(path, "/");

    if (file_open == nullptr) {
        kout[Error] << "SYS_execve open File Fail!" << endl;
        return -1;
    }

    // kout[Info] << "execve 1 " << endl;
    file_object* fo = (file_object*)kmalloc(sizeof(file_object));
    fom.set_fo_file(fo, file_open);
    fom.set_fo_pos_k(fo, 0);
    fom.set_fo_flags(fo, file_flags::RDONLY);

    // kout[Info] << "execve 2 " << endl;

    int argc = 0;
    while (argv[argc] != nullptr)
        argc++;
    kout[Info] << "argc" << argc << endl;
    char** argv1 = new char*[argc];
    for (int i = 0; i < argc; i++) {
        kout[Info] << "argv[" << i << "]" << argv[i] << endl;
        argv1[i] = strdump(argv[i]);
    }

    // kout[Info] << "execve 3 " << endl;

    Process* new_proc = CreateProcessFromELF(fo, cur_proc->getCWD(), argc, argv1,cur_proc->GetFlags(),cur_proc);

    file_object * t=new_proc->getFoHead();
    new_proc->fo_head=nullptr;



    vfsm.close(file_open);


    pm.immSchedule();
    // kout[Fault] << "SYS_execve reached unreacheable branch!" << endl;
    return -1;
}

*/
int Syscall_wait4(int pid, int* status, int options)
{
    // 等待进程改变状态的系统调用
    // 这里的改变状态主要是指等待子进程结束
    // pid是指定进程的pid -1就是等待所有子进程
    // status是接受进程退出状态的指针
    // options是指定选项 可以参考linux系统调用文档
    // 这里主要有WNOHANG WUNTRACED WCONTINUED
    // WNOHANG:return immediately if no child has exited.
    // 成功返回进程ID

    constexpr int WNOHANG = 1; // 目前暂时只需要这个option
    Process* cur_proc = pm.getCurProc();
    if (cur_proc->fstChild == nullptr) {
        // 当前父进程没有子进程
        // 一般调用此函数不存在此情况
        kout[Warning] << "The Process has Not Child Process!" << endl;
        return -1;
    }

    while (1) {

        Process* child = nullptr;
        Process* pptr = nullptr;

        for (pptr = cur_proc->fstChild; pptr != nullptr; pptr = pptr->broNext) {
            if (pptr->getStatus() == S_Terminated) {
                // 找到对应的进程
                if (pid == -1 || pptr->getID() == pid) {
                    child = pptr;
                    break;
                }
            }
        }

        if (child != nullptr) {
            // 当前的child进程即需要wait的进程
            int ret = child->getID();
            if (status != nullptr) {
                // status非空则需要提取相应的状态
                VirtualMemorySpace::EnableAccessUser();

                *status = child->getExitCode() << 8; // 左移8位主要是Linux系统调用的规范

                VirtualMemorySpace::DisableAccessUser();
            }
            // kout<<"SSSSSSSSSSSSSSS"<<endl;
            // child->getVMS()->show();

            // pm.getCurProc()->getVMS()->show();
            child->destroy();
            kout << Red << cur_proc->getName() << "wait4 freeProc " << child->getName();
            pm.freeProc(child); // 回收子进程 子进程的回收只能让父进程来进行
            kout[Info] << "child DEAD   " << ret << endl;
            return ret;
        } else if (options & WNOHANG) {
            // 当没有找到符合的子进程但是options中指定了WNOHANG
            // 直接返回 -1即可
            return -1;
        } else {
            // 说明还需要等待子进程
            // pm.calc_systime(cur_proc); // 从这个时刻之后的wait时间不应被计算到systime中
            cur_proc->getSemaphore()->wait(); // 父进程在子进程上等待 当子进程exit后解除信号量等待可以被回收
            // kout[Info] << "SSSSSSSSSSSSS" << endl;
            pm.immSchedule();
            // kout<<"EEEEEE"<<endl;
        }
        // kout<<"EEEEEE"<<endl;
    }
    return -1;
}

int Syscall_sched_yeild()
{
    needSchedule = true;
    return 0;
}

enum STAT_MODE {

    __S_IFDIR = 0040000, /* Directory.  */
    __S_IFCHR = 0020000, /* Character device.  */
    __S_IFBLK = 0060000, /* Block device.  */
    __S_IFREG = 0100000, /* Regular file.  */
    __S_IFIFO = 0010000, /* FIFO.  */
    __S_IFLNK = 0120000, /* Symbolic link.  */
    __S_IFSOC = 0140000, /* Socket.  */

    /* POSIX.1b objects.  Note that these macros always evaluate to zero.  But
       they do it by enforcing the correct use of the macros.  */
    // __S_TYPEISMQ(buf)  ((buf)->st_mode - (buf)->st_mode)
    // __S_TYPEISSEM(buf) ((buf)->st_mode - (buf)->st_mode)
    // __S_TYPEISSHM(buf) ((buf)->st_mode - (buf)->st_mode)

    /* Protection bits.  */

    __S_ISUID = 04000, /* Set user ID on execution.  */
    __S_ISGID = 02000, /* Set group ID on execution.  */
    __S_ISVTX = 01000, /* Save swapped text after use (sticky).  */
    __S_IREAD = 0400, /* Read by owner.  */
    __S_IWRITE = 0200, /* Write by owner.  */
    __S_IEXEC = 0100, /* Execute by owner.  */
    __S_IRWX = __S_IWRITE | __S_IEXEC | __S_IREAD,

};

int Syscall_fstat(int fd, kstat* kst)
{
    // 获取文件状态的系统调用
    // 输入fd为文件句柄 kst为接收保存文件状态的指针
    // 目前只需要填充几个值
    // 成功返回0 失败返回-1
    // kout[Info] << "SYScall :: fstat" << endl;
    if (kst == nullptr) {
        return -1;
    }

    Process* cur_proc = pm.getCurProc();
    file_object* fo = fom.get_from_fd(cur_proc->fo_head, fd);
    if (fo == nullptr) {
        return -1;
    }
    FileNode* file = fo->file;
    if (file == nullptr) {
        return -1;
    }
    // kout << "fstat file " << file->name << " file:table_size " << file->fileSize << endl;
    VirtualMemorySpace::EnableAccessUser();
    memset(kst, 0, sizeof(kstat));
    kst->st_size = file->fileSize;
    kst->st_nlink = 1;
    kst->st_uid = 0;
    kst->st_gid = 0;
    kst->st_mode = __S_IRWX;
    if (file->TYPE & FileType::__DIR) {
        kst->st_mode |= 0040000;
    } else {
        kst->st_mode |= __S_IFREG;
    }
    // ... others to be added
    VirtualMemorySpace::DisableAccessUser();
    // kout << Green << "fstat Success" << DataWithSizeUnited(kst, sizeof(kstat), 12);
    return 0;
}

int Syscall_linkat(int olddirfd, char* oldpath, int newdirfd, char* newpath, unsigned flags)
{
    Process* curProc = pm.getCurProc();

    VirtualMemorySpace::EnableAccessUser();

    VirtualMemorySpace::DisableAccessUser();

    return -1;
}
Uint64 Syscall_times(tms* tms)
{
    // 获取进程时间的系统调用
    // tms结构体指针 用于获取保存当前进程的运行时间的数据
    // 成功返回已经过去的滴答数 即real time
    // 这里的time基本即指进程在running态的时间
    // 系统调用规范指出为花费的CPU时间 故仅考虑运行时间
    // 而对于running态时间的记录进程结构体中在每次从running态切换时都会记录
    // 对于用户态执行的时间不太方便在用户态记录
    // 这里我们可以认为一个用户进程只有在陷入系统调用的时候才相当于在使用核心态的时间
    // 因此我们在每次系统调用前后记录本次系统调用的时间并加上
    // 进而用总的runtime减去这个时间就可以得到用户时间了
    // 记录这个时间的成员在进程结构体中提供为systime

    Process* cur_proc = pm.getCurProc();
    Uint64 time_unit = 10; // 填充tms结构体的基本时间单位 在qemu上模拟 以微秒为单位
    if (tms != nullptr) {
        Uint64 run_time = cur_proc->runTime + Timer_10ms; // 总运行时间
        Uint64 sys_time = cur_proc->sysTime; // 用户陷入核心态的system时间
        Uint64 user_time = run_time - sys_time; // 用户在用户态执行的时间
        kout << Red << cur_proc->runTime << endl;
        kout << Red << cur_proc->sysTime << endl;
        if ((long long)run_time < 0 || (long long)sys_time < 0 || (long long)user_time < 0) {
            // 3个time有一个为负即认为出错调用失败了
            // 返回-1
            return -1;
        }
        cur_proc->VMS->EnableAccessUser(); // 在核心态操作用户态的数据
        tms->tms_utime = user_time / time_unit;
        tms->tms_stime = sys_time / time_unit;
        // 基于父进程执行到这里时已经wait了所有子进程退出并被回收了
        // 故直接置0
        tms->tms_cutime = 0;
        tms->tms_sutime = 0;
        Process* child = cur_proc->fstChild;
        while (child) {
            tms->tms_cutime += (child->runTime - child->sysTime) / time_unit;
            tms->tms_sutime += child->sysTime / time_unit;
            child = child->broNext;
        }

        cur_proc->VMS->DisableAccessUser();
    }
    return GetClockTime();
}

struct timeval {
    Uint64 sec; // 自 Unix 纪元起的秒数
    Uint64 usec; // 微秒数
};

inline int Syscall_gettimeofday(timeval* ts, int tz = 0)
{
    // 获取时间的系统调用
    // timespec结构体用于获取时间值
    // 成功返回0 失败返回-1

    if (ts == nullptr) {
        return -1;
    }

    // 其他需要的信息测试平台已经预先软件处理完毕了
    VirtualMemorySpace::EnableAccessUser();
    Uint64 cur_time = GetClockTime();
    ts->sec = cur_time / Timer_1s;
    ts->usec = (cur_time % Timer_1s) / 10;
    VirtualMemorySpace::DisableAccessUser();
    return 0;
}

struct utsname {
    char sysname[65];
    char nodename[65];
    char release[65];
    char version[65];
    char machine[65];
    char domainname[65];
};

inline int Syscall_uname(utsname* uts)
{
    // 打印系统信息的系统调用
    // utsname结构体指针用于获取系统信息数据
    // 成功返回0 失败返回-1
    // 相关信息的字符串处理

    if (uts == nullptr) {
        return -1;
    }

    // 操作用户区的数据
    // 需要从核心态进入用户态
    VirtualMemorySpace::EnableAccessUser();
    strcpy(uts->sysname, "ECALLFINAL1_OperatingSystem");
    strcpy(uts->nodename, "ECALLFINAL1_OperatingSystem");
    strcpy(uts->release, "Debug");
    strcpy(uts->version, "1.0");
    strcpy(uts->machine, "RISCV 64");
    strcpy(uts->domainname, "DBStars");
    VirtualMemorySpace::DisableAccessUser();

    return 0;
}

int Syscall_unlinkat(int dirfd, char* path, int flags)
{
    // 移除指定文件的链接(可用于删除文件)的系统调用
    // dirfd是要删除的链接所在的目录
    // path是要删除的链接的名字
    // flags可设置为0或AT_REMOVEDIR
    // 成功返回0 失败返回-1
    kout << "Unlinkat dir fd " << dirfd << endl;

    char* rela_wd = new char[200];
    Process* cur_proc = pm.getCurProc();
    const char* cwd = cur_proc->getCWD();
    if (dirfd == AT_FDCWD) {

        strcpy(rela_wd, cur_proc->getCWD());

    } else {
        file_object* fo = fom.get_from_fd(cur_proc->fo_head, dirfd);
        if (fo != nullptr) {
            vfsm.get_file_path(fo->file, rela_wd);
        } else {
            kout << "unlink can't find file" << endl;
            delete[] rela_wd;
            return -1;
        }
    }

    if (path[0] == '.' && path[1] != '.') {
        path += 2;
    }
    // vfsm.show_opened_file();
    VirtualMemorySpace::EnableAccessUser();
    if (!vfsm.unlink(path, rela_wd)) {
        kout << "unlink failed" << endl;
        delete[] rela_wd;
        return -1;
    }
    VirtualMemorySpace::DisableAccessUser();
    kout << Green << "Unlinkat 6" << endl;

    delete[] rela_wd;
    return 0;
}

inline long long Syscall_write(int fd, void* buf, Uint64 count)
{
    // 从一个文件描述符写入
    // 输入fd为一个文件描述符
    // buf为要写入的内容缓冲区 count为写入内容的大小字节数
    // 成功返回写入的字节数 失败返回-1

    if (buf == nullptr) {
        return -1;
    }

    VirtualMemorySpace::EnableAccessUser();
    kout[DeBug] << "write " << fd <<" count "<<count<<" buf "<<(char *)buf<< endl;
    // if (fd == STDOUT_FILENO) {
    // VirtualMemorySpace::EnableAccessUser();
    // kout << Yellow << buf << endl;
    // for (int i = 0; i < count; i++) {
    // putchar(((char*)buf)[i]);
    // kout << (uint64)((char*)buf)[i] << endl;
    // }
    // VirtualMemorySpace::DisableAccessUser();
    // return count;
    // }

    Process* cur_proc = pm.getCurProc();
    file_object* fo = fom.get_from_fd(cur_proc->fo_head, fd);
    if (fo == nullptr) {
        return -1;
    }

    // 向标准输出写
    /*     if (fo->tk_fd == STDOUT_FILENO) {
            // putchar('s');
            VirtualMemorySpace::EnableAccessUser();
            for (int i = 0; i < count; i++) {
                putchar(*((char*)buf + i));
            }
            VirtualMemorySpace::DisableAccessUser();
            return count;
        }
     */
    // 分配内核缓冲区
    unsigned char* buf1 = new unsigned char[count];
    memcpy(buf1, (const char*)buf, count);
    long long wr_size = 0;

    wr_size = fom.write_fo(fo, buf1, count);
    delete[] buf1;

    VirtualMemorySpace::DisableAccessUser();

    if (wr_size < 0) {
        return -1;
    }

    kout << Green << "wirte Success " << wr_size << endl;

    // FAT32FILE * tst=vfsm.
    // kout[Fault]<<endl;

    return wr_size;
}

inline long long Syscall_read(int fd, void* buf, Uint64 count)
{
    // 从一个文件描述符中读取的系统调用
    // fd是要读取的文件描述符
    // buf是存放读取内容的缓冲e区 count是要读取的字节数
    // 成功返回读取的字节数 0表示文件结束 失败返回-1


    if (buf == nullptr) {
        return -1;
    }

    Process* cur_proc = pm.getCurProc();
    file_object* fo = fom.get_from_fd(cur_proc->fo_head, fd);
    if (fo == nullptr) {
        kout[Error] << "Syscall_read can't open fd " << endl;
        return -1;
    }
    // kout<<Yellow<<"read2"<<endl;
    VirtualMemorySpace::EnableAccessUser();
    long long rd_size = 0;
    unsigned char* buf1 = new unsigned char[count];

    /*
     char a[100];
     fo->file->read(a,100);
     kout<<Red<<a<<endl;
      */
    rd_size = fom.read_fo(fo, buf1, count);
    kout[DeBug] << "read " << fd <<" count "<<count<< " read_se "<<rd_size<<endl;
    if (rd_size == 0) {
        kout[Error] << "Syscall_read rd_size is 0" << endl;
        return 0;
    }
    memcpy(buf, (const char*)buf1, count);
    delete[] buf1;
    // kout<<DataWithSizeUnited(buf,27,16);;
    // kout<<Yellow<<"read4"<<endl;
    VirtualMemorySpace::DisableAccessUser();
    if (rd_size < 0) {
        kout[Error] << "Syscall_read  read failed" << endl;
        // return -1;
        return 0;//??
    }

    return rd_size;
}

inline RegisterData Syscall_fcntl(int fd, int cmd, TrapFrame* tf)
{
    file_object* fh = fom.get_from_fd(pm.getCurProc()->getFoHead(), fd);
    if (fh == nullptr) {
        kout[Warning] << "can't get_from_fd" << fd << endl;
        return -1;
    }

    enum {
        F_DUPFD = 0,
        F_GETFD = 1,
        F_SETFD = 2,
        F_GETFL = 3,
        F_SETFL = 4,
        F_SETOWN = 8,
        F_GETOWN = 9,
        F_SETSIG = 10,
        F_GETSIG = 11,
        F_DUPFD_CLOEXEC = 1030,

    };

    int re = -1;
    file_object* t;

    kout[Info] << "fcntl fd" << fd << " CMD " << cmd << endl;
    switch (cmd) {
    case F_SETFD:
        t = fom.get_from_fd(pm.getCurProc()->getFoHead(), fd);
        re = -1;
        if (fom.set_fo_flags(t, (file_flags)tf->reg.a2)) {
            re = 0;
        }
        break;
    case F_DUPFD_CLOEXEC: {
        file_object* fo_new = fom.duplicate_fo(fh);
        if (fo_new == nullptr) {
            return -1;
        }
        int ret_fd = -1;
        // 将复制的新的文件描述符直接插入当前的进程的文件描述符表
        ret_fd = fom.add_fo_tolist(pm.getCurProc()->fo_head, fo_new);
        fom.set_fo_flags(fo_new, file_flags::CLOEXEC);
        // char a[100];
        // fo_new->file->read(a,100);
        // kout[DeBug]<<"dup_fo fd "<<a<<endl;
        return ret_fd;

    } break;
    default:
        kout[Warning] << "Unknown fcnt cmd  fd" << fd << " CMD " << cmd << endl;

        return -1;
    }
    return re;
}

int Syscall_sigaction(int signum, const struct sigaction* act, struct sigaction* oldact)
{

    kout[Warning] << "Syscall_sigaction " << signum << " " << act << " " << oldact << endl;
    if (act == nullptr) {
        return -1;
    }
    sigaction* act1 = new sigaction;
    act1->sa_sigaction = act->sa_sigaction;
    act1->sa_flags = act->sa_flags;
    act1->sa_mask = act->sa_mask;
    SIGNUM* a = act->sa_mask;
    // while (a!=0) {
    // kout[Info]<<a<<endl;
    // a++;
    // }
    act1->sa_handler = act->sa_handler;
    if (act1 != nullptr) {
        pm.getCurProc()->sigQueue.enqueue(act1);
    }

    kout[Warning] << "Syscall_sigaction end" << endl;
    return 0;
}

inline int Syscall_close(int fd)
{
    // 关闭一个文件描述符的系统调用
    // 传入参数为要关闭的文件描述符
    // 成功执行返回0 失败返回-1

    Process* cur_proc = pm.getCurProc();

    file_object* fo = fom.get_from_fd(cur_proc->fo_head, fd);

    if (fo == nullptr) {
        return -1;
    }

    kout[Info] << fo->file->name << endl;
    // vfsm.show_opened_file();
    // vfsm.close(fo->file);
    // vfsm.show_opened_file();
    if (!fom.close_fo(cur_proc, fo)) {
        // fom中的close_fo调用会关闭这个文件描述符
        // 主要是对相关文件的解引用并且从文件描述符表中删去这个节点
        kout << "close error" << endl;
        return -1;
    }

    kout[Debug] << "close success " << fd << endl;
    return 0;
}

inline int Syscall_dup(int fd)
{
    // 复制文件描述符的系统调用
    // 传入被复制的文件描述符
    // 成功返回新的文件描述符 失败返回-1

    Process* cur_proc = pm.getCurProc();
    file_object* fo = fom.get_from_fd(cur_proc->fo_head, fd);
    if (fo == nullptr || fom.get_count_fdt(fo) > 1000) {
        // 当前文件描述符不存在
        return -1;
    }
    file_object* fo_new = fom.duplicate_fo(fo);
    if (fo_new == nullptr) {
        return -1;
    }
    int ret_fd = -1;
    // 将复制的新的文件描述符直接插入当前的进程的文件描述符表
    ret_fd = fom.add_fo_tolist(cur_proc->fo_head, fo_new);

    kout[Debug]<<"dup "<<fd<<" return "<<ret_fd<<endl;
    // if (ret_fd==4) {//trick
        // return 0; 
    // }
    return ret_fd;
}

inline int Syscall_dup3(int old_fd, int new_fd)
{
    // 复制文件描述符同时指定新的文件描述符的系统调用
    // 成功执行返回新的文件描述符 失败返回-1

    if (old_fd == new_fd) {
        return new_fd;
    }

    Process* cur_proc = pm.getCurProc();
    file_object* fo_old = fom.get_from_fd(cur_proc->fo_head, old_fd);
    if (fo_old == nullptr) {
        return -1;
    }
    file_object* fo_new = fom.duplicate_fo(fo_old);
    if (fo_new == nullptr) {
        return -1;
    }
    // 先查看指定的新的文件描述符是否已经存在
    file_object* fo_tmp = nullptr;
    fo_tmp = fom.get_from_fd(cur_proc->fo_head, new_fd);
    if (fo_tmp != nullptr) {
        // 指定的新的文件描述符已经存在
        // 将这个从文件描述符表中删除
        vfsm.close(fo_tmp->file);

        fom.delete_flobj(cur_proc->fo_head, fo_tmp);
    }

    // 没有串口 继续trick
    // if (old_fd == STjDOUT_FILENO) {
    // fo_new->tk_fd = STDOUT_FILENO;
    // }

    fom.set_fo_fd(fo_new, new_fd);
    // 再将这个新的fo插入进程的文件描述符表
    int rd = fom.add_fo_tolist(cur_proc->fo_head, fo_new);
    if (rd != new_fd) {
        return -1;
    }
    return rd;
}

int Syscall_openat(int fd, const char* filename, int flags, int mode)
{
    // 打开或创建一个文件的系统调用
    // fd为文件所在目录的文件描述符
    // filename为要打开或创建的文件名
    // 如果为绝对路径则忽略fd
    // 如果为相对路径 且fd是AT_FDCWD 则filename相对于当前工作目录
    // 如果为相对路径 且fd是一个文件描述符 则filename是相对于fd所指向的目录来说的
    // flags为访问模式 必须包含以下一种 O_RDONLY O_WRONLY O_RDWR
    // mode为文件的所有权描述
    // 成功返回新的文件描述符 失败返回-1
    // kout << Red << "OpenedFile" << endl;
    kout[DeBug] << "openat fd " << fd << " file_name " << filename << endl;

    VirtualMemorySpace::EnableAccessUser();
    char* rela_wd = new char[200];
    Process* cur_proc = pm.getCurProc();
    // kout << Red << "OpenedFile1" << endl;
    const char* cwd = cur_proc->getCWD();
    kout << Red << "CWD " << cwd << endl;
    if (fd == AT_FDCWD) {
        kout << Red << "OpenedFile3" << endl;
        strcpy(rela_wd, cur_proc->getCWD());
    } else {
        kout << Red << "OpenedFile4" << endl;
        file_object* fo = fom.get_from_fd(cur_proc->fo_head, fd);
        // kout << Red << "OpenedFile5" << endl;
        if (fo != nullptr) {
            rela_wd = new char[200];
            rela_wd[0] = 0;
            kout[Info] << "find path " << fo->file->parent->name << endl;
            vfsm.get_file_path(fo->file, rela_wd);
        }
    }

    // kout << Red << rela_wd << endl;

    if (flags & (Uint64)file_flags::CREAT) {
        // 创建文件或目录
        // 创建则在进程的工作目录进行
        kout << Red << "OpenedFile6" << endl;
        if (flags & file_flags::DIRECTORY) {
            kout << Red << "OpenedFile6 DIR" << endl;
            vfsm.create_dir(rela_wd, cwd, (char*)filename);
        } else {
            kout << Red << "OpenedFile6 FILE" << endl;
            kout[Info] << "creaet_file " << rela_wd << " " << cwd << " " << filename << endl;
            if (!vfsm.create_file(rela_wd, cwd, (char*)filename))
            {
                // kout[Fault] << "create file" << endl;
                return -1;
            }
        }
    }

    // char* path = vfsm.unified_path(filename, rela_wd);
    // kout << Red << "OpenedFile8" << endl;
    // if (path == nullptr) {
    //     return -1;
    // }
    // kout << Red << "OpenedFile9" << endl;

    // trick
    // 暂时没有对于. 和 ..的路径名的处理
    // 特殊处理打开文件当前目录.的逻辑
    FileNode* file = nullptr;

    // if (filename[0] == '.' && filename[1] != '.') {
    //     int str_len = strlen(filename);
    //     char* str_spc = new char[str_len];
    //     strcpy(str_spc, filename + 1);
    //     kout << Red << "OpenedFile10" << endl;
    //     kout << Red << str_spc << endl;
    //     file = vfsm.open(str_spc, rela_wd);
    // } else {
    kout << Red << "OpenedFile11" << endl;
    //     file = vfsm.open(filename, rela_wd);
    // }

    kout[Info] << filename << ' ' << rela_wd << endl;
    file = vfsm.open(filename, rela_wd);

    // file->show();

    if (file != nullptr) {
        kout << Red << "OpenedFile12" << endl;
        if (!(file->TYPE & FileType::__DIR) && (flags & DIRECTORY)) {
            file = nullptr;
        }
    } else {
        delete[] rela_wd;
        kout[Warning] << "SYS_openat can't open file" << endl;
        return -1;
    }

    file_object* fo = fom.create_flobj(cur_proc->fo_head);

    // kout << Red << "SYSCALL__openat::create_flobj fo_head"<< cur_proc->fo_head  << endl;
    if (fo == nullptr || fo->fd < 0) {
        delete[] rela_wd;
        return -1;
    }
    kout << Red << "OpenedFile14" << endl;
    if (file != nullptr) {
        fom.set_fo_file(fo, file);
        fom.set_fo_flags(fo, (file_flags)flags);
        fom.set_fo_mode(fo, mode);
        kout << Red << "OpenedFile15" << endl;
    }
    // kfree(path);

    // file->show();
    // kout << Green << "Open Success1" << endl;

    kout << Green << "Syscall_open fd is " << fo->fd << endl;
    VirtualMemorySpace::DisableAccessUser();
    delete[] rela_wd;
    return fo->fd;
}

int Syscall_mount(const char* special, const char* dir, const char* fstype, Uint64 flags, const void* data)
{
    return 0;
}
int Syscall_umount2(const char* special, int flags)
{
    return 0;
}

int Syscall_munmap(void* start, Uint64 len)
{
    VirtualMemorySpace* vms = pm.getCurProc()->getVMS();
    VirtualMemoryRegion* vmr = vms->FindVMR((PtrSint)start);
    if (vmr == nullptr)
        return -1;
    if (vmr->GetFlags() & VirtualMemoryRegion::VM_File) {
        MemapFileRegion* mfr = (MemapFileRegion*)vmr;
        ErrorType err = mfr->Save();
        if (err < 0)
            kout[Error] << "Syscall_munmap: mfr failed to save! ErrorCode: " << err << endl;
        delete mfr;
    } else
        vms->RemoveVMR(vmr, 1);
    return 0;
}

Sint64 Syscall_lseek(int fd, Sint64 off, int whence)
{
    file_object* fh = fom.get_from_fd(pm.getCurProc()->getFoHead(), fd);

    if (fh == nullptr)
        return -1;

    constexpr int SEEK_SET_ = 0,
                  SEEK_CUR_ = 1,
                  SEEK_END_ = 2;
    int base;
    switch (whence) {
    case SEEK_SET_:
        base = 0;
        break;
    case SEEK_CUR_:
        base = fh->pos_k;
        break;
    case SEEK_END_:
        base = fh->file->size();
        break;
    default:
        return -1;
    }
    ErrorType err = fom.set_fo_pos_k(fh, base + off);
    Sint64 re =( err ? fh->pos_k : -1);

    kout[DeBug]<<"return "<<re<<" off "<<off<<" whence "<<whence <<endl;
    return re;
}

PtrSint Syscall_mmap(void* start, Uint64 len, int prot, int flags, int fd, int off) // Currently flags will be ignored...
{
    if (len == 0) {
        kout[Error] << "syscall mmap len is 0" << endl;
        return -1;
    }
    FileNode* node = nullptr;
    if (fd != -1) {
        file_object* fh = fom.get_from_fd(pm.getCurProc()->getFoHead(), fd);
        if (fh == nullptr)
            return -1;
        node = fh->file;
        if (node == nullptr)
            return -1;
        node->show();
    } else
        DoNothing; // Anonymous mmap
    kout[Info] << "mmap " << start << " " << (void*)len << " " << prot << " " << flags << " " << fd << " " << off << " | " << node << endl;

    VirtualMemorySpace* vms = pm.getCurProc()->getVMS();

    constexpr Uint64 PROT_NONE = 0,
                     PROT_READ = 1,
                     PROT_WRITE = 2,
                     PROT_EXEC = 4,
                     PROT_GROWSDOWN = 0X01000000, // Unsupported yet...
        PROT_GROWSUP = 0X02000000; // Unsupported yet...

    Uint64 vmrProt = node != nullptr ? VirtualMemoryRegion::VM_File : 0;
    // if (prot&PROT_READ)
    vmrProt |= VirtualMemoryRegion::VM_RWX;
    // vmrProt |= VirtualMemoryRegion::VM_MMAP;
    // vmrProt|=VirtualMemoryRegion::VM_KERNEL;
    //	if (prot&PROT_WRITE)
    // vmrProt|=VirtualMemoryRegion::VM_Write;
    //	if (prot&PROT_EXEC)
    // vmrProt|=VirtualMemoryRegion::VM_Exec;
    // vmrProt|=VirtualMemoryRegion::VM_Exec;

    constexpr Uint64 MAP_FIXED = 0x10;
    if (flags & MAP_FIXED) // Need improve...
    {
        VirtualMemoryRegion* vmr = vms->FindVMR((PtrSint)start);
        if (vmr != nullptr) {
            if (vmr->GetEnd() <= ((PtrSint)start + len + PAGESIZE - 1 >> PageSizeBit << PageSizeBit)) {
                if (vmr->GetFlags() & VirtualMemoryRegion::VM_File) {
                    MemapFileRegion* mfr = (decltype(mfr))vmr;
                    mfr->Resize((PtrSint)start - mfr->GetStartAddr());
                } else {
                    // vmr->End=(PtrInt)start+PageSize-1>>PageSizeBit<<PageSizeBit;//??
                    vmr->SetEnd((PtrUint)start + PAGESIZE - 1 >> PageSizeBit << PageSizeBit);
                    //<<Free pages not in range...
                }
            } else
                kout[Error] << "Failed to discard mmap region inside vmr!" << endl;
        }
    }

    PtrSint s = vms->GetUsableVMR(start == nullptr ? 0x60000000 : (PtrSint)start, (PtrSint)0x70000000 /*??*/, len);
    if (s == 0 || start != nullptr && ((PtrSint)start >> PageSizeBit << PageSizeBit) != s)
        goto ErrorReturn;
    s = start == nullptr ? s : (PtrSint)start;

    if (node != nullptr) {
        MemapFileRegion* mfr = new MemapFileRegion(node, (void*)s, len, off, vmrProt);

        if (mfr == nullptr)
            goto ErrorReturn;

        // kout << Yellow << mfr->GetFlags() << endl;
        vms->InsertVMR(mfr);
        // vms->show();
        // kout[Fault]<<endl;

        ErrorType err = mfr->Load();

        // kout[Debug]<<"mmap load"<<endl;
        if (err < 0) {
            kout[Error] << "Syscall_mmap: mfr failed to load! ErrorCode: " << err << endl;
            delete mfr;
            goto ErrorReturn;
        }
    } else {
        VirtualMemoryRegion* vmr = KmallocT<VirtualMemoryRegion>();

        vmr->Init(s, s + len, vmrProt | VirtualMemoryRegion::VM_Mmap);
        vms->InsertVMR(vmr);
    }
    // kout[Debug]<<"mmap 2"<<endl;
    return s;
ErrorReturn:
    kout[Error] << "mmap error" << endl;
    if (node)
        vfsm.close(node);
    return -1;
}

int Syscall_nanosleep(timespec* req, timespec* rem)
{
    // 执行线程睡眠的系统调用
    // sleep()库函数基于此系统调用
    // 输入睡眠的时间间隔
    // 成功返回0 失败返回-1

    if (req == nullptr || rem == nullptr) {
        return -1;
    }

    // Process * cur_proc = pm.getCurProc();

    ClockTick wait_time = 0; // 计算qemu上需要等待的时钟滴答数
    VirtualMemorySpace::EnableAccessUser();
    wait_time = req->tv_sec * Timer_1s + req->tv_nsec / 1000000 * Timer_1ms + req->tv_nsec % 1000000 / 1000 * Timer_1us + req->tv_nsec % 1000 * Timer_1ns;
    rem->tv_sec = rem->tv_nsec = 0;
    VirtualMemorySpace::DisableAccessUser();
    // semaphore.wait(cur_proc);       // 当前进程在semaphore上等待 切换为sleeping态
    // pm.set_waittime_limit(cur_proc, wait_time);
    ClockTime start_timebase = GetClockTime();
    while (1) {
        ClockTime cur_time = GetClockTime();
        if (cur_time - start_timebase >= wait_time) {
            break;
        }
        pm.immSchedule();
    }

    return 0;
}

template <ModeRW rw>
inline RegisterData Syscall_ReadWriteVector(int fd, iovec* iov, int iovcnt, Uint64 off = -1)
{
    file_object* fo = pm.getCurProc()->getFoHead();
    file_object* fh = fom.get_from_fd(fo, fd);
    if (fh == nullptr)
        return -1;
    VirtualMemorySpace::EnableAccessUser();
    Sint64 re = 0, r;
    for (int i = 0; i < iovcnt; ++i) {
        if (iov[i].base == nullptr) {
            continue;
        }
        // kout[DeBug] << "iov " << (char*)iov[i].base << "len " << iov[i].len << endl;
        if constexpr (rw == ModeRW::W) {
            // r=fh->Write(iov[i].base,iov[i].len,off==-1?-1:off+re);
            if (off != -1) {
                fom.set_fo_pos_k(fh, off);
            }
            r = fom.write_fo(fh, iov[i].base, iov[i].len);

        } else {

            if (off != -1) {
                fom.set_fo_pos_k(fh, off);
            }
            r = fom.read_fo(fh, iov[i].base, iov[i].len);
            // r = fh->Read(iov[i].base, iov[i].len, off == -1 ? -1 : off + re);
        }

        if (r < 0)
            break;
        re += r;
        if (r != iov[i].len)
            break;
    }
    VirtualMemorySpace::DisableAccessUser();
    return re;
}

inline int Syscall_pipe2(int* fd, int flags)
{
    // kout << Yellow << "pipe" << endl;
    Process* cur = pm.getCurProc();
    // kout << Yellow << "pipe1" << endl;
    PIPEFILE* pipe = new PIPEFILE();
    if (pipe == nullptr)
        return -1;
    // kout << Yellow << "pipe2" << endl;

    file_object* fo1 = new file_object;
    // 创建两个fo,实际对应同一个pipe文件
    // kout << Yellow << "pipe3" << endl;
    pipe->readRef++;
    pipe->writeRef++;
    fom.set_fo_file(fo1, pipe);
    fom.set_fo_pos_k(fo1, 0);
    fom.set_fo_flags(fo1, file_flags::RDONLY);

    // kout << Yellow << pipe << endl;
    file_object* fo2 = new file_object;
    // kout << Yellow << "pipe5" << endl;
    fom.set_fo_file(fo2, pipe);
    fom.set_fo_pos_k(fo2, 0);
    // fom.set_fo_flags(fo2, 1);
    fom.set_fo_flags(fo2, file_flags::WRONLY);

    // kout << Yellow << "pipe6" << endl;
    if (InThisSet(nullptr, fo1, fo2)) {
        if (fo1 == nullptr && fo2 == nullptr)
            delete pipe;
        else if (fo1 == nullptr)
            delete fo2;
        else
            delete fo1;
        return -1;
    }
    fo1->fd = -1;
    fo2->fd = -1;

    fo1->next = nullptr;
    fo2->next = nullptr;
    fom.add_fo_tolist(cur->getFoHead(), fo1);
    fom.add_fo_tolist(cur->getFoHead(), fo2);

    VirtualMemorySpace::EnableAccessUser();
    fd[0] = fo1->fd;
    fd[1] = fo2->fd;
    // kout << Yellow << "pipe7" << endl;
    VirtualMemorySpace::DisableAccessUser();
    kout[DeBug] << "PIPE open " << fo1->fd << " " << fo2->fd;
    return 0;
}

int Syscall_sendfile(int out_fd, int in_fd, Uint64* offset, size_t count)
{
    Process* curProc = pm.getCurProc();
    file_object* outFo = fom.get_from_fd(curProc->getFoHead(), out_fd);
    file_object* inFo = fom.get_from_fd(curProc->getFoHead(), in_fd);

    ASSERTEX(outFo, "SYSCALL::sendfile outFo is nullptr");
    ASSERTEX(inFo, "SYSCALL::sendfile inFO is nullptr");

    FileNode* outFile = outFo->file;
    FileNode* inFile = inFo->file;

    ASSERTEX(outFile, "SYSCALL::sendfile outFile is nullptr");
    ASSERTEX(inFile, "SYSCALL::sendfile inFile is nullptr");

    int read_size = 0, pos = 0, re = 0, ac_size = 0;

    VirtualMemorySpace::EnableAccessUser();
    if (offset) {
        pos = *(offset);
    } else {
        pos = inFo->pos_k;
        // kout[DeBug] << "SYSCALL::sendfile pos_k " << pos << endl;
    }
    VirtualMemorySpace::DisableAccessUser();

    char* buf = new char[4096];
    read_size = (count >= 4096 ? 4096 : count);
    // kout[DeBug] << "SYSCALL::sendfile count" << count << endl;
    while (count != 0) {

        // kout[DeBug] << "SYSCALL::sendfile read_size:" << read_size << endl;
        read_size = (count >= 4096 ? 4096 : count);

        ac_size = inFile->read(buf, pos, read_size);
        if (ac_size == -1) {
            break;
        }
        if (ac_size != read_size) {
            read_size = ac_size;
            count = ac_size;
        }
        outFile->write(buf, pos, read_size);
        pos += read_size;
        count -= read_size;
        re += read_size;
    }

    VirtualMemorySpace::EnableAccessUser();

    if (offset) {
        (*offset) = pos;
    } else {
        inFo->pos_k = pos;
    }
    VirtualMemorySpace::DisableAccessUser();

    delete[] buf;
    return re;
}
/* int Syscall_ppoll(struct pollfd* fds, nfds_t nfds,
    const struct timespec*  tmo_p,
    const sigset_t* sigmask)
{


    kout[Warning] << "Syscall_flock is ignore" << endl;

    return -1;
}
 */

int Syscall_prlimit64(PID pid, int resource, RegisterData nlmt, RegisterData olmt) // It is not supported completely, only query is allowed now that pid and nlmt will be ignored...
{
    struct rlimit {
        Uint64 cur,
            max;
    };

    enum {
        RLIMIT_CPU = 0,
        RLIMIT_FSIZE = 1,
        RLIMIT_DATA = 2,
        RLIMIT_STACK = 3,
        RLIMIT_CORE = 4,
        RLIMIT_RSS = 5,
        RLIMIT_NPROC = 6,
        RLIMIT_NOFILE = 7,
        RLIMIT_MEMLOCK = 8,
        RLIMIT_AS = 9,
        RLIMIT_LOCKS = 10,
        RLIMIT_SIGPENDING = 11,
        RLIMIT_MSGQUEUE = 12,
        RLIMIT_NICE = 13,
        RLIMIT_RTPRIO = 14,
        RLIMIT_RTTIME = 15,
        RLIMIT_NLIMITS = 16
    };

    int re = 0;
    rlimit *oldlimit = (decltype(oldlimit))olmt,
           *newlimit = (decltype(newlimit))nlmt;
    if (oldlimit != nullptr)
        switch (resource) {
        case RLIMIT_STACK:
            oldlimit->cur = oldlimit->max = InnerUserProcessStackSize - 512;
            break; // Need improve...
        default:
            re = -1;
            break;
        }
    if (newlimit != nullptr)
        kout[Warning] << "Syscall_prlimit64 newlimit is set, however it will be ignored!" << endl;
    return re;
}

int Syscall_ppoll(void* _fds, Uint64 nfds, void* _tmo_p, void* _sigmask)
{
    if (nfds != 1)
        kout[Warning] << "Syscall_ppoll with nfds " << nfds << " is not supported yet!" << endl;
    if (_tmo_p != nullptr)
        kout[Warning] << "Syscall_ppoll with tmo_p " << _tmo_p << " is not nullptr is not supported yet!" << endl;
    if (_sigmask != nullptr)
        kout[Warning] << "Syscall_ppoll with sigmask " << _sigmask << " is not nullptr is not supported yet!" << endl;

    struct pollfd {
        int fd;
        short events;
        short revents;
    }* fds = (pollfd*)_fds;
    struct timespec {
        int tv_sec;
        int tv_nsec;
    }* tmo_p = (timespec*)_tmo_p;
    enum {
        POLLIN = 1
    };

    VirtualMemorySpace::EnableAccessUser();
    for (int i = 0; i < nfds; ++i)
        kout[DeBug] << fds[i].fd << " " << fds[i].events << endline;
    kout << endout;

    if (nfds == 1 && fds[0].fd == 0 && fds[0].events == POLLIN) {
        fds[0].revents = POLLIN;
        return 1;
    } else
        kout[Warning] << "Skipped Syscall_ppoll" << endl;
    VirtualMemorySpace::DisableAccessUser();

    return -1;
}

int Syscall_getdents64(int fd, RegisterData _buf, Uint64 bufSize)
{
    struct Dirent {
        Uint64 d_ino; // 索引结点号
        Sint64 d_off; // 到下一个dirent的偏移
        unsigned short d_reclen; // 当前dirent的长度
        unsigned char d_type; // 文件类型
        char d_name[0]; // 文件名
    } __attribute__((packed));

    Process* proc = pm.getCurProc();
    kout[Info] << "Syscall_getdents64  fd" << fd << "fo_head" << proc->getFoHead() << endl;
    file_object* dir = fom.get_from_fd(proc->getFoHead(), fd);
    // kout[Info]<<"dir->pos_k"<<dir->pos_k<<endl;

    if (dir == nullptr) {
        return -1;
    }

    EXT4* t = (EXT4*)vfsm.get_root()->vfs;
    ext4node* file = new ext4node;
    t->get_next_file((ext4node*)dir->file, nullptr, file);

    for (int i = 0; i < dir->pos_k; i++) {
        t->get_next_file((ext4node*)dir->file, file, file);
    }

    VirtualMemorySpace::EnableAccessUser();
    if (file == nullptr) {
        return 0;
    }
    int n_read = 0;
    int i = dir->pos_k;
    // kout << Red << "getdents buf start" << (void*)_buf << endl;
    bool wirte = true;

    while (file->offset != -1) {
        // for (int k = 0; k < 1; k++) {

        // kout << Green << file->name << endl;

        Dirent* dirent = (Dirent*)(_buf + n_read);

        Uint64 size = sizeof(Uint64) * 2 + sizeof(unsigned) * 2 + strlen(file->name) + 1;
        if (n_read + size > bufSize) {
            kout << Green << "pos " << dir->pos_k << endl;
            dir->pos_k = i;
            return n_read;
        }
        n_read += size;
        if (wirte) {
            dirent->d_ino = i + 1;
            dirent->d_off = 32;
            dirent->d_type = 0;
            int j = 0;
            for (; j < strlen(file->name); j++) {
                dirent->d_name[j] = file->name[j];
            }
            dirent->d_name[j] = 0;

            dirent->d_reclen = sizeof(Uint64) * 2 + sizeof(unsigned) * 2 + strlen(file->name) + 1;
        }

        i++;
        t->get_next_file((ext4node*)dir->file, (ext4node*)file, file);
    }

    kout << Green << "pos " << dir->pos_k << endl;
    dir->pos_k = i;
    // kout << Red << "getdents buf end" << (void*)(_buf + n_read) << endl;
    return n_read;
}

int Syscall_clock_gettime(RegisterData clkid, RegisterData tp)
{
    struct timespec {
        int tv_sec;
        int tv_nsec;
    }* tv = (timespec*)tp;
    VirtualMemorySpace::EnableAccessUser();
    ClockTime t = GetClockTime();
    tv->tv_sec = t / Timer_1s;
    tv->tv_nsec = t % Timer_1s; //??
    VirtualMemorySpace::DisableAccessUser();
    return 0;
}

int Syscall_newfstatat(int dirfd, const char* pathname, kstat* statbuf, int flags)
{
    enum : int {
        AT_EMPTY_PATH = 0x1000,
    };

    if (flags) {
        switch (flags) {
        case AT_EMPTY_PATH:

            // return 0;
            break;
        }

        kout[Warning] << "Syscall::SYS_newfstatat : flags is unsolove  " << flags << endl;
    }

    file_object* dir;
    char* buf = new char[200];
    if (dirfd != AT_FDCWD) {
        dir = fom.get_from_fd(pm.getCurProc()->getFoHead(), dirfd);
        if (dir == nullptr) {
            kout[Warning] << "dir is nullptr" << endl;
        } else {

            vfsm.get_file_path(dir->file, buf);
        }
    } else {
        strcpy(buf, pm.getCurProc()->getCWD());
    }

    // delete[] buf;
    // return  0;
    FileNode* file = vfsm.open(pathname, buf);
    if (file == nullptr) {
        kout[Warning] << "file can't open" << endl;
        return -1;
    }

    file_object* fd = fom.create_flobj(pm.getCurProc()->getFoHead());
    fd->file = file;

    int re = Syscall_fstat(fd->fd, statbuf);
    fom.delete_flobj(pm.getCurProc()->getFoHead(), fd);
    vfsm.close(file);

    // if (buf != nullptr) {
    delete[] buf;
    // }
    return re;
}

Sint64 Syscall_get_unsolve_id()
{
    kout[Warning] << "SYSCALL:: the get id is unsolove" << endl;
    return 0;
}

/* Sint32 Syscall_madvise(void* addr, Uint64 length, int advice)
{

    VirtualMemorySpace * vms= pm.getCurProc()->getVMS();
    VirtualMemoryRegion *vmr_bin = new VirtualMemoryRegion(addr, addr + length, VirtualMemoryRegion::VM_RWX);
    vms->InsertVMR();

    return 0;
}
 */

int Syscall_skip_ok(int syscall_num)
{
    kout[Warning] << "syscall: " << syscall_num << "sikp ok  " << endl;

    return 0;
}
struct winsize {
    unsigned short ws_row; /* rows， in character */
    unsigned short ws_col; /* columns, in characters */
    unsigned short ws_xpixel; /* horizontal size, pixels (unused) */
    unsigned short ws_ypixel;
};

int Syscall_ioctl(int fd, int cmd, TrapFrame* tf)
{

    kout[Warning] << "sikp ioctl  fd: " << fd << "cmd :" << cmd << endl;
    enum : int {

        TIOCGWINSZ = 0x5413,
    };

    switch (cmd) {
    case TIOCGWINSZ:
        winsize* winSize = (winsize*)tf->reg.a2;
        winSize->ws_row = 64;
        winSize->ws_col = 64;
        winSize->ws_xpixel = 1024;
        winSize->ws_ypixel = 1024;
        break;
    };

    return 0;
}
int Syscall_set_tid_address(int* tidptr)
{
    *tidptr = pm.getCurProc()->id;
    // kout[DeBug]<<"enter"<<endl;
    return 0;
}
int Syscall_syslog(int type, char* bufp, int len)
{
    kout[Test] << "TYPE" << type << " bufp " << bufp << " len " << len << endl;

    return 0;
}

struct sysinfo {
    long uptime; /* Seconds since boot */
    unsigned long loads[3]; /* 1, 5, and 15 minute load averages */
    unsigned long totalram; /* Total usable main memory size */
    unsigned long freeram; /* Available memory size */
    unsigned long sharedram; /* Amount of shared memory */
    unsigned long bufferram; /* Memory used by buffers */
    unsigned long totalswap; /* Total swap space size */
    unsigned long freeswap; /* Swap space still available */
    unsigned short procs; /* Number of current processes */
    unsigned short pad; /* Padding to 64 bits */
    unsigned long long totalhigh; /* Total high memory size */
    unsigned long long freehigh; /* Available high memory size */
    unsigned int mem_unit; /* Memory unit size in bytes */
    char _f[20 - 2 * sizeof(long long) - sizeof(int)]; /* Padding to 64 bytes */
};

int Syscall_sysinfo(sysinfo* info)
{
    info->uptime = GetClockTime();

    return 0;
}

bool TrapFunc_Syscall(TrapFrame* tf)
{
    kout << Green << tf->reg.a7 << " " << SyscallName(tf->reg.a7) << " pid " << pm.getCurProc()->getID() << endl;

    if (Banned_Syscall[tf->reg.a7]) {
        pm.getCurProc()->exit(ExitType::Exit_BadSyscall);
        pm.immSchedule();
        return true;
    }

    switch ((Sint64)tf->reg.a7) {

    case 1:
        Putchar(tf->reg.a0);
        break;
    case SYS_getcwd:
        tf->reg.a0 = (Uint64)Syscall_getcwd((char*)tf->reg.a0, tf->reg.a1);
        break;
    case SYS_mkdirat:
        tf->reg.a0 = Syscall_mkdirat(tf->reg.a0, (const char*)tf->reg.a1, tf->reg.a2);
        break;

    case SYS_chdir:
        tf->reg.a0 = Syscalll_chdir((const char*)tf->reg.a0);
        break;
    case SYS_write:
        tf->reg.a0 = Syscall_write(tf->reg.a0, (void*)tf->reg.a1, tf->reg.a2);
        break;
    case SYS_linkat:
        tf->reg.a0 = Syscall_linkat(tf->reg.a0, (char*)tf->reg.a1, tf->reg.a2, (char*)tf->reg.a3, tf->reg.a4);
        break;
    case SYS_syslog:
        tf->reg.a0 = Syscall_syslog(tf->reg.a0, (char*)tf->reg.a1, tf->reg.a2);
        break;
    case SYS_Exit:
    case SYS_exit:
        Syscall_Exit(tf, tf->reg.a0);
        break;

    case SYS_sysinfo:
        tf->reg.a0 = Syscall_sysinfo((sysinfo*)tf->reg.a0);
        break;
    case SYS_brk:
        tf->reg.a0 = Syscall_brk(tf->reg.a0);
        break;
    case SYS_sched_yeild:
        Syscall_sched_yeild();
        break;

    case SYS_gettid:
    case SYS_getpid:
        tf->reg.a0 = Syscall_getpid();
        break;
    case SYS_getppid:
        tf->reg.a0 = Syscall_getppid();
        break;
        // tf->reg.a0 = Syscall_setppid(tf->reg.a0);
        // break;
    case SYS_lseek:
        tf->reg.a0 = Syscall_lseek(tf->reg.a0, tf->reg.a1, tf->reg.a2);
        break;

    case SYS_getpgid:
    case SYS_geteuid:
    case SYS_getuid:
    case SYS_getgid:
    case SYS_getegid:
        tf->reg.a0 = Syscall_get_unsolve_id();
        break;
    // case SYS_madvise:
    // tf->reg.a0 = Syscall_madvise(void* addr, size_t length, int advice);
    // int madvise();
    // break;
    //
    case SYS_mprotect:

        tf->reg.a0 = 0;
        break;
    case SYS_gettimeofday:
        tf->reg.a0 = Syscall_gettimeofday((timeval*)tf->reg.a0, 0);
        break;
    case SYS_uname:
        tf->reg.a0 = Syscall_uname((utsname*)tf->reg.a0);
        break;
    case SYS_unlinkat:
        tf->reg.a0 = Syscall_unlinkat(tf->reg.a0, (char*)tf->reg.a1, tf->reg.a2);
        break;
    case SYS_read:
        tf->reg.a0 = Syscall_read(tf->reg.a0, (void*)tf->reg.a1, tf->reg.a2);
        break;
    case SYS_close:
        tf->reg.a0 = Syscall_close(tf->reg.a0);
        break;
    case SYS_dup:
        tf->reg.a0 = Syscall_dup(tf->reg.a0);
        break;
    case SYS_dup3:
        tf->reg.a0 = Syscall_dup3(tf->reg.a0, tf->reg.a1);
        // kout<<tf->reg.a0<<"________________----"<<endl;
        break;
    case SYS_times:
        tf->reg.a0 = Syscall_times((tms*)tf->reg.a0);
        break;
    case SYS_openat:
        tf->reg.a0 = Syscall_openat(tf->reg.a0, (const char*)tf->reg.a1, tf->reg.a2, tf->reg.a3);
        break;
    case SYS_getdents64:
        tf->reg.a0 = Syscall_getdents64(tf->reg.a0, tf->reg.a1, tf->reg.a2);
        break;
    case SYS_newfstatat:
        tf->reg.a0 = Syscall_newfstatat(tf->reg.a0, (const char*)tf->reg.a1, (kstat*)tf->reg.a2, tf->reg.a3);
        break;
    case SYS_fstat:
        tf->reg.a0 = Syscall_fstat(tf->reg.a0, (kstat*)tf->reg.a1);
        break;
    case SYS_mount:
        tf->reg.a0 = Syscall_mount((const char*)tf->reg.a0, (const char*)tf->reg.a1, (const char*)tf->reg.a2, tf->reg.a3, (const void*)tf->reg.a4);
        break;
    case SYS_umount2:
        tf->reg.a0 = Syscall_umount2((const char*)tf->reg.a0, tf->reg.a1);
        break;
    case SYS_clone:

        tf->reg.a0 = Syscall_clone(tf, tf->reg.a0, (void*)tf->reg.a1, tf->reg.a2, tf->reg.a3, tf->reg.a4);
        break;
    case SYS_wait4:
        // kout << "wait start epc" << (void*)tf->epc << "  " << pm.getCurProc()->getVMS() << endl;
        // pm.getCurProc()->getVMS()->show();
        tf->reg.a0 = Syscall_wait4(tf->reg.a0, (int*)tf->reg.a1, tf->reg.a2);
        // kout << "wait end epc" << (void*)tf->epc << "  " << pm.getCurProc()->getVMS() << endl;
        // pm.getCurProc()->getVMS()->show();
        break;

    case SYS_mmap:
        tf->reg.a0 = Syscall_mmap((void*)tf->reg.a0, tf->reg.a1, tf->reg.a2, tf->reg.a3, tf->reg.a4, tf->reg.a5);
        break;
    case SYS_munmap:
        tf->reg.a0 = Syscall_munmap((void*)tf->reg.a0, tf->reg.a1);
        break;

    case SYS_nanosleep:
        tf->reg.a0 = Syscall_nanosleep((timespec*)tf->reg.a0, (timespec*)tf->reg.a1);
        break;

    case SYS_pipe2:
        tf->reg.a0 = Syscall_pipe2((int*)tf->reg.a0, tf->reg.a1);
        break;
    case SYS_execve:
        Syscall_execve((char*)tf->reg.a0, (char**)tf->reg.a1, (char**)tf->reg.a2);
        break;

    case SYS_clock_gettime:
        tf->reg.a0 = Syscall_clock_gettime(tf->reg.a0, tf->reg.a1); // Currently, clkid will be ignored...
        break;
    case SYS_readv:
        tf->reg.a0 = Syscall_ReadWriteVector<ModeRW::Read>(tf->reg.a0, (iovec*)tf->reg.a1, tf->reg.a2);
        break;
    case SYS_writev:
        tf->reg.a0 = Syscall_ReadWriteVector<ModeRW::Write>(tf->reg.a0, (iovec*)tf->reg.a1, tf->reg.a2);
        // ASSERTEX(tf->reg.a0>0," can't return normal" );
        break;

    case SYS_sigaction:
        tf->reg.a0 = Syscall_sigaction(tf->reg.a0, (const struct sigaction*)tf->reg.a1, (struct sigaction*)tf->reg.a2);
        break;
    case SYS_fcntl:
        tf->reg.a0 = Syscall_fcntl(tf->reg.a0, tf->reg.a1, tf);
        break;

    case SYS_ioctl:
        tf->reg.a0 = Syscall_ioctl(tf->reg.a0, tf->reg.a1, tf);
        break;
    case SYS_set_tid_address:
        tf->reg.a0 = Syscall_set_tid_address((int*)tf->reg.a0);
        break;

    case SYS_sigprocmask:

        tf->reg.a0 = Syscall_skip_ok(tf->reg.a7);
        break;

    case SYS_ppoll:
        tf->reg.a0 = Syscall_ppoll((struct pollfd*)tf->reg.a0, (nfds_t)tf->reg.a1, (void*)tf->reg.a2, (void*)tf->reg.a3);
        break;

    case SYS_sendfile:
        tf->reg.a0 = Syscall_sendfile(tf->reg.a0, tf->reg.a1, (Uint64*)tf->reg.a2, tf->reg.a3);
        break;

    case SYS_prlimit64:
        tf->reg.a0 = Syscall_prlimit64(tf->reg.a0, tf->reg.a1, tf->reg.a2, tf->reg.a3);
        break;
    case SYS_setpgid:
    case SYS_sigtimedwait:
    case SYS_exit_group:

    case SYS_madvise:
        //		case SYS_futex:

    case SYS_get_robust_list:

    case SYS_utimensat:

    case SYS_membarrier:

    case SYS_socket:
    case SYS_bind:
    case SYS_getsockname:
    case SYS_setsockopt:
    case SYS_sendto:
    case SYS_recvfrom:
    case SYS_listen:
    case SYS_connect:
    case SYS_accept:
        kout[Warning] << "Skipped syscall " << tf->reg.a7 << " " << SyscallName((long long)tf->reg.a7) << endl;
        // tf->reg.a0=-1;
        break;

        // case 174:
        // case 175:
        // case 176:

    default: {
        Process* cur = pm.getCurProc();
        if (cur->isKernel())
            kout[Fault] << "TrapFunc_Syscall: Unknown syscall " << tf->reg.a7 << " from kernel process " << cur->getID() << "!" << endl;
        else {
            kout[Error] << "TrapFunc_Syscall: Unknown syscall " << tf->reg.a7 << " from user process " << cur->getID() << "!" << endl;
            cur->exit(ExitType::Exit_BadSyscall);
            pm.immSchedule();
            // kout[Fault]<<"TrapFunc_Syscall: Reaced unreachable branch!"<<endl;
        }
        break;
    }
        // kout[Fault] << "this syscall isn't solve" << tf->reg.a7 << endl;
        // case SYS_futex:
        // tf->reg.a0 = -1;
    }

    return true;
}