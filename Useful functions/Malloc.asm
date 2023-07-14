%include "io.inc"

section .bss
    x resq 1
    struct resd 1

CEXTERN scanf
CEXTERN printf
CEXTERN malloc
CEXTERN free

section .rodata
    fmt1 db '%d', 0
    fmt2 db '%d', 0
 
section .text
global CMAIN
CMAIN:
    push ebp 
    mov ebp, esp

    ; push x
    ; push fmt1
    ; call scanf
    ; add esp, 4

    ; push dword[x]
    ; push fmt1
    ; call printf
    ; add esp, 4

    push 12
    call malloc
    add esp, 4

    mov dword[struct], eax

    mov dword[struct], 1
    mov dword[struct + 4], 7
    mov dword[struct + 8], 9

    mov ebx, dword[struct]
    PRINT_DEC 4, ebx
    NEWLINE
    mov ebx, dword[struct + 4]
    PRINT_DEC 4, ebx
    NEWLINE
    mov ebx, dword[struct + 8]
    PRINT_DEC 4, ebx


    push eax
    call free
    add esp, 4

    mov esp, ebp
    pop ebp
    xor eax, eax
    ret