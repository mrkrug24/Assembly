%include "io.inc"

section .bss
    n resd 1
    k resd 1
    i resd 1
    j resd 1
    cnt resd 1
    tmp resd 1
    size resd 1
    pascals_triangle resq 1024

section .data
    ans dd 0
    zero_left dd 0
    cnt_right dd 0

section .text
global CMAIN
CMAIN:
    GET_UDEC 4, n
    GET_UDEC 4, k
    
;нахождение длины n в двоичном представлении (size)
    mov ecx, 0
    mov eax, [n]
.for_0:
    cmp eax, 0
    jne .if_0
    jmp .else_0
.if_0:
    shr eax, 1
    inc ecx
    jmp .for_0
.else_0:
    dec ecx
    mov [size], ecx
    inc dword[size]

;сравнение длины n в двоичном представлении и k (если size <= k, то таких чисел нет ans = 0)
    mov eax, [size]
    cmp eax, [k]
    jle .exit_4

;подcчет количества нулей в двоичном представлении n (zero_left)
    mov eax, [n]
    mov ebx, 2

.for_zero:
    cmp eax, 0
    je .exit_zero
    xor edx, edx
    div ebx

    cmp edx, 0
    je .if_zero
    jmp .for_zero

.if_zero:
    inc dword[zero_left]
    jmp .for_zero
.exit_zero:

;проверка самого числа n (если zero_left = k, то ans += 1)
    mov eax, [k]
    cmp eax, [zero_left]
    je .add_self
    jmp .else_add
.add_self:
    inc dword[ans]
.else_add:

;построение треугольника Паскаля (первая строка - 1, 1)
    mov dword[pascals_triangle], 1
    mov dword[pascals_triangle + 4], 1
    
    mov dword[i], 1    ;строка
    mov dword[j], 0    ;столбец
    mov dword[cnt], 2

.for_1:
    mov eax, [size]
    cmp dword[i], eax
    jl .if_1
    jmp .else_1

.if_1:
    mov eax, [j]
    cmp eax, 0

    je .if_2
    jmp .else_2

.if_2:
    mov eax, [i]
    mov ebx, 128
    mul ebx
    mov ebx, [j]
    mov dword[pascals_triangle + eax + 4 * ebx], 1
    inc dword[j]
    jmp .for_1

.else_2:
    mov eax, [cnt]
    cmp eax, [j]
    je .if_3
    jmp .else_3

.if_3:
    mov eax, [i]
    mov ebx, 128
    mul ebx
    mov ebx, [j]
    mov dword[pascals_triangle + eax + 4 * ebx], 1
    mov dword[j], 0
    inc dword[i]
    inc dword[cnt]
    jmp .for_1

.else_3:
    mov eax, [i]
    dec eax
    mov ebx, 128
    mul ebx
    mov ebx, [j]
    dec ebx

    mov ecx, dword[pascals_triangle + eax + 4 * ebx]
    inc ebx
    add ecx, dword[pascals_triangle + eax + 4 * ebx]

    mov eax, [i]
    mov ebx, 128
    mul ebx

    mov ebx, [j]
    mov dword[pascals_triangle + eax + 4 * ebx], ecx
    inc dword[j]
    jmp .for_1
.else_1:

;подсчет количества чисел, удовлетворяющих условию и длина которых в двоичном представлении меньше длины n
    mov eax, [size]
    sub eax, 2
    mov ebx, 128
    mul ebx
    mov ebx, [k]
    inc ebx

    mov eax, dword[pascals_triangle + eax + 4 * ebx]
    add dword[ans], eax

;подсчет количества чисел, удовлетворяющих условию и длина которых в двоичном представлении равна длине n
    mov dword[cnt_right], 0
    mov eax, [n]
    mov dword[tmp], eax

.for_4:
    mov eax, [tmp]
    cmp eax, 1
    je .exit_4
    xor edx, edx
    mov ebx, 2
    div ebx
    mov dword[tmp], eax

    cmp edx, 0
    je .if_4
    jmp .else_4

.if_4:
    dec dword[zero_left]
    inc dword[cnt_right]
    jmp .for_4

.else_4:
    mov eax, [k]
    cmp eax, [zero_left]
    jle .elseif

    mov eax, [k]
    sub eax, [zero_left]
    dec eax

    cmp eax, [cnt_right]
    jg .elseif


    mov eax, [cnt_right]
    dec eax
    mov ebx, 128
    mul ebx

    mov ebx, [k]
    sub ebx, [zero_left]
    dec ebx

    mov eax, dword[pascals_triangle + eax + 4 * ebx]
    add dword[ans], eax

.elseif:
    inc dword[cnt_right]
    jmp .for_4
.exit_4:

    PRINT_DEC 4, ans
    xor eax, eax
    ret