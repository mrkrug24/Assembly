%include "io.inc"

section .bss
    n resb 1

section .data
    dignity db '23456789TJQKA', 10
    suit db 'SCDH', 10

section .text
global CMAIN
CMAIN:
    GET_DEC 1, n

    mov eax, [n]
    sub eax, 1
    mov ebx, 13
    xor edx, edx
    div ebx

    PRINT_CHAR [dignity + edx]
    PRINT_CHAR [suit + eax]

    xor eax, eax
    ret