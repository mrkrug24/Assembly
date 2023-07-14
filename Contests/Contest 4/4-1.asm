%include "io.inc"

section .bss
    a resd 1
    b resd 1

CEXTERN scanf
CEXTERN printf

section .rodata
    fmt1 db `%u`, 0
    fmt2 db `0x%08X\n`, 0
    fmt3 db `%c`, 0
 
section .text
global CMAIN
CMAIN:
    push ebp 
    mov ebp, esp

.for:
    push a
    push fmt1
    call scanf
    add esp, 4

    push dword[a]
    push fmt2
    call printf
    add esp, 4

    push b
    push fmt3
    call scanf
    add esp, 4

    mov eax, [b]
    cmp eax, 10
    je .exit
    jmp .for

.exit:
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret