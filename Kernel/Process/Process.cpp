#include "Trap/Syscall/SyscallID.hpp"
#include "Types.hpp"
#include <Arch/Riscv.h>
#include <File/FileObject.hpp>
#include <Library/KoutSingle.hpp>
#include <Library/Kstring.hpp>
#include <Library/SBI.h>
#include <Memory/pmm.hpp>
#include <Memory/vmm.hpp>
#include <Process/Process.hpp>
#include <Synchronize/Synchronize.hpp>
#include <Trap/Clock.hpp>
#include <Trap/Interrupt.hpp>
#include <Trap/Trap.hpp>

void ProcessManager::init()
{
    // 给每个进程初始化
    for (int i = 0; i < MaxProcessCount; i++) {
        Proc[i].flags = S_None;
        Proc[i].pm = this;
    }
    procCount = 0;
    Process* idle0 = allocProc();
    curProc = idle0;

    ////初始化系统进程
    idle0->initForKernelProc0();
}

void Process::show(int level)
{
    kout[Info] << "proc pid : " << id << endline
               << "proc name : " << name << endline
               << "proc state : " << status << endline
               << "proc flags : " << flags << endline
               << "proc VMS : " << (void*)VMS << endline
               << "proc kstack : " << (void*)stack << endline
               << "proc kstacksize : " << stacksize << endl;
    if (level == 1) {
        kout[Info] << "proc pid_fa : " << (void*)father << ' ' << father - &pm->Proc[0] << endline
                   << "proc pid_bro_pre : " << (void*)broPre << ' ' << father - &pm->Proc[0] << endline
                   << "proc pid_bro_next : " << (void*)broNext << ' ' << father - &pm->Proc[0] << endline
                   << "proc pid_fir_child : " << (void*)fstChild << ' ' << father - &pm->Proc[0] << endl;
    }
    kout << endl;
}

void ProcessManager::show(int j)
{
    for (int i = 0; i < MaxProcessCount; i++) {
        if (Proc[i].status != S_None) {
            Proc[i].show(j);
        }
    }
    kout << endl;
}

void ProcessManager::simpleShow()
{
    for (int i = 0; i < MaxProcessCount; i++) {
        if (curProc->id == i) {
            kout[Info] << "Cur====>";
        }
        if (Proc[i].status != S_None) {
            kout[Info] << Proc[i].name << " id: " << Proc[i].id << " status: " << Proc[i].status << endl;
        }
    }
}

bool Process::setName(const char* _name)
{
    if (_name == nullptr) {
        name[0] = 0;
        return 0;
    }
    strcpy(name, _name);

    return 0;
}

void Process::setStack(void* _stack, Uint32 _stacksize)
{
    if (_stack == nullptr) {
        flags |= F_GeneratedStack;
        _stack = kmalloc(_stacksize);
        if (_stack == nullptr) {
            kout[Fault] << "ERR_Kmalloc stack" << endl;
        }
    }
    memset(_stack, 0, _stacksize);
    stack = _stack, stacksize = _stacksize;
}

void Process::initForKernelProc0()
{
    init(F_Kernel); // 初始化
    setFa(nullptr);
    stack = boot_stack;
    stacksize = PAGESIZE;
    setProcCWD("/");
    VMS = VirtualMemorySpace::Boot();
    setName("idle_0");
    switchStatus(S_Running);
}

bool Process::copyFromProc(Process* src)
{
    if (src == nullptr) {
        kout[Fault] << "The Process has not existed!" << endl;
        return false;
    }

    // 这里的copy部分与上面的迁移区别就在于是否初始化
    // 并且迁移基于本质上是同一个进程 而拷贝是两个独立的进程
    // 考虑fork和clone调用的需要 不过vms各自处理 故这里不处理
    // 计时时间部分
    timeBase = src->timeBase;
    runTime = src->runTime;
    sysTime = src->sysTime;
    waitTimeLimit = src->waitTimeLimit;
    readyTime = src->readyTime; // 保留但暂未使用
    sleepTime = src->sleepTime; // 保留但暂未使用

    // 链接部分
    // 这里是两个现实存在的进程间的拷贝
    // 只需要考虑父进程间的copy
    if (father != nullptr) {
        // pm.set_proc_fa(dst, src->fa);
        setFa(src->father);
    }

    // 标志位信息
    flags = src->flags;

    // 进程的名字
    if (!strcmp(src->name, (char*)"")) {
        setName(src->name);
    }

    // 文件系统相关
    // pm.copy_proc_fds(dst, src);

    copyFds(src);
    // kout[Info] << "Porcess copyFromProc src cwd" << src->getCWD() << endl;
    curWorkDir = new char[200];
    strcpy(curWorkDir, src->getCWD());

    return true;
}

