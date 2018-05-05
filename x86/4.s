#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 4
#------------------------------------------------------------------------------
# A palindromic number reads the same both ways. 
# The largest palindrome made from the product of two 2-digit numbers is 
# 9009 = 91 * 99.
#
# Find the largest palindrome made from the product of two 3-digit numbers.
#------------------------------------------------------------------------------
# SOLUTION: 906609
#------------------------------------------------------------------------------
# as -32 4.s -o 4.o
# gcc -m32 4.o -o 4
#------------------------------------------------------------------------------

dec32_format:
    .string "%d\n"

hex32_format:
    .string "%x\n"

.section .text
.globl main

main:    
    call    find_palindrome
    pushl   %eax
    call    print32

#------------------------------------------------------------------------------
main_exit:
    xor     %eax, %eax
    incl    %eax
    xor     %ebx, %ebx
    incl    %ebx
    int     $0x80

#------------------------------------------------------------------------------
.type print_num, @ function

print32:
    pushl   4(%esp)
    pushl   $dec32_format
    call    printf
    addl    $8, %esp
    ret

#------------------------------------------------------------------------------
.type find_palindrome, @ function

find_palindrome:
    xor     %edi, %edi        # i
    movl    $99, %edi         # i = 99
    xor     %ecx, %ecx        # j
    xor     %ebx, %ebx        # greatest palindrome

fp_loop1:
    incl    %edi              # i++
    cmpl    $1000, %edi       # i < 1000
    jge     fp_exit           # else quit
    movl    %edi, %ecx        # j = i
    jmp     fp_loop2          # call j

fp_loop2:    
    incl    %ecx              # j++
    cmpl    $1000, %ecx       # j < 1000
    jge     fp_loop1          # go back to i loop
    movl    %edi, %eax        # low register = j
    mul     %ecx              # i * j
    pushl   %ebx              # save palindrome
    pushl   %edi              # save i
    pushl   %ecx              # save j
    pushl   %eax              # save and pass prod as parameter
    call    is_palindrome     # prod = palindrome?
    test    %eax, %eax        # test for false
    popl    %eax              # restores eax
    popl    %ecx              # restore j
    popl    %edi              # restore i
    popl    %ebx              # restore palindrome
    jz      fp_loop2          # if false continue
    cmpl    %ebx, %eax        # if prod < palindrome
    jl      fp_loop2          # continue
    movl    %eax, %ebx        # else palindrome = prod
    jmp     fp_loop2          # next j

fp_exit:
    movl    %ebx, %eax        # move palindrome to return register
    ret
  
#------------------------------------------------------------------------------
.type is_palindrome, @ function

is_palindrome:
    movl    $10, %ecx
    xor     %edi, %edi        # 10---->
    incl    %edi
    xor     %ebx, %ebx        # <----10
    incl    %ebx

ip_find_power:
    cmpl    4(%esp), %edi     # find the power of 10 that is greater than the number
    jg      ip_main_loop
    movl    $10, %eax
    mul     %edi
    movl    %eax, %edi
    jmp     ip_find_power

ip_main_loop:
    cmpl    %ebx, %edi        # quit when ebx and edi intersect
    jle     ip_yes
    xor     %edx, %edx        
    movl    %edi, %eax
    div     %ecx
    movl    %eax, %edi        # edi = edi/10
    movl    %ebx, %eax        
    mul     %ecx
    movl    %eax, %ebx        # ebx = ebx*10
    movl    4(%esp), %eax    
    div     %edi              # divide number by 10---->
    xor     %edx, %edx        
    div     %ecx              # mod by 10
    pushl   %edx              # edx is the rightmost digit    
    xor     %edx, %edx        
    movl    8(%esp), %eax
    div     %ebx              # mod by <----10
    pushl   %ebx
    pushl   %edx              # remainder
    xor     %edx, %edx        
    movl    %ebx, %eax
    div     %ecx
    movl    %eax, %ebx        # divide a copy of ebx by 10
    popl    %eax    
    xor     %edx, %edx
    div     %ebx              # divide remainder by said copy
    popl    %ebx            
    popl    %edx
    cmpl    %eax, %edx        # finally compares them
    jne     ip_no
    jmp     ip_main_loop
    
ip_yes:
    xor     %eax, %eax
    incl    %eax
    jmp     ip_exit

ip_no:
    xor     %eax, %eax

ip_exit:
    ret

