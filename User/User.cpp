#include "Arch/Riscv.hpp"
#include <Library/SBI.h>

int main()
{
    while (1) {

        for (int i = 0; i < 1000; i++) {
        }
        SBI_PUTCHAR('X');
    }
}