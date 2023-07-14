%include "io.inc"

section .bss
    z resd 1

section .data
    x dd 1.25
    y dd 2.25
    
CEXTERN scanf
CEXTERN printf

section .rodata
    fmt db `%f`, 0
   
section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp

    finit
    sub esp, 8
    fld dword[x]; отправка на стек
    fld dword[y]
    faddp; сложение и pop 1 регистра
    ; fst dword[z] ; записсь в z

    fstp qword[esp + 4]
    mov dword[esp], fmt
    call printf

    add esp, 8
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret