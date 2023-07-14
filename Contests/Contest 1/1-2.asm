%include "io.inc"

section .bss
    x resd 1
    n resd 1
    m resd 1
    y resd 1

section .data
    f dd 2011

section .text
global CMAIN
CMAIN:
    GET_DEC 4, x
    GET_DEC 4, n
    GET_DEC 4, m
    GET_DEC 4, y
    
    mov eax, [x]

    mov edx, [n]
    sub edx, [m]

    mov ebx, [y]
    sub ebx, [f]

    imul edx, ebx
    add eax, edx

    PRINT_DEC 4, eax

    xor eax, eax
    ret