%include "io.inc"

section .bss
    N RESD 1
    K RESD 1
    X RESD 1000

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    GET_UDEC 4, [N]
    XOR ECX, ECX
    .READ:
        CMP ECX, [N]
        JE .END_OF_READ
        GET_UDEC 4, EDX
        MOV [X + 4 * ECX], EDX
        INC ECX
        JMP .READ

    .END_OF_READ:
    
    GET_UDEC 4, [K]
    
    XOR ECX, ECX
    XOR EDX, EDX
    
    .COUNT:
        CMP EDX, [N]
        JE .END
        PUSH DWORD[X + 4 * EDX]
        CALL COUNT
        POP DWORD[X + 4 * EDX]
        CMP EAX, [K]
        JE .ADD
        .CONTINUE_ADD:
        INC EDX
        JMP .COUNT
    
    .ADD:
        INC ECX
        JMP .CONTINUE_ADD
    
    .END:
    PRINT_UDEC 4, ECX
        
    xor eax, eax
    ret
    
    COUNT:
        PUSH EBP
        MOV  EBP, ESP
        
        PUSH ESI
        
        XOR EAX, EAX
        .COUNT_FUNC:
            MOV ESI, [ESP + 12]
            AND ESI, 1
            CMP ESI, 0
            JE .ZERO
            .CONTINUE_ZERO:
            SHR DWORD[ESP + 12], 1
            CMP DWORD[ESP + 12], 0
            JNE .COUNT_FUNC
            JMP .END_OF_FUNC
            
        .ZERO:
            INC EAX
            JMP .CONTINUE_ZERO
         
        .END_OF_FUNC:
            POP ESI
            
            MOV ESP, EBP
            POP EBP
    RET