void Process::init(ProcFlag _flags)
{
    if (status != S_Allocated) {
        kout[Fault] << "Process Init :status is not S_Allocated" << endl;
    }

    switchStatus(S_Initing);
    id = this - pm->Proc;
    timeBase = GetClockTime();
    timeBase = runTime = trapSysTimeBase = sysTime = sleepTime = waitTimeLimit = readyTime = 0;
    stack = nullptr;
    VMS = nullptr;
    Heap = nullptr;
    stacksize = 0;
    father = broNext = broPre = fstChild = nullptr;
    exitCode = 0;
    sigQueue.init();

    fom.init_proc_fo_head(this);
    initFds();
    curWorkDir = nullptr;

    waitSem = new Semaphore(0);
    SemRef = 0;
    // memset(&context, 0, sizeof(context));
    flags = _flags;
    name[0] = 0;
}

void Process::destroy()
{
    // kout[Error] << "Process destroy:" << id << endl;

    if (status == S_None) {
        return;
    } else if (status != S_Initing || status != S_Terminated) {
        exit(Exit_Normal);
    }

    // kout[Info] <<"process ::destroy his family father"<<father<<endline
    // <<"broPre "<<broPre<<"broNext "<<broNext<<endline
    // <<"fstChild "<<fstChild<<"myself "<<this<<endl;
    while (fstChild) {
        fstChild->destroy();
    }
    if (broPre) {
        broPre->broNext = broNext;
    } else {
        // kout[Debug]<<"loop here"<<endl;
        if (father) {
            father->fstChild = broNext;
            // kout[Debug]<<"because not loop here"<<endl;
        }
    }
    if (broNext) {
        broNext->broPre = broPre;
    }
    setFa(nullptr);

    broNext = nullptr;
    broPre = nullptr;

    if (VMS != nullptr) {
        VMS->Destroy();
    }
    VMS = nullptr;
    file_object* del = fo_head->next;
    while (del) {
        fom.close_fo(this, del);
        del = del->next;
        // ASSERTEX(del!=del->next, "DeadLoop");
    }

    destroyFds();

    if (waitSem != nullptr) {
        delete waitSem;
        waitSem = nullptr;
    }
    if (curWorkDir != nullptr) {
        delete[] curWorkDir;
        curWorkDir = nullptr;
    }
    setName(nullptr);
    if (fo_head != nullptr) {
        destroyFds();
        delete fo_head;
        fo_head = nullptr;
    }
    if (Heap != nullptr) {
        delete Heap;
        Heap = nullptr;
    }
    if (stack != nullptr) {
        kfree(stack);
        stack = nullptr;
    }
    stacksize = 0;
    // pm->freeProc(this);
    return;
}

bool Process::exit(int re)
{

    kout[DeBug] << "EXit " << id << endl;
    if (status == S_Terminated || status == S_None) {
        kout[DeBug] << "already exit" << endl;
        return true;
    }
    switchStatus(S_Terminated);
    if (status != S_Terminated) {
        kout[Fault] << "Process ::Exit:status is not S_Terminated" << id << endl;
    }
    if (re != Exit_Normal) {
        kout[Warning] << "Process ::Exit:" << id << "exit with return value" << re << endl;
    }
    exitCode = re;

    while (waitSem->getValue() < 1) {
        kout[DeBug] << "exit1 " << endl;
        waitSem->signal();
    }

    // if(fstChild==nullptr)
    // {
        // kout[Fault]
    // }

    if (father != nullptr) {
        kout[DeBug] << "exit1 " << endl;
        father->waitSem->signal();
    }
    kout[DeBug] << "exit1 " << endl;
    return true;
}

bool Process::run()
{
    Process* cur = pm->getCurProc();
    // cur->show();
    // kout[Info] << "switch from " << cur->name << " id " << cur->getID() << " to " << name << " ID: " << id << endl;
    if (this != cur) {
        if (cur->status == S_Running) {
            cur->switchStatus(S_Ready);
        }
        switchStatus(S_Running);
        pm->curProc = this;
        VMS->Enter();
    }
    // kout[Debug] << "switch finish" << endl;
    return true;
}

void Process::setFa(Process* fa)
{
    if (fa == nullptr) {
        // kout[Error] << "Process::setfa father is nullptr" << endl;
        return;
    }

    if (father != nullptr) {
        // 当需要设置的进程已经有一个非空的父进程了
        // 需要做好关系的转移和清理工作
        if (father == fa) {
            // 父子进程和参数中的已经一致
            return;
        }
        // 关键就是做好关系的转移
        if (father->fstChild == this) {
            father->fstChild = broNext;
        } else if (broPre != nullptr) {
            broPre->broNext = broNext;
        }
        // 再判断一下bro_next进程
        if (broNext != nullptr) {
            broNext->broPre = broPre;
        }
        // 关系转移好了之后清理一下"族谱"关系
        // 一个进程不应该同时具有多个父进程
        broPre = nullptr;
        broNext = nullptr;
        father = nullptr;
    }

    // 设置新的父进程
    father = fa;
    broNext = father->fstChild; // 关系的接替 "顶"上去 类头插
    father->fstChild = this;
    if (broNext != nullptr) {
        broNext->broPre = this;
    }
    broPre = nullptr;
}

bool Process::start(void* func, void* funcData, PtrUint useraddr, int argc, char** argv)
{
    // kout[Debug]<<"Procss::start VMS"<<VMS<<endl;
    if (VMS == nullptr) {
        kout[Fault] << "vms is not set" << endl;
    }
    if (stack == nullptr) {
        kout[Fault] << "stack is not set" << endl;
    }
    Uint64 SPP = 1 << 8; // 利用中断 设置sstatus寄存器 Supervisor Previous Privilege(guess)
    Uint64 SPIE = 1 << 5; // Supervisor Previous Interrupt Enable
    Uint64 SIE = 1 << 1; // Supervisor Interrupt Enable

    context = (TrapFrame*)((char*)stack + stacksize) - 1;
    if (flags & F_Kernel) {
        context->epc = (Uint64)KernelProcessEntry; // Exception PC
        context->reg.s0 = (Uint64)func;
        context->reg.s1 = (Uint64)funcData;
        context->status = (read_csr(sstatus) | SPP | SPIE) & (~SIE); // 详见手册
        context->reg.sp = (Uint64)((char*)stack + stacksize);
    } else {

        context->epc = (Uint64)useraddr; // Exception PC
        context->status = (read_csr(sstatus) | SPIE) & (~SPP) & (~SIE); // 详见手册
        context->reg.sp = InnerUserProcessStackAddr + InnerUserProcessStackSize - 512;
    }
    // kout[Info] << "Process::start epc " << (void*)context->epc << " sp" << context->reg.sp << endl;

    switchStatus(S_Ready);

    return true;
}

void Process::switchStatus(ProcStatus tarStatus)
{
    // kout << Yellow << name << "   status to" << tarStatus << endl;
    ClockTime t = GetClockTime();
    ClockTime d = t - timeBase;
    timeBase = t;
    switch (status) {

    // 更新各时间值
    case S_Allocated:
    case S_Initing:
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
        sleepTime += d;
        break;
    case S_Terminated:
        break;
    default:
        break;
    }

    /*
        switch (tarStatus) {
            case S_None:
                kout[DeBug]<<this->id<<" status to S_None"<<endl;
                break;
            case S_Sleeping:
                kout[DeBug]<<this->id<<" status to S_Sleep"<<endl;
                break;
            case S_Running:
                kout[DeBug]<<this->id<<" status to S_Running"<<endl;
                break;
            default:
                break;
        }  */
    status = tarStatus;
}

Process* ProcessManager::allocProc()
{
    for (int i = 0; i < MaxProcessCount; i++) {
        if (Proc[i].status == S_None) {
            procCount++;
            Proc[i].switchStatus(S_Allocated); // 分配好所有进程状态
            return &Proc[i]; // 返回最后一个空进程
        }
    }
    return nullptr;
}

Process* ProcessManager::getProc(PID _id)
{
    if (_id > 0 && _id < MaxProcessCount) {
        return &Proc[_id];
    }
    if (_id == 0) {
        kout[Fault] << "can't get idle0" << endl;
    }
    kout[Fault] << "PID out of range" << endl;
    return nullptr;
}

bool ProcessManager::freeProc(Process* proc)
{
    // kout << Yellow << "freeProc " << proc->getID() << endl;
    if (proc->getStatus() == S_None) {
        return true;
    }
    if (proc == curProc) {
        kout[Warning] << "freeProcess == curProc" << curProc->id << endl;
    }
    if (proc == &Proc[0]) {
        kout[Fault] << "freeProcess == idle0" << curProc->id << endl;
    }

    Proc[proc->id].switchStatus(S_None);
    procCount--;
    return false;
}

void ProcessManager::destroy()
{
    for (int i = 0; i < MaxProcessCount; i++) {
        if (Proc[i].status != S_None) {
            Proc[i].destroy();
        }
    }
}

