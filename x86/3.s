#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 3
#------------------------------------------------------------------------------
# The prime factors of 13195 are 5, 7, 13 and 29.
#
# What is the largest prime factor of the number 600851475143 ?
#------------------------------------------------------------------------------
# SOLUTION: 6857
#------------------------------------------------------------------------------
# as -32 3.s -o 3.o
# gcc -m32 3.o -o 3 
#------------------------------------------------------------------------------

dec32_format:
    .string "%d\n"

dec64_format:
    .string "%qd\n"

.section .text
.globl main


main:
    pushl   $0x0000008b         # high part of number
    pushl   $0xe589eac7         # low part of number
    call    grt_prime_fctr      # calls greatest prime factor function
    pushl   %eax                # passes result as a parameter
    call    print32             # prints result

#------------------------------------------------------------------------------
main_exit:
    xor     %eax, %eax
    inc     %eax
    xor     %ebx, %ebx
    inc     %ebx
    int     $0x80

#------------------------------------------------------------------------------
.type print_num, @function

print32:
    pushl   4(%esp)
    pushl   $dec32_format
    call    printf
    addl    $8, %esp
    ret

#------------------------------------------------------------------------------
.type print_num, @function

print64:
    pushl   8(%esp)
    pushl   8(%esp)
    pushl   $dec64_format
    call    printf
    addl    $12, %esp
    ret     $4

#------------------------------------------------------------------------------
.type grt_prime_fctr, @ function

grt_prime_fctr:
    pushl   %ebp             # save old base pointer
    movl    %esp, %ebp       # create new stack pointer
    pushl   12(%esp)         # high part of num
    pushl   8(%esp)          # low part of num
    call    sqrt_approx      # calls sqrt function
    movl    %eax, %ebx       # edx is the sqrt
    addl    $8, %esp         # restores stack pointer
    xor     %edi, %edi       # index/divisor    
    inc     %edi

gpf_loop:
    cmpl    %ebx, %edi       # compares index with sqrt of num
    ja      gpf_exit         # leave if greater
    pushl   %ecx             # save gpf result
    pushl   %ebx             # save sqrt
    pushl   %edi             # save and passes index as parameter
    call    is_prime         # call is_prime function
    test    %eax, %eax       # check prime result - test for false
    popl    %edi             # restore index
    popl    %ebx             # restore sqrt
    popl    %ecx             # restore gpf result
    je      skip             # skip next statements if it was not a prime
    xor     %edx, %edx       # high part of dividend = 0
    movl    12(%esp), %eax   # low part of dividend = high part of number
    div     %edi             # divides number by index
    movl    8(%esp), %eax    # low part of dividend = low part of number
    div     %edi             # divides number by index
    cmpl    $0, %edx         # checks if remainder is 0
    jne     skip             # skip if it's not
    movl    %edi, %ecx       # index must be the current greatest prime factor

skip:
    addl    $2, %edi         # index becomes next odd number
    jmp     gpf_loop         # do it again

gpf_exit:
    movl    %ecx, %eax       # moves result into return register
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
    movl    %eax, %ecx       # moves sqrt into ecx register
    mul     %eax             # multiplies sqrt by itself
    cmpl    %eax,8(%ebp)     # checks if product is equal to number
    je      no               # if the number has a sqrt it's not a prime
    movl    $3, %edi         # i = 3

prime_loop:
    cmpl    %ecx, %edi       # i >= sqrt(arg) ?
    jge     yes              # quit if it is
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
