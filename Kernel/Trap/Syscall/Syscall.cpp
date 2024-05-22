#include "Error.hpp"
#include "Library/KoutSingle.hpp"
#include "Memory/vmm.hpp"
#include "Trap/Interrupt.hpp"
#include "Trap/Trap.hpp"
#include "Types.hpp"
#include <File/FileObject.hpp>
#include <File/vfsm.hpp>
#include <Process/Process.hpp>
#include <Trap/Syscall/Syscall.hpp>
#include <Trap/Syscall/SyscallID.hpp>
#include <Trap/Clock.hpp>

extern bool needSchedule;

void Syscall_Exit(TrapFrame* tf, int re)
{
    Process* cur = pm.getCurProc();
    // kout<<"SDAD"<<re<<endl;
    cur->exit(re);
    needSchedule = true;
    // kout[Fault] << "Syscall_Exit: Reached unreachable branch" << endl;
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

    char* rela_wd = nullptr;
    Process* cur_proc = pm.getCurProc();
    // kout<<"S1"<<endl;
    char* cwd = cur_proc->getCWD();
    // kout<<"S2"<<endl;
    if (dirfd == AT_FDCWD) {
        // kout<<"S3"<<endl;
        // VirtualMemorySpace::Boot()->Enter();
        // kout<<(void *)cur_proc->getCWD()<<endl;
        // kout<<"S3"<<endl;
        rela_wd = cur_proc->getCWD();
        // kout<<"S3"<<endl;
    } else {
        file_object* fo = fom.get_from_fd(cur_proc->getFoHead(), dirfd);
        if (fo != nullptr) {
            rela_wd = fo->file->path;
        }
    }
    char* dir_path = vfsm.unified_path(rela_wd, rela_wd);
    if (dir_path == nullptr) {
        return -1;
    }
    bool rt = vfsm.create_dir(dir_path, cwd, (char*)path);
    kfree(dir_path);
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
        create_proc->start(nullptr, nullptr);

    } else {
        // 此时就是相当于clone
        // 创建一个新的线程 与内存间的共享有关
        // 线程thread的创建
        // // 这里其实隐含很多问题 涉及到指令执行流这些 需要仔细体会
        // // 在大赛要求和本内核实现下仅仅是充当创建一个函数线程的作用
        // pm.set_proc_vms(create_proc, cur_proc->vms);
        // memcpy((void*)((TRAPFRAME*)((char*)create_proc->kstack + create_proc->kstacksize) - 1),
        //     (const char*)tf, sizeof(TRAPFRAME));
        // create_proc->context = (TRAPFRAME*)((char*)create_proc->kstack + create_proc->kstacksize) - 1;
        // create_proc->context->epc += 4;
        // create_proc->context->reg.sp = (uint64)stack;
        // create_proc->context->reg.a0 = 0; // clone里面子线程去执行函数 父线程返回
    }
    // pm.copy_other_proc(create_proc, cur_proc);
    // if (flags & SIGCHLD) {
    //     // clone的是子进程
    //     pm.set_proc_fa(create_proc, cur_proc);
    // }
    // pm.switchstat_proc(create_proc, Proc_ready);
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
        POS::Uint64 cwd_len = strlen(cwd);
        if (cwd_len > 0 && cwd_len < size) {
            strcpy(buf, cwd);
        } else {
            kout[Info] << "SYS_getcwd the Buf Size is Not enough to Store the cwd!" << endl;
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
        // 调用规范总是成功
        // 如果是无父进程 可以认为将该进程挂到根进程的孩子进程下
        return pm.getidle()->getID();
    } else {
        return fa_proc->getID();
    }
    return -1;
}

struct tms
{
    long tms_utime;                 // user time
    long tms_stime;                 // system time
    long tms_cutime;                // user time of children
    long tms_sutime;                // system time of children
};

inline Uint64 Syscall_times(tms* tms)
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
    Uint64 time_unit = 10;  // 填充tms结构体的基本时间单位 在qemu上模拟 以微秒为单位
    if (tms != nullptr)
    {
        Uint64 run_time = cur_proc->runTime;    // 总运行时间
        Uint64 sys_time = cur_proc->sysTime;    // 用户陷入核心态的system时间
        Uint64 user_time = run_time - sys_time;                // 用户在用户态执行的时间
        if ((long long)run_time < 0 || (long long)sys_time < 0 || (long long)user_time < 0)
        {
            // 3个time有一个为负即认为出错调用失败了
            // 返回-1
            return -1;
        }
        cur_proc->VMS->EnableAccessUser();                      // 在核心态操作用户态的数据
        tms->tms_utime = user_time / time_unit;
        tms->tms_stime = sys_time / time_unit;
        // 基于父进程执行到这里时已经wait了所有子进程退出并被回收了
        // 故直接置0
        tms->tms_cutime = 0;
        tms->tms_sutime = 0;
        cur_proc->VMS->DisableAccessUser();
    }
    return GetClockTime();
}

struct timeval
{
    Uint64 sec;                     // 自 Unix 纪元起的秒数
    Uint64 usec;                    // 微秒数
};

inline int Syscall_gettimeofday(timeval* ts, int tz = 0)
{
    // 获取时间的系统调用
    // timespec结构体用于获取时间值
    // 成功返回0 失败返回-1

    if (ts == nullptr)
    {
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

    if (uts == nullptr)
    {
        return -1;
    }

    // 操作用户区的数据
    // 需要从核心态进入用户态
    VirtualMemorySpace::EnableAccessUser();
    strcpy(uts->sysname, "DBStars_OperatingSystem");
    strcpy(uts->nodename, "DBStars_OperatingSystem");
    strcpy(uts->release, "Debug");
    strcpy(uts->version, "1.0");
    strcpy(uts->machine, "RISCV 64");
    strcpy(uts->domainname, "DBStars");
    VirtualMemorySpace::DisableAccessUser();

    return 0;
}

bool TrapFunc_Syscall(TrapFrame* tf)
{
    // kout<<tf->reg.a7<<"______"<<endl;
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
        if (tf->reg.a0 == 1) {
            for (int i = 0; i < tf->reg.a2; i++) {
                Putchar(*((char*)tf->reg.a1 + i));
            }
        }
        break;

    case SYS_Exit:
    case SYS_exit:
        Syscall_Exit(tf, tf->reg.a0);
        break;
    case SYS_getpid:
        tf->reg.a0 = Syscall_getpid();
        break;
    case SYS_getppid:
        tf->reg.a0 = Syscall_getppid();
        break;
    case SYS_gettimeofday:
        tf->reg.a0 = Syscall_gettimeofday((timeval*)tf->reg.a0, 0);
        break;
    case SYS_uname:
        tf->reg.a0 = Syscall_uname((utsname*)tf->reg.a0);
        break;
    default:;
    }

    return true;
}