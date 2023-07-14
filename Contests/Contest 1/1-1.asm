%include "io.inc"

section .bss
    v_x resd 1
    v_y resd 1
    a_x resd 1
    a_y resd 1
    t resd 1

section .data
    space db ' ', 0

section .text
global CMAIN
CMAIN:
    GET_DEC 4, v_x
    GET_DEC 4, v_y
    GET_DEC 4, a_x
    GET_DEC 4, a_y
    GET_DEC 4, t

    mov edx, [v_x]
    imul edx, [t]

    mov eax, edx

    mov edx, [a_x]
    imul edx, [t]
    imul edx, [t]

    add eax, edx

    PRINT_DEC 4, eax
    PRINT_CHAR space

    mov edx, [v_y]
    imul edx, [t]

    mov eax, edx

    mov edx, [a_y]
    imul edx, [t]
    imul edx, [t]

    add eax, edx

    PRINT_DEC 4, eax
    
    xor eax, eax
    ret