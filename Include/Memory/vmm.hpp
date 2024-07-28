#ifndef __VMM_HPP__
#define __VMM_HPP__

#include "../Arch/Riscv.hpp"
#include "../Error.hpp"
#include "../Library/DataStructure/LinkTable.hpp"
#include "../Library/KoutSingle.hpp"
#include "../Library/Kstring.hpp"
#include "../Trap/Trap.hpp"
#include "../Types.hpp"
#include "pmm.hpp"

extern "C" {
extern class PageTable boot_page_table_sv39[];
};

constexpr Uint32 PageSizeBit = 12;
constexpr Uint64 PageSizeN[3] { PAGESIZE, PAGESIZE * 512, PAGESIZE * 512 * 512 };
class PageTable { // 页表项
public:
    struct Entry {
        PageTableEntryType x; // 页表结构：32or64

        enum : unsigned { IndexBits = 6 };

        enum : unsigned {
            // 枚举，记录每一个整数
            V = 1 << IndexBits | 0,
            R = 1 << IndexBits | 1,
            W = 1 << IndexBits | 2,
            X = 1 << IndexBits | 3,
            U = 1 << IndexBits | 4,
            G = 1 << IndexBits | 5,
            A = 1 << IndexBits | 6,
            D = 1 << IndexBits | 7,

            XWR = 3 << IndexBits | 1,
            GU = 2 << IndexBits | 4,
            GUXWR = 5 << IndexBits | 1,

            RSW = 2 << IndexBits | 8,
            RSW0 = 1 << IndexBits | 8,
            RSW1 = 1 << IndexBits | 9,

            PPN = 44 << IndexBits | 10,
            PPN0 = 9 << IndexBits | 10,
            PPN1 = 9 << IndexBits | 19,
            PPN2 = 26 << IndexBits | 28,
            PPN_RESERVED = 10 << IndexBits | 54,

            FLAGS = 8 << IndexBits | 0,
            All = 64 << IndexBits | 0
        };

        enum {
            XWR_PageTable = 0,
            XWR_ReadOnly = 1,
            XWR_ReadWrite = 3,
            XWR_ExecOnly = 4,
            XWR_ReadExec = 5,
            XWR_ReadWriteExec = 7
        };

        template <unsigned B>
        inline static constexpr PageTableEntryType Mask()
        { // 掩码
            constexpr PageTableEntryType i = B & ((1 << IndexBits) - 1),
                                         m = ((PageTableEntryType)1 << (B >> IndexBits)) - 1;
            return m << i;
        }

        inline PageTableEntryType& operator()() { return x; }
        inline PageTableEntryType& operator*() { return x; }

        template <unsigned B>
        inline PageTableEntryType Get() const
        { // 解码
            constexpr PageTableEntryType i = B & ((1 << IndexBits) - 1),
                                         m = ((PageTableEntryType)1 << (B >> IndexBits)) - 1;
            return (x >> i) & m;
        }

        template <unsigned B>
        inline void Set(PageTableEntryType y)
        {
            constexpr PageTableEntryType i = B & ((1 << IndexBits) - 1),
                                         m = ~(((PageTableEntryType)1 << (B >> IndexBits)) - 1 << i);
            x = (x & m) | y << i;
        }

        template <unsigned I, unsigned L>
        inline PageTableEntryType Get() const
        {
            return Get<L << IndexBits | I>();
        }

        template <unsigned I, unsigned L>
        inline void Set(PageTableEntryType y)
        {
            return Set<L << IndexBits | I>();
        }

        inline bool Valid() const
        {
            return Get<V>();
        }

        inline void* GetPPN_KAddr() const
        {
            return (void*)((Get<PPN>() << 12) + PVOffset);
        }

        inline bool IsPageTable() const
        {
            return Get<XWR>() == XWR_PageTable;
        }

        inline PageTable* GetPageTable() const
        {
            return (PageTable*)GetPPN_KAddr();
        } // 获取ppn虚拟地址

