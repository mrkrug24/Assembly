;switch
; Умнодить натуральное число на остаток при делении на 5

%include "io.inc"

section .rodata align=4
.LLL:
    dd .L0
    dd .L1
    dd .L2
    dd .L3
    dd .default

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp

    GET_DEC 4, eax

    push eax
    call switch
    pop eax
    
    PRINT_DEC 4, eax

    mov esp, ebp
    pop ebp
    xor eax, eax
    ret


switch:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    mov ecx, eax
    xor edx, edx
    mov ebx, 5
    div ebx
    mov eax, ecx
    jmp [.LLL + 4 * edx]

.L0:
    mul edx
    jmp .switch_exit

.L1:
    mul edx
    jmp .switch_exit
.L2:
    mul edx
    jmp .switch_exit
.L3:
    mul edx
    jmp .switch_exit
.default:
    mul edx
    jmp .switch_exit

.switch_exit:
    mov [ebp + 8], eax
    mov esp, ebp
    pop ebp
    ret