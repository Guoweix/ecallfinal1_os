#include "Error.hpp"
#include "Library/KoutSingle.hpp"
#include "Library/SBI.h"
#include "Memory/vmm.hpp"
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

int Syscall_execve(const char* path, char* const argv[], char* const envp[])
{
    // 执行一个指定的程序的系统调用
    // 关键是利用解析ELF文件创建进程来实现
    // 这里需要文件系统提供的支持
    // argv参数是程序参数 envp参数是环境变量的数组指针 暂时未使用
    // 执行成功跳转执行对应的程序 失败则返回-1

    VirtualMemorySpace::EnableAccessUser();
    Process* cur_proc = pm.getCurProc();
    FAT32FILE* file_open = vfsm.open(path, "/");

    if (file_open == nullptr) {
        kout[Fault] << "SYS_execve open File Fail!" << endl;
        return -1;
    }

    file_object* fo = (file_object*)kmalloc(sizeof(file_object));
    fom.set_fo_file(fo, file_open);
    fom.set_fo_pos_k(fo, 0);
    fom.set_fo_flags(fo, 0);

    Process* new_proc = CreateProcessFromELF(fo, cur_proc->getCWD());
    kfree(fo);

    int exit_value = 0;
    if (new_proc == nullptr) {
        kout[Fault] << "SYS_execve CreateProcessFromELF Fail!" << endl;
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
                if (pptr->getStatus() == S_Terminated) {
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
                pm.freeProc(child);
                break;
            }
        }
    }
    // 顺利执行了execve并回收了子进程
    // 当前进程就执行完毕了 直接退出
    VirtualMemorySpace::DisableAccessUser();
    // pm.exit_proc(cur_proc, exit_value);
    cur_proc->exit(exit_value);
    pm.immSchedule();
    kout[Fault] << "SYS_execve reached unreacheable branch!" << endl;
    return -1;
}

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
        kout[Fault] << "The Process has Not Child Process!" << endl;
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
            child->destroy(); // 回收子进程 子进程的回收只能让父进程来进行
            pm.freeProc(child);
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

