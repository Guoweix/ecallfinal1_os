#ifndef __VMM_HPP__
#define __VMM_HPP__

#include "../Types.hpp"
#include "../Library/TemplateTools.hpp"
#include "pmm.hpp"
#include "../Error.hpp"
#include "../Library/KoutSingle.hpp"
#include "../Library/DataStructure/LinkTable.hpp"
#include "../Trap/Trap.hpp"
#include "../Arch/Riscv.hpp"

extern "C"{
	extern class PageTable boot_page_table_sv39[];
};

class PageTable{//页表项
	public:
		struct Entry{
			PageTableEntryType x;//页表结构：32or64
			
			enum:unsigned {IndexBits=6};
			
			enum:unsigned{
				//枚举，记录每一个整数
				V=1<<IndexBits|0,
				R=1<<IndexBits|1,
				W=1<<IndexBits|2,
				X=1<<IndexBits|3,
				U=1<<IndexBits|4,
				G=1<<IndexBits|5,
				A=1<<IndexBits|6,
				D=1<<IndexBits|7,
				
				XWR=3<<IndexBits|1,
				GU=2<<IndexBits|4,
				GUXWR=5<<IndexBits|1,
				
				RSW=2<<IndexBits|8,
				RSW0=1<<IndexBits|8,
				RSW1=1<<IndexBits|9,
				
				PPN=44<<IndexBits|10,
				PPN0=9<<IndexBits|10,
				PPN1=9<<IndexBits|19,
				PPN2=26<<IndexBits|28,
				PPN_RESERVED=10<<IndexBits|54,
				
				FLAGS=8<<IndexBits|0,
				All=64<<IndexBits|0
			};
			
			enum{
				XWR_PageTable=0,
				XWR_ReadOnly=1,
				XWR_ReadWrite=3,
				XWR_ExecOnly=4,
				XWR_ReadExec=5,
				XWR_ReadWriteExec=7
			};
			
			template <unsigned B> inline static constexpr PageTableEntryType Mask(){//掩码
				constexpr PageTableEntryType i=B&((1<<IndexBits)-1),
								   			 m=((PageTableEntryType)1<<(B>>IndexBits))-1;
				return m<<i;
			}
			
			inline PageTableEntryType& operator () () {return x;}
			inline PageTableEntryType& operator * () {return x;}
			
			template <unsigned B> inline PageTableEntryType Get() const{//解码
				constexpr PageTableEntryType i=B&((1<<IndexBits)-1),
								   			 m=((PageTableEntryType)1<<(B>>IndexBits))-1;
				return (x>>i)&m;
			}
			
			template <unsigned B> inline void Set(PageTableEntryType y){
				constexpr PageTableEntryType i=B&((1<<IndexBits)-1),
											 m=~(((PageTableEntryType)1<<(B>>IndexBits))-1<<i);
				x=(x&m)|y<<i;
			}
			
			template <unsigned I,unsigned L> inline PageTableEntryType Get() const
			{return Get< L<<IndexBits|I >();}
			
			template <unsigned I,unsigned L> inline void Set(PageTableEntryType y)
			{return Set< L<<IndexBits|I >();}
			
			inline bool Valid() const
			{return Get<V>();}
			
			inline void* GetPPN_KAddr() const{
				return (void*)((Get<PPN>()<<12)+PVOffset);
			}
			
			inline bool IsPageTable() const
			{return Get<XWR>()==XWR_PageTable;}
			
			inline PageTable* GetPageTable() const
			{return (PageTable*)GetPPN_KAddr();}//获取ppn虚拟地址
			
			inline void SetPageTable(PageTable *pt){
				Set<V>(1);
				Set<XWR>(XWR_PageTable);
				Set<PPN>((PageTableEntryType)pt->PAddr()>>12);
			}
			
			inline PAGE* GetPage() const
			{return pmm.get_page_from_addr(GetPPN_KAddr());}
			
			inline void SetPage(PAGE *pg,PageTableEntryType flags){
				++pg->ref;
				Set<FLAGS>(flags);
				Set<PPN>((PageTableEntryType)pg->PAddr()>>12);
			}
			
