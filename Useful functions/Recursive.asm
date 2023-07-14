%include "io.inc"

section .bss
    n resd 1
   
CEXTERN fscanf
CEXTERN fprintf

section .rodata
    fmt_1 db `%d\n`, 0
    
func:
    push ebp
    mov ebp, esp
    
    mov eax, dword[ebp + 8]; число
    mov ecx, dword[ebp + 12]; n
    
    cmp eax, ecx
    je .if_1
    
    inc eax
    
    sub esp, 16
    mov dword[esp + 4], ecx; n
    mov dword[esp], eax; число
    call func
    pop eax
    dec eax
    add esp, 14
    
    sub esp, 16
    mov dword[esp + 4], eax
    mov dword[esp], fmt_1
    call printf
    add esp, 16
    
    mov esp, ebp
    pop ebp
    ret
    
    
.if_1:
    sub esp, 16
    mov eax, dword[n]
    mov dword[esp + 4], eax
    mov dword[esp], fmt_1
    call printf
    add esp, 16
    
    mov esp, ebp
    pop ebp
    ret

section .text
global CMAIN
CMAIN:
    push ebp 
    mov ebp, esp
    
    sub esp, 16
    mov dword[esp + 4], n
    mov dword[esp], fmt_1
    call scanf
    add esp, 16
    
    sub esp, 16
    mov eax, dword[n]
    mov dword[esp + 4], eax
    mov dword[esp], 1
    call func
    add esp, 16

    mov esp, ebp
    pop ebp
    xor eax, eax
    ret