TrapFrame* ProcessManager::Schedule(TrapFrame* preContext)
{
    Process* tar;

    kout[DeBug] << "Schedule " << endl;
    pm.simpleShow();
    // kout[Info] << "Schedule NOW  cur::" << curProc->getName() <<"id  "<<curProc->getID() << endl;
    curProc->context = preContext; // 记录当前状态，防止只有一个进程但是触发调度，导致进程号错乱
    // kout << Blue << procCount << endl;
    if (curProc != nullptr && procCount >= 2) {
        int i, p;
        ClockTime minWaitingTarget = -1;
    RetrySchedule:
        for (i = 1, p = curProc->id; i < MaxProcessCount; ++i) {
            tar = &Proc[(i + p) % MaxProcessCount];

            // if (tar->status == S_Sleeping && NotInSet(tar->SemWaitingTargetTime, 0ull, (Uint64)-1)) {//Sleep的休眠时间管理，目前还未实现
            //     minWaitingTarget = minN(minWaitingTarget, tar->SemWaitingTargetTime);
            //     if (GetClockTime() >= tar->SemWaitingTargetTime)
            //         tar->SwitchStat(Process::S_Ready);
            // }
            // kout<<p<<"P+i "<<(p+i)%MaxProcessCount<<tar->status<<endl;
            // pm.show();
            if (tar->status == S_Ready) { // 如果是ready态则进行切换
                tar->getVMS()->showVMRCount();
                tar->run();
                // kout[Debug] << (void*)tar->context->epc;
                // tar->getVMS()->EnableAccessUser();
                // kout[Debug] << DataWithSize((void *)tar->context->epc, 108);
                // tar->getVMS()->DisableAccessUser();
                kout[DeBug] << "into " << tar->name << " id " << tar->getID() << endl;

                return tar->context;
            } else if (tar->status == S_Terminated && (tar->flags & F_AutoDestroy)) // 如果为自动销毁且为僵死态则进行销毁
            {
                tar->destroy();
                pm.freeProc(tar);
            }
            // else if (tar->status==S_None) {

            // } else {
            // kout[DeBug]<<"unknown status "<<tar->id<<" status "<<tar->status<<endl;
            // }
        }
    }

    return pm.getKernelProc()->context; // 如果没有任何调度则进入内核态，防止出错
}

void ProcessManager::immSchedule()
{
    // kout[Info] << "Schedule from Kernel " << endl;
    RegisterData a7 = SYS_sched_yeild;
    asm volatile("ld a7,%0; ebreak" ::"m"(a7) : "memory");
    // kout<<"__________________"<<endl;
}

bool Process::initFds()
{
    // 进程创建时它的fd表的虚拟头节点应该已经创建好
    if (fo_head == nullptr) {
        kout[Fault] << "The Process's fo head doesn't exist!" << endl;
        return false;
    }

    // 必须保证初始化时这三个fd是新生成的
    // 即进程的fd表中没有其他fd表项
    if (fo_head->next != nullptr) {
        kout[Warning] << "The Process init FD TABLE has other fds!" << endl;
        // 那么就先释放掉所有的再新建头节点
        fom.init_proc_fo_head(this);
    }
    // kout[Info] << "initFds" << endl;

    // 初始化一个进程时需要初始化它的文件描述符表
    // 即一个进程创建时会默认打开三个文件描述符 标准输入 输出 错误
    file_object* cur_fo_head = fo_head;
    file_object* tmp_fo = nullptr;
    if (STDIO != nullptr) {
        // 只有当stdio文件对象非空时创建才有必有
        tmp_fo = fom.create_flobj(cur_fo_head, STDIN_FILENO); // 标准输入
        fom.set_fo_file(tmp_fo, STDIO);
        fom.set_fo_flags(tmp_fo, file_flags::RDONLY);
        tmp_fo = fom.create_flobj(cur_fo_head, STDOUT_FILENO); // 标准输出
        fom.set_fo_file(tmp_fo, STDIO);
        fom.set_fo_flags(tmp_fo, file_flags::WRONLY);
        tmp_fo = fom.create_flobj(cur_fo_head, STDERR_FILENO); // 标准错误
        fom.set_fo_file(tmp_fo, STDIO);
        fom.set_fo_flags(tmp_fo, file_flags::WRONLY);
    }
    /*  else {
         // 暂时如下trick
         tmp_fo = fom.create_flobj(cur_fo_head, STDIN_FILENO); // 标准输入
         // fom.set_fo_file(tmp_fo, STDIO);
         fom.set_fo_flags(tmp_fo, O_RDONLY);
         tmp_fo = fom.create_flobj(cur_fo_head, STDOUT_FILENO); // 标准输出
         // fom.set_fo_file(tmp_fo, STDIO);
         fom.set_fo_flags(tmp_fo, O_WRONLY);
         tmp_fo = fom.create_flobj(cur_fo_head, STDERR_FILENO); // 标准错误
         // fom.set_fo_file(tmp_fo, STDIO);
         fom.set_fo_flags(tmp_fo, O_WRONLY);
     } */
    return true;
}

