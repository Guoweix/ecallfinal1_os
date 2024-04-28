#ifndef OS16_INTERRUPT_HPP
#define OS16_INTERRUPT_HPP

#include <Arch/Riscv.h>
#include <Arch/Riscv.hpp>


inline void InterruptEnable()//全局使能中断 
{
	CSR_SET(sstatus,0x1);
}

inline void InterruptDisable()//全局失能中断 
{
	CSR_CLEAR(sstatus,0x1);
}


// 判断现在的中断是否打开
inline bool is_intr_enable()
{
    if (CSR_READ(sstatus) & SSTATUS_SIE)
    {
        return true;
    }
    return false;
}

// 为了设计原语的需要 
// 设计中断使能需要的保存状态等函数和封装
static inline bool _interrupt_save()
{
    if (CSR_READ(sstatus) & SSTATUS_SIE)
    {
        InterruptDisable();
        return 1;           // 相当于上一次中断使能位的状态为1
    }
    return 0;               // 相当于上一次中断使能位的状态为0
}

static inline void _interrupt_restore(bool intr_flag)
{
    if (intr_flag)
    {
        InterruptEnable(); // 若上一次本身就是0就无需什么操作
    }
}

// 宏定义方便使用
// 参考借鉴了ucore实现
#define IntrSave(intr_flag)        do { intr_flag = _interrupt_save(); } while (0)
#define IntrRestore(intr_flag)     _interrupt_restore(intr_flag);



#endif
