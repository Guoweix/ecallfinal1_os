#ifndef OS16_RISCV_HPP
#define OS16_RISCV_HPP

// SBI Ecall内嵌汇编宏
#define SBI_ECALL(__num, __a0, __a1, __a2)                            \
    ({                                                                \
        register unsigned long a0 asm("a0") = (unsigned long)(__a0);  \
        register unsigned long a1 asm("a1") = (unsigned long)(__a1);  \
        register unsigned long a2 asm("a2") = (unsigned long)(__a2);  \
        register unsigned long a7 asm("a7") = (unsigned long)(__num); \
        asm volatile("ecall"                                          \
                     : "+r"(a0)                                       \
                     : "r"(a1), "r"(a2), "r"(a7)                      \
                     : "memory");                                     \
        a0;                                                           \
    })

// 几个SBI常用功能
#define SBI_PUTCHAR(__a0) SBI_ECALL(1, __a0, 0, 0)
#define SBI_GETCHAR() SBI_ECALL(2, 0, 0, 0)
#define SBI_SET_TIMER(t) SBI_ECALL(0, t, 0, 0)
#define SBI_SHUTDOWN() SBI_ECALL(8, 0, 0, 0)

// 读CSR
#define CSR_READ(reg)                              \
    ({                                             \
        unsigned long long re;                     \
        asm volatile("csrr %0, " #reg : "=r"(re)); \
        re;                                        \
    })

// 写CSR
#define CSR_WRITE(reg, val)                            \
    ({                                                 \
        asm volatile("csrw " #reg ", %0" ::"rK"(val)); \
    })

// 读CSR后写CSR
#define CSR_SWAP(reg, val)                                             \
    ({                                                                 \
        unsigned long long re;                                         \
        asm volatile("csrrw %0, " #reg ", %1" : "=r"(re) : "rK"(val)); \
        re;                                                            \
    })

// 读CSR后与bit按位或
#define CSR_SET(reg, bit)                                              \
    ({                                                                 \
        unsigned long long re;                                         \
        asm volatile("csrrs %0, " #reg ", %1" : "=r"(re) : "rK"(bit)); \
        re;                                                            \
    })

// 读CSR后与!bit按位与
#define CSR_CLEAR(reg, bit)                                            \
    ({                                                                 \
        unsigned long long re;                                         \
        asm volatile("csrrc %0, " #reg ", %1" : "=r"(re) : "rK"(bit)); \
        re;                                                            \
    })


#define readb(addr) (*(volatile Uint8*)(addr))
#define readw(addr) (*(volatile Uint16*)(addr))
#define readd(addr) (*(volatile Uint32*)(addr))
#define readq(addr) (*(volatile Uint64*)(addr))

#define writeb(v, addr)                   \
    {                                     \
        (*(volatile Uint8*)(addr)) = (v); \
    }
#define writew(v, addr)                    \
    {                                      \
        (*(volatile Uint16*)(addr)) = (v); \
    }
#define writed(v, addr)                    \
    {                                      \
        (*(volatile Uint32*)(addr)) = (v); \
    }
#define writeq(v, addr)                    \
    {                                      \
        (*(volatile Uint64*)(addr)) = (v); \
    }




#endif