        inline void SetPageTable(PageTable* pt)
        {
            Set<V>(1);
            Set<XWR>(XWR_PageTable);
            Set<PPN>((PageTableEntryType)pt->PAddr() >> 12);
        }

        inline PAGE* GetPage() const
        {
            return pmm.get_page_from_addr(GetPPN_KAddr());
        }

        inline void SetPage(PAGE* pg, PageTableEntryType flags)
        {
            ++pg->ref;
            Set<FLAGS>(flags);
            Set<PPN>((PageTableEntryType)pg->PAddr() >> 12);
        }

        // 用于设置大页
        inline void SetLargePage(PAGE* pg, PageTableEntryType flags)
        {
            Set<V>(1); // 设置有效位
            Set<XWR>(XWR_ReadWrite); // 读写权限
            Set<PPN>((PageTableEntryType)pg->PAddr() >> 21); // 对于2MB大页，PPN右移21位
            Set<RSW>(RSW1); // 设置为大页
        }

        inline Entry(PageTableEntryType _x)
            : x(_x)
        {
        }
        inline Entry() { }
    };

    enum {
        PageTableEntryCountBit = 9,
        PageTableEntryCount = 1 << PageTableEntryCountBit
    };

protected:
    Entry entries[PageTableEntryCount]; // 几级页表

public:
    template <unsigned n>
    static inline unsigned VPN(PtrUint kaddr)
    {
        constexpr unsigned i = 12 + n * PageTableEntryCountBit,
                           m = (1 << PageTableEntryCountBit) - 1;
        return kaddr >> i & m;
    }

    static inline unsigned VPN(PtrUint kaddr, unsigned n)
    {
        unsigned i = 12 + n * PageTableEntryCountBit,
                 m = (1 << PageTableEntryCountBit) - 1;
        return kaddr >> i & m;
    }

    inline static PageTable* Boot()
    {
        return boot_page_table_sv39;
    }

    inline void* KAddr()
    {
        return this;
    }

    inline void* PAddr()
    {
        return (void*)((Uint64)this - PVOffset);
    }

    inline Uint64 PPN()
    {
        return (Uint64)PAddr() >> 12;
    }

    inline Entry& operator[](int i)
    {
        return entries[i];
    }

    inline const Entry& operator[](int i) const
    {
        return entries[i];
    }

    inline ErrorType InitAsPDT()
    {
        POS::MemsetT(entries, Entry(0), PageTableEntryCount - 4);
        POS::MemcpyT(&entries[PageTableEntryCount - 4], &(*Boot())[PageTableEntryCount - 4], 4);
        return ERR_None;
    }

    inline ErrorType Init()
    {
        POS::MemsetT(entries, Entry(0), PageTableEntryCount);
        return ERR_None;
    }

    inline ErrorType Destroy(const int level)
    {
        ASSERTEX(level >= 0, "PageTable::Destroy level " << level << " <0!");
        for (int i = 0; i < PageTableEntryCount; ++i)
            if (entries[i].Valid())
                if (entries[i].IsPageTable())
                    entries[i].GetPageTable()->Destroy(level - 1);
                else if (entries[i].Get<Entry::U>() == 0)
                    continue; // Kernel page won't be freed
                else if (level == 0) {
                    PAGE* page = entries[i].GetPage();
                    ASSERTEX(page, "PageTable::Destroy: page is nullptr!");
                    if (--page->ref == 0)
                        pmm.free_pages(page);
                } else
                    kout[Warning] << "PageTable::Destroy free huge page is not usable!" << endl;
        pmm.free_pages(pmm.get_page_from_addr(this));
        return ERR_None;
    }
};
using PageEntry = PageTable::Entry;

class VirtualMemorySpace;

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
        VM_Mmap=1<<10,
        VM_MmapFile=1<<11,

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

