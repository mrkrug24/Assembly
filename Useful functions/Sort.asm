%include "io.inc"

section .bss
    n resd 1
    arr resd 1
   
CEXTERN scanf
CEXTERN printf
CEXTERN calloc

section .rodata
    fmt_1 db `%d `, 0
    
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    push ebp 
    mov ebp, esp
    
    sub esp, 16
    mov dword[esp + 4], n
    mov dword[esp], fmt_1
    call scanf
    add esp, 16
    
    
    sub esp, 16
    mov dword[esp + 4], 4  ;размер 1 элемента
    mov eax, dword[n]
    mov dword[esp], eax   ;количество
    call calloc
    add esp, 16
    
    mov dword[arr], eax
    
    mov esi, 0

.for_input:
    cmp esi, dword[n]
    je .exit_input
    
    mov eax, esi
    shl eax, 2
    add eax, dword[arr]
    
    sub esp, 16
    mov dword[esp + 4], eax
    mov dword[esp], fmt_1
    call scanf
    add esp, 16
    
    inc esi
    jmp .for_input
    
.exit_input:
    mov esi, 0
    
.for_output:
    cmp esi, dword[n]
    je .exit_output
    
    mov eax, esi
    shl eax, 2
    add eax, dword[arr]
    mov eax, [eax]
    
    sub esp, 16
    mov dword[esp + 4], eax
    mov dword[esp], fmt_1
    call printf
    add esp, 16
    
    inc esi
    jmp .for_output
    
.exit_output:
;    sub esp, 16
;    mov eax, dword[a]
;    mov dword[esp + 4], eax
;    mov eax, dword[b]
;    mov dword[esp], eax
;    call sort
;    add esp, 16
;    
;    sub esp, 16
;    mov eax, dword[a]
;    mov dword[esp + 4], eax
;    mov eax, dword[b]
;    mov dword[esp], eax
;    call print_arr
;    add esp, 16
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret