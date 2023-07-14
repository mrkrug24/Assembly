%include "io.inc"

section .data
    a dq 1000000000000000000
    b dq 2000000000000000000

section .text
global CMAIN
CMAIN:
    mov eax, [a]
    mov qword[ebp + 8], eax

    mov eax, [b]
    mov qword[ebp + 16], eax
   
    mov eax, dword [ebp+16] 
    mov edx, dword [ebp+20] 
    add eax, dword [ebp+8]
    adc edx, dword [ebp+12] ;старшие разряды

    PRINT_DEC 4, eax
    xor eax, eax
    ret

;если вычитание, то sbb