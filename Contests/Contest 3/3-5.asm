%include "io.inc"

section .bss
   k resd 1
   n resd 1
   a resd 1

   tmp resd 1
   res resd 1

   eax_tmp resd 1
   ebx_tmp resd 1

section .data
    const dd 2011
    mtp dd 1
   
section .text

func:
    push ebp 
    mov ebp, esp

    mov eax, [ebp + 8]
    mov dword[res], 0
    mov dword[mtp], 1

    cmp eax, 0
    jne .for_1
    mov eax, [k]
    mov dword[mtp], eax
    mov eax, [ebp + 12]
    jmp .for_2

.for_1:
    cmp eax, 0
    je .else_1
    xor edx, edx
    mov ebx, [k]
    div ebx

    mov dword[tmp], eax
    mov eax, edx
    mov ebx, [mtp]
    mul ebx
    add dword[res], eax

    mov eax, [mtp]
    mov ebx, [k]
    mul ebx
    mov dword[mtp], eax

    mov eax, [tmp]
    jmp .for_1
.else_1:
    mov eax, [ebp + 12]

.for_2:
    cmp eax, 0
    je .else_2
    xor edx, edx
    mov ebx, [k]
    div ebx

    mov dword[tmp], eax
    mov eax, edx
    mov ebx, [mtp]
    mul ebx
    add dword[res], eax

    mov eax, [mtp]
    mov ebx, [k]
    mul ebx
    mov dword[mtp], eax

    mov eax, [tmp]
    jmp .for_2
.else_2:

    mov esp, ebp
    pop ebp
    ret

global CMAIN
CMAIN:
    GET_UDEC 4, k
    GET_UDEC 4, n
    GET_UDEC 4, a

    mov eax, [a]
    mov ebx, [const]
    xor edx, edx
    div ebx
    mov eax, edx
    mov ebx, eax
    mov esi, 0

.for_4:
    cmp esi, [n]
    jge .else_4

    mov dword[eax_tmp], eax
    mov dword[ebx_tmp], ebx

    push eax
    push ebx
    call func
    add esp, 8

    mov eax, [res]
    mov ebx, [const]
    xor edx, edx
    div ebx
    mov eax, edx
    mov dword[res], eax

    mov ebx, [eax_tmp]
    mov eax, [res]
    inc esi
    jmp .for_4

.else_4:
    PRINT_UDEC 4, res

    xor eax, eax
    ret