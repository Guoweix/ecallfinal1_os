#include "Library/KoutSingle.hpp"
#include "Memory/pmm.hpp"
#include "Memory/vmm.hpp"
#include "Process/Process.hpp"
#include "Trap/Interrupt.hpp"
#include "Types.hpp"
#include <File/FileObject.hpp>
#include <File/vfsm.hpp>
#include <Library/Pathtool.hpp>
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
    // kout[Info] << "CreateUserImgProcess" << (void*)start << (void*)end << endl;
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
    // proc->init(Flag);
    proc->setVMS(vms);

    // proc->setProcCWD("/");
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

        // pm.getCurProc()->getVMS()->Enter();
    }
    proc->setStack(nullptr, PAGESIZE * 4);
    // if (!(Flag & F_AutoDestroy)) {
    proc->setFa(pm.getCurProc());
    // }
    // vms->RemoveVMR(VirtualMemorySpace::Kernel()->FindVMR((PtrUint)kernelstart), false);
    //

    proc->start((void*)nullptr, nullptr, InnerUserProcessLoadAddr);
    kout[Info] << "CreateUserImgProcess" << (void*)start << " " << (void*)end << "with  PID " << proc->getID() << endl;

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
    Uint64 final_entry=proc_data->e_header.e_entry;

    Uint64 breakpoint = 0; // 用来定义用户数据段
    Uint64 ProgramHeaderAddress = 0;
    Uint64 ProgramInterpreterBase = 0;
    Uint16 phnum = proc_data->e_header.e_phnum; // 可执行文件中的需要解析的段数量
    Uint64 phoff = proc_data->e_header.e_phoff; // 段表在文件中的偏移量 需要通过段表访问到每个段
    Uint16 phentsize = proc_data->e_header.e_phentsize; // 段表中每个段表项的大小
    // kout[Info] << phnum << ' ' << phoff << ' ' << phentsize << endl;
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
                // kout[Info] << "p_align: " << (void*)(pgm_hdr.p_align) << endl;
                // kout[Info] << "p_filesz: " << (void*)(pgm_hdr.p_filesz) << endl;
                // kout[Info] << "p_flags: " << (void*)(pgm_hdr.p_flags) << endl;
                // kout[Info] << "p_memsz: " << (void*)(pgm_hdr.p_memsz) << endl;
                // kout[Info] << "p_offset: " << (void*)(pgm_hdr.p_offset) << endl;
                // kout[Info] << "p_paddr: " << (void*)(pgm_hdr.p_paddr) << endl;
                // kout[Info] << "p_type: " << (void*)(pgm_hdr.p_type) << endl;
                // kout[Info] << "p_vaddr: " << (void*)(pgm_hdr.p_vaddr) << endl;

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
                // kout << "Add VMR from " << (void*)vmr_begin << " to " << (void*)vmr_end << " " << (void*)vmr_flags << endl;

                // VirtualMemoryRegion* vmr_add = (VirtualMemoryRegion*)kmalloc(sizeof(VirtualMemoryRegion));
                // vmr_add->Init(vmr_begin, vmr_end, vmr_flags);
                VirtualMemoryRegion* vmr_add = new VirtualMemoryRegion(vmr_begin, vmr_end, vmr_flags);
                vms->InsertVMR(vmr_add);
                vms->Enter();

                MemsetT<char>((char*)vmr_begin, 0x00, vmr_memsize);
                pm.getCurProc()->getVMS()->Enter();
                // vms->Leave();

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
                kout << Red << "size " << (void*)pgm_hdr.p_filesz << endl;
                rd_size = fom.read_fo(fo, (void*)vmr_begin, pgm_hdr.p_filesz);
                // kout[Debug]<<DataWithSizeUnited((void *)vmr_begin,0x1000,32);

                pm.getCurProc()->getVMS()->Enter();
                // vms->Leave();
                if (rd_size != pgm_hdr.p_filesz) {
                    kout[Fault] << "Read ELF program header in file Fail!" << endl;
                    return -1;
                }
                // kout << Hex((uint64)(vmr_begin)) << endl;
                // kout << Memory((void*)0x1000, (void*)0x2000, 100);
            }
            break;
        case P_type::PT_INTERP: // Need improve...
        {
            Uint64 err;
            fom.seek_fo(fo, pgm_hdr.p_offset, file_ptr::Seek_beg);
            char* interpPath = new char[pgm_hdr.p_filesz];

            err = fom.read_fo(fo, interpPath, pgm_hdr.p_filesz);
            // kout[DeBug]<<"read PT_INTERP "<<offset<<" fileSize "<<pgm_hdr.p_filesz<<" PTAH  "<<interpPath<<endl;
            file_object* fn = nullptr;
            if (err == pgm_hdr.p_filesz) {
                file_object* file = nullptr;
                char* path = new char[200];
                unified_path(interpPath, "/", path);
                FileNode* node = vfsm.open(path, "/");
                delete[] path;
                if (node != nullptr) {
                    fn = new file_object;
                    fom.set_fo_file(fn, node);
                }
                if (fn != nullptr) {
                    Elf_Ehdr header { 0 };

                    err = fom.read_fo(fn, &header, sizeof(header));

                    if (err != sizeof(header))
                        kout[Fault] << "Failed to read interpreter elf header! Error code " << err << endl;
                    Uint64 needSize = 0;
                    for (int i = 0; i < header.e_phnum; ++i) {
                        Elf_Phdr ph { 0 };
                        fom.seek_fo(fn, header.e_phoff + i * header.e_phentsize, file_ptr::Seek_beg);

                        Sint64 err = fom.read_fo(fn, &ph, sizeof(ph));
                        // kout[DeBug] << "TYPE __________________" << ph.p_type << "offset " << (void*)ph.p_offset << "vaddr " << (void*)ph.p_vaddr << "paddr " << (void*)ph.p_paddr << endl;

                        if (err != sizeof(ph))
                            kout[Fault] << "Failed to read interpreter elf program header " << file << " ,error code " << -err << endl;
                        if (ph.p_type == P_type::PT_LOAD)
                            needSize += ph.p_memsz;
                    }
                    PtrSint s = ProgramInterpreterBase = vms->GetUsableVMR(0x60000000, 0x70000000, needSize);
                    {
                        final_entry= s + header.e_entry;
                    }
                    for (int i = 0; i < header.e_phnum; ++i) {
                        Elf_Phdr ph { 0 };
                        // file->Seek(header.phoff + i * header.phentsize, FileHandle::Seek_Beg);
                        fom.seek_fo(fn, header.e_phoff + i * header.e_phentsize, file_ptr::Seek_beg);
                        Sint64 err = fom.read_fo(fn, &ph, sizeof(ph));

                        if (err != sizeof(ph))
                            kout[Fault] << "Failed to read interpreter elf program header " << file << " ,error code " << -err << endl;
                        switch (ph.p_type) {
                        case PT_LOAD: {
                            Uint64 flags = 0;
                            if (ph.p_flags & P_flags::PF_R)
                                flags |= VirtualMemoryRegion::VM_Read;
                            //		if (ph.flags&ELF_ProgramHeader64::PF_W)
                            flags |= VirtualMemoryRegion::VM_Write;
                            if (ph.p_flags & P_flags::PF_X)
                                flags |= VirtualMemoryRegion::VM_Exec;

                            // kout[DeBug] << "Add VMR of INTERP " << (void*)(s + ph.p_vaddr) << " " << (void*)(s + ph.p_vaddr + ph.p_memsz) << " " << (void*)flags << endl;
                            auto vmr = KmallocT<VirtualMemoryRegion>();
                            vmr->Init(s + ph.p_vaddr, s + ph.p_vaddr + ph.p_memsz, flags);
                            vms->InsertVMR(vmr);

                            fom.seek_fo(fn, ph.p_offset, file_ptr::Seek_beg);
                            vms->Enter();
                            err = fom.read_fo(fn, (void*)(s + ph.p_vaddr), ph.p_filesz);
                            // kout[DeBug] << DataWithSizeUnited((void*)(s + ph.p_vaddr), 0x1000, 64);

                            pm.getCurProc()->getVMS()->Enter();

                            if (err != ph.p_filesz)
                                kout[Fault] << "Failed to read elf segment " << file << " ,error code " << -err << endl;
                        }

                        break;
                        }
                    }
                } else
                    kout[Fault] << "Failed to read elf INTERP path " << interpPath << endl;
                delete file;
                vfsm.close(node);
            } else
                kout[Fault] << "Failed to read elf INTERP path! Error code " << -err << endl;
            delete[] interpPath;
            break;
        }
        case P_type::PT_PHDR:
            ProgramHeaderAddress = pgm_hdr.p_vaddr;
            break;
        case P_type::PT_LOPROC:
        case P_type::PT_HIPROC:
        case P_type::PT_GNU_RELRO:
        case P_type::PT_GNU_STACK:
        case P_type::PT_TLS:
        case P_type::DT_AARCH64_PAC_PLT:
        case P_type::PT_DYNAMIC:
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
    // 
    vms->Enter();
    Uint64 vmr_user_stack_beign = InnerUserProcessStackAddr;
    Uint64 vmr_user_stack_size = InnerUserProcessStackSize;
    Uint64 vmr_user_stack_end = vmr_user_stack_beign + vmr_user_stack_size;
    VirtualMemoryRegion* vmr_user_stack = new VirtualMemoryRegion(vmr_user_stack_beign, vmr_user_stack_end, VirtualMemoryRegion::VM_USERSTACK);
    vms->InsertVMR(vmr_user_stack);

    MemsetT<char>((char*)vmr_user_stack_beign, 0, vmr_user_stack_size);
    // kout << "++++++++++hmr++++++++++++=" << endl;
    // kout<<Yellow<<DataWithSizeUnited((void *)0x1000,0x1141,16);
    // 用户堆段信息 也即数据段
    // HeapMemoryRegion* hmr = new HeapMemoryRegion(breakpoint);
    HeapMemoryRegion* hmr = (HeapMemoryRegion *)kmalloc(sizeof(HeapMemoryRegion));
    hmr->Init(breakpoint);
    vms->InsertVMR(hmr);

    // kout[DeBug] << (void*)hmr->GetStart()<<"flag "<<;
    // kout[DeBug] << " flag "<<hmr<<endl;

    MemsetT<char>((char*)hmr->GetStart(), 0, hmr->GetLength());
    // kout<<DataWithSize((void *)0x800020,1000);
    // vms->Leave();
    pm.getCurProc()->getVMS()->Enter();
    // 在这里将进程的heap成员更新
    // 也是在进程管理部分基本不会操作heap段的原因
    // pHMSm.set_proc_heap(proc, hmr);
    proc->setHeap(hmr);

    // kout << "++++++++++argv++++++++++++=" << endl;
    PtrSint p = vms->GetUsableVMR(0x60000000, 0x70000000, PAGESIZE);
    // kout[Info]<<"start_process_formELF:: p " << (void*)p << endl;

    TrapFrame* tf = (TrapFrame*)((char*)proc->stack + proc->stacksize) - 1;
    tf->reg.sp = InnerUserProcessStackAddr + InnerUserProcessStackSize - 512;
    Uint8* sp = (decltype(sp))tf->reg.sp;
    VirtualMemoryRegion* vmr_str = (VirtualMemoryRegion*)kmalloc(sizeof(VirtualMemoryRegion));
    vmr_str->Init(p, p + PAGESIZE, VirtualMemoryRegion::VM_RW);
    vms->InsertVMR(vmr_str);

    // vms->show(Debug);
    vms->Enter();
    // kout << sp << endl;
    char* s = (char*)p;

    // kout << ()p << endl;
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
        // kout[Info]<<"start_process_formELF :: *s"<<(void *)s<<" "<<s<<endl;
        *s++ = 0;
        return s_bak;
    };

    auto AddAUX = [&PushInfo64](ELF_AT at, Uint64 value) {
        PushInfo64((Uint64)at);
        PushInfo64(value);
    };

    // for (int i=0; i<proc_data->argc; i++) {
    // kout[Info]<<"argv["<<i<<"]"<<proc_data->argv[i]<<endl;
    // }

    PushInfo32(proc_data->argc);
    if (proc_data->argc)
        for (int i = 0; i < proc_data->argc; ++i) {
            PushInfo64((Uint64)PushString(proc_data->argv[i]));
            // kout[Info]<<"x"<<endl;
        }
    PushInfo64(0); // End of argv
    // kout[Info]<<"A"<<endl;
    // PushInfo64((Uint64)PushString("LD_LIBRARY_PATH=/"));
	PushInfo64((Uint64)PushString("LD_LIBRARY_PATH=/lib"));
    PushInfo64((Uint64)PushString("PATH=/"));
    PushInfo64((Uint64)PushString("SHELL=/busybox"));
    // kout[Info]<<"B"<<endl;
    PushInfo64(0); // End of envs
    // kout[Info]<<"C"<<endl;
    // kout << "++++++++++++++++++++++=" << endl;
    // AUX的添加，暂时先不处理

    if (ProgramHeaderAddress != 0) {
        AddAUX(ELF_AT::PHDR, ProgramHeaderAddress);
        AddAUX(ELF_AT::PHENT, proc_data->e_header.e_phentsize);
        AddAUX(ELF_AT::PHNUM, proc_data->e_header.e_phnum);

        AddAUX(ELF_AT::UID, 10);
        AddAUX(ELF_AT::EUID, 10);
        AddAUX(ELF_AT::GID, 10);
        AddAUX(ELF_AT::EGID, 10);
    }
    AddAUX(ELF_AT::PAGESZ, PAGESIZE);
    if (ProgramInterpreterBase != 0)
        AddAUX(ELF_AT::BASE, ProgramInterpreterBase);
    AddAUX(ELF_AT::ENTRY, proc_data->e_header.e_entry);
    PushInfo64(0); // End of auxv
    // kout << "++++++++++++start++++++++++=" << endl;

    // kout[Info]<<DataWithSizeUnited((void *)0x1207bc,0x1000,32);
    // vms->Leave();
    pm.getCurProc()->getVMS()->Enter();
    vms->DisableAccessUser();

    // kout[Debug]<<"form ELF VMS"<<proc->getVMS()<<endl;
    proc->start((void*)nullptr, nullptr, final_entry, proc_data->argc, proc_data->argv);
    proc->setName(fo->file->name);
    // pm.show();

    // 正确完整地执行了这个流程
    // 接触阻塞并且返回0
    // proc_data->sem.signal();
    return 0;
}

