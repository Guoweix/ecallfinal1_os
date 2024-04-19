#ifndef __SLAB_HPP__
#define __SLAB_HPP__

#include <Types.hpp>

// 定义不同大小的Slab和数量，page分配大小
#define SLAB_SIZE_B1   64
#define SLAB_SIZE_B2   512
#define SLAB_SIZE_B3   1024

#define SLAB_PAGE1   2
#define SLAB_PAGE2   2
#define SLAB_PAGE3   2

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

// 定义Slab结构
class SlabB {
private:
    slabB head;//表头
	slabB* PagesEndAddr;//结束地址
	Uint64 SlabStartAddress,
           Slab_Size,
           slabBCount;//可用空闲页数

public:
    void Init(Uint32 size,Uint32 PageCounts);
    slabB* allocslabB(Uint64 num);
    bool insert_page(slabB* src); // 更新线段树
    bool freeslabB(slabB* t);
    slabB* get_from_addr(void* addr);

    void free(void* freeaddress);
};

class SlabAllocator {

private:
    //PMM& pmm; // 引用物理内存管理器

    // 不同大小的Slab
    SlabB sB1,//链表
          sB2,
          sB3;
public:

    SlabAllocator(){}
    
    void Init();

    void free(void* freeaddress,Uint64 usage);

    // 分配内存
    void* allocate(Uint64 bytesize);

     // 分配指定大小的Slab
    void* allocateSlab(Uint64 size,Uint32 usage);
};

extern SlabAllocator slab;

#endif // __SLAB_HPP__