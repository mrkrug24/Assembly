%include "io.inc"

section .bss
    r resq 1
    h resq 1

section .data
    tmp dq 2.0
   
CEXTERN scanf
CEXTERN printf

section .rodata
    fmt_input db `%lf`, 0
    fmt_output db `%.8lf`, 0
   
section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp

    sub esp, 8
    mov dword[esp + 4], r
    mov dword[esp], fmt_input 
    call scanf
    add esp, 8

    sub esp, 8
    mov dword[esp + 4], r
    mov dword[esp], fmt_input 
    call scanf
    add esp, 8

    finit
    fld qword[r]
    fld qword[r]
    fld qword[tmp]
    fldpi
    fmulp
    fmulp
    fmulp

    fld qword[tmp]
    fldpi
    fld qword[r]
    fld qword[h]
    fmulp
    fmulp
    fmulp
    faddp

    sub esp, 8
    fstp qword[esp + 4]
    mov dword[esp], fmt_output
    call printf
    add esp, 8

    mov esp, ebp
    pop ebp
    xor eax, eax
    ret