## 物理内存
#### 引言
       本小队先对物理内存进行开发，保证物理内存malloc和free正确的情况下，再更进一步进行虚拟内存开发。
#### 设计思路
       内存空间是一块连续的物理内存，我们采用链表的方法进行管理。设置PAGE用来管理每一个页的空间，再用PMM来进一步管理众多连续的PAGE。
       计算管理这些页所需要多少个PAGE大小，将这些结构体按数组的内存分配布局放入最前面的几页，并将这几页的PAGE标记为非空闲，同时在PMM中记录第一个空闲页（双向链表的head指针）就是完成了PMM的初始化工作。
         对于alloc_pages函数，实现了物理内存分配逻辑，采用链表管理思路：先从头结点开始搜索符合空间大小的内存空间，若没有则采用insert_page进行合并直到找到第一个能用于分配指定大小的页空间。
       对于free_pages函数，实现了页的回收逻辑。首先先将总的空闲页增加并将该页标记为空闲，最后根据结构体PAGE的地址的大小插入会双向链表（管理PAGE*的head），同时查看是否可以合并并合并。
       对于get_page_from_addr函数，用于从物理地址获取对应页的PAGE指针，从而便于free回收逻辑。
        对于malloc函数，实现了PMM的内存分配，由于本小队打算完善小内存的管理，所有添加了每页的标记位的数（具体将于slab中进行讲述）。
       对于free函数，实现了物理页的回收逻辑：首先找到回收地址对应的PAGE指针，然后调用free_pages函数进行页的回收。
#### PMM
       在PMM处，我们设计了管理PAGE结构体的表头，记录最后一个结构体后一个的物理地址，便于判断页是否超内存空间大小。以及记录可用空闲页数的PageCount。最后将PMM的变量pmm作为全局变量，便于其他部分的使用。
```cpp
class PMM {
private:
    PAGE head; // 表头
    PAGE* PagesEndAddr; // 结束地址
    Uint64 PageCount; // 可用空闲页数
}
```
#### PAGE
       在PAGE处，设计了标记位flags（ 0表示空闲，1表示不是slab，2表示slab64B，3表示slab512B，4表示slab4KB），以及当前页结构体后面有多少个空闲的连续的页，对于ref是为了后续虚拟内存设计的接口，便于找到虚拟内存多级页表是否有页表中的项指向它。最后是pre和nxt双向链表指针，便于页的分配和回收。
       在Index函数，实现了找到该PAGE结构体对应于污泥内存中第几个页。
       KAddr函数，实现了具体指向的页的地址而不是PAGE的地址。
       PAddr函数，实现了具体的物理地址，而不是虚拟地址（多个偏移）
```cpp
struct PAGE {
    Uint64 flags, // 0表示空闲，1表示不是slab，2表示slab64B，3表示slab512B，4表示slab4KB
        num, // 当前表后面有连续的几页
        ref; // 有多少个其他的页表中的项指向它
    PAGE *pre,
        *nxt;
}
```
## slab分配器
#### 设计
      为了便于小内存的分配，本小队写了一个简易的slab内存分配器。和物理内存采用类似的结构进行管理和分配。
#### slabB
       与PAGE类似，用来管理每个小的内存空间。
```cpp
struct slabB
{
   Uint64 flags,//0表示空闲，1表示不
          SlabStartAddress,
          Slab_Size,
          num;//当前表后面有连续的几页
    slabB* pre,
           * nxt;
    
    inline Uint64 Index() const
    {return ((Uint64)this-SlabStartAddress)/sizeof(slabB);}//第几页
    
    inline void* KAddr() const
    {return (void*)(SlabStartAddress+Index()*Slab_Size);}//具体页的地址
    
    inline void* PAddr() const
    {return (void*)(SlabStartAddress+Index()*Slab_Size-0xffffffff00000000);}//物理地址
};
```
#### SlabB
       SlabB代表管理每个slabB的结构体，具体实现采用PMM的方式进行实现。
```cpp
// 定义Slab结构
class SlabB {
private:
    slabB head;//表头
    slabB* PagesEndAddr;//结束地址
    Uint64 SlabStartAddress,
           Slab_Size,
           slabBCount;//可用空闲块数

public:
    void Init(Uint32 size,Uint32 PageCounts,Uint32 Usage);
    slabB* allocslabB(Uint64 num);
    bool insert_page(slabB* src); 
    bool freeslabB(slabB* t);
    slabB* get_from_addr(void* addr);
    inline Uint64 getSlabBCount(){return  slabBCount;} 
    void free(void* freeaddress);
};
```
#### SlabAllocator
      该类主要用于最终slab的分配，内部设置三个管理对应大小的slab链表。Init在一开始会给每个大小分配指定大小的页专门用于分配大小。
```cpp
class SlabAllocator {
private:
    SlabB sB1,//链表
          sB2,
          sB3;
}
```
        具体分配逻辑采用最简单的谁符合就分配对应slab大学的块
```cpp
// 这边具体逻辑还需要算法修改
void* SlabAllocator::allocate(Uint64 bytesize)
{
    if (bytesize <= SLAB_SIZE_B1) {
        if (sB1.getSlabBCount() <= 0)
            return nullptr;
        else
            return sB1.allocslabB(1)->KAddr();
    } else if (bytesize <= SLAB_SIZE_B2) {
        if (sB2.getSlabBCount() <= 0)
            return nullptr;
        else
            return sB2.allocslabB(1)->KAddr();
    } else if (bytesize <= 4096) {
        int num = bytesize / SLAB_SIZE_B3;
        if (bytesize % SLAB_SIZE_B2 != 0) {
            num++;
        }
        if (sB3.getSlabBCount() <= 0)
            return nullptr;
        else
            return sB3.allocslabB(num)->KAddr();
    }
    return nullptr;
}
```
            在释放时，找到对应的slab链表再进行对应的free即可。
#### 遇到问题
       1.slab管理结构体本身占用太多内存，还需要进一步进行优化。2.同时对于一页+一小块的内存仍无法拆分进行分配还是会造成相应的内存浪费。
# 虚拟内存
       虚拟内存是现代主流操作系统支持的管理方案，它需要硬件提供MMU进行分页机制。虚拟内存部分由主要由三个类/结构体进行控制，分别为虚拟内存空间（Virtual Memory Space，简称VMS），虚拟内存区域（Virtual Memory Region，简称VMR），页表（PageTable）,堆内存区域管理（HeapMemoryRegion）。
#### PageTable
       页表是我们根据SV39页表的规范构造的结构体，在目前的虚拟内存机制下它是由512个页表项组成的，大小为一个4k页的结构体，特别注意，创建该对象时不能用一般的Kmalloc或new，而需要用PMM中提供的分配物理页方法，以保证4KB对齐。
#### PageEntry
       页表项是页表的成员，可以作为次级页表索引，也可以作为物理页索引，此外其上还标记了一些标志位，用于权限控制等。为了提高效率，读写标志位的部分均使用模板实现，最大限度地提高效率，同时保留易用性。页表项的XWR三个位用来标识当前页表项的属性，当全为0时表示次级页表，索引时需要拿到次级页表的物理页号，转换成内核虚拟页号，一级一级向下找。
#### VirtualMemorySpace
        VMS用于管理概念上的一个逻辑地址空间，拥有一个根页表（PDT）和若干VMR串成的链表。
成员变量如下：
```cpp
class VirtualMemorySpace {
protected:
    static VirtualMemorySpace *CurrentVMS, // 目前层的VMS
        *BootVMS, // 启动时使用的vms
        *KernelVMS; // 内核层vms

    POS::LinkTableT<VirtualMemoryRegion> vmrHead; // 管理vmr的链表
    Uint32 VmrCount; // vmr的数量
    VirtualMemoryRegion* VmrCache; // 最近使用的vmr，便于命中
    PageTable* PDT;//根页表指针
    Uint32 SharedCount;//共享计数，当共享计数达到0时可以自动销毁自身空间
}
```
类方法如下：
```cpp
class VirtualMemorySpace {
protected:
    ErrorType ClearVMR(){};//情况vmr链表
    ErrorType CreatePDT() {};//创造页表项
    static ErrorType InitForBoot(){};//Bootvms初始化
    static ErrorType InitForKernel(){};//内核层vms初始化
public:
    inline static VirtualMemorySpace* Current() {};//返回当前vms
    inline static VirtualMemorySpace* Boot(){};//返回Bootvms
    inline static VirtualMemorySpace* Kernel(){};//返回内核层vms
    inline static void EnableAccessUser(){};//默认情况下，内核态是不可以访问用户态地址空间的，
当用户态传递了某个指针必须由内核访问时，可以 暂时开启访问允许，不需要后立刻关闭，以最大程度避免误操作
    inline static void DisableAccessUser(){};//与上一个类似，为关闭允许访问用户空间使用。
    ErrorType Init(){};//vms整体变量初始化
    static ErrorType InitStatic(){};//内核和Bootvms的初始化，同时当前态进入内核态
    void InsertVMR(VirtualMemoryRegion* vmr){};//插入一个构造好的VMR到当前VMS管理的链表中，
表示启用地址空间中的某一区域
    VirtualMemoryRegion* FindVMR(PtrUint p){};//查找某个地址所属的VMR，
如果不存在则返回nullptr
    void RemoveVMR(VirtualMemoryRegion* vmr, bool DeleteVmr){};//从地址空间中移除某个VMR
    void Enter(){};//VMS的核心功能之一，即进入到当前虚拟地址空间，
具体操作时是对页表进行更换，并刷新TLB缓存
    inline void Leave(){};//概念上与Enter相反的功能，由于进程必须呆在地址空间中，
因此Leave实际上是Enter到了KernelVMS中
    inline void show(){};//展示vmr里的所有结点信息
    ErrorType SolvePageFault(TrapFrame* tf){};//解决缺页异常
    ErrorType Create(){};//创建一个指定类型的虚拟内存空间
    ErrorType Destroy(){};
    ErrorType showVMRCount(){};//打印VMRcount
    ErrorType CreateFrom(VirtualMemorySpace* src) {};//从给定的虚拟内存空间创建一个新的VMS，即拷贝VMS
};
```
      在处理缺页异常时，增加了大页的逻辑，但只是简单的根据内存区域的标志来决定是否采用大页，后续还需要进一步完善。
```cpp
// 检查地址对齐
        if ((faultAddress & (2 * 1024 * 1024 - 1)) != 0) {
            return false; // 地址没有适当对齐，不能使用大页
        }

        // 根据内存区域的标志来决定
        if (flags & VM_Heap) {
            // 对于堆区域，如果预期会频繁使用大量内存，可能倾向于使用大页
            return true;
        } else if (flags & VM_Stack) {
            // 栈通常不适合使用大页，因为栈的增长通常是小块的
            return false;
        } else if (flags & VM_Exec) {
            // 对于执行代码区域，使用大页可以提高指令缓存的效率
            return true;
        }
        // 默认情况，不使用大页
        return false;
```
#### VirtualMemoryRegion
       虚拟内存区域VMR表示的是VMS中的一个合法区间，通过VMR我们可以对进程的不同段进行划分，区分内存映射文件等。
成员变量如下：
```cpp
class VirtualMemoryRegion : public POS::LinkTableT<VirtualMemoryRegion> {
    friend class VirtualMemorySpace;
public:
    enum : Uint32 // 标志位
    {
        VM_Read = 1 << 0,
        VM_Write = 1 << 1,
        VM_Exec = 1 << 2,
        VM_Stack = 1 << 3,
        VM_Heap = 1 << 4,
        VM_Kernel = 1 << 5,
        VM_Shared = 1 << 6,
        VM_Device = 1 << 7,
        VM_File = 1 << 8,
        VM_Dynamic = 1 << 9,

        VM_RW = VM_Read | VM_Write,
        VM_RWX = VM_RW | VM_Exec,
        VM_KERNEL = VM_Kernel | VM_RWX,
        VM_USERSTACK = VM_RW | VM_Stack | VM_Dynamic,
        VM_USERHEAP = VM_RW | VM_Heap | VM_Dynamic,
        VM_MMIO = VM_RW | VM_Kernel | VM_Device,
    };

protected:
    PtrUint StartAddress, // 起始地址
        EndAddress; // 终结地址
    VirtualMemorySpace* VMS; // 管理的存储信息
    Uint32 Flags; // 这块vms的权限
}
```
类方法如下：
```cpp
class VirtualMemoryRegion : public POS::LinkTableT<VirtualMemoryRegion> {
public:
    inline PageTableEntryType ToPageEntryFlags(){}；
    inline bool Intersect(PtrUint l, PtrUint r) const // r在中间
    inline bool In(PtrUint l, PtrUint r) const // 包含l,r
    inline bool In(PtrUint p)
    inline PtrUint GetStart(){};//获取该管理空间的起始地
    inline PtrUint GetEnd(){};//获取终地址
    inline PtrUint GetLength(){};//获取内存空间大小
    bool ShouldUseLargePage(Uint32 flags, PtrUint faultAddress){};//是否启用大页的逻辑
    inline Uint32 GetFlags(){};//获取标志位信息
    ErrorType Init(PtrUint start, PtrUint end, Uint32 flags){};//vmr初始化
    ErrorType CopyMemory(PageTable& pt, const PageTable& src, int level, Uint64 l) {};
    //为了实现Clone的功能，必须要支持对VMS进行拷贝，而VMS的拷贝实际上就是对所属的VMR一个一个进行拷贝，
    //因此我们设计将VMR作为拷贝的单元。
};
```
#### HeapMemoryRegion
       原先设计的VMR并不支持动态地调整大小，为了提供动态调整大小的功能，从VMR派生出HeapMemoryRegion（HMR），用来支持用户程序的brk调用，即调整堆段大小。当进行调整时，函数会判断这次调用是否能成功，保证不与其他VMR发生重叠。HMR一般在载入用户进程时创建，根据ELF文件段表的描述，我们在最后一个段出现的位置后面用GetUsableVMR来获取一个可用区域作为堆段。
```cpp
class HeapMemoryRegion : public VirtualMemoryRegion {
protected:
    Uint64 BreakPointLength = 0;
public:
    inline PtrUint BreakPoint(){};
    inline ErrorType Resize(Sint64 delta){};
    inline ErrorType Init(PtrUint start, Uint64 len = PAGESIZE, Uint64 flags = VM_USERHEAP){};
};
```
