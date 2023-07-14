section .data
    const_1 dq 1.0
    const_3 dq 3.0
    const_4 dq 4.0
    const_6 dq 6.0
    const_8 dq -8.0
    const_24 dq 24
   
; fx_y означает, что это функция номер x (1,2 или 3), а y означает порядок производной (0 - сама функция, 1 - первая производная)
section .text
    global f1_0
    global f1_1
    global f2_0
    global f2_1
    global f3_0
    global f3_1

; f1_0 = 1 + 4 / (1 + x ^ 2)
f1_0:                       
    push ebp
    mov ebp, esp
    
    fld qword[ebp + 8]
    fld qword[ebp + 8]
    fmulp      
    fld qword[const_1]             
    faddp
    fld qword[const_4] 
    fdivrp
    fld qword[const_1]     
    faddp          
    
    leave
    ret

; f1_1 = -8x / (1 + x ^ 2) ^ 2
f1_1:
    push ebp
    mov ebp, esp
    
    fld qword[ebp + 8]
    fld qword[ebp + 8]
    fmulp      
    fld qword[const_1]             
    faddp
    fld qword[ebp + 8]
    fld qword[ebp + 8]
    fmulp      
    fld qword[const_1]             
    faddp
    fmulp
    fld qword[ebp + 8]
    fld qword[const_8]    
    fmulp   
    fdivrp
    
    leave
    ret

; f2_0 = x ^ 3
f2_0:
    push ebp
    mov ebp, esp
    
    fld qword[ebp + 8]
    fld qword[ebp + 8]
    fld qword[ebp + 8]
    fmulp                   
    fmulp                   
    fstp st1
    
    leave
    ret

; f2_1 = 3x ^ 2
f2_1:
    push ebp
    mov ebp, esp
    
    fld qword[ebp + 8]
    fld qword[ebp + 8]
    fld qword[const_3]
    fmulp                   
    fmulp                   
    fstp st1
    
    leave
    ret

; f3_0 = 2 ^ (-x)
f3_0:
    push ebp
    mov ebp, esp
    
    fld qword[ebp + 8]
    fchs                    
    fldln2
    fmulp                  
    fldl2e
    fmul
    fld st0
    frndint
    fsub st1, st0
    fxch st1
    f2xm1
    fld1
    fadd
    fscale
    fstp st1
    
    leave
    ret

; f3_1 = -ln(2) / (2 ^ x)
f3_1:
    push ebp
    mov ebp, esp
    
    fld qword[ebp + 8]
    fchs                 
    fldln2
    fmulp                  
    fldl2e
    fmul
    fld st0
    frndint
    fsub st1, st0
    fxch st1
    f2xm1
    fld1
    fadd
    fscale
    fchs
    fldln2
    fmulp
    fstp st1
    
    leave
    ret