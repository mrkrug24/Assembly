%include "io.inc"

section .bss
    n resd 1
    a resd 1
    b resd 1
    c resd 1
    x resd 1
   
section .data
    space db ' ', 0

section .text
global CMAIN
CMAIN:
    GET_DEC 4, n
    GET_DEC 4, a
    GET_DEC 4, b
    GET_DEC 4, c

    mov eax, [a]
    mov ebx, [b]
    mov ecx, [c]

    cmp eax, ebx
    jl .if_1
    jmp .else_1

.if_1:
    mov ebx, eax
    mov eax, [b]
    mov [a], eax
    mov [b], ebx

.else_1:
    cmp ecx, eax
    jge .if_2
    jmp .else_2

.if_2:
    mov ecx, eax
    mov eax, [c]
    mov [a], eax
    mov [c], ecx

    mov ecx, ebx
    mov ebx, [c]
    mov [b], ebx
    mov [c], ecx

    jmp .sort_1

.else_2:
    cmp eax, ecx
    jg .if_3
    jmp .else_3

.if_3:
    cmp ecx, ebx
    jg .if_4
    jmp .else_4

.if_4:
    mov ecx, ebx
    mov ebx, [c]
    mov [b], ebx
    mov [c], ecx

.else_3:
.else_4:
.sort_1:

    mov edx, [n]
    sub edx, 3
    cmp edx, 0
    je .end

.if_5:
    GET_DEC 4, x
    cmp [x], eax
    jge .if_6
    jmp .else_6

.if_6:
    mov ecx, ebx
    mov ebx, eax
    mov eax, [x]

    mov [a], eax
    mov [b], ebx
    mov [c], ecx

    jmp .sort_2

.else_6:
    cmp [x], ebx
    jge .if_7
    jmp .else_7

.if_7:
    mov ecx, ebx
    mov ebx, [x]
    mov [b], ebx
    mov [c], ecx
    jmp .sort_2

.else_7:
    cmp [x], ecx
    jg .if_8
    jmp .sort_2

.if_8:
    mov ecx, [x]
    mov [c], ecx

.sort_2:
    dec edx
    cmp edx, 0
    jg .if_5

.end:
    PRINT_DEC 4, a
    PRINT_CHAR space
    PRINT_DEC 4, b
    PRINT_CHAR space
    PRINT_DEC 4, c

    xor eax, eax
    ret