public:
    inline PageTableEntryType ToPageEntryFlags()
    { // 这一页的信息解码
        using PageEntry = PageTable::Entry;
        PageTableEntryType re = PageTable::Entry::Mask<PageTable::Entry::V>();
        if (Flags & VM_Read)
            re |= PageTable::Entry::Mask<PageTable::Entry::R>();
        if (Flags & VM_Write)
            re |= PageTable::Entry::Mask<PageTable::Entry::W>();
        if (Flags & VM_Exec)
            re |= PageTable::Entry::Mask<PageTable::Entry::X>();
        if (!(Flags & VM_Kernel))
            re |= PageTable::Entry::Mask<PageTable::Entry::U>();
        return re;
    }

    inline bool Intersect(PtrUint l, PtrUint r) const // r在中间
    {
        return r > StartAddress && EndAddress > l;
    }

    inline bool In(PtrUint l, PtrUint r) const // 包含l,r
    {
        return StartAddress <= l && r <= EndAddress;
    }

    inline bool In(PtrUint p)
    {
        return StartAddress <= p && p < EndAddress;
    }

    inline PtrUint GetStart()
    {
        return StartAddress;
    }

    inline PtrUint GetEnd()
    {
        return EndAddress;
    }

    inline PtrUint GetLength()
    {
        return EndAddress - StartAddress;
    }
    inline void SetEnd(PtrUint _EndAddress)
    {
        EndAddress =_EndAddress;
    }

    bool ShouldUseLargePage(Uint32 flags, PtrUint faultAddress)
    {
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
    }

    inline Uint32 GetFlags()
    {
        return Flags;
    }

    ErrorType Init(PtrUint start, PtrUint end, Uint32 flags)
    { // 初始化
        LinkTableT::Init(); // 对整块vmr初始化
        StartAddress = start >> 12 << 12; // 12bit对齐
        EndAddress = end + PAGESIZE - 1 >> 12 << 12; // 终页的最后一个不可用地址
        VMS = nullptr;
        Flags = flags;
        ASSERTEX(StartAddress < EndAddress, "VirtualMemoryRegion::Init: Start " << (void*)StartAddress << " >= End " << (void*)EndAddress);
        return ERR_None;
    }

    VirtualMemoryRegion(PtrUint start, PtrUint end, Uint32 flags)
    {
        ASSERTEX(Init(start, end, flags) == ERR_None, "Failed to init VMR!"); // c中的断言
    }

    ErrorType CopyMemory(PageTable& pt, const PageTable& src, int level, Uint64 l)
    {
        ASSERTEX(level >= 0, "VirtualMemoryRegion::CopyMemory of " << this << " from " << src << " level " << level << " <0!");
        if (Flags & VM_Kernel) {
            //		kout[Warning]<<"VirtualMemoryRegion::CopyMemory kernel region don't need copy?"<<endl;
            return ERR_None;
        }
        for (int i = 0; i < PageTable::PageTableEntryCount; ++i, l += PageSizeN[level])
            if (src[i].Valid() && Intersect(l, l + PageSizeN[level]))
                if (src[i].IsPageTable()) {
                    PageTable *srcNxt = src[i].GetPageTable(),
                              *ptNxt = nullptr;
                    if (!pt[i].Valid()) {
                        ptNxt = (PageTable*)pmm.alloc_pages(1)->KAddr();
                        ASSERTEX(ptNxt, "VirtualMemoryRegion::CopyMemory: Cannot allocate ptNxt in VMR " << this);
                        ASSERTEX(((PtrSint)ptNxt & (PAGESIZE - 1)) == 0, "ptNxt " << ptNxt << " in " << this << " is not aligned to 4k!");
                        ptNxt->Init();
                        pt[i].SetPageTable(ptNxt);
                    } else
                        ptNxt = pt[i].GetPageTable();
                    CopyMemory(*ptNxt, *srcNxt, level - 1, l);
                } else if (level == 0) {
                    PAGE* srcPage = src[i].GetPage();
                    if (Flags & VM_Shared | Flags & VM_Kernel)
                        pt[i].SetPage(srcPage, ToPageEntryFlags());
                    else {
                        PAGE* page = pmm.alloc_pages(1);
                        ASSERTEX(page, "VirtualMemoryRegion::CopyMemory: Cannot allocate page in VMR " << this);
                        ASSERTEX(((PtrSint)page->PAddr() & (PAGESIZE - 1)) == 0, "page->Paddr() " << page->PAddr() << " is not aligned to 4k!");
                        ASSERTEX(!pt[i].Valid(), "VirtualMemoryRegion::CopyMemory: pt[i] is valid!");
                        MemcpyT<char>((char*)page->KAddr(), (const char*)srcPage->KAddr(), PAGESIZE);
                        pt[i].SetPage(page, ToPageEntryFlags());
                    }
                } else
                    kout[Warning] << "VirtualMemoryRegion::CopyMemory copy huge page is not usable!" << endl;
        return ERR_None;
    }
};

