#include <Library/KoutSingle.hpp>
#include <Trap/Trap.hpp>
#include <Trap/Clock.hpp>
#include <Trap/Interrupt.hpp>
#include <Memory/pmm.hpp>
#include <Memory/vmm.hpp>
#include <Memory/slab.hpp>
#include <Process/Process.hpp>

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
    // 在 slab 中进行内存分配测试,通过
    void* memory64B = kmalloc(4096);
	if (memory64B)
        kout[Info] << "Allocated 4KB memory successfully!" << (void*)memory64B<<endl;
    else
        kout[Error] << "Failed to allocate 4KB memory!" << endl;
	pmm.show();

    kfree(memory64B);

	void* memory64B2 = kmalloc(4096);
	if (memory64B2)
        kout[Info] << "Allocated 4KB memory successfully!" <<(void*) memory64B2<< endl;
    else
        kout[Error] << "Failed to allocate 4KB memory!" << endl;
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

void pagefault_test(){
	VirtualMemorySpace::Current()->InsertVMR(new VirtualMemoryRegion(0x100,0x200,VirtualMemoryRegion::VM_RW|VirtualMemoryRegion::VM_Kernel));//插入新的vmr
	*(char*)0x100='A';
	
	kout[Test]<<"Original VMS:"<<(char*)0x100<<endl;
	
	VirtualMemorySpace *vms=new VirtualMemorySpace();
	vms->Init();
	vms->Create();
	vms->Enter();
	vms->InsertVMR(new VirtualMemoryRegion(0x100,0x200,VirtualMemoryRegion::VM_RW|VirtualMemoryRegion::VM_Kernel));
	*(char*)0x100='B';
	
	kout[Test]<<"New VMS:"<<(char*)0x100<<endl;
	vms->Leave();
	//kout[Test]<<"Leave New VMS:"<<(char*)0x100<<endl;
	
	vms->Destroy();
	delete vms;
}

void pm_test()
{
	pm.show();
	Process * t= pm.allocProc();
	t->init(F_OutsideName);
	pm.show();
	// t->run();
	// pm.show();

}

int main() 
{
	TrapInit();
	ClockInit();
	InterruptEnable();
	kout[Info]<<"System start success!"<<endl;
	pmm.Init();
    //pmm.show();
	slab.Init();
	pmm_test();

	VirtualMemorySpace::InitStatic();

    //pagefault_test();
    //pm_test();

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
