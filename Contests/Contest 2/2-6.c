#include <stdio.h>
#include <stdlib.h>

int main(void) {
    int eax, ebx, ecx;
    scanf("%d", &ecx);

    ebx = 1;
    eax = 0;
    

    for (int i = ecx; i > 0; i--) {
        eax = eax ^ ebx;
        ebx = eax ^ ebx;
        eax = eax ^ ebx;

        ebx += eax;
    }

    printf("%d ", eax);

    return 0;
}