%include "io.inc"

SIZE_OF_INT EQU 4

section .bss
    x resd 100

section .data
    N dd 5

section .text
global CMAIN
CMAIN:
    MOV ECX, 0
    
    MOV EBX, [N]

.for_input:
    GET_DEC 4, [x + SIZE_OF_INT * ECX]
    INC ECX
    CMP ECX, [N]
    JL .for_input

    MOV EAX, DWORD[x]
    MOV ECX, 0

.for2:
    MOV EDX, 0
    DEC EBX

.for1:
    MOV ESI, [x + SIZE_OF_INT * EDX]
    MOV EDI, [x + SIZE_OF_INT * EDX + SIZE_OF_INT]
    CMP ESI, EDI
    JG .change_min
    JMP .next

.change_min:
    MOV [x + SIZE_OF_INT * EDX], EDI
    MOV [x + SIZE_OF_INT * EDX + SIZE_OF_INT], ESI
        
.next:    
    INC EDX
    CMP EDX, EBX
    JL .for1

    INC ECX
    CMP ECX, [N]
    JL .for2

    MOV ECX, 0
            
.for_print_array:
    PRINT_DEC 4, [x + SIZE_OF_INT * ECX]
    PRINT_STRING ` `
    INC ECX
    CMP ECX, [N]
    JL .for_print_array

    xor eax, eax
    ret
