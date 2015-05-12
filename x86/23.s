#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 23
#------------------------------------------------------------------------------
# A perfect number is a number for which the sum of its proper divisors is 
# exactly equal to the number. For example, the sum of the proper divisors 
# of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect 
# number.
#
# A number n is called deficient if the sum of its proper divisors is less 
# than n and it is called abundant if this sum exceeds n.
#
# As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest 
# number that can be written as the sum of two abundant numbers is 24. By
# mathematical analysis, it can be shown that all integers greater than 28123
# can be written as the sum of two abundant numbers. However, this upper limit 
# cannot be reduced any further by analysis even though it is known that the 
# greatest number that cannot be expressed as the sum of two abundant numbers 
# is less than this limit.
#
# Find the sum of all the positive integers which cannot be written as the 
# sum of two abundant numbers.
#------------------------------------------------------------------------------
# SOLUTION: 4179871
#------------------------------------------------------------------------------
# as -32 23.s -o 23.o
# gcc -m32 23.o -o 23
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
	movl	%esp, %ebp

fs_abundant_nums_loop:				# generates an array of abundant numbers
	incl	%edi
	cmpl	$20161, %edi			
	jg		fs_all_numbers
	pushl	%edi	
	call	is_abundant
	popl	%edi
	cmpl	$1, %eax
	jne		fs_abundant_nums_loop
	pushl	%edi	
	jmp		fs_abundant_nums_loop

fs_all_numbers:						# generates an array of all numbers
	xor		%edi, %edi
	movl	%esp, %ecx

fs_all_numbers_loop:
	incl	%edi
	pushl	%edi
	cmpl	$20161, %edi			# 20161 is the greatest number that cannot be 
	jl		fs_all_numbers_loop		# written as the sum of two abundant numbers

fs_sum_of_two_abundant_numbers:		# all possible sums of two abundant numbers
	movl	%ecx, %esp
	movl	%ebp, %ecx
	movl	$4, %ebx

fs_sotan_loop:						# plucks out the numbers that can be
	cmpl	%ebp, %esp				# be written as the sum of two abundant numbers
	je		fs_total				# from the array of all numbers
	addl	$-4, %ebp
	movl	%ebp, %edi

fs_sotan_inner_loop:
	xor		%eax, %eax
	addl	(%ebp), %eax
	addl	(%edi), %eax
	cmpl	$20161, %eax			# we're only dealing with numbers below 20161
	jg		fs_sotan_loop
	mul		%ebx

	subl	%eax, %esp
	movl	$0, (%esp)				# sets those numbers to 0 so they don't count in the sum
	addl	%eax, %esp

	cmpl	%edi, %esp
	je		fs_sotan_loop
	addl	$-4, %edi
	jmp		fs_sotan_inner_loop

fs_total:
	xor		%eax, %eax

fs_total_loop:						# sums up the leftover numbers
	addl	$-4, %esp
	addl	(%esp), %eax
	cmpl	$20161, (%esp)
	jl		fs_total_loop

fs_exit:
	movl	%ecx, %ebp
	movl	%ebp, %esp
	ret

#------------------------------------------------------------------------------
.type is_abundant, @ function

is_abundant:
	xor		%edi, %edi
	xor		%ecx, %ecx
	movl	4(%esp), %ebx
	shr		$1, %ebx

ia_loop:
	incl	%edi
	cmpl	%ebx, %edi
	jg		ia_no
	xor		%edx, %edx
	movl	4(%esp), %eax
	div		%edi
	cmpl	$0, %edx
	jne		ia_loop
	addl	%edi, %ecx
	cmpl	4(%esp), %ecx
	jg		ia_yes
	jmp		ia_loop

ia_yes:
	xor		%eax, %eax
	incl	%eax
	jmp		ia_exit

ia_no:
	xor		%eax, %eax

ia_exit:
	ret
