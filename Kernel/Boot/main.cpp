#include <Library/KoutSingle.hpp>
#include <Trap/Trap.hpp>
#include <Trap/Clock.hpp>
#include <Trap/Interrupt.hpp>
#include <Memory/pmm.hpp>
#include <Memory/slab.hpp>

extern "C"
{
	void Putchar(char ch)
	{
		SBI_PUTCHAR(ch);
	}
};

namespace POS
{
	KOUT kout;
};

void pmm_test()
{
	pmm.Init();
    pmm.show();
    
	slab.Init();

    // 在 slab 中进行内存分配测试
    void* memory64B = kmalloc(64);
	if (memory64B)
        kout[Info] << "Allocated 1KB memory successfully!" << (void*)memory64B<<endl;
    else
        kout[Error] << "Failed to allocate 1KB memory!" << endl;
	pmm.show();

    kfree(memory64B);

	void* memory64B2 = kmalloc(64);
	if (memory64B2)
        kout[Info] << "Allocated 1KB memory successfully!" <<(void*) memory64B2<< endl;
    else
        kout[Error] << "Failed to allocate 1KB memory!" << endl;
	pmm.show();

    /*void* memory512B = slab.allocate(512);
    if (memory512B)
        kout[Info] << "Allocated 4KB memory successfully!" << endl;
    else
        kout[Error] << "Failed to allocate 4KB memory!" << endl;
    pmm.show();

    void* memory4KB = slab.allocate(4096);   
    if (memory4KB)
        kout[Info] << "Allocated 16KB memory successfully!" << endl;
    else
        kout[Error] << "Failed to allocate 16KB memory!" << endl;
	pmm.show();*/
}

int main() 
{
	TrapInit();
	ClockInit();
	InterruptEnable();
	kout[Info]<<"System start success!"<<endl;
	
	pmm_test();

	//Below do nothing...
	auto Sleep=[](int n){while (n-->0);};
	auto DeadLoop=[Sleep](const char *str)
	{
		while (1)
			Sleep(1e8),
			kout<<str;
	};
	DeadLoop(".");
	
	kout[Info]<<"Shutdown!"<<endl;
	SBI_SHUTDOWN();
	return 0;
}
