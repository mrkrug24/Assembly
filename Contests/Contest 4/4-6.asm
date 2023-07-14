%include "io.inc"

section .bss
    n resd 1
    arr resd 1
    cnt resd 1
    x resd 1

CEXTERN scanf
CEXTERN fprintf
CEXTERN calloc
CEXTERN get_stdout

section .rodata
    fmt_0 db `%d`, 0
    fmt_1 db `%d\n`, 0

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

    sub esp, 16
    mov eax, dword[n]
    mov dword[esp + 4], 4
    mov dword[esp], eax
    call calloc
    add esp, 16

    mov dword[arr], eax
    mov dword[cnt], 0

.for_0:
    mov ecx, dword[cnt]
    cmp ecx, dword[n]
    je .exit_0

    sub esp, 16
    mov dword[esp + 4], x
    mov dword[esp], fmt_0
    call scanf
    add esp, 16

    mov eax, dword[cnt]

    mov ecx, dword[x]
    mov edx, dword[arr]
    mov dword[edx + 4 * eax], ecx

    inc dword[cnt]
    jmp .for_0

.exit_0:
    ; apply(array, length, fprintf, 2, stdout, "%d\n").
    
    sub esp, 16
    call get_stdout
    add esp, 16

    mov edx, dword[n]
    
    sub esp, 32
    mov dword[esp + 20], fmt_1 
    mov dword[esp + 16], eax
    mov dword[esp + 12], 2      
    mov dword[esp + 8], fprintf 
    mov dword[esp + 4], edx     
    mov eax, dword[arr]
    mov dword[esp], eax         
    call apply                  
    add esp, 32                 
   
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret

apply:
    push ebp
    mov ebp, esp
    push esi
    push edi
    push ebx
    
    mov esi, 0
    
.for_1:
    cmp esi, dword[ebp + 12]
    je .exit_1

    mov eax, esi
    shl eax, 2
    add eax, dword[ebp + 8]
    mov eax, [eax]
    
    sub esp, 16
    mov dword[esp + 8], eax
    
    mov eax, dword[ebp + 28]
    mov dword[esp + 4], eax

    mov eax, dword[ebp + 24]
    mov dword[esp], eax

    mov eax, dword[ebp + 16]
    call eax
    add esp, 16

    inc esi
    jmp .for_1

.exit_1:
    pop ebx
    pop edi
    pop esi
    mov esp, ebp
    pop ebp
    ret