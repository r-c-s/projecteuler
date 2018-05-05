#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 36
#------------------------------------------------------------------------------
# The decimal number, 585 = 1001001001 (binary), is palindromic in both bases.
#
# Find the sum of all numbers, less than one million, which are palindromic in
# base 10 and base 2.
#
# (Please note that the palindromic number, in either base, may not include
# leading zeros.)
#------------------------------------------------------------------------------
# SOLUTION: 872187
#------------------------------------------------------------------------------
# as -32 36.s -o 36.o
# gcc -m32 36.o -o 36
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
    xor     %edi, %edi
    xor     %ebx, %ebx

fs_loop:
    incl    %edi
    cmpl    $1000000, %edi
    jge     fs_exit
    pushl   %ebx
    pushl   %edi
    call    is_palindrome_2
    popl    %edi
    popl    %ebx
    cmpl    $1, %eax
    jne     fs_loop
    pushl   %ebx
    pushl   %edi
    call    is_palindrome_10
    popl    %edi
    popl    %ebx
    cmpl    $1, %eax
    jne     fs_loop
    addl    %edi, %ebx
    jmp     fs_loop    

fs_exit:
    movl    %ebx, %eax
    ret

#------------------------------------------------------------------------------
.type is_palindrome_2, @ function

is_palindrome_2:
    movl    4(%esp), %ebx       # ebx is the candidate
    movl    $0x80000000, %edx   # tracks rightmost bit of candidate
    movl    $0x00000001, %ecx   # leftmost bit starts at 1

ip2_first_bit:    
    pushl   %ebx                # save candidate
    and     %edx, %ebx          # get the 4 bits
    cmpl    $0, %ebx            # check if bit is at least 1
    popl    %ebx                # restores candidate
    jg      ip2_main_loop       # if bit is at least one go to main loop
    shr     $1, %edx            # else shift left edx
    jmp     ip2_first_bit    

ip2_main_loop:
    cmpl    %ecx, %edx          # test if edx and ecx intersect
    jbe     ip2_yes             # if it did, it's a palindrome
    movl    %ebx, %eax
    movl    %ebx, %edi
    and     %edx, %eax          # get rightmost 4 bits
    and     %ecx, %edi          # get leftmost 4 bits

ip2_shift_right_eax:
    cmpl    $0, %eax
    je      ip2_shift_right_edi
    pushl   %eax
    and     $0x00000001, %eax
    cmpl    $0, %eax
    popl    %eax
    jg      ip2_shift_right_edi
    shr     $1, %eax
    jmp     ip2_shift_right_eax

ip2_shift_right_edi:    
    cmpl    $0, %edi
    je      ip2_compare
    pushl   %edi
    and     $0x00000001, %edi
    cmpl    $0, %edi
    popl    %edi
    jg      ip2_compare
    shr     $1, %edi
    jmp     ip2_shift_right_edi

ip2_compare:
    cmp     %eax, %edi
    jne     ip2_no
    shr     $1, %edx
    shl     $1, %ecx
    jmp     ip2_main_loop

ip2_yes:
    xor     %eax, %eax
    incl    %eax
    jmp     ip2_exit

ip2_no:
    xor     %eax, %eax

ip2_exit:
    ret

#------------------------------------------------------------------------------
.type is_palindrome_10, @ function

is_palindrome_10:
    movl    $10, %ecx
    xor     %edi, %edi        # 10---->
    incl    %edi
    xor     %ebx, %ebx        # <----10
    incl    %ebx

ip10_find_power:
    cmpl    4(%esp), %edi     # find the power of 10 that is greater than the number
    jg      ip10_main_loop
    movl    $10, %eax
    mul     %edi
    movl    %eax, %edi
    jmp     ip10_find_power

ip10_main_loop:
    cmpl    %ebx, %edi        # quit when ebx and edi intersect
    jle     ip10_yes
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
    jne     ip10_no
    jmp     ip10_main_loop
    
ip10_yes:
    xor     %eax, %eax
    incl    %eax
    jmp     ip10_exit

ip10_no:
    xor     %eax, %eax

ip10_exit:
    ret
