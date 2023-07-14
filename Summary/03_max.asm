%include "io.inc"

section .bss
    x resd 1
    y resd 1
    z resd 1

section .text
global CMAIN
CMAIN:
    ; пролог
    push ebp
    mov ebp, esp    ; EBP <- ESP

    GET_DEC 4, [x]
    GET_DEC 4, [y]
    GET_DEC 4, [z]
    
    PRINT_STRING `x: ` 
    PRINT_DEC 4, [x]
    NEWLINE

    PRINT_STRING `y: ` 
    PRINT_DEC 4, [y]
    NEWLINE

    PRINT_STRING `z: ` 
    PRINT_DEC 4, [z]
    NEWLINE
    
    push DWORD[z]
    push DWORD[y]
    push DWORD[x]
    
    call max3
    
    add ESP, 12 ; "откат"    

    PRINT_STRING `max: `
    PRINT_DEC 4, eax

    ; эпилог
    mov esp, ebp
    pop ebp
    
    xor eax, eax
    ret
    
    
max3:
    ; пролог
    push ebp
    mov ebp, esp    ; EBP <- ESP
    
    PRINT_STRING `max3 x: ` 
    PRINT_DEC 4, [EBP+8]
    NEWLINE

    PRINT_STRING `max3 y: ` 
    PRINT_DEC 4, [EBP+12]
    NEWLINE

    PRINT_STRING `max3 z: ` 
    PRINT_DEC 4, [EBP+16]
    NEWLINE
    
    mov eax, [EBP+8]    ; eax <- x
    cmp eax, [EBP+12]
    cmovl eax, [EBP+12]
    cmp eax, [EBP+16]
    cmovl eax, [EBP+16]
    

    ; эпилог
    mov esp, ebp
    pop ebp

    ret