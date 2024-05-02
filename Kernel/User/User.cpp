#include "Types.hpp"
#include <User/User.hpp>
#include <Library/SBI.h>

int UserSleep()
{
    while (1) {
    }
}
int UserKeepPrint(void * ch)
{
    char x=*(char *)ch;
    while (1) {
        for (int i=0;i<10000 ; i++) {
                sbi_putchar(x);
        } 
    }
}
