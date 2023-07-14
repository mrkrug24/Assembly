%include "io.inc"

section .bss
    a11 resd 1
    a12 resd 1
    a21 resd 1
    a22 resd 1
    b1 resd 1
    b2 resd 1
    not_a11 resd 1
    not_a12 resd 1
    not_a21 resd 1
    not_a22 resd 1
    not_b1 resd 1
    not_b2 resd 1
    x resd 1
    y resd 1

section .data
    space db ' ', 0

section .text
global CMAIN
CMAIN:
    GET_UDEC 4, a11
    GET_UDEC 4, a12
    GET_UDEC 4, a21
    GET_UDEC 4, a22
    GET_UDEC 4, b1
    GET_UDEC 4, b2

    ;нахождение not от переменных
    mov eax, [a11]
    not eax
    mov [not_a11], eax

    mov eax, [a12]
    not eax
    mov [not_a12], eax

    mov eax, [a21]
    not eax
    mov [not_a21], eax

    mov eax, [a22]
    not eax
    mov [not_a22], eax

    mov eax, [b1]
    not eax
    mov [not_b1], eax

    mov eax, [b2]
    not eax
    mov [not_b2], eax

    ;поиск x
    mov ebx, [a11]
    or ebx, [a21]
    mov eax, ebx

    mov ebx, [b1]
    or ebx, [b2]
    and eax, ebx

    mov ebx, [a11]
    or ebx, [a12]
    or ebx, [not_b1]
    and eax, ebx

    mov ebx, [a12]
    or ebx, [b1]
    or ebx, [not_a11]
    and eax, ebx

    mov ebx, [a12]
    or ebx, [b1]
    or ebx, [not_a22]
    and eax, ebx

    mov ebx, [a21]
    or ebx, [a22]
    or ebx, [not_a12]
    and eax, ebx

    mov ebx, [a21]
    or ebx, [a22]
    or ebx, [not_b2]
    and eax, ebx

    mov ebx, [a22]
    or ebx, [b2]
    or ebx, [not_a21]
    and eax, ebx

    mov ebx, [not_a11]
    or ebx, [not_a12]
    or ebx, [not_a21]
    or ebx, [not_a22]
    and eax, ebx

    mov ebx, [not_a12]
    or ebx, [not_a22]
    or ebx, [not_b1]
    or ebx, [not_b2]
    and eax, ebx

    PRINT_UDEC 4, eax
    PRINT_CHAR space

    ;поиск y
    mov ebx, [a12]
    or ebx, [a22]
    mov eax, ebx

    mov ebx, [b1]
    or ebx, [b2]
    and eax, ebx

    mov ebx, [a11]
    or ebx, [a12]
    or ebx, [not_b1]
    and eax, ebx

    mov ebx, [a11]
    or ebx, [b1]
    or ebx, [not_a12]
    and eax, ebx

    mov ebx, [a21]
    or ebx, [a22]
    or ebx, [not_b2]
    and eax, ebx

    mov ebx, [a21]
    or ebx, [b2]
    or ebx, [not_a22]
    and eax, ebx

    mov ebx, [a12]
    or ebx, [not_a21]
    or ebx, [not_b1]
    or ebx, [not_b2]
    and eax, ebx

    mov ebx, [a22]
    or ebx, [not_a11]
    or ebx, [not_b1]
    or ebx, [not_b2]
    and eax, ebx

    mov ebx, [b1]
    or ebx, [not_a12]
    or ebx, [not_a21]
    or ebx, [not_a22]
    and eax, ebx

    mov ebx, [b2]
    or ebx, [not_a11]
    or ebx, [not_a12]
    or ebx, [not_a22]
    and eax, ebx

    PRINT_UDEC 4, eax
    xor eax, eax
    ret