class VirtualMemorySpace {
protected:
    static VirtualMemorySpace *CurrentVMS, // 目前层的VMS
        *BootVMS, // 用户层vms
        *KernelVMS; // 内核层vms

    POS::LinkTableT<VirtualMemoryRegion> vmrHead; // 管理vmr的链表
    Uint32 VmrCount; // vmr的数量
    VirtualMemoryRegion* VmrCache; // 最近使用的vmr，便于命中
    PageTable* PDT;
    Uint32 SharedCount;

    ErrorType ClearVMR()
    { // 清空vmr
        while (vmrHead.Nxt())
            RemoveVMR(vmrHead.Nxt(), true);
        return ERR_None;
    }

    ErrorType CreatePDT()
    {
        PDT = (PageTable*)pmm.alloc_pages(1)->KAddr(); // 分配初始页表给pdt
        ASSERTEX(((PtrUint)PDT & (PAGESIZE - 1)) == 0, "PDT " << PDT << " in VMS " << this << " is not aligned to 4k!");
        PDT->InitAsPDT();
        return ERR_None;
    }

    static ErrorType InitForBoot()
    {
        kout[VMMINFO] << "Initing Boot VirtualMemorySpace..." << endl;
        BootVMS = new VirtualMemorySpace();
        BootVMS->Init();
        {
            auto vmr = KmallocT<VirtualMemoryRegion>(); // 分配内存区域
            vmr->Init((PtrUint)kernelstart, PhysicalMemoryStart() + PhysicalMemorySize(), VirtualMemoryRegion::VM_KERNEL); // 程序的内核vmr
            BootVMS->InsertVMR(vmr);
        }

        BootVMS->PDT = PageTable::Boot(); // 页表项
        BootVMS->SharedCount = 1;
        kout[VMMINFO] << "Init BootVMS " << BootVMS << " OK" << endl;
        return ERR_None;
    }

    static ErrorType InitForKernel()
    {
        KernelVMS = BootVMS;
        kout[VMMINFO] << "Init KernelVMS " << KernelVMS << " OK" << endl;
        return ERR_None;
    }

public:
    inline static VirtualMemorySpace* Current()
    {
        return CurrentVMS;
    }

    inline static VirtualMemorySpace* Boot()
    {
        return BootVMS;
    }

    inline static VirtualMemorySpace* Kernel()
    {
        return KernelVMS;
    }

    inline static void EnableAccessUser()
    {
        CSR_SET(sstatus, 1 << 18);
    }

    inline static void DisableAccessUser()
    {
        CSR_CLEAR(sstatus, !(1 << 18));
    }

    ErrorType Init()
    {
        vmrHead.Init();
        VmrCount = 0;
        VmrCache = nullptr;
        PDT = nullptr;
        SharedCount = 0;
        return ERR_None;
    }

