#include "Library/KoutSingle.hpp"
#include "Memory/pmm.hpp"
#include "Memory/vmm.hpp"
#include "Process/Process.hpp"
#include "Trap/Interrupt.hpp"
#include "Types.hpp"
#include <File/FileObject.hpp>
#include <File/vfsm.hpp>
#include <Process/ParseELF.hpp>
#include <Library/Pathtool.hpp>

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
        // kout[Info] << DataWithSize((void*)start, loadsize) << endl;
        memcpy((char*)InnerUserProcessLoadAddr, (const char*)start, loadsize);
        // while (1) ;
        // kout[Info] << DataWithSize((void*)InnerUserProcessLoadAddr, loadsize) << endl;
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
    Uint64 ProgramHeaderAddress=0;
    Uint16 phnum = proc_data->e_header.e_phnum; // 可执行文件中的需要解析的段数量
    Uint64 phoff = proc_data->e_header.e_phoff; // 段表在文件中的偏移量 需要通过段表访问到每个段
    Uint16 phentsize = proc_data->e_header.e_phentsize; // 段表中每个段表项的大小
    kout[Info] << phnum << ' ' << phoff << ' ' << phentsize << endl;
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

        // kout[Error]<<(void*)type<<endl;
        // kout[Error]<<DataWithSize(&pgm_hdr,512)<<endl;

        switch (type) {
        case P_type::PT_LOAD:
            // 读到可装载的段了可以直接退出
            //
            //
            {
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
                // kout<<Red<<"START"<<pgm_hdr.p_filesz<<endl;
                rd_size = fom.read_fo(fo, (void*)vmr_begin, pgm_hdr.p_filesz);
                vms->Leave();
                if (rd_size != pgm_hdr.p_filesz) {
                    kout[Fault] << "Read ELF program header in file Fail!" << endl;
                    return -1;
                }
                // kout << Hex((uint64)(vmr_begin)) << endl;
                // kout << Memory((void*)0x1000, (void*)0x2000, 100);
            }
            break;
        case P_type::PT_INTERP:
            kout[Fault] << "PT_INTERP" << type << endl;
            break;
        case P_type::PT_PHDR:
				ProgramHeaderAddress=pgm_hdr.p_vaddr;
        case P_type::PT_LOPROC:
        case P_type::PT_HIPROC:
        case P_type::PT_GNU_RELRO:
        case P_type::PT_GNU_STACK:
        case P_type::PT_TLS:
        case P_type::DT_AARCH64_PAC_PLT :
            kout[Warning] << "Unsolvable ELF Segment whose Type is " << type << endl;
            break;

        default:
            // 其他的情况输出相关提示信息即可
            kout[Fault] << "Unsolvable ELF Segment whose Type is " << type << endl;
            return -1;
        }
    }
    // kout << "++++++++++stack++++++++++++=" << endl;

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
    // kout << "++++++++++hmr++++++++++++=" << endl;
    // kout<<Yellow<<DataWithSizeUnited((void *)0x1000,0x1141,16);
    // 用户堆段信息 也即数据段
    HeapMemoryRegion* hmr = (HeapMemoryRegion*)kmalloc(sizeof(HeapMemoryRegion));
    hmr->Init(breakpoint);
    vms->InsertVMR(hmr);
    kout << (void*)hmr->GetStart();
    memset((char*)hmr->GetStart(), 0, hmr->GetLength());
    // kout<<DataWithSize((void *)0x800020,1000);
    vms->Leave();
    // 在这里将进程的heap成员更新
    // 也是在进程管理部分基本不会操作heap段的原因
    // pHMSm.set_proc_heap(proc, hmr);
    proc->setHeap(hmr);


    
    // kout << "++++++++++argv++++++++++++=" << endl;
    PtrSint p = vms->GetUsableVMR(0x60000000, 0x70000000, PAGESIZE);
    kout<<(void *)p<<endl;
    VirtualMemoryRegion* vmr_str = (VirtualMemoryRegion*)kmalloc(sizeof(VirtualMemoryRegion));

    TrapFrame* tf = (TrapFrame*)((char*)proc->stack + proc->stacksize) - 1;
    tf->reg.sp = InnerUserProcessStackAddr + InnerUserProcessStackSize - 512;
    Uint8* sp = (decltype(sp))tf->reg.sp;
    vmr_str->Init(p, p + PAGESIZE, VirtualMemoryRegion::VM_RW);
    vms->InsertVMR(vmr_str);

    vms->show();
    vms->Enter();
    // kout << sp << endl;
    char* s = (char*)p;

    auto PushInfo32 = [&sp](Uint32 info) {
        *(Uint32*)sp = info;
        sp += sizeof(long); //!! Need improve...
    };
    auto PushInfo64 = [&sp](Uint64 info) {
        *(Uint64*)sp = info;
        sp += 8;
    };
    auto PushString = [&s](const char* str) -> const char* {
        const char* s_bak = s;
        s = strcpyre(s, str);
        *s++ = 0;
        return s_bak;
    };

    PushInfo32(proc_data->argc);
    if (proc_data->argc)
        for (int i = 0; i < proc_data->argc; ++i)
            PushInfo64((Uint64)PushString(proc_data->argv[i]));
    PushInfo64(0); // End of argv
    PushInfo64((Uint64)PushString("LD_LIBRARY_PATH=/VFS/FAT32"));
    PushInfo64(0); // End of envs
                
    vms->Leave();
    vms->DisableAccessUser();
    // kout << "++++++++++++++++++++++=" << endl;
