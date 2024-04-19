#ifndef OS16_INTERRUPT_HPP
#define OS16_INTERRUPT_HPP

#include "../Arch/Riscv.hpp"

inline void InterruptEnable()//全局使能中断 
{
	CSR_SET(sstatus,0x1);
}

inline void InterruptDisable()//全局失能中断 
{
	CSR_CLEAR(sstatus,0x1);
}

#endif
