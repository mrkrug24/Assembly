#include <stdio.h>
#include <stdlib.h>

#define SIZE 32
#define MAX_NUMBER 4294967295

int main(void) {
    unsigned int eax, ebx;
    scanf("%u", &eax);

    ebx = eax;
    ebx--;
    eax = eax ^ ebx;

    int cf = 0;

    if (eax == MAX_NUMBER) {
        cf = 1;
    }

    eax++;
    eax = (eax >> 1) | (cf << (SIZE - 1));

    printf("%u", eax);

    return 0;
}