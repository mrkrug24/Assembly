%include "io.inc"

section .bss
    x resd 1
    y resd 1

; Требуется реализовать функцию 
;void swap(int* x, int* y) {
;    int* tmp = x;
;    *x = *y;
;    *y = *tmp;
;}


section .text
global CMAIN
CMAIN:
    GET_DEC 4, [x]
    GET_DEC 4, [y]
    
    PRINT_STRING `x: ` 
    PRINT_DEC 4, [x]
    NEWLINE

    PRINT_STRING `y: ` 
    PRINT_DEC 4, [y]
    NEWLINE
    
    ; eax не сохраняем, если нет необходимости (не хранилость значимых данных)   
    push eax

    push y  ; можно, т.к. адрес - dword (32 бита, разрядность архитектуры 32); 
            ; либо push dword y
    push x
    
    ;push x      ; адрес переменной x
    ;push dword [x]    ; значение переменной x 
    
    ; на стек необходимо передать адреса(!) переменных x, y

                          
    call swap
    
    ; сохраняем return ф-ии (полученный в eax) куда-нибудь
   
    add esp, 8

    pop eax ; восстанавливаем eax, которое было до вызова функции    
 
    NEWLINE
    
    PRINT_STRING `x: ` 
    PRINT_DEC 4, [x]
    NEWLINE

    PRINT_STRING `y: ` 
    PRINT_DEC 4, [y]
    NEWLINE    
   
    xor eax, eax
    ret
    
    
swap:
    push ebp
    mov ebp, esp

    ; сохраняем значения регистров
    push esi
    push edi
    push ebx

    mov esi, [EBP + 8]   ; адрес переменной x
    mov edi, [EBP + 12]  ; адрес переменной y

    NEWLINE
    PRINT_STRING `[x]: `
    PRINT_DEC 4, [esi];
    NEWLINE
    PRINT_STRING `[y]: `
    PRINT_DEC 4, [edi];
    NEWLINE
    
    mov ebx, [esi]
    mov eax, [edi]

    mov [esi], eax
    mov [edi], ebx
    
    ; восстанавливаем значения регистров
    pop ebx
    pop edi
    pop esi
    
    mov esp, ebp
    pop ebp

    ret