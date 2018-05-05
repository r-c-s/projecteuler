#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 35
#------------------------------------------------------------------------------
# The number, 197, is called a circular prime because all rotations of the 
# digits: 197, 971, and 719, are themselves prime.
#
# There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37,
# 71, 73, 79, and 97.
#
# How many circular primes are there below one million?
#------------------------------------------------------------------------------
# SOLUTION: 55
#------------------------------------------------------------------------------
# as -32 35.s -o 35.o
# gcc -m32 35.o -o 35
#------------------------------------------------------------------------------

dec32_format:
    .string "%d\n"

.section .text
.globl main

main:
    pushl   $1000000
    call    circular_primes
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
.type circular_primes, @ function

circular_primes:
    xor     %edi, %edi
    addl    $1, %edi
    xor     %ebx, %ebx
    incl    %ebx            # 2

cp_loop:
    addl    $2, %edi        # odd numbers only
    cmpl    4(%esp), %edi
    jge     cp_exit
    pushl   %ebx
    pushl   %edi
    call    is_a_circular_prime
    popl    %edi
    popl    %ebx
    cmpl    $0, %eax
    je      cp_loop
    incl    %ebx
    jmp     cp_loop

cp_exit:
    movl    %ebx, %eax
    ret
    
#------------------------------------------------------------------------------
.type is_a_circular_prime, @ function

is_a_circular_prime:
    xor     %ecx, %ecx
    addl    $10, %ecx
    xor     %eax, %eax
    addl    $1, %eax
    movl    4(%esp), %edi

iacp_power:
    cmpl    %edi, %eax
    jg      iacp_skip
    mul     %ecx
    jmp     iacp_power

iacp_skip:
    xor     %edx, %edx
    div     %ecx
    movl    %eax, %ebx

iacp_loop:
    movl    %edi, %eax
    movl    $10, %ecx
    xor     %edx, %edx
    div     %ecx
    movl    %eax, %edi
    movl    %edx, %eax
    xor     %edx, %edx
    mul     %ebx
    addl    %eax, %edi
    pushl   %ebx
    pushl   %edi
    call    is_prime
    popl    %edi
    popl    %ebx
    cmpl    $0, %eax
    je      iacp_no
    cmpl    4(%esp), %edi
    je      iacp_yes
    jmp     iacp_loop

iacp_yes:
    xor     %eax, %eax
    incl    %eax
    jmp     iacp_exit

iacp_no:
    xor     %eax, %eax

iacp_exit:
    ret

#------------------------------------------------------------------------------
.type is_prime, @function

is_prime:
    pushl   %ebp            # save old base pointer
    movl    %esp, %ebp      # create new stack pointer
    cmpl    $2, 8(%ebp)     # compares argument to 2
    je      yes             # if it's equal it's prime
    jl      no              # if it's less than it's not prime
    movl    8(%ebp), %eax    
    andl    $1, %eax        # check if it's even
    cmpl    $0, %eax
    je      no
    pushl   $0              # high part of parameter
    pushl   8(%ebp)         # low part of parameter
    call    sqrt_approx     # call sqrt function
    addl    $8, %esp        # restores sp
    movl    %eax, %ecx      # assigns sqrt to ecx
    movl    $3, %edi        # i = 3

prime_loop:
    cmpl    %ecx, %edi      # i >= sqrt(arg) ?
    jg      yes             # quit if it is
    xor     %edx, %edx      # higher part of dividend
    movl    8(%ebp), %eax   # lower part of dividend
    divl    %edi            # divides current by index
    test    %edx, %edx      # checks if remainder is 0
    jz      no              # if it is it's not a prime
    addl    $2, %edi        # index+=2
    jmp     prime_loop      # do it again

yes:
    xor     %eax, %eax      # clears register
    inc     %eax            # sets result to "true"
    jmp     prime_exit      # exits

no:
    xor     %eax, %eax      # sets result to "false"

prime_exit:
    movl    %ebp, %esp      # stack pointer
    popl    %ebp            # restores base pointer
    ret

#------------------------------------------------------------------------------
.type sqrt_approx, @function

sqrt_approx:
    xor     %edi, %edi      # index/sqrt candidate
    incl    %edi

sqrt_loop:
    movl    %edi, %eax      # move sqrt into required mul register
    mul     %eax            # multiply said register by itself
    cmpl    8(%esp), %edx   # compare high part of result with high part of number
    jl      continue        # skip next statements if it's less than
    cmpl    4(%esp), %eax   # compare low part of result with low part of number
    jae     sqrt_exit       # if it's greater than or equal leave

continue:
    incl    %edi            # else increment sqrt
    jmp     sqrt_loop       # do it again

sqrt_exit:
    movl    %edi, %eax      # move sqrt value into return register    
    ret
    