Process* CreateProcessFromELF(file_object* fo, const char* wk_dir, int argc, char** argv, ProcFlag proc_flags)
{
    bool t;
    IntrSave(t);

    ASSERTEX(fo, "CreateProcessFromELF fo is nullptr");
    procdata_fromELF* proc_data = new procdata_fromELF;
    proc_data->fo = fo;
    // 信号量初始化

    Sint64 rd_size = 0;
    // kout << "read_fo start" << endl;
    rd_size = fom.read_fo(fo, &proc_data->e_header, sizeof(proc_data->e_header));

    // kout<<DataWithSize((void *)&proc_data->e_header,sizeof(proc_data->e_header))<<endl;

    // kout << "read_fo finish" << endl;

    if (rd_size != sizeof(proc_data->e_header) || !proc_data->e_header.is_ELF()) {
        // kout[red] << "Create Process from ELF Error!" << endl;
        kout[Error] << "Read File is NOT ELF!" << endl;
        kfree(proc_data);
        IntrRestore(t);
        return nullptr;
    }

    VirtualMemorySpace* vms = (VirtualMemorySpace*)kmalloc(sizeof(VirtualMemorySpace));
    vms->Init();

    //
    Process* proc = nullptr;
    // VirtualMemorySpace* vms_t = nullptr;
    // if (proc_ == nullptr) {

        proc = pm.allocProc();

        proc->init((ProcFlag)((Uint64)F_User | (Uint64)proc_flags));
        proc->setStack(nullptr, PAGESIZE * 4);
        proc->setVMS(vms);
        proc->setFa(pm.getCurProc());

        char* abs_cwd = new char[200];
        unified_path((const char*)wk_dir, pm.getCurProc()->getCWD(), abs_cwd);
        proc->setProcCWD(abs_cwd);
        delete[] abs_cwd;
    // } 
    // else {
        // vms_t = proc->VMS;
        // vms_t->show();
        // proc->setVMS(vms);
        // memset(proc->stack, 0, proc->stacksize);
    // }

    // 填充userdata
    // 然后跳转执行指定的启动函数
    proc_data->vms = vms;
    proc_data->proc = proc;
    proc_data->argv = argv;
    proc_data->argc = argc;
    // kout[Info]<<"argc "<<argc<<endl;

    Uint64 user_start_addr = proc_data->e_header.e_entry;
    start_process_formELF(proc_data);
    // pm.start_user_proc(proc, start_process_formELF, proc_data, user_start_addr);

    // if (proc_) {
        // vms_t->Destroy();
    // }
    // 这里跳转到启动函数之后进程管理就会有其他进程参与轮转调度了
    // 为了确保新的进程能够顺利执行完启动函数这里再释放相关的资源
    // 这里让当前进程阻塞在这里
    // proc_data->sem.wait();
    // proc_data->sem.destroy();
    // kfree(proc_data);
    IntrRestore(t);

    return proc;
}