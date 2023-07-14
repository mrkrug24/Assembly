#include <stdio.h>
#include <stdlib.h>

unsigned int f(unsigned int eax) { 
    if (eax != 0) {
        eax -= 1;
        eax = f(eax);
        eax += 2 * eax;
        return eax;
    } else {
         eax = 1;
         return eax;
    }
}

int main(void) {
    unsigned int eax;
    scanf("%u", &eax);

    eax = f(eax);
    printf("%u\n", eax);

    return 0;
}