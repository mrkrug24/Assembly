%include "io.inc"

section .text

find_one:
    push ebp
    mov ebp, esp

    push ebx
    push esi
    push edi

    xor edx, edx
    mov eax, dword[ebp + 16]
    mov ecx, dword[ebp + 12]
    mov ebx, dword[ebp + 8]

    div ebx

    cmp edx, 1
    je .if_1
    jmp .else_1

.if_1:
    inc ecx

.else_1:
    cmp eax, 0
    jne .if_2
    jmp .else_2

.if_2:
    push eax
    push ecx
    push ebx
    
    call find_one

    add esp, 12

.else_2:
    pop edi
    pop esi
    pop ebx

    mov eax, ecx
    mov esp, ebp
    pop ebp
    ret


global CMAIN
CMAIN:
    GET_UDEC 4, eax
    
    push eax
    push 0
    push 3

    call find_one

    add esp, 12

    PRINT_UDEC 4, eax

    xor eax, eax
    ret