#include <Memory/pmm.hpp>

using size_t=long unsigned int;

extern "C"{
    void* __cxa_pure_virtual=0;
}

void* operator new(size_t size)
{return kmalloc(size);}

void* operator new[](size_t size)
{return kmalloc(size);}

void operator delete(void *p,size_t size)
{kfree(p);}

void operator delete[](void *p)
{
    kfree(p);
}
