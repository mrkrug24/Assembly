%include "io.inc"

;void helloworld(void) {
;    ...
;}

    
;.метка          для переходов jmp, j??, 
;имя_функции     для функций
        
section .text
global CMAIN
CMAIN:
    call helloworld  ; call <=> jmp метка
    
    
    xor eax, eax
    ret

    
        
helloworld:
    PRINT_STRING `Hello, world!`
    
    RET