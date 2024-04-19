#include <Memory/pmm.hpp>
#include <Library/KoutSingle.hpp>

void PMM::Init()
{
    using namespace POS;
	kout[MemInfo]<<"POS_PMM init..."<<endl;
    PAGE * page = (PAGE*)FreeMemoryStart();//起始地址，用数组存树
    //kout[MemInfo]<<"FreeMemoryStart: "<<freememstart<<endl;
    PageCount= (PhysicalMemorySize()+PhysicalMemoryStart()-FreeMemoryStart()) / PAGESIZE;
	//内存空间除以每个页（块）的大小
    kout[MemInfo]<<"Free physical page count: "<<PageCount<<endl;
    for(int i=0;i<PageCount;i++)    {
        page[i].flags = 0;//每个块空闲
    }
    Uint64 page_need_size = PageCount * sizeof(PAGE);//需要存储所有page（块）信息的头项的内存空间大小
    Uint64 page_need_page_num = page_need_size / PAGESIZE + 1;//需要多少页存储这些头信息
    kout[MemInfo]<<"Page manager used page count: "<<page_need_page_num<<endl;
    page[0].num = page_need_page_num;//0-page_need_page_num都用来存信息
    page[0].flags = 1;//非空闲
    
    page[page_need_page_num].num = PageCount - page_need_page_num;//这一位开始空闲
    page[page_need_page_num].nxt = nullptr;
    head.nxt = page + page_need_page_num;//从第几个开始空闲
    page[page_need_page_num].pre = &head;//双向
    PagesEndAddr = page + PageCount;//总共页表头的地址
    PageCount-=page_need_page_num;//可用的空闲地址
    kout[MemInfo]<<"PMM init OK"<<endl;
}

void PMM::show()
{
    kout[MemInfo]<<"Free physical page count: "<<PageCount<<endl;
    kout[MemInfo]<<"Physical page index: "<<head.nxt->KAddr()<<endl;
    kout[MemInfo]<<"Physical page index free count: "<<head.nxt->num<<endl;
    kout[MemInfo]<<"Physical page End Address: "<<(void*)PagesEndAddr<<endl;
}

PAGE* PMM::alloc_pages(Uint64 nums)
{
    PAGE* p=head.nxt;//从可分配的页开始
    while(p){
		insert_page(p);
        if(nums<p->num){//数量够了就分配
            PAGE* np = p+nums;//指向最前面没用的页
            int num = p->num;
            p->num=nums;//分配的p的页数就是count
            p->pre->nxt = np;
            if (p->nxt)//不是尾节点
            	p->nxt->pre=np;
            np->pre=p->pre;
			np->nxt=p->nxt;            
            np->num = num - nums;
            p->flags = 1;
            PageCount-=nums;//空闲页数减少
            return p;
        }
        else if(p->num==nums){//刚好相等直接去除该结点就好
            p->pre->nxt = p->nxt;
            if(p->nxt){
                p->nxt->pre = p->pre;
            }
            p->flags = 1;
            PageCount-=nums;
            return p;
        }
        p = p->nxt;
    }
    kout[Fault]<<"PMM::alloc_Page "<<nums<<" failed! Maybe run out of Memory! Left PageCount "<<PageCount<<endl;
    return nullptr;
}

bool PMM::insert_page(PAGE* src)
{
     if(src+src->num<PagesEndAddr&&(src+src->num)->flags==0){
        //head下一个的下一个存在并且空闲
        PAGE* nxt = src+src->num;
        src->num+=nxt->num;//更新管理总数量
        src->nxt = nxt->nxt;
        if(nxt->nxt){//如果nxt不是尾节点
            nxt->nxt->pre = src;
        }
        return true;
    }
    return false;
}

bool PMM::free_pages(PAGE* t)
{
   if (t==nullptr) return false;//释放页表为空

	PageCount+=t->num;//释放后，空闲页增加
    t->flags = 0;//空闲
    PAGE* pre = head.nxt;
    if(pre==nullptr||pre > t)
    {//释放前，已经没有空闲页或者释放的是nxt前的空闲页
        PAGE* headnxt = pre;
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
    PAGE* nxt = pre->nxt;
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
PAGE* PMM::get_page_from_addr(void* addr)
{
    return (PAGE*)(void*)(FreeMemoryStart() + ((Uint64)addr - FreeMemoryStart()) / PAGESIZE * sizeof(PAGE));;
}

// 实现malloc函数 返回的就是分配的内存块是实际物理地址
void* PMM::malloc(Uint64 bytesize,Uint32 usage)
{
    int need_page_count = bytesize / PAGESIZE;
    if (bytesize % need_page_count != 0)
    {
        // 说明分配字节数不是整数倍
        // 强制整数 但是伴随产生内存碎片
        need_page_count++;
    }
    PAGE* temppage = alloc_pages(need_page_count);
    if (temppage == nullptr)
    {
        // 没有分配成功
        kout[Error] << "Malloc Fail!" << endl;
        return nullptr;
    }

    for(int i=0;i<need_page_count;i++){
        temppage[i].flags=usage;
    }

    // 由于页分配实现的是返回页结构体指针 是个页表地址  
    // malloc实现的是返回成功分配后的内存起始地址
    // kout[green] << "success malloc,addr:" << KOUT::hex((Uint64)(temppage - all_pages) * PAGESIZE + (Uint64)all_pages) << endl;
    return temppage->KAddr();
}

void PMM::free(void* freeaddress)
{
    PAGE* wait_free_page = get_page_from_addr(freeaddress);

    if (wait_free_page == nullptr)
    {
        kout[Error] << "Free Fail!" << endl;
        return;
    }
    if (!free_pages(wait_free_page))
    {
        kout[Error] << "Free Fail!" << endl;
        return;
    }
    // Free Success
    return;
}

PMM pmm;