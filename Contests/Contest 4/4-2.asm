%include "io.inc"

section .bss
    a resb 1001
    b resb 1001
    x resb 1
    len_a resd 1
    len_b resd 1
    tmp resd 1

section .data
    ans_1 dd '2 1'
    ans_2 dd '1 2'

CEXTERN scanf
CEXTERN printf

section .rodata
    fmt db `%c`, 0
    fmt2 db `%s`, 0
 
section .text
global CMAIN
CMAIN:
    push ebp 
    mov ebp, esp
    mov esi, 0

;ввод строки a, подсчет len_a
.for_1:
    push x
    push fmt
    call scanf
    add esp, 4

    mov eax, [x]
    cmp eax, 10
    je .exit_1

    mov dword[a + esi], eax
    inc esi
    mov dword[x], 0
    jmp .for_1
.exit_1:

    mov ebx, esi
    mov esi, 0
    mov dword[x], 0

;ввод строки b, подсчет len_b
.for_2:
    push x
    push fmt
    call scanf
    add esp, 4

    mov eax, [x]
    cmp eax, 10
    je .exit_2

    mov dword[b + esi], eax
    inc esi
    mov dword[x], 0
    jmp .for_2
.exit_2:

    mov dword[len_a], ebx
    mov dword[len_b], esi

;чья длина больше
    mov eax, [len_a]
    cmp eax, [len_b]
    jg .if_3
    jmp .else_3

;длинее a
.if_3:
    mov ecx, 0; индекс a
    mov edx, 0; индекс b

.for_3:
    cmp ecx, dword[len_a]
    je .exit_3

    movzx eax, byte[a + ecx]
    movzx ebx, byte[b + edx]
    cmp eax, ebx
    je .if_4
    jmp .else_4

.if_4:
    cmp edx, 0
    je .if_start
    jmp .else_start

.if_start:
    mov dword[tmp], ecx

.else_start:
    mov esi, edx
    inc esi
    cmp esi, dword[len_b]
    je .if_5
    jmp .else_5

.if_5:
    push ans_1
    push fmt2
    call printf
    add esp, 4
    jmp .exit_4

.else_5:
    inc ecx
    inc edx
    jmp .for_3

.else_4:
    cmp edx, 0
    je .if_stop
    jmp .else_stop

.if_stop:
    inc ecx
    jmp .for_3

.else_stop:
    mov ecx, [tmp]
    inc ecx
    mov edx, 0
    jmp .for_3

;длинее b
.else_3:
    mov ecx, 0; индекс a
    mov edx, 0; индекс b

.for_4:
    cmp edx, dword[len_b]
    je .exit_3

    movzx eax, byte[a + ecx]
    movzx ebx, byte[b + edx]
    cmp eax, ebx
    je .if_6
    jmp .else_6

.if_6:
    cmp ecx, 0
    je .if_start_1
    jmp .else_start_1

.if_start_1:
    mov dword[tmp], edx

.else_start_1:
    mov esi, ecx
    inc esi
    cmp esi, dword[len_a]
    je .if_7
    jmp .else_7

.if_7:
    push ans_2
    push fmt2
    call printf
    add esp, 4
    jmp .exit_4

.else_7:
    inc ecx
    inc edx
    jmp .for_4

.else_6:
    cmp ecx, 0
    je .if_stop_1
    jmp .else_stop_1

.if_stop_1:
    inc edx
    jmp .for_4

.else_stop_1:
    mov edx, [tmp]
    inc edx
    mov ecx, 0
    jmp .for_4

.exit_3:
    push '0'
    push fmt
    call printf
    add esp, 4
.exit_4:
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret