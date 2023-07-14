%include "io.inc"

section .bss
    month resd 1
    day resd 1
   
section .data
    odd_month dd 41
    even_month dd 42

section .text
global CMAIN
CMAIN:
    mov ebp, esp

    GET_DEC 1, month
    GET_DEC 1, day

    mov ebx, 2
    mov eax, [month]
    sub eax, 1
    xor edx, edx
    div ebx

    mov ebx, [odd_month]
    add ebx, [even_month]

    imul eax, ebx
    imul edx, [odd_month]

    add eax, edx
    add eax, [day]

    PRINT_DEC 4, eax

    xor eax, eax
    ret