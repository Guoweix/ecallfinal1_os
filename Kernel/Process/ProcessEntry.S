#include<Arch/Riscv.h>

# 启动内核进程的汇编指令 通过trap实现
.section .text
KernelProcessEntry:
    .global KernelProcessEntry
    move a0,s1
    jalr s0
    jal KernelProcessExit


