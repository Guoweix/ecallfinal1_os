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
    kout[Debug] << "proc pid : " << id << endline
                << "proc name : " << name << endline
                << "proc state : " << status << endline
                << "proc flags : " << flags << endline
                << "proc VMS : " << (void*)VMS << endline
                << "proc kstack : " << (void*)stack << endline
                << "proc kstacksize : " << stacksize << endl;
    if (level == 1) {
        kout[Debug] << "proc pid_fa : " << (void*)father << endline
                    << "proc pid_bro_pre : " << (void*)broPre << endline
                    << "proc pid_bro_next : " << (void*)broNext << endline
                    << "proc pid_fir_child : " << (void*)fstChild << endl;
    }
    kout << endl;
}

void ProcessManager::show()
{
    for (int i = 0; i < MaxProcessCount; i++) {
        if (Proc[i].status != S_None) {
            Proc[i].show();
        }
    }
    kout << endl;
}

void ProcessManager::simpleShow()
{
    for (int i = 0; i < MaxProcessCount; i++) {
        if (curProc->id == i) {
            kout[Debug] << "Cur====>" << endl;
        }
        if (Proc[i].status != S_None) {
            kout[Debug] << Proc[i].name << endline
                        << Proc[i].id << endl;
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
    init(F_Kernel);
    setFa(nullptr);
    stack = boot_stack;
    stacksize = PAGESIZE;
    setProcCWD("/");
    VMS = VirtualMemorySpace::Boot();

    setName("idle_0");
    switchStatus(S_Running);
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

    fom.init_proc_fo_head(this);
    initFds();
    curWorkDir = nullptr;

    waitSem = new Semaphore(0);
    SemRef = 0;
    memset(&context, 0, sizeof(context));
    flags = _flags;
    name[0] = 0;
}

void Process::destroy()
{
    kout[Debug] << "Process destroy:" << id << endl;
    if (status == S_None) {
        return;
    } else if (status != S_Initing || status != S_Terminated) {
        exit(Exit_Normal);
    }
    while (fstChild) {
        fstChild->destroy();
    }
    if (broPre) {
        broPre->broNext = broNext;
    } else {
        if (father) {
            father->fstChild = broNext;
        }
    }
    if (broNext) {
        broNext->broPre = broPre;
    }
    setFa(nullptr);

    // if (VMS!=nullptr) {

    // }
    if (waitSem != nullptr) {
        delete waitSem;
        waitSem = nullptr;
    }
    if (curWorkDir != nullptr) {
        kfree(curWorkDir);
        curWorkDir = nullptr;
    }
    setName(nullptr);
    if (fo_head != nullptr) {
        destroyFds();
        kfree(fo_head);
        fo_head = nullptr;
    }
    if (Heap != nullptr) {
        kfree(Heap);
        Heap = nullptr;
    }
    if (stack != nullptr) {
        kfree(stack);
        stack = nullptr;
    }
    stacksize = 0;
    pm->freeProc(this);
    return;
}

bool Process::exit(int re)
{
    // kout<<"exit"<<re;
    switchStatus(S_Terminated);
    if (status != S_Terminated) {
        kout[Fault] << "Process ::Exit:status is not S_Terminated" << id << endl;
    }
    if (re != Exit_Normal) {
        kout[Warning] << "Process ::Exit:" << id << "exit with return value" << re << endl;
    }
    VMS->Leave();
    destroyFds();
    if (!(flags & F_AutoDestroy) && father != nullptr) {
        father->waitSem->signal();
    }
    return true;
}

bool Process::run()
{
    Process* cur = pm->getCurProc();
    cur->show();
    kout[Debug] << "switch from " << cur->name << " to " << name << endl;
    if (this != cur) {
        if (cur->status == S_Running) {
            cur->switchStatus(S_Ready);
        }
        switchStatus(S_Running);
        pm->curProc = this;
        VMS->Enter();
    }
    kout[Debug] << "switch finish" << endl;
    return true;
}

bool Process::start(void* func, void* funcData, PtrUint useraddr)
{

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
    kout[Info] << "creaet Porcess" << name << (void*)context->epc << endl;

    switchStatus(S_Ready);

    return true;
}

void Process::switchStatus(ProcStatus tarStatus)
{
    ClockTime t = GetClockTime();
    ClockTime d = t - timeBase;
    timeBase = t;
    switch (status) {

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
    status = tarStatus;
}

Process* ProcessManager::allocProc()
{
    for (int i = 0; i < MaxProcessCount; i++) {
        if (Proc[i].status == S_None) {
            procCount++;
            Proc[i].switchStatus(S_Allocated);
            return &Proc[i];
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
    if (proc == curProc) {
        kout[Fault] << "freeProcess == curProc" << curProc->id << endl;
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

    kout[Debug] << "Schedule NOW" << endl;
    curProc->context = preContext;

    if (curProc != nullptr && procCount >= 2) {
        int i, p;
        ClockTime minWaitingTarget = -1;
    RetrySchedule:
        for (i = 1, p = curProc->id; i < MaxProcessCount; ++i) {
            tar = &Proc[(i + p) % MaxProcessCount];
            // if (tar->status == S_Sleeping && NotInSet(tar->SemWaitingTargetTime, 0ull, (Uint64)-1)) {
            //     minWaitingTarget = minN(minWaitingTarget, tar->SemWaitingTargetTime);
            //     if (GetClockTime() >= tar->SemWaitingTargetTime)
            //         tar->SwitchStat(Process::S_Ready);
            // }
            // kout<<p<<"P+i "<<(p+i)%MaxProcessCount<<tar->status<<endl;
            // pm.show();

            if (tar->status == S_Ready) {

                tar->getVMS()->showVMRCount();
                tar->run();
                // if (tar->getID()==3) {
                //     asm volatile("li s0,0\ncsrw sstatus,s0,li s1,0x80020\ncsrw sepc,s1\nsret");

                // }

                // kout[Debug] << (void*)tar->context->epc;

                // tar->getVMS()->EnableAccessUser();
                // kout[Debug] << DataWithSize((void *)tar->context->epc, 108);
                // tar->getVMS()->DisableAccessUser();

                return tar->context;
            } else if (tar->status == S_Terminated && (tar->flags & F_AutoDestroy))
                tar->destroy();
        }
    }
    
    return pm.getKernelProc()->context;
}

void ProcessManager::immSchedule()
{
    bool t;
    IntrSave(t);
    sbi_set_time(sbi_get_time());
    IntrRestore(t);
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
        kout[Info] << "The Process init FD TABLE has other fds!" << endl;
        // 那么就先释放掉所有的再新建头节点
        fom.init_proc_fo_head(this);
    }

    // 初始化一个进程时需要初始化它的文件描述符表
    // 即一个进程创建时会默认打开三个文件描述符 标准输入 输出 错误
    file_object* cur_fo_head = fo_head;
    file_object* tmp_fo = nullptr;
    if (STDIO != nullptr) {
        // 只有当stdio文件对象非空时创建才有必有
        tmp_fo = fom.create_flobj(cur_fo_head, STDIN_FILENO); // 标准输入
        fom.set_fo_file(tmp_fo, STDIO);
        fom.set_fo_flags(tmp_fo, O_RDONLY);
        tmp_fo = fom.create_flobj(cur_fo_head, STDOUT_FILENO); // 标准输出
        fom.set_fo_file(tmp_fo, STDIO);
        fom.set_fo_flags(tmp_fo, O_WRONLY);
        tmp_fo = fom.create_flobj(cur_fo_head, STDERR_FILENO); // 标准错误
        fom.set_fo_file(tmp_fo, STDIO);
        fom.set_fo_flags(tmp_fo, O_WRONLY);
    } else {
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
    }
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
    }
    return true;
}

bool Process::setProcCWD(const char* cwd_path)
{

    if (cwd_path == nullptr) {
        kout[Fault] << "The cwd_path to be set is NULL!" << endl;
        return false;
    }

    if (curWorkDir != nullptr) {
        // 已经存在了则直接释放字符串分配的资源
        kfree(curWorkDir);
    }
    // 由于是字符指针
    // 不能忘记分配空间
    curWorkDir = (char*)kmalloc(strlen(cwd_path) + 5);
    strcpy(curWorkDir, cwd_path);
    return true;
}

extern "C" {
void KernelProcessExit(int re)
{

    kout[Debug] << "FFFFFFFFFF" << re << endl;
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