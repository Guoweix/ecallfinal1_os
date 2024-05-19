#ifndef OS16_CLOCK_HPP
#define OS16_CLOCK_HPP

#include "../Arch/Riscv.hpp"

constexpr ClockTime Timer_1ms=1e4, 
					Timer_10ms=Timer_1ms*10,
					Timer_100ms=Timer_1ms*100,
					Timer_1s=Timer_1ms*1000,
					TickDuration=Timer_1ms;

inline void SetClockTimeEvent(ClockTime t)//设置下一次触发时钟中断的时刻 
{
	SBI_SET_TIMER(t);
}

inline ClockTime GetClockTime()//获取当前时钟时间 
{
	return CSR_READ(time);
}

inline void SetNextClockEvent()//设置默认的下一次触发时钟中断 
{
	SetClockTimeEvent(GetClockTime()+TickDuration);
}

inline void ClockInit()//初始化时钟
{
	CSR_SET(sie,1ull<<InterruptCode_SupervisorTimerInterrupt);//使能时钟中断 
	SetNextClockEvent();//设置第一次时钟中断触发 
}

#endif
