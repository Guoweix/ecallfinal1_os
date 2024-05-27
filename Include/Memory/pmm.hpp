#ifndef __PMM_HPP__
#define __PMM_HPP__
#include <Library/KoutSingle.hpp>
// 先考虑基于QEMU模拟机上的运行 实际烧写等到具体场景再做修改
// QEMU模拟的DRAM物理内存大小
// QEMU模拟的物理内存地址从0x0到0x80000000处都是QEMU部分
// DRAM可分配的物理内存就是从0x80000000到0x88000000部分
// 默认物理内存大小是128MB 当然也是可以指定的 这里采取默认实现
extern "C" {
extern char kernelstart[];
extern char kernel_end[]; // 链接脚本里PROVIDE的符号，可获取其地址
extern char freememstart[]; // 虚拟地址
extern char boot_stack[]; // 虚拟地址
};
#define PVOffset 0xffffffff00000000
#define MEMORYEND 0x88000000
#define MemInfo 31
#define MemTest 31
// pagesize页大小为0x1000B 即4096B 即4KB标准sv39页大小
#define PAGESIZE 0x1000
#include <Memory/slab.hpp>
#include <Types.hpp>

inline Uint64 PhysicalMemoryStart()
{
    return 0x80000000 + PVOffset;
} // 硬编码qemu物理内存在虚拟内存中的起始地址

inline Uint64 PhysicalMemorySize()
{
    return 0x08000000;
} // 128MB的内存大小

inline Uint64 FreeMemoryStart() // 可用于分配的自由虚拟内存起始地址
{
    return (Uint64)(freememstart);
}

inline Uint64 FreeMemorySize() // 自由内存大小
{
    return PhysicalMemoryStart() + PhysicalMemorySize() - FreeMemoryStart();
}

struct PAGE {
    Uint64 flags, // 0表示空闲，1表示不是slab，2表示slab64B，3表示slab512B，4表示slab4KB
        num, // 当前表后面有连续的几页
        ref; // 有多少个其他的页表中的项指向它
    PAGE *pre,
        *nxt;

    inline Uint64 Index() const
    {
        return ((Uint64)this - FreeMemoryStart()) / sizeof(PAGE);
    } // 第几页

    inline void* KAddr() const
    {
        return (void*)(FreeMemoryStart() + Index() * PAGESIZE);
    } // 具体页的地址

    inline void* PAddr() const
    {
        return (void*)(FreeMemoryStart() + Index() * PAGESIZE - PVOffset);
    } // 物理地址
};

// 双链表实现最优分配
class PMM {
private:
    PAGE head; // 表头
    PAGE* PagesEndAddr; // 结束地址
    Uint64 PageCount; // 可用空闲页数

public:
    void Init();
    PAGE* alloc_pages(Uint64 num);
    bool free_pages(PAGE* t);
    PAGE* get_page_from_addr(void* addr);
    void show(); // 显示内容
    bool insert_page(PAGE* src); // 更新线段树
    // 实现malloc和free
    // 基于已经实现的页分配简单实现
    // 实现并非很精细 没有充分处理碎片等问题 要求分配的空间必须为整数页张

    // 传参为需要分配的字节数 第二个默认参数为了适配页分配的_ID 基本不会使用
    // 其返回的参数就是实际内存块中的物理地址
    void* malloc(Uint64 bytesize, Uint32 usage);
    void free(void* freeaddress);
};
extern PMM pmm;

// 声明作为标准库通用的内存分配函数
inline void* kmalloc(Uint64 bytesize)
{
    // kout <<"Kmalloc " << bytesize << '\n';
    void* re;
    if (bytesize < 4000) {
        void* p = slab.allocate(bytesize);
        // kout << "slab alloc addr" << p << endl;
        if (p == nullptr) {
            p = pmm.malloc(bytesize, 1);
        }
        re = p;
    } else {
        // kout << "pmm alloc addr" << endl;
        re = pmm.malloc(bytesize, 1);
    }

    // kout <<  "Kmalloc " << (Uint64)re<<' '<<re << '\n';
    return re;
}

inline void kfree(void* freeaddress)
{
    // kout << "Kfree " << (Uint64)freeaddress <<' '<<freeaddress << '\n';

    if (freeaddress != nullptr) {
        PAGE* cur = pmm.get_page_from_addr(freeaddress);

        if (cur->flags == 1) {
            pmm.free(freeaddress);
        } else {
            slab.free(freeaddress, cur->flags);
        }
    }
}

template <typename T>
inline T* KmallocT()
{
    return (T*)kmalloc(sizeof(T));
}

#endif