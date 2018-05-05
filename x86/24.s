#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 24
#------------------------------------------------------------------------------
# A permutation is an ordered arrangement of objects. For example, 3124 is one 
# possible permutation of the digits 1, 2, 3 and 4. If all of the permutations 
# are listed numerically or alphabetically, we call it lexicographic order. 
# The lexicographic permutations of 0, 1 and 2 are:
#
# 012   021   102   120   201   210
#
# What is the millionth lexicographic permutation of the digits 
# 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?
#------------------------------------------------------------------------------
# SOLUTION: 2783915460
#------------------------------------------------------------------------------
# as -32 24.s -o 24.o
# gcc -m32 24.o -o 24
#------------------------------------------------------------------------------

dec32_format_unsigned:
    .string "%u\n"

.section .text
.globl main

main:
    pushl   $0
    pushl   $1
    pushl   $2
    pushl   $3
    pushl   $4
    pushl   $5
    pushl   $6
    pushl   $7
    pushl   $8
    pushl   $9
    call    millionth_permutation
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
.type millionth_permutation, @ function

millionth_permutation:
    xor     %edi, %edi
    addl    $1, %edi

mp_next_perm:
    cmpl    $1000000, %edi    
    je      mp_done
    movl    %esp, %ecx
    addl    $8, %ecx
    movl    %esp, %ebx
    addl    $4, %ebx

mp_next:
    movl    (%ecx), %edx
    cmpl    %edx, -4(%ecx)
    jle     mp_next_skip
    pushl   %ebx
	
mp_next_compare:
    movl    (%ecx), %edx
    cmpl    %edx, (%ebx)
    jge     mp_next_continue
    addl    $4, %ebx
    jmp     mp_next_compare

mp_next_continue:
    movl    (%ebx), %edx
    movl    (%ecx), %eax
    movl    %eax, (%ebx)
    movl    %edx, (%ecx)
    popl    %ebx
    addl    $-4, %ecx

mp_next_compare2:
    cmpl    %ecx, %ebx
    jg      mp_next_done
    movl    (%ecx), %edx
    movl    (%ebx), %eax
    movl    %eax, (%ecx)
    movl    %edx, (%ebx)
    addl    $-4, %ecx
    addl    $4, %ebx
    jmp     mp_next_compare2

mp_next_done:
    incl    %edi
    jmp     mp_next_perm

mp_next_skip:
    addl    $4, %ecx
    jmp     mp_next

mp_done:
    xor     %eax, %eax
    movl    %esp, %ecx
    addl    $44, %ecx
    movl    $10, %ebx

mp_done_loop:
    addl    $-4, %ecx
    cmpl    %esp, %ecx
    je      mp_exit
    mul     %ebx
    addl    (%ecx), %eax
    jmp     mp_done_loop

mp_exit:
    ret
