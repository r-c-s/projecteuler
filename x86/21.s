#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 21
#------------------------------------------------------------------------------
# Let d(n) be defined as the sum of proper divisors of n (numbers less than n 
# which divide evenly into n).
# If d(a) = b and d(b) = a, where a  b, then a and b are an amicable pair and
# each of a and b are called amicable numbers.
#
# For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 
# 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4, 
# 71 and 142; so d(284) = 220.
#
# Evaluate the sum of all the amicable numbers under 10000.
#------------------------------------------------------------------------------
# SOLUTION: 31626
#------------------------------------------------------------------------------
# as -32 21.s -o 21.o
# gcc -m32 21.o -o 21
#------------------------------------------------------------------------------

dec32_format:
	.string "%d\n"

.section .text
.globl main

main:
	call	find_sum
	pushl	%eax
	call	print32

#------------------------------------------------------------------------------
main_exit:
	xor		%eax, %eax
	incl	%eax
	xor		%ebx, %ebx
	int		$0x80

#------------------------------------------------------------------------------
.type print32, @ function

print32:
	pushl	4(%esp)
	pushl	$dec32_format
	call	printf
	addl	$8, %esp
	ret

#------------------------------------------------------------------------------
.type find_sum, @ function

find_sum:
	xor		%edi, %edi
	xor		%ecx, %ecx

fs_loop:
	incl	%edi
	cmpl	$10000, %edi
	jge		fs_exit
	pushl	%ecx
	pushl	%edi	
	call	sum_of_proper_divisors		# d(n)
	popl	%edi
	popl	%ecx
	cmpl	%eax, %edi					# excludes case d(n) = n
	je		fs_loop
	pushl	%ecx
	pushl	%edi
	pushl	%eax
	call	sum_of_proper_divisors		# d(d(n)) = n?
	addl	$4, %esp
	popl	%edi
	popl	%ecx
	cmpl	%eax, %edi
	jne		fs_loop
	addl	%edi, %ecx
	jmp		fs_loop

fs_exit:
	movl	%ecx, %eax
	ret

#------------------------------------------------------------------------------
.type sum_of_proper_divisors, @ function

sum_of_proper_divisors:
	xor		%edi, %edi
	xor		%ecx, %ecx
	movl	4(%esp), %ebx
	shr		$1, %ebx

sopd_loop:
	incl	%edi
	cmpl	%ebx, %edi
	jg		sopd_exit
	xor		%edx, %edx
	movl	4(%esp), %eax
	div		%edi
	cmpl	$0, %edx
	jne		sopd_loop
	addl	%edi, %ecx
	jmp		sopd_loop

sopd_exit:
	movl	%ecx, %eax
	ret









