#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 2
#------------------------------------------------------------------------------
# By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see 
# that the 6th prime is 13.
#
# What is the 10 001st prime number?
#------------------------------------------------------------------------------
# SOLUTION: 104743
#------------------------------------------------------------------------------
# as -32 7.s -o 7.o
# gcc -m32 7.o -o 7
#------------------------------------------------------------------------------

dec32_format:
    .string "%d\n"

.section .text
.globl main

main:
    pushl   $10001
    call    get_prime
    pushl   %eax
    call    print32

#------------------------------------------------------------------------------
main_exit:
    xor    %eax, %eax
    incl   %eax
    xor    %ebx, %ebx
    incl   %ebx
    int    $0x80

#------------------------------------------------------------------------------
.type print_num, @ function

print32:
    pushl   4(%esp)
    pushl   $dec32_format
    call    printf
    addl    $8, %esp
    ret

#------------------------------------------------------------------------------
get_prime:
    movl    4(%esp), %ecx
    xor     %ebx, %ebx
    incl    %ebx
    xor     %edi, %edi
    incl    %edi

get_prime_loop:
    cmpl    %ecx, %edi       # checks if index is 10001
    je      get_prime_exit   # exits if it is
    addl    $2, %ebx         # current+=2
    pushl   %edi             # saves index    
    pushl   %ecx
    pushl   %ebx             # saves and passes current as parem
    call    is_prime         # calls prime function
    popl    %ebx             # restores current    
    popl    %ecx
    popl    %edi             # restores index 
    cmpl    $0, %eax         # checks result
    je      get_prime_loop   # if not, next
    incl    %edi             # increments prime count
    jmp     get_prime_loop   # next

get_prime_exit:
    movl    %ebx, %eax
    ret

#------------------------------------------------------------------------------
.type is_prime, @function

is_prime:
    pushl   %ebp             # save old base pointer
    movl    %esp, %ebp       # create new stack pointer
    cmpl    $2, 8(%ebp)      # compares argument to 2
    je      yes              # if it's equal it's prime
    jl      no               # if it's less than it's not prime
    movl    8(%ebp), %eax    
    andl    $1, %eax         # check if it's even
    cmpl    $0, %eax
    je      no
    pushl   $0               # high part of parameter
    pushl   8(%ebp)          # low part of parameter
    call    sqrt_approx      # call sqrt function
    addl    $8, %esp         # restores sp
    movl    %eax, %ecx       # assigns sqrt to ecx
    movl    $3, %edi         # i = 3

prime_loop:
    cmpl    %ecx, %edi       # i >= sqrt(arg) ?
    jg      yes              # quit if it is
    xor     %edx, %edx       # higher part of dividend
    movl    8(%ebp), %eax    # lower part of dividend
    divl    %edi             # divides current by index
    test    %edx, %edx       # checks if remainder is 0
    jz      no               # if it is it's not a prime
    addl    $2, %edi         # index+=2
    jmp     prime_loop       # do it again

yes:
    xor     %eax, %eax       # clears register
    inc     %eax             # sets result to "true"
    jmp     prime_exit       # exits

no:
    xor     %eax, %eax       # sets result to "false"

prime_exit:
    movl    %ebp, %esp       # stack pointer
    popl    %ebp             # restores base pointer
    ret

#------------------------------------------------------------------------------
.type sqrt_approx, @function

sqrt_approx:
    xor     %edi, %edi       # index/sqrt candidate
    incl    %edi

sqrt_loop:
    movl    %edi, %eax       # move sqrt into required mul register
    mul     %eax             # multiply said register by itself
    cmpl    8(%esp), %edx    # compare high part of result with high part of number
    jl      continue         # skip next statements if it's less than
    cmpl    4(%esp), %eax    # compare low part of result with low part of number
    jae     sqrt_exit        # if it's greater than or equal leave

continue:
    incl    %edi             # else increment sqrt
    jmp     sqrt_loop        # do it again

sqrt_exit:
    movl    %edi, %eax       # move sqrt value into return register    
    ret
