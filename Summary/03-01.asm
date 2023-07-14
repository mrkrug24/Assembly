%include "io.inc"

section .text
global CMAIN
CMAIN:
    GET_UDEC 4, EAX
    GET_UDEC 4, EBX
    
    PUSH EBX
    PUSH EAX
    
    CALL GCD
    
    MOV EDI, EAX
    
    POP EAX
    POP EBX 
    
    GET_DEC 4, EAX
    GET_DEC 4, EBX
    
    PUSH EBX
    PUSH EAX
    
    CALL GCD
   
    MOV ESI, EAX
    
    POP EAX
    POP EBX
    
    PUSH ESI
    PUSH EDI

    CALL GCD
    
    POP EDX
    POP ECX
    
    PRINT_UDEC 4, EAX
    xor eax, eax
    ret
    
GCD:
    PUSH EBP
    MOV  EBP, ESP
    
    MOV EAX, DWORD[ESP + 8]
    MOV ECX, DWORD[ESP + 12]
    CMP ECX, 0
    JE .END_GCC
    XOR EDX, EDX
    DIV ECX
    PUSH EDX
    PUSH ECX
    CALL GCD
    POP ECX
    POP EDX
    .END_GCC:
    
    MOV ESP, EBP
    POP EBP
RET