    static ErrorType InitStatic()
    { // 初始化最初，处于内核态
        InitForBoot();
        InitForKernel();
        CurrentVMS = KernelVMS;
        return ERR_None;
    }

    void InsertVMR(VirtualMemoryRegion* vmr)
    { // 代码冗余
        ASSERTEX(vmr, "VirtualMemorySpace::InsertVMR: vmr is nullptr!");
        ASSERTEX(vmr->Single(), "VirtualMemorySpace::InsertVMR: vmr is not single!");
        ASSERTEX(vmr->VMS == nullptr, "VirtualMemorySpace::InsertVMR: vmr->VMS is not nullptr!");
        vmr->VMS = this; // vmr这一块属于哪一大块管理

        if (vmrHead.Nxt() == nullptr)
            vmrHead.NxtInsert(vmr);
        else if (VmrCache != nullptr && VmrCache->Nxt() == nullptr && VmrCache->EndAddress <= vmr->StartAddress)
            VmrCache->NxtInsert(vmr);
        else {
            VirtualMemoryRegion* v = vmrHead.Nxt();
        VMS_INSERTVMR_WHILE:
            if (vmr->EndAddress <= v->StartAddress)
                v->PreInsert(vmr);
            else if (vmr->StartAddress >= v->EndAddress)
                if (v->Nxt() == nullptr)
                    v->NxtInsert(vmr);
                else {
                    v = v->Nxt();
                    if (v != nullptr)
                        goto VMS_INSERTVMR_WHILE;
                }
            else
                kout[Fault] << "VirtualMemoryRegion::InsertVMR: vmr " << vmr << " overlapped with " << v << endl;
        }
        VmrCache = vmr;
        ++VmrCount;

        kout[VMMINFO] << "Insert vmr  " << (void*)vmr << " Success!" << endl;
    }

    VirtualMemoryRegion* FindVMR(PtrUint p)
    {
        if (VmrCache != nullptr && VmrCache->In(p))
            return VmrCache;
        VirtualMemoryRegion* v = vmrHead.Nxt();
        while (v != nullptr)
            if (p < v->StartAddress)
                return nullptr;
            else if (p < v->EndAddress)
                return VmrCache = v;
            else
                v = v->Nxt();
        return nullptr;
    }

    void RemoveVMR(VirtualMemoryRegion* vmr, bool DeleteVmr)
    {
        ASSERTEX(vmr, "VirtualMemorySpace::RemoveVMR: vmr is nullptr!");
        if (VmrCache == vmr)
            VmrCache = nullptr;
        vmr->Remove();
        vmr->VMS = nullptr;
        --VmrCount;
        if (DeleteVmr)
            delete vmr;
    }

    void Enter()
    { // 进入指定状态的vms
        // kout<<Red<<"enter vms is "<<this<<endl;
        if (this == CurrentVMS)
            return;
        CurrentVMS = this;
        CSR_WRITE(satp, 8ull << 60 | PDT->PPN());
        asm volatile("sfence.vma;fence.i;fence");
    }

    inline void Leave()
    { // 切换为内核态vms
        if (CurrentVMS == this)
            KernelVMS->Enter();
    }
    inline void show()
    {
        VirtualMemoryRegion* t;
        t = vmrHead.Nxt();
        kout[Info];
        while (t) {
            kout << (void*)t->StartAddress << '-' << (void*)t->EndAddress << " || "<<(void *)t->Flags<<endline;
            t = t->Nxt();
        }
        kout << endl;
    }

