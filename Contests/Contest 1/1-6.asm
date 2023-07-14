%include "io.inc"

section .bss
    x_1 resd 1
    y_1 resd 1
    x_2 resd 1
    y_2 resd 1
    x_3 resd 1
    y_3 resd 1

section .data
    point db '.', 0

section .text
global CMAIN
CMAIN:
    mov ebp, esp

    GET_DEC 4, x_1
    GET_DEC 4, y_1
    GET_DEC 4, x_2
    GET_DEC 4, y_2
    GET_DEC 4, x_3
    GET_DEC 4, y_3

    mov ebx, [y_2]
    sub ebx, [y_3]
    imul ebx, [x_1]
    mov eax, ebx

    mov ebx, [y_3]
    sub ebx, [y_1]
    imul ebx, [x_2]
    add eax, ebx

    mov ebx, [y_1]
    sub ebx, [y_2]
    imul ebx, [x_3]
    add eax, ebx

    cdq
    xor eax, edx
    sub eax, edx

    mov ebx, 2
    xor edx, edx
    div ebx

    PRINT_DEC 4, eax
    PRINT_CHAR point

    imul edx, 5
    PRINT_DEC 4, edx

    xor eax, eax
    ret