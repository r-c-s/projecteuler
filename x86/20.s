#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 20
#------------------------------------------------------------------------------
# n! means n * (n * 1) * ... * 3 * 2 * 1
#
# For example, 10! = 10 * 9 * ... * 3 * 2 * 1 = 3628800,
# and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.
#
# Find the sum of the digits in the number 100!
#------------------------------------------------------------------------------
# SOLUTION: 648
#------------------------------------------------------------------------------
# as -32 20.s -o 20.o
# gcc -m32 20.o -o 20
#------------------------------------------------------------------------------

dec32_format:
    .string "%d\n"

.section .text
.globl main

main:
    pushl   $100                             # function parameter
    call    find_sum_of_digits_in_factorial
    pushl   %eax                             # function output
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
.type find_sum_of_digits_in_factorial, @ function

find_sum_of_digits_in_factorial:
    pushl   %ebp                # save base pointer
    pushl   $1                  # first number in factorial
    pushl   $-1                 # flag end of number
    addl    $4, %esp            # move back behind flag
    xor     %ebx, %ebx          
    addl    $10, %ebx           # we'll use this 10 to single out carries
    xor     %edi, %edi
    addl    12(%esp), %edi      # function parameter
    incl    %edi

fsodif_main_loop:
    cmpl    $1, %edi            # factorial is done computing?
    jle     fsodif_done         # go get ready to add the digits
    decl    %edi                # else decrement paramter
    movl    %esp, %ebp          # copy of stack pointer
    xor     %edx, %edx 
    xor     %ecx, %ecx

fsodif_multiply_loop:
    cmpl   $-1, (%ebp)           # check for flag
    jne    fsodif_ml_continue    # no flag yet, multiply again
    cmpl   $0, %ecx              # else check if there's a carry
    je     fsodif_main_loop      # no carry, back to main loop
    movl   %ecx, %eax            # yes carry, need to propagate it

fsodif_ml_propagate_carry:            # pushes each digit of carry
    xor    %edx, %edx                 # to the next stack location
    div    %ebx                       # gets carry in eax
    movl   %edx, (%ebp)               # move remainder to current location
    addl   $-4, %ebp                  # move to the next adress
    cmpl   $0, %eax                   # is there still a carry?
    jne    fsodif_ml_propagate_carry  # then do it again
    movl   $-1, (%ebp)                # else push flag back in before leaving
    jmp    fsodif_main_loop 

fsodif_ml_continue:
    movl   (%ebp), %eax          # gets current value in stack address
    mul    %edi                  # multiply it by factorial (n..1)
    addl   %ecx, %eax            # carry from previous multiplication
    div    %ebx                  # get only 1 digit
    movl   %edx, (%ebp)          # move that digit to current stack address
    movl   %eax, %ecx            # ecx holds the current carry
    addl   $-4, %ebp             # shift go to next stack
    jmp    fsodif_multiply_loop  # go back to multiply loop

fsodif_done: 
    xor    %eax, %eax          # sum
    movl   %esp, %ebp          # copy of stack pointer - start at beginning

fsodif_add:    
    cmpl   $-1, (%ebp)         # check for flag
    je     fsodif_exit         # if we've arrived at the flag, we're done
    addl   (%ebp), %eax        # else add
    addl   $-4, %ebp           # move to the next stack address
    jmp    fsodif_add          # do it again

fsodif_exit:
    addl   $4, %esp            # restore stack pointer
    popl   %ebp                # restore base pointer
    ret
