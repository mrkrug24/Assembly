%include "io.inc"

section .bss
    a resd 1
    b resd 1
   
CEXTERN fscanf
CEXTERN fprintf

section .rodata
    fmt_1 db `%d\n`, 0
    
gcd:
    push ebp
    mov ebp, esp
    
    mov eax, dword[ebp + 8]; a
    mov ecx, dword[ebp + 12]; b
    
    cmp eax, ecx
    je .exit
    
    jl .if_1
    jmp .else
    

.if_1:
    sub esp, 16
    mov dword[esp + 4], eax
    sub ecx, eax
    mov dword[esp], ecx
    call gcd
    add esp, 16
    jmp .exit

.else:
    sub esp, 16
    sub eax, ecx
    mov dword[esp + 4], eax
    mov dword[esp], ecx
    call gcd
    add esp, 16
    jmp .exit
    
  
.exit:
    mov esp, ebp
    pop ebp
    ret
    

section .text
global CMAIN
CMAIN:
    push ebp 
    mov ebp, esp
    
    sub esp, 16
    mov dword[esp + 4], a
    mov dword[esp], fmt_1
    call scanf
    add esp, 16
    
    sub esp, 16
    mov dword[esp + 4], b
    mov dword[esp], fmt_1
    call scanf
    add esp, 16
    

    sub esp, 16
    mov eax, dword[a]
    mov dword[esp + 4], eax
    mov eax, dword[b]
    mov dword[esp], eax
    call gcd
    add esp, 16
    
    sub esp, 16
    mov dword[esp + 4], eax
    mov dword[esp], fmt_1
    call printf
    add esp, 16
    
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret