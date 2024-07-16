#include "Arch/Riscv.hpp"
#include <Library/SBI.h>
// #include <Library/Easyfunc.hpp>

int main(int argc,char * argv[])
{
    // while (1) {
        // for (int i = 0; i < 1000; i++) {
        // }
        SBI_PUTCHAR('S');
        SBI_PUTCHAR('A');
        // cout<<argc<<endl;
        SBI_PUTCHAR(argv[0][0]);
        SBI_PUTCHAR(argv[1][0]);

    // }

    return 0;
}