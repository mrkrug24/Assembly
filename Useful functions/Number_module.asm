%include "io.inc"

section .bss
    x resd 1
    
section .data

section .text
global CMAIN
CMAIN:
    GET_DEC 4, x
    mov eax, [x]
    cmp eax, 0

    jge .end
    neg eax
    .end:

    PRINT_DEC 4, eax
    xor eax, eax
    ret