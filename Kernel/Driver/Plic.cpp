// #include "include/types.h"
// #include "include/param.h"
// #include "include/memlayout.h"
// #include "include/riscv.h"
// #include "include/sbi.h"
// #include "include/plic.h"
// #include "include/proc.h"
// #include "include/printf.h"

#include <Driver/Plic.hpp>
#include <Arch/Riscv.hpp>
#include <Types.hpp>

unsigned long long cpuid()
{
    unsigned long long id;
    asm volatile("mv %0,tp" : "=r"(id));
    return 0;
}

//
// the riscv Platform Level Interrupt Controller (PLIC).
//

void plicinit(void)
{
    writed(1, PLIC_V + DISK_IRQ * sizeof(Uint32));
    writed(1, PLIC_V + UART_IRQ * sizeof(Uint32));

#ifdef DEBUG
    printf("plicinit\n");
#endif
}

void plicinithart()
{
    int hart = cpuid();
#ifdef QEMU
    // set uart's enable bit for this hart's S-mode.
    *(Uint32*)PLIC_SENABLE(hart) = (1 << UART_IRQ) | (1 << DISK_IRQ);
    // sbi_putchar('F');
    // set this hart's S-mode priority threshold to 0.
    *(Uint32*)PLIC_SPRIORITY(hart) = 0;
#else
    Uint32* hart_m_enable = (Uint32*)PLIC_MENABLE(hart);
    *(hart_m_enable) = readd(hart_m_enable) | (1 << DISK_IRQ);
    Uint32* hart0_m_int_enable_hi = hart_m_enable + 1;
    *(hart0_m_int_enable_hi) = readd(hart0_m_int_enable_hi) | (1 << (UART_IRQ % 32));
#endif

    // #ifdef DEBUG
    // printf("plicinithart\n");
    // #endif
}

// ask the PLIC what interrupt we should serve.
int plic_claim(void)
{
    int hart = cpuid();
    int irq;
#ifndef QEMU
    irq = *(Uint32*)PLIC_MCLAIM(hart);
#else
    irq = *(Uint32*)PLIC_SCLAIM(hart);
#endif
    return irq;
}

// tell the PLIC we've served this IRQ.
void plic_complete(int irq)
{
    int hart = cpuid();
#ifndef QEMU
    *(Uint32*)PLIC_MCLAIM(hart) = irq;
#else
    *(Uint32*)PLIC_SCLAIM(hart) = irq;
#endif
}