bool Process::destroyFds()
{
    // 释放一个进程的所有文件描述符表资源
    // 由于在fom封装层做了核心的工作
    // 这一层封装的关键妙处就在于对于进程来讲需要管控的资源只有fo文件对象结构体的资源
    // 而至于这个结构体里面的成员的相关资源在文件系统和fom类中已经分别做了处理
    // 使得各自完成各自的工作 层次清晰 互不干扰
    // 即进程只管理文件描述符表 没有权利直接管理文件 由OS进行整体的组织
    // 这里只需要调用相关函数即可
    if (fo_head == nullptr) {
        // 已经为空
        return true;
    }
    fom.free_all_flobj(fo_head);
    return true;
}

file_object* Process::getSpecFds(int fd_num)
{
    // 充分体现了在进程和文件增加一层fo的管理和封装的绝妙之处
    // 极大地方便了两边的管理和代码编写 逻辑和层次也非常清晰
    file_object* ret_fo = nullptr;
    ret_fo = fom.get_from_fd(fo_head, fd_num);
    if (ret_fo == nullptr) {
        kout[Fault] << "The Process can not get the specified FD!" << endl;
        return ret_fo;
    }
    return ret_fo;
}

bool Process::copyFds(Process* src)
{
    // 对于进程间的文件描述符表的拷贝
    // 使用最简单朴素的方式 即删除原来的 复制新的
    // 不过需要注意复制新的并不能仅仅做指针的迁移
    // 因为如上所述 fo即fom的封装与设计极好地分割又统一联系了进程和文件系统间的关系
    // 而且fo是进程的下层接口 文件系统是进程的上层接口
    // 因此进程只要按照它需要的逻辑任意操作fo即可 不需要考虑文件系统的组织问题
    fom.free_all_flobj(fo_head);
    file_object* dst_fo_head = fo_head;
    file_object* dst_fo_ptr = dst_fo_head;
    file_object* src_fo_ptr = nullptr;
    for (src_fo_ptr = src->fo_head->next; src_fo_ptr != nullptr; src_fo_ptr = src_fo_ptr->next) {
        file_object* new_fo = fom.duplicate_fo(src_fo_ptr);
        fom.set_fo_fd(new_fo, src_fo_ptr->fd);
        if (new_fo == nullptr) {
            kout[Fault] << "File Object Duplicate Error!" << endl;
        }
        dst_fo_ptr->next = new_fo;
        dst_fo_ptr = dst_fo_ptr->next;
        // kout[Info]<<"loop detecte "<<endl;
    }
    return true;
}

bool Process::setProcCWD(const char* cwd_path)
{
    // kout[Warning]<<"set Proc CWD___________________________________"<<cwd_path<<endl;
    if (cwd_path == nullptr) {
        kout[Fault] << "The cwd_path to be set is NULL!" << endl;
        return false;
    }

    if (curWorkDir != nullptr) {
        // 已经存在了则直接释放字符串分配的资源
        delete[] curWorkDir;
    }
    // 由于是字符指针
    // 不能忘记分配空间
    curWorkDir = new char[strlen(cwd_path) + 1];
    strcpy(curWorkDir, cwd_path);
    kout[Warning] << "set Proc CWD___________________________________" << curWorkDir << endl;

    return true;
}

extern "C" {
void KernelProcessExit(int re)
{

    // kout[Debug] << "FFFFFFFFFF" << re << endl;
    // pm.getCurProc()->switchStatus(S_Terminated);

    RegisterData a0 = re, a7 = SYS_Exit;
    asm volatile("ld a0,%0; ld a7,%1; ebreak" ::"m"(a0), "m"(a7) : "memory");
    //	ProcessManager::Current()->Exit(re);//Multi cpu need get current of that cpu??
    //	ProcessManager::Schedule();//Need improve...
    kout[Fault] << "KernelProcessExit:Reached unreachable branch" << endl;
}

void UserProcessExit(Process* proc)
{

    proc->switchStatus(S_Terminated);
    RegisterData a7 = SYS_Exit;
    kout[Fault] << "KernelProcessExit:Reached unreachable branch" << endl;
}
}

void SwitchToUserStat()
{
    pm.getCurProc()->switchStatus(S_UserRunning);
}

ProcessManager pm;