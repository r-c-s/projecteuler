#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 30
#------------------------------------------------------------------------------
# Surprisingly there are only three numbers that can be written as the sum of 
# fourth powers of their digits:
# 
# 1634 = 14 + 64 + 34 + 44
# 8208 = 84 + 24 + 04 + 84
# 9474 = 94 + 44 + 74 + 44
# As 1 = 14 is not a sum it is not included.
#
# The sum of these numbers is 1634 + 8208 + 9474 = 19316.
# 
# Find the sum of all the numbers that can be written as the sum of fifth 
# powers of their digits.
#------------------------------------------------------------------------------
# SOLUTION: 443839
#------------------------------------------------------------------------------
# as -32 30.s -o 30.o
# gcc -m32 30.o -o 30
#------------------------------------------------------------------------------

dec32_format:
    .string "%d\n"

.section .text
.globl main

main:
    call    find_sum
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
.type find_sum, @ function

find_sum:
    xor     %ebx, %ebx
    xor     %edi, %edi
    incl    %edi

fs_loop:
    incl    %edi
    cmpl    $1000000, %edi
    jge     fs_exit
    pushl   %ebx
    pushl   %edi
    call    sum_of_fifth_powers
    popl    %edi
    popl    %ebx
    cmpl    %edi, %eax
    jne     fs_loop
    addl    %edi, %ebx
    jmp     fs_loop

fs_exit:
    movl    %ebx, %eax
    ret

#------------------------------------------------------------------------------
.type sum_of_fifth_powers, @ function

sum_of_fifth_powers:
    xor     %ebx, %ebx
    movl    $10, %ecx
    movl    $1, %eax

sofp_power_of_ten:
    cmpl    4(%esp), %edi
    jg      sofp_loop
    mul     %ecx
    movl    %eax, %edi
    jmp     sofp_power_of_ten

sofp_loop:
    movl    %edi, %eax
    movl    $10, %ecx
    xor     %edx, %edx
    div     %ecx
    movl    %eax, %edi
    cmpl    $0, %edi
    jle     sofp_exit
    
    movl    4(%esp), %eax
    xor     %edx, %edx
    div     %edi            # / 10
    xor     %edx, %edx
    div     %ecx            # % 10    

    pushl   %ebx
    pushl   %edi
    pushl   %edx            # digit
    pushl   $5
    call    power
    addl    $4, %esp
    popl    %edx
    popl    %edi
    popl    %ebx

    addl    %eax, %ebx
    jmp     sofp_loop

sofp_exit:
    movl    %ebx, %eax
    ret

#------------------------------------------------------------------------------
.type power, @ function

power:
    movl    8(%esp), %ecx
    movl    %ecx, %eax
    movl    4(%esp), %edi

p_loop:
    decl    %edi
    cmpl    $0, %edi
    je      p_exit
    mul     %ecx
    jmp     p_loop

p_exit:
    ret
