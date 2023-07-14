%include "io.inc"

section .bss
    arr resd 6; 3 на 2

section .data
    space db ' '
   
section .text
global CMAIN
CMAIN:
    mov ecx, 0
    mov ebx, 0 ; i dd 0; до 1 строки
    mov edx, 0 ; j dd 0; до 2 столбцы

;ввод массива
.for_1:
    cmp ecx, 6
    jl .if_1
    jmp .else_1

.if_1:
    GET_DEC 4, eax
    mov dword[arr + ebx + 4 * edx], eax
    inc ecx
    inc edx

    cmp edx, 3
    je .if_2
    jmp .for_1

.if_2:
    mov edx, 0
    add ebx, 12
    jmp .for_1 

.else_1:

; вывод массива
    mov ecx, 0
    mov ebx, 0 ; i dd 0; до 1 строки
    mov edx, 0 ; j dd 0; до 2 столбцы

.for_2:
    cmp ecx, 6
    jl .if_3
    jmp .else_3

.if_3:
    mov eax, dword[arr + ebx + 4 * edx]
    PRINT_DEC 4, eax
    PRINT_CHAR space
    inc ecx
    inc edx

    cmp edx, 3
    je .if_4
    jmp .for_2

.if_4:
    mov edx, 0
    add ebx, 12
    NEWLINE
    jmp .for_2

.else_3:
    xor eax, eax
    ret