			inline Entry(PageTableEntryType _x):x(_x) {}
			inline Entry() {}
		};
		
		enum{
			PageTableEntryCountBit=9,
			PageTableEntryCount=1<<PageTableEntryCountBit
		};
		
	protected:
		Entry entries[PageTableEntryCount];//几级页表
		
	public:
		template <unsigned n> static inline unsigned VPN(PtrUint kaddr){
			constexpr unsigned i=PageSizeBit+n*PageTableEntryCountBit,
							   m=(1<<PageTableEntryCountBit)-1;
			return kaddr>>i&m;
		}
		
		static inline unsigned VPN(PtrUint kaddr,unsigned n){
			unsigned i=12+n*PageTableEntryCountBit,
					 m=(1<<PageTableEntryCountBit)-1;
			return kaddr>>i&m;
		}
		
		inline static PageTable* Boot()
		{return boot_page_table_sv39;}
		
		inline void* KAddr()
		{return this;}
		
		inline void* PAddr()
		{return (void*)((Uint64)this-PVOffset);}
		
		inline Uint64 PPN()
		{return (Uint64)PAddr()>>12;}

		inline Entry& operator [] (int i)
		{return entries[i];}
		
		inline const Entry& operator [] (int i) const
		{return entries[i];}
		
		inline ErrorType InitAsPDT(){
			POS::MemsetT(entries,Entry(0),PageTableEntryCount-4);
			POS::MemcpyT(&entries[PageTableEntryCount-4],&(*Boot())[PageTableEntryCount-4],4);
			return ERR_None;
		}
		
		inline ErrorType Init(){
			POS::MemsetT(entries,Entry(0),PageTableEntryCount);
			return ERR_None;
		}
		
		inline ErrorType Destroy(const int level){
			ASSERTEX(level>=0,"PageTable::Destroy level "<<level<<" <0!");
			for (int i=0;i<PageTableEntryCount;++i)
				if (entries[i].Valid())
					if (entries[i].IsPageTable())
						entries[i].GetPageTable()->Destroy(level-1);
					else if (entries[i].Get<Entry::U>()==0)
						continue;//Kernel page won't be freed
					else if (level==0)
					{
						PAGE *page=entries[i].GetPage();
						ASSERTEX(page,"PageTable::Destroy: page is nullptr!");
						if (--page->ref==0)
							pmm.free_pages(page);
					}
					else kout[Warning]<<"PageTable::Destroy free huge page is not usable!"<<endl;
			pmm.free_pages(pmm.get_page_from_addr(this));
			return ERR_None;
		}
};
using PageEntry=PageTable::Entry;

class VirtualMemorySpace;
class VirtualMemoryRegion:public POS::LinkTableT <VirtualMemoryRegion>
{
	friend class VirtualMemorySpace;
	public:
		enum:Uint32
		{
			VM_Read		=1<<0,
			VM_Write	=1<<1,
			VM_Exec		=1<<2,
			VM_Stack	=1<<3,
			VM_Heap		=1<<4,
			VM_Kernel	=1<<5,
			VM_Shared	=1<<6,
			VM_Device	=1<<7,
			VM_File		=1<<8,
			VM_Dynamic	=1<<9,
			
			VM_RW=VM_Read|VM_Write,
			VM_RWX=VM_RW|VM_Exec,
			VM_KERNEL=VM_Kernel|VM_RWX,
			VM_USERSTACK=VM_RW|VM_Stack|VM_Dynamic,
			VM_USERHEAP=VM_RW|VM_Heap|VM_Dynamic,
			VM_MMIO=VM_RW|VM_Kernel|VM_Device,
		};
	
	protected:
		VirtualMemorySpace *VMS;//相当于data
		PtrUint Start,//起始地址
			    End;//终结地址
		Uint32 Flags;//管理者负责这块vms的权限
		
