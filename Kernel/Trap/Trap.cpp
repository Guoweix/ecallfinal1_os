#include "Driver/Memlayout.hpp"
#include "Memory/pmm.hpp"
#include "Trap/Syscall/Syscall.hpp"
#include "Types.hpp"
#include <Arch/Riscv.h>
#include <Driver/Plic.hpp>
#include <Driver/VirtioDisk.hpp>
#include <Library/KoutSingle.hpp>
#include <Memory/vmm.hpp>
#include <Process/Process.hpp>
#include <Trap/Clock.hpp>
#include <Trap/Syscall/SyscallID.hpp>
#include <Trap/Trap.hpp>

static const char* TrapInterruptCodeName[16] = // 中断/异常名字数组，便于打印调试
    {
        "InterruptCode_0",
        "InterruptCode_SupervisorSoftwareInterrupt",
        "InterruptCode_2",
        "InterruptCode_MachineSoftwareInterrupt",
        "InterruptCode_4",
        "InterruptCode_SupervisorTimerInterrupt",
        "InterruptCode_6",
        "InterruptCode_MachineTimerInterrupt",
        "InterruptCode_8",
        "InterruptCode_SupervisorExternalInterrupt",
        "InterruptCode_10",
        "InterruptCode_MachineExternalInterrupt",
        "InterruptCode_12",
        "InterruptCode_13",
        "InterruptCode_14",
        "InterruptCode_15"
    };

static const char* TrapExceptionCodeName[16] = {
    "ExceptionCode_InstructionAddressMisaligned",
    "ExceptionCode_InstructionAccessFault",
    "ExceptionCode_IllegalInstruction",
    "ExceptionCode_BreakPoint",
    "ExceptionCode_LoadAddressMisaligned",
    "ExceptionCode_LoadAccessFault",
    "ExceptionCode_StoreAddressMisaligned",
    "ExceptionCode_StoreAccessFault",
    "ExceptionCode_UserEcall",
    "ExceptionCode_SupervisorEcall",
    "ExceptionCode_HypervisorEcall",
    "ExceptionCode_MachineEcall",
    "ExceptionCode_InstructionPageFault",
    "ExceptionCode_LoadPageFault",
    "ExceptionCode_14",
    "ExceptionCode_StorePageFault"
};

void TrapFailedInfo(TrapFrame* tf, bool fault = true)
{
    VirtualMemorySpace::Current()->show(Debug);
    kout[fault ? Fault : Debug] << "TrapFailed:" << endline
                                << "    Type  :" << (void*)tf->cause << endline
                                << "    Name  :" << ((long long)tf->cause < 0 ? TrapInterruptCodeName[tf->cause << 1 >> 1] : TrapExceptionCodeName[tf->cause]) << endline
                                << "    tval  :" << (void*)tf->tval << endline
                                << "    status:" << (void*)tf->status << endline
                                << "    epc   :" << (void*)tf->epc << endline
                                << "    ra    :" << (void*)tf->reg.ra << endl;
}

bool needSchedule;


        char  StaticallocPage[0x500*PAGESIZE];
        Uint64 al=1;
        
