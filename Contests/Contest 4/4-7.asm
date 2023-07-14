%include "io.inc"

section .bss
    myfile resd 1
    x resd 1
    head resd 1
    tmp resd 1
    stage resd 1
    stage_val resd 1

    min_val resd 1
    min_p resd 1
   
section .data
    sizeof dd 4

CEXTERN fscanf
CEXTERN fprintf
CEXTERN fopen
CEXTERN fclose
CEXTERN calloc
CEXTERN free

section .rodata
    fmt_1 db `%d`, 0
    fmt_2 db `%d `, 0
    fmt_input db 'r', 0
    fmt_output db 'w', 0
    file_input db 'input.txt', 0
    file_output db 'output.txt', 0

section .text
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
    sub esp, 16
    mov dword[esp + 4], 4
    mov dword[esp], 3
    call calloc
    add esp, 16

    cmp esi, 0
    je .if_head
    jmp .else_head

.if_head:
    mov dword[head], eax
    mov dword[tmp], eax
    mov dword[eax], 0
    mov ebx, dword[x]
    mov dword[eax + 4], ebx
    mov dword[eax + 8], 0
    
    inc esi
    jmp .for_0

.else_head:
    mov ebx, dword[tmp]
    add ebx, 8
    mov dword[ebx], eax

    mov ebx, dword[tmp]
    mov dword[eax], ebx
    mov ebx, dword[x]
    mov dword[eax + 4], ebx
    mov dword[eax + 8], 0
    mov dword[tmp], eax

    inc esi
    jmp .for_0

.exit_0:


    ;СОРТИРОВКА
    mov esi, dword[head]
    mov dword[tmp], esi
    mov dword[stage], esi

.for_sort_i:
    mov esi, dword[stage]
    cmp esi, 0
    je .exit_sort_i

    add esi, 4
    mov esi, [esi]
    mov dword[min_val], esi
    mov dword[stage_val], esi

    mov esi, dword[stage]
    mov dword[min_p], esi

    mov esi, dword[stage]
    add esi, 8
    mov esi, [esi]
    mov dword[tmp], esi

.for_sort_j:
    mov esi, dword[tmp]
    cmp esi, 0
    je .swap

    add esi, 4
    mov esi, [esi]
    cmp dword[min_val], esi
    jle .miss

    mov dword[min_val], esi

    mov esi, dword[tmp]
    mov dword[min_p], esi

.miss:
    mov esi, dword[tmp]
    add esi, 8
    mov esi, [esi]
    mov dword[tmp], esi 
    jmp .for_sort_j

.swap:
    mov esi, dword[stage]
    add esi, 4
    mov ebx, dword[min_val]
    mov dword[esi], ebx

    mov esi, dword[min_p]
    add esi, 4
    mov ebx, dword[stage_val]
    mov dword[esi], ebx

    mov esi, dword[stage]
    add esi, 8
    mov esi, [esi]
    mov dword[stage], esi

    jmp .for_sort_i

.exit_sort_i:


    ;ВЫВОД 
    sub esp, 16
    mov dword[esp + 4], fmt_output
    mov dword[esp], file_output
    call fopen
    mov dword[myfile], eax
    add esp, 16

    mov esi, dword[head]
    mov dword[tmp], esi

.for_print:
    mov esi, dword[tmp]
    cmp esi, 0
    je .exit_print

    mov esi, dword[tmp]
    add esi, 4
    mov esi, [esi]

    sub esp, 16
    mov dword[esp + 8], esi
    mov dword[esp + 4], fmt_2
    mov ebx, [myfile]
    mov dword[esp], ebx
    call fprintf
    add esp, 16

    mov esi, dword[tmp]
    add esi, 8
    mov esi, [esi]
    mov dword[tmp], esi

    jmp .for_print
    
.exit_print:

    mov esp, ebp
    pop ebp
    xor eax, eax
    ret