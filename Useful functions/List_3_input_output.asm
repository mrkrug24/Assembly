%include "io.inc"

section .bss
    arr resd 5

section .data
    space db ' '

section .text
global CMAIN
CMAIN:
    mov ecx, 0

;ввод массива
.for_1:
    cmp ecx, 5
    jl .if_1
    jmp .else_1

.if_1:
    GET_DEC 4, eax
    mov dword[arr + 4 * ecx], eax
    inc ecx
    jmp .for_1 

.else_1:

; вывод массива
    mov ecx, 0

.for_2:
    cmp ecx, 5
    jl .if_2
    jmp .else_2

.if_2:
    mov eax, dword[arr + 4 * ecx]
    PRINT_DEC 4, eax
    PRINT_CHAR space
    inc ecx
    jmp .for_2

.else_2:
    xor eax, eax
    ret