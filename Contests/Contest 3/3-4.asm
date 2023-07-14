%include "io.inc"

section .bss
   n resd 1
   a resd 1
   b resd 1

section .data
    x dd 0
    y dd 1
    max dq 100000000

section .text

gcd:
    .for:
    cmp eax, ebx
    jl .if
    jmp .else

.if:
    mov esi, eax
    mov eax, ebx
    mov ebx, esi

.else:
    xor edx, edx
    div ebx

    cmp edx, 0
    je .exit_gcd

    mov eax, edx
    jmp .for

.exit_gcd:
    mov eax, ebx
    ret

global CMAIN
CMAIN:
    GET_DEC 4, n
    mov ecx, 0

.for_1:
    cmp ecx, [n]
    jl .if_1
    jmp .else_1
.if_1:
    GET_UDEC 4, a
    GET_UDEC 4, b

    mov esi, [y]
    mov ebx, [b]
    mov eax, [x]
    mul ebx
    mov dword[x], eax
    mov eax, [y]
    mul ebx
    mov dword[y], eax
    mov eax, [a]
    mov ebx, esi
    mul ebx
    add dword[x], eax

    mov eax, [x]
    mov ebx, [y]

    cmp eax, [max]
    jge .urgently
    cmp ebx, [max]
    jge .urgently
    jmp .else_urgently

.urgently:
    call gcd
    mov ebx, eax
    mov eax, [x]
    xor edx, edx
    div ebx
    mov [x], eax
    mov eax, [y]
    xor edx, edx
    div ebx
    mov [y], eax

.else_urgently:
    inc ecx
    jmp .for_1
.else_1:

    mov eax, [x]
    mov ebx, [y]

    call gcd
    mov ebx, eax
    mov eax, [x]
    xor edx, edx
    div ebx
    mov [x], eax

    mov eax, [y]
    xor edx, edx
    div ebx
    mov [y], eax

    PRINT_UDEC 4, x
    PRINT_CHAR ' '
    PRINT_UDEC 4, y

    xor eax, eax
    ret   