/* //AUX的添加，暂时先不处理
    
    if (ProgramHeaderAddress != 0) {
        AddAUX(ELF_AT::PHDR, ProgramHeaderAddress);
        AddAUX(ELF_AT::PHENT, proc_data->e_header.phentsize);
        AddAUX(ELF_AT::PHNUM, proc_data->e_header.phnum);

        AddAUX(ELF_AT::UID, 10);
        AddAUX(ELF_AT::EUID, 10);
        AddAUX(ELF_AT::GID, 10);
        AddAUX(ELF_AT::EGID, 10);
    }
    AddAUX(ELF_AT::PAGESZ, PAGESIZE);
    if (ProgramInterpreterBase != 0)
        AddAUX(ELF_AT::BASE, ProgramInterpreterBase);
    AddAUX(ELF_AT::ENTRY, proc_data->e_header.entry);
    PushInfo64(0); // End of auxv
                    */
    // kout << "++++++++++++start++++++++++=" << endl;

    proc->start((void*)nullptr, nullptr, proc_data->e_header.e_entry, proc_data->argc, proc_data->argv);
    proc->setName(fo->file->name);
    pm.show();

    // 正确完整地执行了这个流程
    // 接触阻塞并且返回0
    // proc_data->sem.signal();
    return 0;
}

Process* CreateProcessFromELF(file_object* fo, const char* wk_dir, int argc, char** argv, ProcFlag proc_flags)
{
    bool t;
    IntrSave(t);

    procdata_fromELF* proc_data = new procdata_fromELF;
    proc_data->fo = fo;
    // 信号量初始化

    Sint64 rd_size = 0;
    kout<<"read_fo start"<<endl;
    rd_size = fom.read_fo(fo, &proc_data->e_header, sizeof(proc_data->e_header));

    // kout<<DataWithSize((void *)&proc_data->e_header,sizeof(proc_data->e_header))<<endl;

    kout<<"read_fo finish"<<endl;

    if (rd_size != sizeof(proc_data->e_header) || !proc_data->e_header.is_ELF()) {
        // kout[red] << "Create Process from ELF Error!" << endl;
        kout[Error] << "Read File is NOT ELF!" << endl;
        kfree(proc_data);
        IntrRestore(t);
        return nullptr;
    }

    VirtualMemorySpace* vms = (VirtualMemorySpace*)kmalloc(sizeof(VirtualMemorySpace));
    vms->Init();

    Process* proc = pm.allocProc();

    proc->init((ProcFlag)((Uint64)F_User | (Uint64)proc_flags));
    proc->setStack(nullptr, PAGESIZE * 4);
    proc->setVMS(vms);
    proc->setFa(pm.getCurProc());

    char* abs_cwd = new  char[200];
    kout<<Blue<<"abs_cwd "<<wk_dir<<' '<< pm.getCurProc()->getCWD()<<endl;
    unified_path((char *)wk_dir, pm.getCurProc()->getCWD(),abs_cwd);
    proc->setProcCWD(abs_cwd);
    kout<<Blue<<"abs_cwd "<<abs_cwd<<endl;
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
    proc_data->argv = argv;
    proc_data->argc = argc;
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