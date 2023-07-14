%include "io.inc"

section .bss
    x resd 1
    y resd 1
    z resd 1
   
CEXTERN scanf
CEXTERN printf

section .rodata
    fmt db `%f`, 0
   
section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp

    sub esp, 8
    push x
    push fmt
    call scanf
    add esp, 8

    sub esp, 8
    push y
    push fmt
    call scanf
    add esp, 8

    sub esp, 8
    finit
    fld dword[x]
    fld dword[y]
    faddp
    fst dword[z] 

    fstp qword[esp + 4]
    mov dword[esp], fmt
    call printf
    add esp, 8

    mov esp, ebp
    pop ebp
    xor eax, eax
    ret