    inline PtrUint GetUsableVMR(PtrUint start, PtrUint end, PtrUint length) // return 0 means invalid
    {
        if (start >= end || length == 0 || end - start < length)
            return 0;
        start = start >> PageSizeBit << PageSizeBit;
        end = end + PAGESIZE - 1 >> PageSizeBit << PageSizeBit;
        length = length + PAGESIZE - 1 >> PageSizeBit << PageSizeBit;
        if (vmrHead.Nxt() == nullptr || maxN(PAGESIZE * 4ull, start) + length <= minN(vmrHead.Nxt()->StartAddress, end))
            return maxN(PAGESIZE * 4ull, start);
        for (VirtualMemoryRegion* vmr = vmrHead.Nxt(); vmr; vmr = vmr->Nxt())
            if (vmr->Nxt() == nullptr) //??
                return 0;
            else if (maxN(vmr->EndAddress, start) + length <= minN(vmr->Nxt()->StartAddress, end))
                return maxN(vmr->EndAddress, start);
        return 0;
    }

    ErrorType SolvePageFault(TrapFrame* tf)
    {
        kout[VMMINFO] << "SolvePageFault in " << (void*)tf->tval << endl;
        VirtualMemoryRegion* vmr = FindVMR(tf->tval); // 找到是谁管理这块地址空间

        kout[VMMINFO] << "Solve Page Fault " << (void*)tf->tval << " is managed by " << vmr << endl;
        kout[VMMINFO] << "VMS" << (void*)this << endl;

        if (vmr == nullptr) {
            show();
            return ERR_AccessInvalidVMR;
        }
        // 根据内存访问模式决定是否使用大页
        // bool useLargePage = vmr->ShouldUseLargePage(vmr->GetFlags(), tf->tval);
        bool useLargePage = false;
        if (useLargePage) {
            // 处理大页映射
            PageTable::Entry& e2 = (*PDT)[PageTable::VPN<2>(tf->tval)];
            PageTable* pt2;
            if (!e2.Valid()) {
                PAGE* pg2 = pmm.alloc_pages(1); // 分配一个大页
                if (pg2 == nullptr)
                    return ERR_OutOfMemory;
                pt2 = (PageTable*)pg2->KAddr();
                pt2->Init();
                e2.SetLargePage(pg2, vmr->ToPageEntryFlags()); // 设置为大页
                asm volatile("sfence.vma \n fence.i \n fence"); // 刷新TLB
                kout[VMMINFO] << "Allocated large page and mapped it" << endl;
                return ERR_None;
            }
        } else {
            PageTable::Entry& e2 = (*PDT)[PageTable::VPN<2>(tf->tval)];
            PageTable* pt2; // 建立新页表
            if (!e2.Valid()) {
                PAGE* pg2 = pmm.alloc_pages(1);
                if (pg2 == nullptr)
                    return ERR_OutOfMemory;
                pt2 = (PageTable*)pg2->KAddr();
                ASSERTEX(((PtrUint)pt2 & (PAGESIZE - 1)) == 0, "pt2 is not aligned to 4k!");
                pt2->Init(); // 页表初始化
                e2.SetPageTable(pt2); // 插入起始节点
            } else
                pt2 = e2.GetPageTable();

            PageTable::Entry& e1 = (*pt2)[PageTable::VPN<1>(tf->tval)];
            PageTable* pt1;
            if (!e1.Valid()) {
                PAGE* pg1 = pmm.alloc_pages(1);
                if (pg1 == nullptr)
                    return ERR_OutOfMemory;
                pt1 = (PageTable*)pg1->KAddr();
                ASSERTEX(((PtrUint)pt1 & (PAGESIZE - 1)) == 0, "pt1 is not aligned to 4k!");
                pt1->Init();
                e1.SetPageTable(pt1);
            } else
                pt1 = e1.GetPageTable();

            PAGE* pg0;
            PageTable::Entry& e0 = (*pt1)[PageTable::VPN<0>(tf->tval)];
            if (!e0.Valid()) {
                pg0 = pmm.alloc_pages(1); // 尝试分配一个大页
                if (pg0 == nullptr)
                    return ERR_OutOfMemory;
                ASSERTEX(((PtrUint)pg0->PAddr() & (PAGESIZE - 1)) == 0, "pg0->Paddr() is not aligned to 4k!");
                MemsetT<char>((char*)pg0->KAddr(), 0, PAGESIZE); // Clear the page data that no data will leak and also for pointer safty.
                e0.SetPage(pg0, vmr->ToPageEntryFlags());
            } else {
                kout[Fault] << "VirtualMemorySpace::SolvePageFault: Page exist, however page fault!" << endl;
                // return ERR_Unknown;
            }
            asm volatile("sfence.vma \n fence.i \n fence"); // 刷新TLB
            //}
        }
        kout[VMMINFO] << "SolvePageFault OK" << endl;

        return ERR_None;
    }

