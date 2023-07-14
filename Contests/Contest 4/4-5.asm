%include "io.inc"

section .bss
    n resd 1
    k resd 1
    x resd 1
    cnt resd 1
    mtrx resd 1

    i resd 1
    j resd 1
    trace resq 1

    ans_mtrx resd 1
    ans_trace resq 1
    ans_size resd 1

CEXTERN scanf
CEXTERN printf
CEXTERN calloc
CEXTERN free

section .rodata
    fmt_0 db `%d`, 0
    fmt_1 db `%d `, 0
    fmt_2 db `\n`, 0

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp

    sub esp, 16
    mov dword[esp + 4], n
    mov dword[esp], fmt_0
    call scanf
    add esp, 16

    mov dword[cnt], 0

.for_main:
    mov eax, dword[cnt]
    cmp eax, dword[n]
    je .exit_main

    sub esp, 16
    mov dword[esp + 4], k
    mov dword[esp], fmt_0
    call scanf
    add esp, 16

    mov eax, dword[k]
    mul eax

    sub esp, 16
    mov dword[esp + 4], 4
    mov dword[esp], eax
    call calloc
    add esp, 16
    mov dword[mtrx], eax

    mov dword[i], 0
    mov dword[j], 0 

    mov dword[trace], 0
    mov dword[trace + 4], 0

.for_scan_i:
    mov eax, dword[i]
    cmp eax, dword[k]
    je .exit_scan

.for_scan_j:
    mov eax, dword[j]
    cmp eax, dword[k]
    je .if_scan_j
    jmp .else_scan_j

.if_scan_j:
    inc dword[i]
    mov dword[j], 0
    jmp .for_scan_i
    
.else_scan_j:
    sub esp, 16
    mov dword[esp + 4], x
    mov dword[esp], fmt_0
    call scanf
    add esp, 16

    mov eax, dword[i]
    mov ecx, dword[k]
    mul ecx  
    add eax, dword[j]
    mov ecx, dword[x]
   
    mov edx, dword[mtrx]
    mov dword[edx + 4 * eax], ecx
    
    mov eax, dword[i]
    cmp eax, dword[j]
    je .if_add_trace
    jmp .else_trace

.if_add_trace:
    mov eax, dword[x]
    cdq
    add dword[trace], eax
    adc dword[trace + 4], edx

.else_trace:
    inc dword[j]
    jmp .for_scan_j

.exit_scan:

    mov eax, dword[cnt]
    cmp eax, 0
    je .if_first
    jmp .else_first

.if_first:
    mov eax, dword[mtrx]
    mov dword[ans_mtrx], eax
    mov eax, dword[k]
    mov dword[ans_size], eax
    mov eax, dword[trace + 4]
    mov dword[ans_trace + 4], eax
    mov eax, dword[trace]
    mov dword[ans_trace], eax

.else_first:
    mov eax, dword[ans_trace + 4]
    cmp eax, dword[trace + 4]
    jg .else_new
    jl .if_new
    
    mov eax, dword[ans_trace]
    cmp eax, dword[trace]
    jae .else_new
    
.if_new:
    mov eax, dword[mtrx]
    mov dword[ans_mtrx], eax
    mov eax, dword[k]
    mov dword[ans_size], eax
    mov eax, dword[trace + 4]
    mov dword[ans_trace + 4], eax
    mov eax, dword[trace]
    mov dword[ans_trace], eax
    inc dword[cnt]
    jmp .for_main

.else_new:
    inc dword[cnt]
    ; sub esp, 16
    ; mov eax, dword[mtrx]
    ; mov dword[esp], eax
    ; call free
    ; add esp, 16
    jmp .for_main

.exit_main:

    mov dword[i], 0
    mov dword[j], 0 
    
.for_print_i:
    mov eax, dword[i]
    cmp eax, dword[ans_size]
    je .exit_print

.for_print_j:
    mov eax, dword[j]
    cmp eax, dword[ans_size]
    je .if_print_j
    jmp .else_print_j

.if_print_j:
    inc dword[i]
    mov dword[j], 0

    sub esp, 16 
    mov dword[esp], fmt_2
    call printf
    add esp, 16

    jmp .for_print_i
    
.else_print_j:
    mov eax, dword[i]
    mov ecx, dword[ans_size]
    mul ecx  
    add eax, dword[j]
    shl eax, 2
    add eax, dword[ans_mtrx]
    mov eax, [eax]
   
    sub esp, 16
    mov dword[esp + 4], eax
    mov dword[esp], fmt_1
    call printf
    add esp, 16
    
    inc dword[j]
    jmp .for_print_j

.exit_print:
    ; sub esp, 16
    ; mov eax, dword[ans_mtrx]
    ; mov dword[esp], eax
    ; call free
    ; add esp, 16

    mov esp, ebp
    pop ebp
    xor eax, eax
    ret