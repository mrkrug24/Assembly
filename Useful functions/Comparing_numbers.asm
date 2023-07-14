%include "io.inc"

section .bss
    x resd 1
    
section .text
global CMAIN
CMAIN:
    GET_DEC 4, x
    cmp dword[x], 10
    
    je .aza 

    PRINT_DEC 4, 0

    jmp .end

    .aza:

    PRINT_DEC 4, 1

    .end:
    
    xor eax, eax
    ret