	public:
		inline PageTableEntryType ToPageEntryFlags(){
			using PageEntry=PageTable::Entry;
			PageTableEntryType re=PageTable::Entry::Mask<PageTable::Entry::V>();
			if (Flags&VM_Read)
				re|=PageTable::Entry::Mask<PageTable::Entry::R>();
			if (Flags&VM_Write)
				re|=PageTable::Entry::Mask<PageTable::Entry::W>();
			if (Flags&VM_Exec)
				re|=PageTable::Entry::Mask<PageTable::Entry::X>();
			if (!(Flags&VM_Kernel))
				re|=PageTable::Entry::Mask<PageTable::Entry::U>();
			return re;
		}
		
		inline bool Intersect(PtrUint l,PtrUint r) const//r在中间
		{return r>Start&&End>l;}
		
		inline bool In(PtrUint l,PtrUint r) const//包含l,r
		{return Start<=l&&r<=End;}
		
		inline bool In(PtrUint p)
		{return Start<=p&&p<End;}
		
		inline PtrUint GetStart()
		{return Start;}
		
		inline PtrUint GetEnd()
		{return End;}
		
		inline PtrUint GetLength()
		{return End-Start;}
		
		inline Uint32 GetFlags()
		{return Flags;}
		
		ErrorType Init(PtrUint start,PtrUint end,Uint32 flags){
			LinkTableT::Init();
			VMS=nullptr;
			Start=start>>12<<12;//12bit对齐
			End=end+PAGESIZE-1>>12<<12;//终页的最后一个不可用地址）
			Flags=flags;
			ASSERTEX(Start<End,"VirtualMemoryRegion::Init: Start "<<(void*)Start<<" >= End "<<(void*)End);
			return ERR_None;
		}
		
		VirtualMemoryRegion(PtrUint start,PtrUint end,Uint32 flags){
			ASSERTEX(Init(start,end,flags)==ERR_None,"Failed to init VMR!");//c中的断言
		}
};

class VirtualMemorySpace{
	protected:
		static VirtualMemorySpace *CurrentVMS,//目前层的VMS
								  *BootVMS,//用户层vms
								  *KernelVMS;//内核层vms
		
		POS::LinkTableT <VirtualMemoryRegion> VmrHead;//管理vmr的链表
		Uint32 VmrCount;
		VirtualMemoryRegion *VmrCache;//Recent found VMR
		PageTable *PDT;
		Uint32 SharedCount;

		ErrorType ClearVMR(){//清空vmr
			while (VmrHead.Nxt())
				RemoveVMR(VmrHead.Nxt(),true);
			return ERR_None;
		}
		
		ErrorType CreatePDT(){
			PDT=(PageTable*)pmm.alloc_pages(1)->KAddr();//分配初始页表给pdt
			ASSERTEX(((PtrUint)PDT&(PAGESIZE-1))==0,"PDT "<<PDT<<" in VMS "<<this<<" is not aligned to 4k!");
			PDT->InitAsPDT();
			return ERR_None;
		}
		
		static ErrorType InitForBoot(){
			kout[Info]<<"Initing Boot VirtualMemorySpace..."<<endl;
			BootVMS=new VirtualMemorySpace();
			BootVMS->Init();
			{
				auto vmr=KmallocT<VirtualMemoryRegion>();//分配内存区域
				vmr->Init((PtrUint)kernelstart,PhysicalMemoryStart()+PhysicalMemorySize(),VirtualMemoryRegion::VM_KERNEL);//程序的内核vmr
				BootVMS->InsertVMR(vmr);
			}
		
			BootVMS->PDT=PageTable::Boot();//页表项
			BootVMS->SharedCount=1;
			kout[Info]<<"Init BootVMS "<<BootVMS<<" OK"<<endl;
			return ERR_None;
		}
		
		static ErrorType InitForKernel(){
			KernelVMS=BootVMS;
			kout[Info]<<"Init KernelVMS "<<KernelVMS<<" OK"<<endl;
			return ERR_None;
		}
		
	public:
		inline static VirtualMemorySpace* Current()
		{return CurrentVMS;}
		
		inline static VirtualMemorySpace* Boot()
		{return BootVMS;}
		
		inline static VirtualMemorySpace* Kernel()
		{return KernelVMS;}
		
