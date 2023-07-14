%include "io.inc"

section .bss
    string_1 resb 100
    string_2 resb 100

CEXTERN scanf
CEXTERN printf
CEXTERN strcmp
CEXTERN strcpy
CEXTERN strcat

section .rodata
    fmt_1 db `%s`, 0
   
section .text
global CMAIN
CMAIN:
    push ebp 
    mov ebp, esp
    
    sub esp, 16
    mov dword[esp + 4], string_1
    mov dword[esp], fmt_1
    call scanf
    add esp, 16
    
    sub esp, 16
    mov dword[esp + 4], string_2
    mov dword[esp], fmt_1
    call scanf
    add esp, 16
    
    sub esp, 16
    mov dword[esp + 4], string_1
    mov dword[esp], string_2
    call strcat
    add esp, 16
   
    
    sub esp, 16
    mov dword[esp + 4], string_2
    mov dword[esp], fmt_1
    call printf
    add esp, 16
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret