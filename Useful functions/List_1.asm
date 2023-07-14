%include "io.inc"

section .bss
    head resd 1
    tail resd 1
    
section .data
    y dd 1
    
CEXTERN scanf
CEXTERN qsort
CEXTERN calloc
CEXTERN printf

section .rodata
    fmt_1 db `%d`, 0
   
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    push ebp 
    mov ebp, esp
    
    sub esp, 16
    mov dword[esp + 4], 4
    mov dword[esp], 2
    call calloc
    mov dword[head], eax
    
    mov eax, dword[head]
    mov dword[eax], 5
    mov dword[eax + 4], 0
  
    sub esp, 16
    mov dword[esp + 4], 4
    mov dword[esp], 2
    call calloc
    mov dword[tail], eax
    
    mov eax, dword[tail]
    mov dword[eax], 10
    mov dword[eax + 4], 0
    
    mov eax, dword[head]
    mov ebx, dword[tail]
    mov dword[eax + 4], ebx
    
    
    mov eax, dword[head]
    mov eax, [eax + 4]
    mov eax, [eax]
    
    sub esp, 16
    mov dword[esp + 4], eax
    mov dword[esp], fmt_1
    call printf
    add esp, 16
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret