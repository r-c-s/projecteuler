#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 10
#------------------------------------------------------------------------------
# The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
#
# Find the sum of all the primes below two million.
#------------------------------------------------------------------------------
# SOLUTION: 142913828922
#------------------------------------------------------------------------------
# as -32 10.s -o 10.o
# gcc -m32 10.o -o 10
#------------------------------------------------------------------------------

dec64_format:
    .string "%qd\n"

dec32_format:
    .string "%d\n"

.section .text
.globl main

main:
    call    find_sum
    pushl   %ecx
    pushl   %edx
    call    print64

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
.type print64, @ function

print64:
    pushl   8(%esp)
    pushl   8(%esp)
    pushl   $dec64_format
    call    printf
    addl    $12, %esp
    ret    

#------------------------------------------------------------------------------
.type find_sum, @ function

find_sum:
    xor     %ecx, %ecx
    xor     %edx, %edx
    addl    $2, %edx
    xor     %edi, %edi
    incl    %edi

fs_loop:
    addl    $2, %edi
    cmpl    $2000000, %edi
    jg      fs_exit
    pushl   %ecx
    pushl   %edx
    pushl   $0
    pushl   %edi
    call    is_prime
    cmpl    $0, %eax
    popl    %edi
    popl    %edx
    popl    %edx
    popl    %ecx
    je      fs_loop
    addl    %edi, %edx
    adcl    $0, %ecx
    jmp     fs_loop

fs_exit:    
    ret

#------------------------------------------------------------------------------
.type sqrt_approx, @function

sqrt_approx:
    xor     %edx, %edx
    xor     %edi, %edi       # index/sqrt candidate
    incl    %edi

sqrt_loop:
    movl    %edi, %eax       # move sqrt into required mul register
    mul     %eax             # multiply said register by itself
    cmpl    8(%esp), %edx    # compare high part of result with high part of number
    jl      continue         # skip next statements if it's less than
    cmpl    4(%esp), %eax    # compare low part of result with low part of number
    jge     sqrt_exit        # if it's greater than or equal leave

continue:
    incl    %edi              # else increment sqrt
    jmp     sqrt_loop         # do it again

sqrt_exit:
    movl    %edi, %eax        # move sqrt value into return register    
    ret    

#------------------------------------------------------------------------------
.type is_prime, @function

is_prime:
    pushl   %ebp              # save old base pointer
    movl    %esp, %ebp        # create new stack pointer
    cmpl    $2, 8(%ebp)       # compares argument to 2
    je      yes               # if it's equal it's prime
    jl      no                # if it's less than it's not prime
    movl    8(%ebp), %eax    
    andl    $1, %eax          # check if it's even
    cmpl    $0, %eax
    je      no
    pushl   12(%ebp)          # high part of parameter
    pushl   8(%ebp)           # low part of parameter
    call    sqrt_approx       # call sqrt function
    addl    $8, %esp          # restores sp
    movl    %eax, %ecx        # moves sqrt into ecx register
    movl    $3, %edi          # i = 3

prime_loop:
    cmpl   %ecx, %edi         # i >= sqrt(arg) ?
    jg     yes                # quit if it is
    movl   12(%ebp), %edx     # higher part of dividend
    movl   8(%ebp), %eax      # lower part of dividend
    divl   %edi               # divides current by index
    test   %edx, %edx         # checks if remainder is 0
    jz     no                 # if it is it's not a prime
    addl   $2, %edi           # index+=2
    jmp    prime_loop         # do it again

yes:
    xor    %eax, %eax         # clears register
    inc    %eax               # sets result to "true"
    jmp    prime_exit         # exits

no:
    xor    %eax, %eax         # sets result to "false"

prime_exit:
    movl   %ebp, %esp         # stack pointer
    popl   %ebp               # restores base pointer
    ret
