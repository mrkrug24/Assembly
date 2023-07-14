%include "io.inc"

section .bss
    x resd 1
    n resd 1
    myfile resd 1
    arr resd 1000

section .data
    sizeof dd 4

CEXTERN fscanf
CEXTERN fprintf
CEXTERN fopen
CEXTERN fclose
CEXTERN qsort

section .rodata
    fmt_1 db `%d`, 0
    fmt_2 db `%d `, 0
    fmt_input db 'r', 0
    fmt_output db 'w', 0
    file_input db 'input.txt', 0
    file_output db 'output.txt', 0

section .text

compare:
    push ebp 
    mov ebp, esp
    push ebx
    push edi
    push esi

    mov eax, [ebp + 8]
    mov ebx, [ebp + 12]

    mov eax, [eax]
    mov ebx, [ebx]
    
    cmp eax, ebx
    jl .if_1
    je .if_2
    jg .if_3

.if_1:
    mov eax, -1
    jmp .exit_1

.if_2:
    mov eax, 0
    jmp .exit_1

.if_3:
    mov eax, 1

.exit_1:
    pop esi
    pop edi
    pop ebx
    mov esp, ebp
    pop ebp
    ret

global CMAIN
CMAIN:
    push ebp 
    mov ebp, esp

    sub esp, 16
    mov dword[esp + 4], fmt_input
    mov dword[esp], file_input
    call fopen
    mov dword[myfile], eax
    add esp, 16

    mov esi, 0

.for_0:
    sub esp, 16
    mov dword[esp + 8], x
    mov dword[esp + 4], fmt_1
    mov ebx, [myfile]
    mov dword[esp], ebx
    call fscanf
    add esp, 16

    cmp eax, 1
    je .if_0
    jmp .exit_0

.if_0:
    mov ebx, dword[x]
    mov dword[arr + 4 * esi], ebx
    inc esi
    jmp .for_0

.exit_0:
    mov dword[n], esi

    sub esp, 16
    mov eax, [myfile]
    mov dword[esp], eax
    call fclose
    add esp, 16

    sub esp, 16
    mov dword[esp], arr
    mov [esp + 4], esi
    mov dword[esp + 8], 4
    mov dword[esp + 12], compare
    call qsort
    add esp, 16

    sub esp, 16
    mov dword[esp + 4], fmt_output
    mov dword[esp], file_output
    call fopen
    mov dword[myfile], eax
    add esp, 16

    mov esi, 0

.for_2:
    cmp esi, dword[n]
    je .exit_2

    sub esp, 16
    mov eax, dword[arr + 4 * esi]
    mov dword[esp + 8], eax
    mov dword[esp + 4], fmt_2
    mov ebx, [myfile]
    mov dword[esp], ebx
    call fprintf
    add esp, 16
    inc esi
    jmp .for_2

.exit_2:

    mov esp, ebp
    pop ebp
    xor eax, eax
    ret