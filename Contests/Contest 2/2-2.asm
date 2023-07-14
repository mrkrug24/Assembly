%include "io.inc"

section .bss
    n resd 1
    
section .text
global CMAIN
CMAIN:
    GET_UDEC 4, n
    mov eax, [n]
    mov ebx, 2
    mov ecx, 0

.for:
    xor edx, edx
    div ebx
    add ecx, edx

    cmp eax, 0
    jg .for

    PRINT_UDEC 4, ecx
    xor eax, eax
    ret