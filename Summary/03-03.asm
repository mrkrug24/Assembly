%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    GET_UDEC 4, EDX
    .READ:
        GET_UDEC 4, EAX
        PUSH EAX
        
        CALL DIV3
        
        POP EAX
        
        DEC EDX
        CMP EDX, 0
        JE .END_OF_READ
        JMP .READ
    
    .END_OF_READ:
        
    xor eax, eax
    ret
    
DIV3:
    PUSH EBP
    MOV  EBP, ESP
    PUSH EBX
    PUSH ESI
    
    XOR ECX, ECX   
    XOR ESI, ESI
    
    .FOR:
        MOV EBX, DWORD[ESP + 16]
        AND EBX, 1
        CMP ECX, 0
        JNE .SUB
        ADD ESI, EBX
        INC ECX
        .CONTINUE_SUB:
        SHR DWORD[ESP + 16], 1
        CMP DWORD[ESP + 16], 0
        JE .END_OF_FOR
        JMP .FOR
    

    .END_OF_FOR:    
        CMP ESI, 0
        JL .NEG
        .CONTINUE_NEG:
        
        CMP ESI, 0
        JE .YES
        
        CMP ESI, 3
        JE .YES
        
        CMP ESI, 6
        JE .YES
        
        CMP ESI, 9
        JE .YES
        
        CMP ESI, 12
        JE .YES
        
        CMP ESI, 15
        JE .YES     
        PRINT_STRING `NO`
        JMP .END_OF_DIV3
        .YES:
        PRINT_STRING `YES`
        
    .END_OF_DIV3:
    NEWLINE
    POP ESI
    POP EBX
    
    MOV ESP, EBP
    POP EBP
    RET

.SUB:
    SUB ESI, EBX
    XOR ECX, ECX
    JMP .CONTINUE_SUB
    
.NEG:
    NEG ESI
    JMP .CONTINUE_NEG