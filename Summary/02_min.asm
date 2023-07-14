%include "io.inc"

; Требуется написать функцию, возращающую максимум двух чисел
;
;int max(int a, int b) {
;    return (a > b) ? a : b;
;}


section .data
    x dd 6
    y dd 5


section .text
global CMAIN
CMAIN:
    ; max(x, y)
    
    ; возвращаемое значение записывается в eax, либо в edx:eax
    
;    неправильно
;    --------
;    x
;    --------
;    y
;    --------
;    адрес возврата (действие call)
;    --------
;    сохраненный ebp
;    --------

;->
;    правильно
;    --------
;    y                                       EBP + 12
;    --------
;    x                                       EBP + 8
;    --------
;    адрес возврата (действие call)
;    --------
;    сохраненный ebp
;    --------

;!    формальные параметры
;!    фактические аргументы

    ; разместить аргументы функции на стеке без push (через mov)
    sub esp, 8          ; выделяем на стеке пространство для аргументов функции
    mov eax, [x]
    mov [ESP], eax
    mov eax, [y]
    mov [ESP+4], eax
    
    ; EBP != ESP
    ; ESP - адрес вершины стека
    
        
    ;push DWORD [y]
    ;push DWORD [x]
    
    call max2

    add esp, 8  ; перемещение ESP (откат) <=> pop, pop, только без присваивания куда-нибудь значений из вершины стека
    ;pop DWORD [x]
    ;pop DWORD [y]
    
    PRINT_STRING `max(x, y): `
    PRINT_DEC 4, eax
    NEWLINE

    


    xor eax, eax
    ret
    
; 1. пролог (сохранение стековых регистров, ebp <- esp для относительной адресации через ebp: ebp+4, ebp-8)
; 2. тело функции
; 3. эпилог (восстановление стековых регистров)   
    

max2:
    ; пролог
    push ebp
    mov ebp, esp
    
    ; тело функции
    PRINT_STRING `x: `
    PRINT_DEC 4, [EBP + 8]
    NEWLINE

    PRINT_STRING `y: `
    PRINT_DEC 4, [EBP + 12]
    NEWLINE
    
    mov eax, [EBP + 8]  ; eax <- x
    cmp eax, [EBP + 12] ; compare x, y
    cmovl eax, [EBP + 12]
    
    ;cmovg eax, ebx
    ;если eax > ebx, то eax := ebx

    ;cmovl eax, ebx
    ;если eax < ebx, то eax := ebx
    
    ;PRINT_STRING `eax: `
    ;PRINT_DEC 4, eax
    ;NEWLINE

    ; эпилог
    mov esp, ebp
    pop ebp
       
    ret