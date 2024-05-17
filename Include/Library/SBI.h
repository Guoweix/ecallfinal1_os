#ifndef _SBI_HPP_
#define _SBI_HPP_

#include <Types.hpp>

#define sbi_call(ext, fid, arg0, arg1, arg2, arg3, arg4, arg5)              \
    ({                                                                      \
        register unsigned long a0 asm("a0") = (Uint32)(arg0);               \
        register unsigned long a1 asm("a1") = (Uint32)(arg1);               \
        register unsigned long a2 asm("a2") = (Uint32)(arg2);               \
        register unsigned long a3 asm("a3") = (Uint32)(arg3);               \
        register unsigned long a4 asm("a4") = (Uint32)(arg4);               \
        register unsigned long a5 asm("a5") = (Uint32)(arg5);               \
        register unsigned long a6 asm("a6") = (Uint32)(fid);                \
        register unsigned long a7 asm("a7") = (Uint32)(ext);                \
        asm volatile("ecall"                                                \
                     : "+r"(a0), "+r"(a1)                                   \
                     : "r"(a2), "r"(a3), "r"(a4), "r"(a5), "r"(a6), "r"(a7) \
                     : "memory");                                           \
        a0;                                                                 \
    })

#define sbi_putchar(arg0) sbi_call(1, 0, arg0, 0, 0, 0, 0, 0)
#define sbi_getchar() sbi_call(2, 0, 0, 0, 0, 0, 0, 0)
#define sbi_set_time(t) sbi_call(0, 0, t, 0, 0, 0, 0, 0)
#define sbi_shutdown() sbi_call(8, 0, 0, 0, 0, 0, 0, 0)

#define sbi_get_time()            \
    ({                            \
        Uint64 re;                \
        asm volatile("rdtime %0"  \
                     : "=r"(re)); \
        re;                       \
    })

#endif