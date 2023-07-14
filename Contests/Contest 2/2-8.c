#include <stdio.h>
#include <stdlib.h>

int main(void) {
    unsigned int ebx = 0xffffffff;
    unsigned int eax;
    scanf("%u", &eax);

    while (eax != 0) {
        if (eax <= ebx) {
            ebx = eax;
        }

        scanf("%u", &eax);
    }

    printf("%u", ebx);

    return 0;
}