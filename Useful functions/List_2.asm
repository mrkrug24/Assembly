%include "io.inc"

section .bss
    n resd 1
    head resd 1
    first resd 1
    second resd 1
    
CEXTERN scanf
CEXTERN calloc
CEXTERN printf

section .rodata
    fmt db `%d `, 0
    
create_node:
    push ebp
    mov ebp, esp
    
    sub esp, 16
    mov dword[esp + 4], 4
    mov dword[esp], 2
    call calloc
    add esp, 16
    
    mov ecx, dword[ebp + 8]
    mov [eax], ecx
  
    mov esp, ebp
    pop ebp
    ret
    
    
push_front:
    push ebp
    mov ebp, esp
    
    mov ecx, dword[ebp + 8]; страрая голова
    mov eax, dword[ebp + 12]; новая

    mov [eax + 4], ecx

    mov esp, ebp
    pop ebp
    ret
   
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    push ebp 
    mov ebp, esp
    
    
    ; первая
    sub esp, 16
    mov dword[esp], 10
    call create_node
    add esp, 16
    
    sub esp, 16
    mov dword[esp + 4], eax ;новая
    mov eax, 0  ; старая
    mov dword[esp], eax
    call push_front
    add esp, 16
    mov dword[head], eax
    
    ;вторая
    sub esp, 16
    mov dword[esp], 20
    call create_node
    add esp, 16
    
    sub esp, 16
    mov dword[esp + 4], eax ;новая
    mov eax, dword[head]  ; старая
    mov dword[esp], eax
    call push_front
    add esp, 16
    mov dword[head], eax
    
    mov eax, dword[head]
    
    mov eax, dword[head]
    
    
    mov dword[n], 0
   
.for_n:
    cmp eax, 0
    je .exit_n
    
    inc dword[n]

    mov eax, [eax + 4]
    
    jmp .for_print
   
.exit_n:
    
    PRINT_DEC 4, n

    mov eax, dword[head]
    
.for_1:
    mov dword[first], eax


.for_2:
    cmp eax, 0
    je .exit_2
    mov eax, [eax + 4]
    jmp .for_2
    
.exit_2:
    mov dword[second], eax
    mov dword[head], eax
    
    
    jmp .for_1
    
    ;вывод
    ;mov eax, dword[head]

.for_print:
    cmp eax, 0
    je .exit_print
    
    mov ecx, [eax]
    PRINT_DEC 4, ecx
    PRINT_STRING '->'
    
    mov eax, [eax + 4]
    
    jmp .for_print
    
 
.exit_print:

    PRINT_STRING 'NULL'

    mov esp, ebp
    pop ebp
    xor eax, eax
    ret