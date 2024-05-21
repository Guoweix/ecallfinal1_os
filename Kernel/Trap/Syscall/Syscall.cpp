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
    case SYS_brk:
        tf->reg.a0 = Syscall_brk(tf->reg.a0);
        break;
    default:
        kout[Fault] << "TrapFunc_Syscall::unsolve " << tf->reg.a7 << endl;
        return false;
    }

    return true;
}