struct tms {
    long tms_utime; // user time
    long tms_stime; // system time
    long tms_cutime; // user time of children
    long tms_sutime; // system time of children
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
    Uint64 time_unit = 10; // 填充tms结构体的基本时间单位 在qemu上模拟 以微秒为单位
    if (tms != nullptr) {
        Uint64 run_time = cur_proc->runTime; // 总运行时间
        Uint64 sys_time = cur_proc->sysTime; // 用户陷入核心态的system时间
        Uint64 user_time = run_time - sys_time; // 用户在用户态执行的时间
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

inline int Syscall_unlinkat(int dirfd, char* path, int flags)
{
    // 移除指定文件的链接(可用于删除文件)的系统调用
    // dirfd是要删除的链接所在的目录
    // path是要删除的链接的名字
    // flags可设置为0或AT_REMOVEDIR
    // 成功返回0 失败返回-1

    Process* cur_proc = pm.getCurProc();
    file_object* fo_head = cur_proc->fo_head;
    file_object* fo = fom.get_from_fd(fo_head, dirfd);
    if (fo == nullptr) {
        return -1;
    }
    VirtualMemorySpace::EnableAccessUser();
    if (!vfsm.unlink(path, fo->file->path)) {
        return -1;
    }
    VirtualMemorySpace::DisableAccessUser();
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

    if (fd == STDOUT_FILENO) {
        VirtualMemorySpace::EnableAccessUser();
        kout<<Yellow<<buf<<endl;
        for (int i = 0; i < count; i++) {
            putchar(((char*)buf)[i]);
            // kout << (uint64)((char*)buf)[i] << endl;
        }
        VirtualMemorySpace::DisableAccessUser();
        return count;
    }

    Process* cur_proc = pm.getCurProc();
    file_object* fo = fom.get_from_fd(cur_proc->fo_head, fd);
    if (fo == nullptr) {
        return -1;
    }

    // trick实现文件信息的打印
    // 向标准输出写
    if (fo->tk_fd == STDOUT_FILENO) {
        // putchar('s');
        VirtualMemorySpace::EnableAccessUser();
        for (int i = 0; i < count; i++) {
            putchar(*((char*)buf+i));
        }
        VirtualMemorySpace::DisableAccessUser();
        return count;
    }

    VirtualMemorySpace::EnableAccessUser();
    long long wr_size = 0;
    wr_size = fom.write_fo(fo, buf, count);
    VirtualMemorySpace::DisableAccessUser();
    if (wr_size < 0) {
        return -1;
    }
    return wr_size;
}

inline long long Syscall_read(int fd, void* buf, Uint64 count)
{
    // 从一个文件描述符中读取的系统调用
    // fd是要读取的文件描述符
    // buf是存放读取内容的缓冲区 count是要读取的字节数
    // 成功返回读取的字节数 0表示文件结束 失败返回-1

    if (buf == nullptr) {
        return -1;
    }

    Process* cur_proc = pm.getCurProc();
    file_object* fo = fom.get_from_fd(cur_proc->fo_head, fd);
    if (fo == nullptr) {
        return -1;
    }
    VirtualMemorySpace::EnableAccessUser();
    long long rd_size = 0;
    rd_size = fom.read_fo(fo, buf, count);
    VirtualMemorySpace::DisableAccessUser();
    if (rd_size < 0) {
        return -1;
    }
    return rd_size;
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
    if (!fom.close_fo(cur_proc, fo)) {
        // fom中的close_fo调用会关闭这个文件描述符
        // 主要是对相关文件的解引用并且从文件描述符表中删去这个节点
        return -1;
    }
    return 0;
}

inline int Syscall_dup(int fd)
{
    // 复制文件描述符的系统调用
    // 传入被复制的文件描述符
    // 成功返回新的文件描述符 失败返回-1

    Process* cur_proc = pm.getCurProc();
    file_object* fo = fom.get_from_fd(cur_proc->fo_head, fd);
    if (fo == nullptr) {
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
        fom.delete_flobj(cur_proc->fo_head, fo_tmp);
    }

    // 没有串口 继续trick
    if (old_fd == STDOUT_FILENO) {
        fo_new->tk_fd = STDOUT_FILENO;
    }

    fom.set_fo_fd(fo_new, new_fd);
    // 再将这个新的fo插入进程的文件描述符表
    int rd = fom.add_fo_tolist(cur_proc->fo_head, fo_new);
    if (rd != new_fd) {
        return -1;
    }
    return rd;
}

inline int Syscall_openat(int fd, const char* filename, int flags, int mode)
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

    VirtualMemorySpace::EnableAccessUser();
    char* rela_wd = nullptr;
    Process* cur_proc = pm.getCurProc();
    char* cwd = cur_proc->getCWD();
    if (fd == AT_FDCWD) {
        rela_wd = cur_proc->getCWD();
    } else {
        file_object* fo = fom.get_from_fd(cur_proc->fo_head, fd);
        if (fo != nullptr) {
            rela_wd = fo->file->path;
        }
    }

    if (flags & file_flags::O_CREAT) {
        // 创建文件或目录
        // 创建则在进程的工作目录进行
        if (flags & file_flags::O_DIRECTORY) {
            vfsm.create_dir(rela_wd, cwd, (char*)filename);
        } else {
            vfsm.create_file(rela_wd, cwd, (char*)filename);
        }
    }

    char* path = vfsm.unified_path(filename, rela_wd);
    if (path == nullptr) {
        return -1;
    }
    // trick
    // 暂时没有对于. 和 ..的路径名的处理
    // 特殊处理打开文件当前目录.的逻辑
    FAT32FILE* file = nullptr;
    if (filename[0] == '.' && filename[1] != '.') {
        int str_len = strlen(filename);
        char* str_spc = new char[str_len];
        strcpy(str_spc, filename + 1);
        file = vfsm.open(str_spc, rela_wd);
    } else {
        file = vfsm.open(filename, rela_wd);
    }

    if (file != nullptr) {
        if (!(file->TYPE & FAT32FILE::__DIR) && (flags & O_DIRECTORY)) {
            file = nullptr;
        }
    }
    file_object* fo = fom.create_flobj(cur_proc->fo_head);
    if (fo == nullptr || fo->fd < 0) {
        return -1;
    }
    if (file != nullptr) {
        fom.set_fo_file(fo, file);
        fom.set_fo_flags(fo, flags);
        fom.set_fo_mode(fo, mode);
    }
    kfree(path);
    VirtualMemorySpace::DisableAccessUser();
    return fo->fd;
}

bool TrapFunc_Syscall(TrapFrame* tf)
{
    kout << tf->reg.a7 << "______" << endl;
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
        tf->reg.a0=Syscall_write(tf->reg.a0, (void*)tf->reg.a1, tf->reg.a2 );
        break;

    case SYS_Exit:
    case SYS_exit:
        Syscall_Exit(tf, tf->reg.a0);
        break;
    case SYS_brk:
        tf->reg.a0 = Syscall_brk(tf->reg.a0);
        break;
    case SYS_sched_yeild:
        Syscall_sched_yeild();
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
    case SYS_openat:
        tf->reg.a0 = Syscall_openat(tf->reg.a0, (const char*)tf->reg.a1, tf->reg.a2, tf->reg.a3);
        break;
    case SYS_clone:
        
        tf->reg.a0 = Syscall_clone(tf, tf->reg.a0, (void*)tf->reg.a1, tf->reg.a2, tf->reg.a3, tf->reg.a4);
        break;
    case SYS_wait4:
        kout << "wait start epc" << (void*)tf->epc << "  " << pm.getCurProc()->getVMS() << endl;
        pm.getCurProc()->getVMS()->show();

        tf->reg.a0 = Syscall_wait4(tf->reg.a0, (int*)tf->reg.a1, tf->reg.a2);
        kout << "wait end epc" << (void*)tf->epc << "  " << pm.getCurProc()->getVMS() << endl;
        pm.getCurProc()->getVMS()->show();
        break;

    case SYS_execve:
        Syscall_execve((char*)tf->reg.a0, (char**)tf->reg.a1, (char**)tf->reg.a2);
        break;
    default:
        kout[Fault]<<"this syscall isn't solve"<<tf->reg.a7<<endl;
    }

    return true;
}