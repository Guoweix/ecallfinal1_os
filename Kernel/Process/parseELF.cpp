#include "Library/KoutSingle.hpp"
#include "Memory/pmm.hpp"
#include "Memory/vmm.hpp"
#include "Process/Process.hpp"
#include "Trap/Interrupt.hpp"
#include "Types.hpp"
#include <File/FileObject.hpp>
#include <File/vfsm.hpp>
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

    kPorcess->start((void*)func, arg);
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

    PtrUint loadsize = (char*)end - (char*)start;
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
    // char a[100];

    {
        proc->getVMS()->Enter();
        proc->getVMS()->EnableAccessUser();
        kout[Info] << DataWithSize((void*)start, loadsize) << endl;
        memcpy((char*)InnerUserProcessLoadAddr, (const char*)start, loadsize);
        // while (1) ;
        kout[Info] << DataWithSize((void*)InnerUserProcessLoadAddr, loadsize) << endl;
        VirtualMemorySpace::Current()->show();
        // kout<<a[0]<<endl;
        proc->getVMS()->DisableAccessUser();
        proc->getVMS()->Leave();
    }
    proc->setStack(nullptr, PAGESIZE * 4);
    if (!(Flag & F_AutoDestroy)) {
        proc->setFa(pm.getCurProc());
    }
    // vms->RemoveVMR(VirtualMemorySpace::Kernel()->FindVMR((PtrUint)kernelstart), false);
    proc->start((void*)nullptr, nullptr, InnerUserProcessLoadAddr);
    kout[Test] << "CreateUserImgProcess" << (void*)start << " " << (void*)end << "with  PID " << proc->getID() << endl;

    _interrupt_restore(t);
    return proc;
}

