## ELF解析
ELF解析主要是从ELF头中解析出各段的作用，重点主要在于从磁盘到到虚拟内存的VMR设置，保证VMR权限设置合理。
- 解析头
```cpp
struct Elf_Phdr
{
    Uint32 p_type;                          // 本程序头描述的段的类型
    Uint32 p_flags;                         // 本段内容的属性
    Uint64 p_offset;                        // 本段内容在文件中的位置 段内容的开始位置相对于文件头的偏移量
    Uint64 p_vaddr;                         // 本段内容的开始位置在进程空间中的虚拟地址
    Uint64 p_paddr;                         // 本段内容的开始位置在进程空间中的物理地址
    Uint64 p_filesz;                        // 本段内容在文件中的大小 以字节为单位
    Uint64 p_memsz;                         // 本段内容在内容镜像中的大小
    Uint64 p_align;                         // 对齐方式 可装载段来讲应该要向内存页面对齐
}__attribute__((packed));


```

- 解析段 
```cpp
// 段类型的枚举表示
enum P_type
{
    PT_NULL = 0,                            // 本程序头是未使用的
    PT_LOAD = 1,                            // 本程序头指向一个可装载的段
    PT_DYNAMIC = 2,                         // 本段指明了动态链接的信息
    PT_INTERP = 3,                          // 本段指向一个字符串 是一个ELF解析器的路径
    PT_NOTE = 4,                            // 本段指向一个字符串 包含一些附加的信息
    PT_SHLIB = 5,                           // 本段类型是保留的 未定义语法
    PT_PHDR = 6,                            // 自身所在的程序头表在文件或内存中的位置和大小
    PT_LOPROC = 0x70000000,                 // 为特定处理器保留使用的区间
    PT_HIPROC = 0x7fffffff,
};

```
- 设置VMR
在VMS中设置了方便的接口，直接根据内存地址设置即可
```cpp
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
 
```
- 写入VMR
由于riscv权限设置，专门设计了用内核态访问用户空间的函数
```cpp
    vms->EnableAccessUser();
    vms->DisableAccessUser();
```
<p align="right">By:郭伟鑫</p>