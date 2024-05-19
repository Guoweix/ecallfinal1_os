#include <Memory/slab.hpp>
#include<Types.hpp>
#include <Memory/pmm.hpp>
#include <Library/KoutSingle.hpp>

void SlabB::Init(Uint32 size,Uint32 Pagecounts){
    using namespace POS;
	kout[MemInfo]<<"SlabB init..."<<endl;
    //存储头结点
    slabB* s = (slabB*)slab.allocateSlab(Pagecounts*4096,2);//一页的虚拟起始地址
    slabBCount= Pagecounts*4096/size;
    Slab_Size=size;
    SlabStartAddress=(Uint64)s;
	//内存空间除以每个页（块）的大小
    kout[MemInfo]<<"slab B count: "<<slabBCount<<endl;
    for(int i=0;i<slabBCount;i++)    {
        s[i].flags = 0;//每个块空闲
        s[i].SlabStartAddress=(Uint64)s;
        s[i].Slab_Size=size;
    }

    Uint64 s_need_size = slabBCount * sizeof(slabB);//需要存储所有的头项的内存空间大小
    Uint64 s_need_num = s_need_size / size + 1;//需要多少页存储这些头信息
    kout[MemInfo]<<"manager used count: "<<s_need_num<<endl;
    s[0].num = s_need_num;//0-page_need_page_num都用来存信息
    s[0].flags = 1;//非空闲
    
    s[s_need_num].num = slabBCount - s_need_num;//这一位开始空闲
    s[s_need_num].nxt = nullptr;
    head.nxt = s + s_need_num;//从第几个开始空闲
    s[s_need_num].pre = &head;//双向
    PagesEndAddr = s + s_need_num;//总共页表头的地址
    slabBCount-=s_need_num;//可用的空闲地址
    kout[MemInfo]<<"s init OK"<<endl;
}

slabB* SlabB::allocslabB(Uint64 nums)
{
    slabB* p=head.nxt;//从可分配的页开始
    while(p){
		insert_page(p);
        if(nums<p->num){//数量够了就分配
            slabB* np = p+nums;//指向最前面没用的页
            int num = p->num;
            p->num=nums;//分配的p的页数就是count
            p->pre->nxt = np;
            if (p->nxt)//不是尾节点
            	p->nxt->pre=np;
            np->pre=p->pre;
			np->nxt=p->nxt;            
            np->num = num - nums;
            p->flags = 1;
            slabBCount-=nums;//空闲页数减少
            return p;
        }
        else if(p->num==nums){//刚好相等直接去除该结点就好
            p->pre->nxt = p->nxt;
            if(p->nxt){
                p->nxt->pre = p->pre;
            }
            p->flags = 1;
            slabBCount-=nums;
            return p;
        }
        p = p->nxt;
    }
    kout[Fault]<<"Slab::allocslabB "<<nums<<" failed! Maybe run out of Memory! Left Count "<<slabBCount<<endl;
    return nullptr;
}

bool SlabB::insert_page(slabB* src)
{
     if(src+src->num<PagesEndAddr&&(src+src->num)->flags==0){
        //head下一个的下一个存在并且空闲
        slabB* nxt = src+src->num;
        src->num+=nxt->num;//更新管理总数量
        src->nxt = nxt->nxt;
        if(nxt->nxt){//如果nxt不是尾节点
            nxt->nxt->pre = src;
        }
        return true;
    }
    return false;
}

bool SlabB::freeslabB(slabB* t)
{
   if (t==nullptr) return false;//释放页表为空

	slabBCount+=t->num;//释放后，空闲页增加
    t->flags = 0;//空闲
    slabB* pre = head.nxt;
    if(pre==nullptr||pre > t)
    {//释放前，已经没有空闲页或者释放的是nxt前的空闲页
        slabB* headnxt = pre;
        head.nxt = t;//添加到头结点后面
        t->pre = &head;
        t->nxt = headnxt;
        if(headnxt)
        {
            headnxt->pre = t;
        }
        insert_page(t);
        return true;
    }

    //找到第一个比t大的结点
    while(pre->nxt&&pre->nxt < t)
    {
        pre = pre->nxt;
    }

    //插入结点
    slabB* nxt = pre->nxt;
    pre ->nxt = t;
    t->pre = pre;
    t->nxt = nxt;
    if(nxt)
    {
        nxt->pre = t;
    }
    insert_page(t);
    return true;
}

// 从物理地址获取对应的页 参数addr实际上是相对all_pages的偏移量
slabB* SlabB::get_from_addr(void* addr)
{
    return (slabB*)(void*)(SlabStartAddress+((Uint64)addr - SlabStartAddress) / Slab_Size * sizeof(slabB));;
}

void SlabB::free(void* freeaddress)
{
    slabB* wait_free_page = get_from_addr(freeaddress);

    if (wait_free_page == nullptr)
    {
        kout[Error] << "Free Fail!" << endl;
        return;
    }
    if (!freeslabB(wait_free_page))
    {
        kout[Error] << "Free Fail!" << endl;
        return;
    }
    // Free Success
    return;
}

//这边具体逻辑还需要算法修改
void* SlabAllocator::allocate(Uint64 bytesize) {
    if (bytesize <= SLAB_SIZE_B1) {
        return sB1.allocslabB(1)->KAddr();
    } else if (bytesize <= SLAB_SIZE_B2) {
        return sB2.allocslabB(1)->KAddr();
    } else if (bytesize <= 4096) {
        int num=bytesize/SLAB_SIZE_B3;
        if(bytesize%SLAB_SIZE_B2!=0){
            num++;
        }
        return sB3.allocslabB(num)->KAddr();
    }
    return nullptr; 
}

void SlabAllocator::Init(){
    sB1.Init(SLAB_SIZE_B1,SLAB_PAGE1);
    sB2.Init(SLAB_SIZE_B2,SLAB_PAGE2);
    sB3.Init(SLAB_SIZE_B3,SLAB_PAGE3);
}

void SlabAllocator::free(void* freeaddress,Uint64 usage){
    if(usage==2){
        sB1.free(freeaddress);
    }else if(usage==3){
        sB2.free(freeaddress);
    }else{
        sB3.free(freeaddress);
    }
}

void* SlabAllocator::allocateSlab(Uint64 size,Uint32 usage) {
    return pmm.malloc(size,usage);
}

SlabAllocator slab;