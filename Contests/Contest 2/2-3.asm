%include "io.inc"

section .bss
    a_x resd 1
    a_y resd 1

    b_x resd 1
    b_y resd 1

    c_x resd 1
    c_y resd 1

    d_x resd 1
    d_y resd 1

    p_x resd 1
    p_y resd 1

    max_x resd 1
    max_y resd 1

    min_x resd 1
    min_y resd 1

section .data
    yes db 'YES', 0
    no db 'NO', 0
    
section .text
global CMAIN
CMAIN:
    GET_DEC 4, a_x
    GET_DEC 4, a_y

    GET_DEC 4, b_x
    GET_DEC 4, b_y

    GET_DEC 4, c_x
    GET_DEC 4, c_y

    GET_DEC 4, d_x
    GET_DEC 4, d_y

    GET_DEC 4, p_x
    GET_DEC 4, p_y

    ;поиск max_x
    mov eax, [a_x]
    cmp eax, [b_x]
    jl .if_1
    jmp .else_1
.if_1:
    mov eax, [b_x]
.else_1:
    cmp eax, [c_x]
    jl .if_2
    jmp .else_2
.if_2:
    mov eax, [c_x]
.else_2:
    mov [max_x], eax

    ;поиск max_y
    mov eax, [a_y]
    cmp eax, [b_y]
    jl .if_3
    jmp .else_3
.if_3:
    mov eax, [b_y]
.else_3:
    cmp eax, [c_y]
    jl .if_4
    jmp .else_4
.if_4:
    mov eax, [c_y]
.else_4:
    mov [max_y], eax

    ;поиск min_x
    mov eax, [a_x]
    cmp eax, [b_x]
    jg .if_5
    jmp .else_5
.if_5:
    mov eax, [b_x]
.else_5:
    cmp eax, [c_x]
    jg .if_6
    jmp .else_6
.if_6:
    mov eax, [c_x]
.else_6:
    mov [min_x], eax

    ;поиск min_y
    mov eax, [a_y]
    cmp eax, [b_y]
    jg .if_7
    jmp .else_7
.if_7:
    mov eax, [b_y]
.else_7:
    cmp eax, [c_y]
    jg .if_8
    jmp .else_8
.if_8:
    mov eax, [c_y]
.else_8:
    mov [min_y], eax

    ;cравнения
    mov eax, [p_x]
    cmp eax, [max_x]
    jge .end
    cmp eax, [min_x]
    jle .end

    mov eax, [p_y]
    cmp eax, [max_y]
    jge .end
    cmp eax, [min_y]
    jle .end

    PRINT_STRING yes
    jmp .finish

.end:
    PRINT_STRING no

.finish:
    xor eax, eax
    ret