		inline static void EnableAccessUser()
		{CSR_SET(sstatus,1<<18);}
		
		inline static void DisableAccessUser()
		{CSR_CLEAR(sstatus,!(1<<18));}
		
		static ErrorType InitStatic(){//初始化最初，处于内核态
			InitForBoot();
			InitForKernel();
			CurrentVMS=KernelVMS;
			return ERR_None;
		}
		
		VirtualMemoryRegion* FindVMR(PtrUint p){
			if (VmrCache!=nullptr&&VmrCache->In(p))
				return VmrCache;
			VirtualMemoryRegion *v=VmrHead.Nxt();
			while (v!=nullptr)
				if (p<v->Start) return nullptr;
				else if (p<v->End) return VmrCache=v;
				else v=v->Nxt();
			return nullptr;
		}
		
		void InsertVMR(VirtualMemoryRegion *vmr){//代码冗余
			ASSERTEX(vmr,"VirtualMemorySpace::InsertVMR: vmr is nullptr!");
			ASSERTEX(vmr->Single(),"VirtualMemorySpace::InsertVMR: vmr is not single!");
			ASSERTEX(vmr->VMS==nullptr,"VirtualMemorySpace::InsertVMR: vmr->VMS is not nullptr!");
			vmr->VMS=this;
			if (VmrHead.Nxt()==nullptr)
				VmrHead.NxtInsert(vmr);
			else if (VmrCache!=nullptr&&VmrCache->Nxt()==nullptr&&VmrCache->End<=vmr->Start)
				VmrCache->NxtInsert(vmr);
			else{
				VirtualMemoryRegion *v=VmrHead.Nxt();
				VMS_INSERTVMR_WHILE:
					if (vmr->End<=v->Start)
						v->PreInsert(vmr);
					else if (vmr->Start>=v->End)
						if (v->Nxt()==nullptr)
							v->NxtInsert(vmr);
						else{
							v=v->Nxt();
							if (v!=nullptr)
								goto VMS_INSERTVMR_WHILE;
						}
					else kout[Fault]<<"VirtualMemoryRegion::InsertVMR: vmr "<<vmr<<" overlapped with "<<v<<endl;
			}
			VmrCache=vmr;
			++VmrCount;
		}
		
		void RemoveVMR(VirtualMemoryRegion *vmr,bool DeleteVmr){
			ASSERTEX(vmr,"VirtualMemorySpace::RemoveVMR: vmr is nullptr!");
			if (VmrCache==vmr) VmrCache=nullptr;
			vmr->Remove();
			vmr->VMS=nullptr;
			--VmrCount;
			if (DeleteVmr) delete vmr;
		}

		bool TryDeleteSelf(){//Should not be kernel common space!
			if (SharedCount==0&&POS::NotInSet(this,BootVMS,KernelVMS)){
				if (this==CurrentVMS) Leave();
				Destroy();
				kfree(this);
				return 1;
			}
			else return 0;
		}
		
		void Enter(){//进入指定状态的vms
			if (this==CurrentVMS) return;
			CurrentVMS=this;
			CSR_WRITE(satp,8ull<<60|PDT->PPN());
			asm volatile("sfence.vma;fence.i;fence");
		}
		
		inline void Leave(){//切换为内核态vms
			if (CurrentVMS==this) KernelVMS->Enter();
		}
		
