#include <Trap/Trap.hpp>
#include <Trap/Clock.hpp>
#include <Library/KoutSingle.hpp>
#include <Memory/vmm.hpp>
using namespace POS;

static const char* TrapInterruptCodeName[16]=//中断/异常名字数组，便于打印调试 
{
	"InterruptCode_0"							,
	"InterruptCode_SupervisorSoftwareInterrupt" ,
	"InterruptCode_2"							,
	"InterruptCode_MachineSoftwareInterrupt"	,
	"InterruptCode_4"							,
	"InterruptCode_SupervisorTimerInterrupt"	,
	"InterruptCode_6"							,
	"InterruptCode_MachineTimerInterrupt"		,
	"InterruptCode_8"							,
	"InterruptCode_SupervisorExternalInterrupt"	,
	"InterruptCode_10"							,
	"InterruptCode_MachineExternalInterrupt"	,
	"InterruptCode_12"							,
	"InterruptCode_13"							,
	"InterruptCode_14"							,
	"InterruptCode_15"
};

static const char* TrapExceptionCodeName[16]=
{
	"ExceptionCode_InstructionAddressMisaligned" ,
	"ExceptionCode_InstructionAccessFault"       ,
	"ExceptionCode_IllegalInstruction"           ,
	"ExceptionCode_BreakPoint"                   ,
	"ExceptionCode_LoadAddressMisaligned"        ,
	"ExceptionCode_LoadAccessFault"              ,
	"ExceptionCode_StoreAddressMisaligned"       ,
	"ExceptionCode_StoreAccessFault"             ,
	"ExceptionCode_UserEcall"	                 ,
	"ExceptionCode_SupervisorEcall"              ,
	"ExceptionCode_HypervisorEcall"              ,
	"ExceptionCode_MachineEcall"                 ,
	"ExceptionCode_InstructionPageFault"         ,
	"ExceptionCode_LoadPageFault"                ,
	"ExceptionCode_14"                           ,
	"ExceptionCode_StorePageFault"
};

void TrapFailedInfo(TrapFrame *tf,bool fault=true)
{
	kout[fault?Fault:Debug]<<"TrapFailed:"<<endline
			   <<"    Type  :"<<(void*)tf->cause<<endline
			   <<"    Name  :"<<((long long)tf->cause<0?TrapInterruptCodeName[tf->cause<<1>>1]:TrapExceptionCodeName[tf->cause])<<endline
			   <<"    tval  :"<<(void*)tf->tval<<endline
			   <<"    status:"<<(void*)tf->status<<endline
			   <<"    epc   :"<<(void*)tf->epc<<endl;
}

extern "C"
{
	void Trap(TrapFrame *tf)
	{
		if ((long long)tf->cause<0) switch(tf->cause<<1>>1)//为中断 
		{
			case InterruptCode_SupervisorTimerInterrupt:
				static Uint64 ClockTick=0;
				++ClockTick;
				if (ClockTick%100==0)
					kout<<"*";
				SetClockTimeEvent(GetClockTime()+TickDuration);
				if (ClockTick%50==0)
					//return OS16_PM.Scheduler(tf);
				break;
			default:
				TrapFailedInfo(tf);
		}
		else switch(tf->cause)//为异常 
		{
			case ExceptionCode_BreakPoint:
				switch (tf->reg.a7)
				{
					
				}
			case ExceptionCode_UserEcall:
				TrapFailedInfo(tf);
			case ExceptionCode_LoadAccessFault:
			case ExceptionCode_StoreAccessFault:
			case ExceptionCode_InstructionPageFault:
			case ExceptionCode_LoadPageFault:
			case ExceptionCode_StorePageFault:
				if (TrapFunc_FageFault(tf)!=ERR_None)
					TrapFailedInfo(tf);
				break;
			default://对于没有手动处理过的中断/异常异常都进行到这一步，便于调试 
				TrapFailedInfo(tf);
		}
	}
	
	extern void TrapEntry(void);//定义外部函数，用于获取汇编里定义的地址 
}

void TrapInit()
{
	CSR_SET(sie,1ull<<InterruptCode_SupervisorSoftwareInterrupt);//使能S态软中断 
	CSR_SET(sie,1ull<<InterruptCode_SupervisorExternalInterrupt);//使能S态外部中断 
	CSR_WRITE(sscratch,0);//sscratch清0（目前还没用到） 
	CSR_WRITE(stvec,&TrapEntry);//设置Trap处理的入口点 
}
