#ifndef OS16_TRAP_HPP
#define OS16_TRAP_HPP

#include "../Types.hpp"

struct RegisterContext//通用寄存器的上下文 
{
	union//使用联合体，这样既可以按名字访问寄存器，也可以按编号访问寄存器 
	{
		RegisterData x[32];
		struct//按照Risc-V64规范定义的32个寄存器 
		{
			RegisterData zero,ra,sp,gp,tp,
						 t0,t1,t2,
						 s0,s1,
						 a0,a1,a2,a3,a4,a5,a6,a7,
						 s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,
						 t3,t4,t5,t6;
		};
	};
	
	inline RegisterData& operator [] (int index)
	{return x[index];}
};

struct TrapFrame//一次中断/异常所需要保存的上下文/帧 
{
	RegisterContext reg;
	RegisterData status,//原先的CPU状态 
				 epc,//原先的PC寄存器的值，表示程序执行的位置 
				 tval,//地址例外中出错的地址、发生非法指令例外的指令本身、其他异常为0
				 cause;//中断/异常原因
};

enum//使用enum枚举异常类型，避免直接编写异常号，便于维护 
{
	ExceptionCode_InstructionAddressMisaligned	=0,
	ExceptionCode_InstructionAccessFault		=1,
	ExceptionCode_IllegalInstruction			=2,
	ExceptionCode_BreakPoint					=3,
	ExceptionCode_LoadAddressMisaligned			=4,
	ExceptionCode_LoadAccessFault				=5,
	ExceptionCode_StoreAddressMisaligned		=6,
	ExceptionCode_StoreAccessFault				=7,
	ExceptionCode_UserEcall						=8,
	ExceptionCode_SupervisorEcall				=9,
	ExceptionCode_HypervisorEcall				=10,
	ExceptionCode_MachineEcall					=11,
	ExceptionCode_InstructionPageFault			=12,
	ExceptionCode_LoadPageFault					=13,
	ExceptionCode_StorePageFault				=15
};

enum
{
	InterruptCode_SupervisorSoftwareInterrupt	=1,
	InterruptCode_MachineSoftwareInterrupt		=3,
	InterruptCode_SupervisorTimerInterrupt		=5,
	InterruptCode_MachineTimerInterrupt			=7,
	InterruptCode_SupervisorExternalInterrupt	=9,
	InterruptCode_MachineExternalInterrupt		=11
};

extern "C" void Trap(TrapFrame *tf);//异常处理函数，发生异常后首先进入到该函数，然后进行分发处理 

void TrapInit();//初始化中断入口点等 

#endif