int start_process_formELF(procdata_fromELF* proc_data)
{
    // 从ELF解析产生的进程会执行这个启动函数
    // 传入参数完成进程的初始化后进入用户状态执行程序
    file_object* fo = proc_data->fo;
    Process* proc = proc_data->proc;
    VirtualMemorySpace* vms = proc_data->vms;
    vms->Create();
    vms->EnableAccessUser();

    Uint64 breakpoint = 0; // 用来定义用户数据段
    Uint16 phnum = proc_data->e_header.e_phnum; // 可执行文件中的需要解析的段数量
    Uint64 phoff = proc_data->e_header.e_phoff; // 段表在文件中的偏移量 需要通过段表访问到每个段
    Uint16 phentsize = proc_data->e_header.e_phentsize; // 段表中每个段表项的大小
    kout << phnum << ' ' << phoff << ' ' << phentsize << endl;
    for (int i = 0; i < phnum; i++) {
        // 解析每一个程序头 即段
        Elf_Phdr pgm_hdr { 0 };
        // 为了读取文件中这个位置的段
        // 需要计算偏移量通过seek操作进行读取
        Sint64 offset = phoff + i * phentsize;
        fom.seek_fo(fo, offset, file_ptr::Seek_beg);
        Sint64 rd_size = 0;
        rd_size = fom.read_fo(fo, &pgm_hdr, sizeof(pgm_hdr));
        if (rd_size != sizeof(pgm_hdr)) {
            // 没有成功读到指定大小的文件
            // 输出提示信息并且终止函数执行
            kout[Fault] << "Read ELF program header Fail!" << endl;
            return -1;
        }

        bool is_continue = 0;
        Uint32 type = pgm_hdr.p_type;
        switch (type) {
        case P_type::PT_LOAD:
            // 读到可装载的段了可以直接退出
            break;
        default:
            // 其他的情况输出相关提示信息即可
            if (type >= P_type::PT_LOPROC && type <= P_type::PT_HIPROC) {
                kout[Info] << "Currently the ELF Segment parsing is unsolvable!" << endl;
                kout[Info] << "The Segment Type is " << type << endl;
                is_continue = 1;
            } else {
                kout[Fault] << "Unsolvable ELF Segment whose Type is " << type << endl;
                return -1;
            }
            break;
        }

        if (is_continue) {
            // 说明需要继续去读段
            // 直接在这里跳转 否则就继续进行下面的转载
            continue;
        }

        kout[Debug] << "p_align: " << (void*)(pgm_hdr.p_align) << endl;
        kout[Debug] << "p_filesz: " << (void*)(pgm_hdr.p_filesz) << endl;
        kout[Debug] << "p_flags: " << (void*)(pgm_hdr.p_flags) << endl;
        kout[Debug] << "p_memsz: " << (void*)(pgm_hdr.p_memsz) << endl;
        kout[Debug] << "p_offset: " << (void*)(pgm_hdr.p_offset) << endl;
        kout[Debug] << "p_paddr: " << (void*)(pgm_hdr.p_paddr) << endl;
        kout[Debug] << "p_type: " << (void*)(pgm_hdr.p_type) << endl;
        kout[Debug] << "p_vaddr: " << (void*)(pgm_hdr.p_vaddr) << endl;

        // 统计相关信息
        // 加入VMR
        Uint32 vmr_flags = 0;
        Uint32 ph_flags = pgm_hdr.p_flags;
        // 段权限中可读与可执行是通用的
        // 可写权限是最高权限 可以覆盖其他两个
        if (ph_flags & P_flags::PF_R) {
            vmr_flags |= 0b1;
            vmr_flags |= 0b100;
        }
        if (ph_flags & P_flags::PF_X) {
            vmr_flags |= 0b100;
            vmr_flags |= 0b1;
        }
        vmr_flags |= 0b10;

        // 权限统计完 可以在进程的虚拟空间中加入这一片VMR区域了
        // 这边使用的memsz信息来作为vmr的信息
        // 输出提示信息
        Uint64 vmr_begin = pgm_hdr.p_vaddr;
        Uint64 vmr_memsize = pgm_hdr.p_memsz;
        Uint64 vmr_end = vmr_begin + vmr_memsize;
        kout << "Add VMR from " << vmr_begin << " to " << vmr_end << " " << (void*)vmr_flags << endl;

        // VirtualMemoryRegion* vmr_add = (VirtualMemoryRegion*)kmalloc(sizeof(VirtualMemoryRegion));
        // vmr_add->Init(vmr_begin, vmr_end, vmr_flags);
        VirtualMemoryRegion* vmr_add = new VirtualMemoryRegion(vmr_begin, vmr_end, vmr_flags);
        vms->InsertVMR(vmr_add);
        vms->Enter();

        memset((char*)vmr_begin, 0, vmr_memsize);
        vms->Leave();

        Uint64 tmp_end = vmr_add->GetEnd();
        if (tmp_end > breakpoint) {
            // 更新用户空间的数据段(heap)
            breakpoint = tmp_end;
        }

        // 上面读取了程序头
        // 接下来继续去读取段的在文件中的内容
        // 将对应的内容存放到进程中vaddr的区域
        // 这边就是用filesz来读取具体的内容
        fom.seek_fo(fo, pgm_hdr.p_offset, file_ptr::Seek_beg);
        vms->Enter();
        rd_size = fom.read_fo(fo, (void*)vmr_begin, pgm_hdr.p_filesz);
        vms->Leave();
        if (rd_size != pgm_hdr.p_filesz) {
            kout[Fault] << "Read ELF program header in file Fail!" << endl;
            return -1;
        }
        // kout << Hex((uint64)(vmr_begin)) << endl;
        // kout << Memory((void*)0x1000, (void*)0x2000, 100);
    }
    kout<<"++++++++++++++++++++++="<<endl;

    // 上面的循环已经读取了所有的段信息
    // 接下来更新进程需要的相关信息即可
    // 首先是为用户进程开辟一块用户栈空间
    vms->Enter();
    Uint64 vmr_user_stack_beign = InnerUserProcessStackAddr;
    Uint64 vmr_user_stack_size = InnerUserProcessStackSize;
    Uint64 vmr_user_stack_end = vmr_user_stack_beign + vmr_user_stack_size;
    VirtualMemoryRegion* vmr_user_stack = (VirtualMemoryRegion*)kmalloc(sizeof(VirtualMemoryRegion));
    vmr_user_stack->Init(vmr_user_stack_beign, vmr_user_stack_end, VirtualMemoryRegion::VM_USERSTACK);
    vms->InsertVMR(vmr_user_stack);

    memset((char*)vmr_user_stack_beign, 0, vmr_user_stack_size);
    kout<<"++++++++++++++++++++++="<<endl;

    // 用户堆段信息 也即数据段
    HeapMemoryRegion* hmr = (HeapMemoryRegion*)kmalloc(sizeof(HeapMemoryRegion));
    kout<<"++++++++++++++++++++++="<<endl;
    hmr->Init(breakpoint);
    vms->InsertVMR(hmr);
    kout<<(void*)hmr->GetStart();
    memset((char*)hmr->GetStart(), 0, hmr->GetLength());
    // kout<<DataWithSize((void *)0x800020,1000);
    vms->Leave();
    // 在这里将进程的heap成员更新
    // 也是在进程管理部分基本不会操作heap段的原因
    // pHMSm.set_proc_heap(proc, hmr);
    proc->setHeap(hmr);

    vms->DisableAccessUser();



    proc->start((void*)nullptr, nullptr, proc_data->e_header.e_entry);
    proc->setName("user");
    // kout[Test] << "CreateUserImgProcess" << (void*)start << " " << (void*)end << "with  PID " << proc->getID() << endl;
    pm.show();


    // 正确完整地执行了这个流程
    // 接触阻塞并且返回0
    // proc_data->sem.signal();
    return 0;
}

