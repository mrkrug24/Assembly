%include "io.inc"

section .bss
    x resd 1
    y resd 1

section .data
    size dd 8
    alph dd 'H', 0

section .text
global CMAIN
CMAIN:
    GET_CHAR x
    GET_DEC 4, y

    mov ebx, [alph]
    sub ebx, [x]

    mov eax, ebx

    mov ebx, [size]
    sub ebx, [y]

    mul ebx
    shr eax, 1

    PRINT_DEC 4, eax
    xor eax, eax
    ret