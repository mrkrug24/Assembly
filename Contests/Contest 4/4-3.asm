%include "io.inc"

section .bss
    n resd 1
    s resb 11
    arr resb 500*11
    cnt resd 1
    tmp resd 1

CEXTERN scanf
CEXTERN printf
CEXTERN strcmp
CEXTERN strcpy

section .rodata
    fmt_0 db `%d`, 0
    fmt_1 db `%s`, 0
   
section .text
global CMAIN
CMAIN:
    push ebp 
    mov ebp, esp

    sub esp, 16
    mov dword[esp + 4], n
    mov dword[esp], fmt_0 
    call scanf
    add esp, 16
    mov esi, 0

.for_1:
    mov eax, dword[cnt]
    cmp eax, dword[n]
    je .exit_0

    sub esp, 16
    mov dword[esp + 4], s
    mov dword[esp], fmt_1
    call scanf
    add esp, 16
    mov dword[tmp], 0

.for_2:
    mov eax, dword[tmp]
    cmp eax, esi
    je .exit_1

    mov eax, dword[tmp]
    mov ebx, 11
    mul ebx
    add eax, arr
    mov ebx, s

    sub esp, 16
    mov dword[esp + 4], eax
    mov dword[esp], ebx
    call strcmp
    add esp, 16

    cmp eax, 0
    je .if_1
    jmp .else_2

.if_1:
    inc dword[cnt]
    jmp .for_1

.else_2:
    inc dword[tmp]
    jmp .for_2

.exit_1:
    mov eax, esi
    mov edi, 11
    mul edi
    add eax, arr

    sub esp, 16
    mov dword[esp + 4], s
    mov dword[esp], eax
    call strcpy 
    add esp, 16 

    inc esi
    inc dword[cnt]
    jmp .for_1

.exit_0:
    sub esp, 16
    mov eax, esi
    mov dword[esp + 4], eax
    mov dword[esp], fmt_0 
    call printf
    add esp, 16

    mov esp, ebp
    pop ebp
    xor eax, eax
    ret