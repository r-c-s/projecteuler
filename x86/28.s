#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 28
#------------------------------------------------------------------------------
# Starting with the number 1 and moving to the right in a clockwise direction 
# a 5 by 5 spiral is formed as follows:
# 
# 21 22 23 24 25
# 20  7  8  9 10
# 19  6  1  2 11
# 18  5  4  3 12
# 17 16 15 14 13
# 
# It can be verified that the sum of the numbers on the diagonals is 101.
# 
# What is the sum of the numbers on the diagonals in a 1001 by 1001 spiral 
# formed in the same way?
#------------------------------------------------------------------------------
# SOLUTION: 669171001
#------------------------------------------------------------------------------
# as -32 28.s -o 28.o
# gcc -m32 28.o -o 28
#------------------------------------------------------------------------------

dec32_format_unsigned:
    .string "%u\n"

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
    pushl   $dec32_format_unsigned
    call    printf
    addl    $8, %esp
    ret

#------------------------------------------------------------------------------
.type find_sum, @ function

find_sum:
    xor     %edi, %edi
    addl    $1, %edi
    xor     %ebx, %ebx        # step
    xor     %eax, %eax        # sum
    incl    %eax

fs_loop:
    cmpl    $1002001, %edi
    jge     fs_exit
    addl    $2, %ebx
    xor     %ecx, %ecx
    
fs_inner_loop:
    cmpl    $4, %ecx
    je      fs_loop
    addl    %ebx, %edi
    addl    %edi, %eax
    incl    %ecx
    jmp     fs_inner_loop    

fs_exit:
    ret
