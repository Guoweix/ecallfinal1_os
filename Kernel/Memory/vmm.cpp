#include <Memory/vmm.hpp>

 VirtualMemorySpace *VirtualMemorySpace::CurrentVMS=nullptr,
 				   *VirtualMemorySpace::BootVMS=nullptr,
 				   *VirtualMemorySpace::KernelVMS=nullptr;
