%include "io.inc"

section .bss
    n resd 1
    k resd 1
    ans resd 1
    prev resd 1

section .text

dig_sum:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8] ;число
    mov ebx, [ebp + 12] ;k
    mov ecx, 0 ;сумма

.for_1:
    cmp eax, 0
    je .exit_1
    xor edx, edx
    div ebx

    add ecx, edx
    jmp .for_1

.exit_1:
    mov eax, ecx
    mov esp, ebp
    pop ebp
    ret

global CMAIN
CMAIN:
    GET_UDEC 4, n
    GET_UDEC 4, k

    mov eax, [n]
    mov dword[ans], eax
    mov dword[prev], -1
    
.for:
    push dword[k]
    push eax
    
    call dig_sum

    add esp, 8

    add dword[ans], eax
    cmp eax, [prev]
    je .exit
    mov dword[prev], eax
    jmp .for

.exit:
    PRINT_UDEC 4, ans
    
    xor eax, eax
    ret