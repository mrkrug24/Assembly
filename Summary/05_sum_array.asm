%include "io.inc"

; Требуется написать функцию, возвращающую сумму элементов массива
; признак окончания ввода - 0


;int array_sum(int* x, int n) {
;    int sum = 0;
;    
;    for (int i = 0; i < n; i++) {
;        sum += x[i];
;    }
;    
;    return sum;
;}

N EQU 100

section .bss
    x resd N
    sum resd 1


section .text
global CMAIN
CMAIN:
    MOV ECX, 0
    
.input_for:
    GET_DEC 4, eax
    CMP eax, 0
    JE .input_end ; окончание ввода
    
    MOV [x + ECX * 4], eax
    INC ECX
    JMP .input_for

.input_end:

    MOV EDX, ECX ; в EDX запишем фактическую длину массива (кол-во добавленных элементов) 
    
    MOV ECX, 0

.print_for:    
    PRINT_DEC 4, [x + ECX * 4]
    PRINT_STRING ` `
    INC ECX
    CMP ECX, EDX
    JL .print_for

    NEWLINE    
    
    MOV eax, 42
    MOV ecx, 100500
    
    ; optional
    push eax
    push ecx
    
    push edx        ; n (длина массива)
    push x          ; x (адрес начала массива) 
    
    CALL array_sum
    
    mov DWORD[sum], eax     ; сохранили return функции

    add esp, 8      ; откат
    pop ecx
    pop eax

    PRINT_STRING `old eax: `
    PRINT_DEC 4, eax
    NEWLINE
    
    PRINT_STRING `old ecx: `
    PRINT_DEC 4, ecx
    NEWLINE

    PRINT_STRING `sum =`
    PRINT_DEC 4, [sum]
    NEWLINE
   
    xor eax, eax
    ret

; НЕ ИСПОЛЬЗОВАТЬ (чит)!    
;pushad  push all dwords (всех регистров)
;popad   pop  all dwords
        
                        
array_sum:    
    push ebp
    mov ebp, esp
    
    push esi
    push edi

    mov esi, [EBP + 8]   ; esi <- x
    mov edi, [EBP + 12]  ; edi <- n
    
    MOV eax, 0
    
    MOV ECX, 0
    
.sum_for:
    ADD eax, [esi + ECX * 4]
    INC ecx
    CMP ecx, edi
    JL .sum_for    
    
    PRINT_STRING `n =`
    PRINT_DEC 4, [EBP + 12]
    NEWLINE
    
    pop edi
    pop esi
    
    mov esp, ebp
    pop ebp
    
    ret