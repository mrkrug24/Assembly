%include "io.inc"

section .bss
    X1 RESD 1
    X2 RESD 1
    X3 RESD 1
    Y1 RESD 1
    Y2 RESD 1
    Y3 RESD 1
    S  RESD 1
    V  RESD 1
    G  RESD 1
    CORD1 RESD 1
    CORD2 RESD 1

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging

    GET_DEC 4, [X1]
    GET_DEC 4, [Y1]
    GET_DEC 4, [X2]
    GET_DEC 4, [Y2]
    GET_DEC 4, [X3]
    GET_DEC 4, [Y3]
        
    MOV EAX, [X2]
    SUB EAX, [X1]
    MOV ECX, [Y3]
    SUB ECX, [Y1]
    
    CDQ 
    MUL ECX
    
    MOV [S], EAX
    
    MOV EAX, [X3]
    SUB EAX, [X1]
    MOV ECX, [Y2]
    SUB ECX, [Y1]
    
    CDQ 
    MUL ECX
    
    SUB [S], EAX
    
    CMP DWORD[S], 0
    JL .NEG
    .CONTINUE_NEG:
    
    PUSH DWORD[S]
    CALL PICK
   
    POP DWORD[S]
    JMP .END
    
    .NEG:
        NEG DWORD[S]
        JMP .CONTINUE_NEG
    
    .END:
    MOV DWORD[V], EAX
    
    MOV EAX, DWORD[X2]
    SUB EAX, DWORD[X1]
    MOV DWORD[CORD1], EAX
    
    MOV EAX, DWORD[Y2]
    SUB EAX, DWORD[Y1]
    MOV DWORD[CORD2], EAX
    
    PUSH DWORD[CORD2]
    PUSH DWORD[CORD1]
    
    CALL GCD
    
    POP DWORD[CORD1]
    POP DWORD[CORD2]
    
    ADD DWORD[G], EAX
    
    MOV EAX, DWORD[X3]
    SUB EAX, DWORD[X2]
    MOV DWORD[CORD1], EAX
    
    MOV EAX, DWORD[Y3]
    SUB EAX, DWORD[Y2]
    MOV DWORD[CORD2], EAX
    
    PUSH DWORD[CORD2]
    PUSH DWORD[CORD1]
    
    CALL GCD
    
    POP DWORD[CORD1]
    POP DWORD[CORD2]
    
    ADD DWORD[G], EAX
    
    MOV EAX, DWORD[X1]
    SUB EAX, DWORD[X3]
    MOV DWORD[CORD1], EAX
    
    MOV EAX, DWORD[Y1]
    SUB EAX, DWORD[Y3]
    MOV DWORD[CORD2], EAX
    
    PUSH DWORD[CORD2]
    PUSH DWORD[CORD1]
    
    CALL GCD
    
    POP DWORD[CORD1]
    POP DWORD[CORD2]
    
    ADD DWORD[G], EAX
    
    MOV EAX, DWORD[V]
    SUB EAX, DWORD[G]
    
    XOR EDX, EDX
    MOV EBX, 2
    DIV EBX
    MOV DWORD[V], EAX
    
    PRINT_UDEC 4, [V]
    xor eax, eax
    ret
    
    PICK:
        PUSH EBP
        MOV  EBP, ESP
        
        ADD DWORD[ESP + 8], 2
        MOV EAX, [ESP + 8]
        
        
        MOV ESP, EBP
        POP EBP
    RET
    
    GCD:
    PUSH EBP
    MOV  EBP, ESP
    
    CMP DWORD[ESP + 8], 0
    JL .NEG_1
    .CONTINUE_NEG_1:
    
    CMP DWORD[ESP + 12], 0
    JL .NEG_2
    .CONTINUE_NEG_2:
    
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
    
    .NEG_1:
        NEG DWORD[ESP + 8]
        JMP .CONTINUE_NEG_1
        
    .NEG_2:
        NEG DWORD[ESP + 12]
        JMP .CONTINUE_NEG_2