    ErrorType Create()
    {
        CreatePDT();
        {
            auto vmr = KmallocT<VirtualMemoryRegion>();
            vmr->Init((PtrUint)kernelstart, PhysicalMemoryStart() + PhysicalMemorySize(), VirtualMemoryRegion::VM_KERNEL);
            InsertVMR(vmr);
        }
        return ERR_None;
    }

    ErrorType Destroy()
    {
        ASSERTEX(this != Current(), "VirtualMemorySpace::Destroy this is current!");
        if (SharedCount != 0)
            kout[Fault] << "VirtualMemorySpace::Destroy " << this << " while SharedCount " << SharedCount << " is not zero!" << endl;
        ClearVMR();
        if (PDT != nullptr)
            PDT->Destroy(2);
        return ERR_None;
    }
    ErrorType showVMRCount()
    {
        kout << VmrCount << endl;
    }

    ErrorType CreateFrom(VirtualMemorySpace* src)
    {
        kout[VMMINFO] << "VirtualMemorySpace::CreateFrom " << src << ", this is " << this << endl;
        CreatePDT();
        VirtualMemoryRegion *p = src->vmrHead.Nxt(), *q = nullptr;
        while (p) {
            q = KmallocT<VirtualMemoryRegion>();
            ASSERTEX(q, "VirtualMemorySpace::CreateFrom failed to allocate VMR!");
            q->Init(p->StartAddress, p->EndAddress, p->Flags);
            InsertVMR(q);
            q->CopyMemory(*PDT, *src->PDT, 2, 0);
            p = p->Nxt();
        }
        kout[VMMINFO] << "VirtualMemorySpace::CreateFrom " << src << ", OK this is " << this << endl;
        VirtualMemoryRegion* t;
    }
};

class HeapMemoryRegion : public VirtualMemoryRegion {
protected:
    Uint64 BreakPointLength = 0;

public:
    inline PtrUint BreakPoint()
    {
        return StartAddress + BreakPointLength;
    }

    inline ErrorType Resize(Sint64 delta)
    {
        if (delta >= 0) {
            BreakPointLength += delta;
            if (StartAddress + BreakPointLength > EndAddress)
                if (nxt == nullptr || StartAddress + BreakPointLength <= nxt->GetStart())
                    EndAddress = StartAddress + BreakPointLength + PAGESIZE - 1 >> PageSizeBit << PageSizeBit;
                else
                    return ERR_HeapCollision;
        } else {
            if (-delta > BreakPointLength) {
                BreakPointLength = 0;
                EndAddress = StartAddress + PAGESIZE;
            } else {
                BreakPointLength += delta;
                EndAddress = StartAddress + BreakPointLength + PAGESIZE - 1 >> PageSizeBit << PageSizeBit;
            }
            //<<destroy uneeded pages...
        }
        return ERR_None;
    }

    inline ErrorType Init(PtrUint start, Uint64 len = PAGESIZE, Uint64 flags = VM_USERHEAP)
    {
        BreakPointLength = len;
        return VirtualMemoryRegion::Init(start, start + len, flags);
    }
};
inline ErrorType TrapFunc_FageFault(TrapFrame* tf)
{
    return VirtualMemorySpace::Current()->SolvePageFault(tf);
}

#endif