Process* CreateProcessFromELF(file_object* fo, const char* wk_dir, ProcFlag proc_flags)
{
    bool t;
    IntrSave(t);

    procdata_fromELF* proc_data = new procdata_fromELF;
    proc_data->fo = fo;
    // 信号量初始化

    Sint64 rd_size = 0;
    rd_size = fom.read_fo(fo, &proc_data->e_header, sizeof(proc_data->e_header));

    if (rd_size != sizeof(proc_data->e_header) || !proc_data->e_header.is_ELF()) {
        // kout[red] << "Create Process from ELF Error!" << endl;
        // kout[red] << "Read File is NOT ELF!" << endl;
        kfree(proc_data);
        return nullptr;
    }

    VirtualMemorySpace* vms = (VirtualMemorySpace*)kmalloc(sizeof(VirtualMemorySpace));
    vms->Init();

    Process* proc = pm.allocProc();

    proc->init((ProcFlag)((Uint64)F_User | (Uint64)proc_flags));
    proc->setStack(nullptr, PAGESIZE * 4);
    proc->setVMS(vms);
    proc->setFa(pm.getCurProc());

    char * abs_cwd=vfsm.unified_path(wk_dir, pm.getCurProc()->getCWD());
    proc->setProcCWD(abs_cwd);
    // pm.init_proc(proc, 2, proc_flags);
    // pm.set_proc_kstk(proc, nullptr, KERNELSTACKSIZE * 4);
    // pm.set_proc_vms(proc, vms);
    // pm.set_proc_fa(proc, pm.get_cur_proc());

    // 通过vfsm得到标准化的绝对路径
    // char* abs_cwd = vfsm.unified_path(wk_dir, pm.getCurProc()->getCWD());

    kfree(abs_cwd);

    // 填充userdata
    // 然后跳转执行指定的启动函数
    proc_data->vms = vms;
    proc_data->proc = proc;
    Uint64 user_start_addr = proc_data->e_header.e_entry;
    start_process_formELF(proc_data);
    // pm.start_user_proc(proc, start_process_formELF, proc_data, user_start_addr);

    // 这里跳转到启动函数之后进程管理就会有其他进程参与轮转调度了
    // 为了确保新的进程能够顺利执行完启动函数这里再释放相关的资源
    // 这里让当前进程阻塞在这里
    // proc_data->sem.wait();
    // proc_data->sem.destroy();
    // kfree(proc_data);
    IntrRestore(t);

    return proc;
}