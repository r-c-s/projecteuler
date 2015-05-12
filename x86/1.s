#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 2
#------------------------------------------------------------------------------
# If we list all the natural numbers below 10 that are multiples of 3 or 5, we 
# get 3, 5, 6 and 9. 
# The sum of these multiples is 23.
#
# Find the sum of all the multiples of 3 or 5 below 1000.
#------------------------------------------------------------------------------
# SOLUTION: 233168
#------------------------------------------------------------------------------
# as -32 1.s -o 1.o
# gcc -m32 1.o -o 1
#------------------------------------------------------------------------------

dec32_format:
    .string "%d\n"

.section .text
.globl main

main:
	pushl	$1000
	pushl	$3
	pushl	$5
	call	get_sum
	pushl	%eax
	call	print32

#------------------------------------------------------------------------------
main_exit:
	xor		%eax, %eax
	incl	%eax
	xor		%ebx, %ebx
	incl	%ebx
	int 	$0x80

#------------------------------------------------------------------------------
.type print_num, @ function

print32:
	pushl	4(%esp)
	pushl	$dec32_format
	call	printf
	addl	$8, %esp
	ret

#------------------------------------------------------------------------------
.type get_sum, @ function

get_sum:
	xor		%ebx, %ebx
	xor		%edi, %edi
	incl	%edi

sum_loop:
	incl	%edi
	cmpl	12(%esp), %edi
	je		sum_exit	
	xor		%edx, %edx		
	movl	%edi, %eax	
	movl	8(%esp), %ecx	
	divl	%ecx		
	test	%edx, %edx
	jne		skip
	addl	%edi, %ebx
	jmp 	sum_loop

skip:
	xor		%edx, %edx		
	movl	%edi, %eax	
	movl	4(%esp), %ecx	
	divl	%ecx	
	test	%edx, %edx
	jne		sum_loop
	addl	%edi, %ebx	
	jmp 	sum_loop

sum_exit:
	movl	%ebx, %eax
	ret
	
