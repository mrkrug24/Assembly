#include <stdio.h>
#include <stdlib.h>

int M(int eax, int ecx, int edx) {
    int cnt = 0;

    while (eax <= edx || cnt == 0) {
        if (cnt == 0) {
            cnt = 1;
        }

        if (eax < ecx) {
            eax = eax ^ ecx;
            ecx = eax ^ ecx;
            eax = eax ^ ecx;
        }

        if (eax <= edx) {
            return eax;
        }

        eax = eax ^ edx;
        edx = eax ^ edx;
        eax = eax ^ edx;
    }

    return eax;
}

int main(void) {
   int eax, ecx, edx;
   scanf("%d %d %d", &eax, &ecx, &edx);

   eax = M(eax, ecx, edx);

   printf("%d", eax);

   return 0;
}