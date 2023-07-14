%include "io.inc"

section .bss
    a resd 1
    b resd 1
    
section .text
global CMAIN
CMAIN:
    GET_UDEC 4, a
    GET_UDEC 4, b
    mov eax, [a]
    mov ebx, [b]

.gce:
    cmp eax, ebx
    jl .if_1
    jmp .else_1

.if_1:
    mov ebx, eax
    mov eax, [b]

    mov [a], eax
    mov [b], ebx 

.else_1:
    xor edx, edx
    div ebx

    cmp edx, 0
    je .end

    mov eax, edx
    mov [a], eax

    jmp .gce


.end:
    PRINT_UDEC 4, ebx

    xor eax, eax
    ret