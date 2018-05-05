#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 37
#------------------------------------------------------------------------------
# The number 3797 has an interesting property. Being prime itself, it is
# possible to continuously remove digits from left to right, and remain prime
# at each stage: 3797, 797, 97, and 7. Similarly we can work from right to
# left: 3797, 379, 37, and 3.
#
# Find the sum of the only eleven primes that are both truncatable from left
# to right and right to left.
#
# NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.
#------------------------------------------------------------------------------
# SOLUTION: 748317
#------------------------------------------------------------------------------
# as -32 37.s -o 37.o
# gcc -m32 37.o -o 37
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
    xor     %edx, %edx
    xor     %ecx, %ecx
    xor     %edi, %edi
    addl    $1, %edi

fs_loop:
    cmpl    $11, %ecx
    je      fs_exit
    addl    $2, %edi

    pushl   %edx
    pushl   %ecx
    pushl   %edi
    call    is_truncatable
    popl    %edi
    popl    %ecx
    popl    %edx

    cmpl    $0, %eax
    je      fs_loop

    incl    %ecx
    addl    %edi, %edx
    jmp     fs_loop

fs_exit:
    movl    %edx, %eax
    ret

#------------------------------------------------------------------------------
.type is_truncatable, @function

is_truncatable:
    cmpl    $10, 4(%esp)
    jle     it_no
    pushl   4(%esp)
    call    is_prime
    addl    $4, %esp
    cmpl    $0, %eax
    je      it_no
    xor     %eax, %eax
    addl    $1, %eax
    xor     %ecx, %ecx
    addl    $10, %ecx
    
it_get_power:
    cmpl    4(%esp), %ebx
    jg      it_from_left
    mul     %ecx
    movl    %eax, %ebx
    jmp     it_get_power

it_from_left:
    cmpl    $10, %ebx
    je      it_yes

    xor     %edx, %edx
    movl    %ebx, %eax
    movl    $10, %ecx
    div     %ecx
    movl    %eax, %ebx

    xor     %edx, %edx
    movl    4(%esp), %eax
    div     %ebx

    pushl   %ebx
    pushl   %edx
    pushl   %eax
    call    is_prime
    cmpl    $0, %eax
    popl    %eax
    popl    %edx
    popl    %ebx
    je      it_no

    pushl   %ebx
    pushl   %edx
    call    is_prime
    popl    %edx
    popl    %ebx
    cmpl    $0, %eax
    je      it_no

    jmp     it_from_left    

it_yes:
    xor     %eax, %eax
    incl    %eax
    jmp     it_exit

it_no:
    xor     %eax, %eax
    
it_exit:
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
