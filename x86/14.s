#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 14
#------------------------------------------------------------------------------
# The following iterative sequence is defined for the set of positive integers:
#
# n  n/2 (n is even)
# n  3n + 1 (n is odd)
#
# Using the rule above and starting with 13, we generate the following sequence:
#
# 13  40  20  10  5  16  8  4  2  1
# It can be seen that this sequence (starting at 13 and finishing at 1) contains
# 10 terms. Although it has not been proved yet (Collatz Problem), it is thought 
# that all starting numbers finish at 1.
#
# Which starting number, under one million, produces the longest chain?
#
# NOTE: Once the chain starts the terms are allowed to go above one million.
#------------------------------------------------------------------------------
# SOLUTION: 837799
#------------------------------------------------------------------------------
# as -32 14.s -o 14.o
# gcc -m32 14.o -o 14
#------------------------------------------------------------------------------

dec32_format:
	.string "%d\n"

.section .text
.globl main

main:
	call	find_num
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
.type find_num, @ function

find_num:
	xor		%edi, %edi
	pushl	%edi			# number 
	pushl	$0

fn_loop:	
	cmpl	$1000000, %edi
	je		fn_exit
	incl	%edi
	xor		%ecx, %ecx
	addl	%edi, %ecx
	xor		%edx, %edx
	pushl	%edx

fn_inner_loop:
	popl	%edx
	incl	%edx
	pushl	%edx
	cmpl	$1, %ecx
	je		fn_update
	xor		%ebx, %ebx
	addl	%ecx, %ebx
	and		$1, %ebx
	cmpl	$0, %ebx
	je		fn_il_even
	xor		%eax, %eax
	addl	%ecx, %eax
	xor		%ebx, %ebx
	addl	$3, %ebx
	mul		%ebx
	incl	%eax
	xor		%ecx, %ecx
	addl	%eax, %ecx
	jmp		fn_inner_loop

fn_il_even:
	shr		$1, %ecx
	jmp		fn_inner_loop

fn_update:
	movl	0(%esp), %ecx	# new
	movl	4(%esp), %ebx	# old
	cmpl	%ebx, %ecx
	jle		fn_u_skip
	addl	$12, %esp		# discard everything
	pushl	%edi			# update with new number
	pushl	%ecx			# save number's chain length
	jmp		fn_loop
fn_u_skip:
	addl	$4, %esp		# discard new chain length
	jmp		fn_loop

fn_exit:
	popl	%edx			# chain length
	popl	%eax			# number
	ret
