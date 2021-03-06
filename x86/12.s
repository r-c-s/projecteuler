#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 12
#------------------------------------------------------------------------------
# The sequence of triangle numbers is generated by adding the natural numbers.
# So the 7th triangle number would be 1 + 2 + 3 + 4 + 5 + 6 + 7 = 28. The first 
# ten terms would be:
# 
# 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
#
# Let us list the factors of the first seven triangle numbers:
#
#  1: 1
#  3: 1,3
#  6: 1,2,3,6
# 10: 1,2,5,10
# 15: 1,3,5,15
# 21: 1,3,7,21
# 28: 1,2,4,7,14,28
# We can see that 28 is the first triangle number to have over five divisors.
#
# What is the value of the first triangle number to have over five hundred 
# divisors?
#------------------------------------------------------------------------------
# SOLUTION: 76576500
#------------------------------------------------------------------------------
# as -32 12.s -o 12.o
# gcc -m32 12.o -o 12
#------------------------------------------------------------------------------

dec32_format:
    .string "%d\n"

.section .text
.globl main

main:
    call    find_num
    pushl   %eax
    call    print32

#------------------------------------------------------------------------------
main_exit:
    xor     %eax, %eax
    incl    %eax
    xor     %ebx, %ebx
    int     $0x80

#------------------------------------------------------------------------------
.type print32, @ function

print32:
    pushl   4(%esp)
    pushl   $dec32_format
    call    printf
    addl    $8, %esp
    ret

#------------------------------------------------------------------------------
.type find_num, @ function

find_num:
    xor     %edi, %edi
    xor     %ecx, %ecx

fn_loop:
    incl    %edi
    addl    %edi, %ecx
    pushl   %edi
    pushl   %ecx
    call    number_of_divisors
    popl    %ecx
    popl    %edi
    cmpl    $500, %eax
    jl      fn_loop
    
fn_exit:
    movl    %ecx, %eax
    ret        

#------------------------------------------------------------------------------
.type number_of_divisors, @ function

number_of_divisors:
    movl    4(%esp), %ebx
    pushl   $0
    pushl   %ebx
    call    sqrt_approx
    popl    %ebx
    popl    %ecx
    movl    %eax, %ecx
    xor     %edx, %edx
    movl    $2, %edx        # 1 and itself
    xor     %edi, %edi
    movl    $1, %edi
    
nod_loop:
    incl    %edi
    cmpl    %ecx, %edi
    jge     nod_exit
    pushl   %edx
    xor     %edx, %edx
    movl    %ebx, %eax
    divl    %edi
    cmpl    $0, %edx
    popl    %edx
    jne     nod_loop
    addl    $2, %edx
    jmp     nod_loop

nod_exit:
    movl    %edx, %eax
    ret

#------------------------------------------------------------------------------
.type sqrt_approx, @function

sqrt_approx:
    xor     %edx, %edx
    xor     %edi, %edi        
    incl    %edi

sqrt_loop:
    movl    %edi, %eax         
    mul     %eax        
    cmpl    8(%esp), %edx 
    jl      continue        
    cmpl    4(%esp), %eax
    jge     sqrt_exit    

continue:
    incl    %edi    
    jmp     sqrt_loop

sqrt_exit:
    movl    %edi, %eax    
    ret