extern "C" {
TrapFrame* Trap(TrapFrame* tf)
{
    // kout[NEWINFO]<<"entry "<<endl;
    int t = needSchedule;
    needSchedule = 0;
    if ((long long)tf->cause < 0)
        switch (tf->cause << 1 >> 1) // 为中断
        {

        case InterruptCode_SupervisorTimerInterrupt:
            static Uint64 ClockTick = 0;
            ++ClockTick;
            // if (ClockTick%100==0)
            // kout<<"*";
            // Putchar('*');
            if (ClockTick % 50 == 0) {
                needSchedule = true;
            }
            SetClockTimeEvent(GetClockTime() + TickDuration);
            break;
        case IRQ_S_EXT: {
            int irq = plic_claim();
            // kout[Debug] << "irq " << irq << endl;
            switch (irq) {
            case 0:
                break;
            case UART_IRQ:
                //...
                break;
            case DISK_IRQ: {
                bool err = Disk.DiskInterruptSolve();
                // kout[green]<<"DiskInterruptSolve"<<endl;
                if (!err)
                    kout[Fault] << "error DiskInterruptSolve" << endl;
                break;
            }
            default:
                kout[Fault] << "irq error" << endl;
            }
            if (irq)
                plic_complete(irq);
            break;
        }
        default:
            TrapFailedInfo(tf);
        }
    else {
        switch (tf->cause) // 为异常
        {
        case ExceptionCode_BreakPoint:
            // switch (tf->reg.a7) {
            // default:
            // kout << "ExceptionCode_BreakPoint" << tf->reg.a7 << endl;
            // }
        case ExceptionCode_UserEcall: {
            ClockTime trapStartTime = GetClockTime();
            // kout[Info] << "Ecall start" << (void*)tf->epc << endl;
            bool re = TrapFunc_Syscall(tf);
            if (!re) {
                TrapFailedInfo(tf);
            } else {
                tf->epc += tf->cause == ExceptionCode_UserEcall ? 4 : 2;
                // kout[Info] << "Ecall finish" << (void*)tf->epc << endl;
                // pm.getCurProc()->getVMS()->show();
                // kout<<DataWithSize((char *)tf->epc,100)<<endl;
            }

            if (!needSchedule) { // 如果不需要进程切换则认为程序在系统态运行
                ClockTime trapEndTime = GetClockTime();
                pm.getCurProc()->sysTime += trapEndTime - trapStartTime;
            }
            break;
        }
        case ExceptionCode_LoadAccessFault:
        case ExceptionCode_StoreAccessFault:
        case ExceptionCode_InstructionPageFault:
        case ExceptionCode_LoadPageFault:
        case ExceptionCode_StorePageFault: 
/*
            kout[DeBug] << "PageFault type " << (void*)tf->cause << endline << "    Name  :" << ((long long)tf->cause < 0 ? TrapInterruptCodeName[tf->cause << 1 >> 1] : TrapExceptionCodeName[tf->cause]) << endl;
            kout[DeBug] << "PageFault pc " << (void*)tf->epc <<endl;

            ASSERTEX(tf->tval == 0xfffffffec0200000, "tval != 0xFFFFFFFec0200000ull");

            Uint64* t = (Uint64*)boot_page_table_sv39;
            Uint64* p1=(Uint64 *)((Uint64)(&StaticallocPage[1*PAGESIZE])/0x1000*0x1000-VIRT_OFFSET);

            kout[DeBug]<<"trapP1"<<p1<<endl;

            // t[507] = (((Uint64)0x40000 )<< 10) | 0xcf;
            t[507] = (((Uint64)p1 >>12)<< 10) | 0xc1;

            Uint64* p2=(Uint64 *)((Uint64)(&StaticallocPage[4*PAGESIZE])/0x1000*0x1000-VIRT_OFFSET);
            p1[1]= (((Uint64)p2>>12) << 10) | 0xc1;
            // for (int i=0;i<512;i++) {
                // p1[i]=((Uint64)p2 << 10) | 0x1;
                // p1[i]=((Uint64)40200 << 10) | 0xcf;
            // } 

            // kout[DeBug]<<"trapP2"<<p2<<endl;
            Uint64* p3=(Uint64 *)((Uint64)(&StaticallocPage[40*PAGESIZE])/0x1000*0x1000-VIRT_OFFSET);
            p2[0]= ((Uint64)0x40200 << 10) | 0xcf;
            // p2[0]= (((Uint64)p3 >>12)<< 10) | 0xf;
            // for (int i=0;i<512;i++) {
                // p2[i]= ((Uint64)p3 << 10) | 0xf;
            // } 
            asm volatile("sfence.vma zero,zero\n fence.i \nfence");

            */
                      kout[VMMINFO] << "PageFault type " << (void*)tf->cause << endline << "    Name  :" << ((long long)tf->cause < 0 ? TrapInterruptCodeName[tf->cause << 1 >> 1] : TrapExceptionCodeName[tf->cause]) << endl;
                    if (TrapFunc_FageFault(tf) != ERR_None) {
                        kout[Info] << "PID" << pm.getCurProc()->getID() << endl;
                        if (tf->status&0x100) {
                        TrapFailedInfo(tf);
                        }
                        pm.getCurProc()->exit(-1);
                        needSchedule=1;
                    } 
        // kout[DeBug]<<"Trap show"<<endl;
        // VirtualMemorySpace::Current()->show(Debug);
        break;
        default: // 对于没有手动处理过的中断/异常异常都进行到这一步，便于调试
            TrapFailedInfo(tf);
        }
    }
    // kout[NEWINFO]<<"leave "<<endl;
    if (needSchedule) {
        needSchedule = t;
        // if(t)
        // kout << "true" << endl;
        // else
        // kout<<"false"<<endl;
        return pm.Schedule(tf);
    } else {

        return tf;
    }
}

extern void TrapEntry(void); // 定义外部函数，用于获取汇编里定义的地址
}
char regName[32][10] = { "zero", "ra", "sp", "gp", "tp",
    "t0", "t1", "t2",
    "s0", "s1",
    "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7",
    "s2", "s3", "s4", "s5", "s6", "s7", "s8", "s9", "s10", "s11",
    "t3", "t4", "t5", "t6" };

void TrapFramePrint(TrapFrame* tf, KoutType t)
{
    for (int i = 0; i < 32; i++) {
        kout[t] << regName[i] << ":\t" << (void*)tf->reg[i] << endl;
    }
    kout[t] << "cause:\t" << (void*)tf->cause << endl;
    kout[t] << "epc:\t" << (void*)tf->epc << endl;
    kout[t] << "state:\t" << (void*)tf->status << endl;
    kout[t] << "tcal:\t" << (void*)tf->tval << endl;
    // kout[Info] << "wrtcal:\t" << (void*)tf->tval << endl;
}

void TrapInit()
{
    CSR_SET(sie, 1ull << InterruptCode_SupervisorSoftwareInterrupt); // 使能S态软中断
    CSR_SET(sie, 1ull << InterruptCode_SupervisorExternalInterrupt); // 使能S态外部中断
    CSR_WRITE(sscratch, 0); // sscratch清0（目前还没用到）
    CSR_WRITE(stvec, &TrapEntry); // 设置Trap处理的入口点
}