		ErrorType SolvePageFault(TrapFrame *tf){
			kout[Test]<<"SolvePageFault in "<<(void*)tf->tval<<endl;
			VirtualMemoryRegion* vmr=FindVMR(tf->tval);//找到是谁管理这块地址空间
			if (vmr==nullptr) return ERR_AccessInvalidVMR;
			{
				// 尝试使用大页
                PAGE* pg0 = nullptr;
                PageTable::Entry &e0 = (*PDT)[PageTable::VPN<0>(tf->tval)];
                if (!e0.Valid()) {
                pg0 = pmm.alloc_pages(1); // 尝试分配一个大页
                if (pg0 != nullptr && pg0->ref == 1) {
                    // 如果分配成功，并且是第一次引用，则使用大页
                    e0.SetPage(pg0, vmr->ToPageEntryFlags());
                    asm volatile("sfence.vma \n fence.i \n fence"); // 刷新 TLB
                    kout[Test] << "SolvePageFault: Allocated large page" << endl;
                    return ERR_None;
                    }
                // 如果分配失败或者不是第一次引用，则尝试按照原逻辑处理
                }

				PageTable::Entry &e2=(*PDT)[PageTable::VPN<2>(tf->tval)];
				PageTable *pt2;//建立新页表
				if (!e2.Valid()){
					PAGE*pg2=pmm.alloc_pages(1);
					if (pg2==nullptr)
						return ERR_OutOfMemory;
					pt2=(PageTable*)pg2->KAddr();
					ASSERTEX(((PtrUint)pt2&(PAGESIZE-1))==0,"pt2 is not aligned to 4k!");
					pt2->Init();//页表初始化
					e2.SetPageTable(pt2);//插入起始节点
				}
				else pt2=e2.GetPageTable();
				
				PageTable::Entry &e1=(*pt2)[PageTable::VPN<1>(tf->tval)];
				PageTable *pt1;
				if (!e1.Valid()){
					PAGE *pg1=pmm.alloc_pages(1);
					if (pg1==nullptr)
						return ERR_OutOfMemory;
					pt1=(PageTable*)pg1->KAddr();
					ASSERTEX(((PtrUint)pt1&(PAGESIZE-1))==0,"pt1 is not aligned to 4k!");
					pt1->Init();
					e1.SetPageTable(pt1);
				}
				else pt1=e1.GetPageTable();
				
				PageTable::Entry &e0=(*pt1)[PageTable::VPN<0>(tf->tval)];
				PAGE *pg0;
				if (!e0.Valid()){
					pg0=pmm.alloc_pages(1);
					if (pg0==nullptr)
						return ERR_OutOfMemory;
					ASSERTEX(((PtrUint)pg0->PAddr()&(PAGESIZE-1))==0,"pg0->Paddr() is not aligned to 4k!");
					MemsetT<char>((char*)pg0->KAddr(),0,PAGESIZE);//Clear the page data that no data will leak and also for pointer safty.
					e0.SetPage(pg0,vmr->ToPageEntryFlags());
				}
				else kout[Fault]<<"VirtualMemorySpace::SolvePageFault: Page exist, however page fault!"<<endl;
				
				asm volatile("sfence.vma \n fence.i \n fence");//刷新TLB
			}
			kout[Test]<<"SolvePageFault OK"<<endl;
			return ERR_None;
		}
		
		ErrorType Create(){
			CreatePDT();
			{
				auto vmr=KmallocT<VirtualMemoryRegion>();
				vmr->Init((PtrUint)kernelstart,PhysicalMemoryStart()+PhysicalMemorySize(),VirtualMemoryRegion::VM_KERNEL);
				InsertVMR(vmr);
			}
			{//外设的，目前用不到
				auto vmr=KmallocT<VirtualMemoryRegion>();
				vmr->Init(PVOffset,PVOffset+0x80000000,VirtualMemoryRegion::VM_MMIO);
				InsertVMR(vmr);
			}
			return ERR_None;
		}
		
		ErrorType Init(){
			VmrHead.Init();
			VmrCount=0;
			VmrCache=nullptr;
			PDT=nullptr;
			SharedCount=0;
			return ERR_None;
		}
		
		ErrorType Destroy(){
			ASSERTEX(this!=Current(),"VirtualMemorySpace::Destroy this is current!");
			if (SharedCount!=0)
				kout[Fault]<<"VirtualMemorySpace::Destroy "<<this<<" while SharedCount "<<SharedCount<<" is not zero!"<<endl;
			ClearVMR();
			if (PDT!=nullptr)
				PDT->Destroy(2);
			return ERR_None;
		}
};

inline ErrorType TrapFunc_FageFault(TrapFrame *tf){
	return VirtualMemorySpace::Current()->SolvePageFault(tf);
}

#endif