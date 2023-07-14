%include "io.inc"

section .bss
    a resd 1
    b resd 1
    c resd 1
    d resd 1
    
section .text
gcd:
    .for:
    cmp eax, ebx
    jl .if_1
    jmp .else_1

.if_1:
    mov ecx, eax
    mov eax, ebx
    mov ebx, ecx

.else_1:
    xor edx, edx
    div ebx

    cmp edx, 0
    je .exit

    mov eax, edx
    jmp .for

.exit:
    mov eax, ebx
    ret

global CMAIN
CMAIN:
    GET_UDEC 4, a
    GET_UDEC 4, b
    GET_UDEC 4, c
    GET_UDEC 4, d

    mov eax, [a]
    mov ebx, [b]
    call gcd 
    mov [a], eax

    mov eax, [c]
    mov ebx, [d]
    call gcd 

    mov ebx, [a]
    call gcd

    PRINT_UDEC 4, eax
    xor eax, eax
    ret