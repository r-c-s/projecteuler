#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 9
#------------------------------------------------------------------------------
# A Pythagorean triplet is a set of three natural numbers, a  b  c, for which,
#
# a2 + b2 = c2
# For example, 32 + 42 = 9 + 16 = 25 = 52.
#
# There exists exactly one Pythagorean triplet for which a + b + c = 1000.
# Find the product abc.
#------------------------------------------------------------------------------
# SOLUTION: 31875000
#------------------------------------------------------------------------------
# as -32 9.s -o 9.o
# gcc -m32 9.o -o 9
#------------------------------------------------------------------------------

dec32_format:
	.string "%d\n"

.section .text
.globl main

main:
	call	find_prod_of_triplet
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
.type find_prod_of_triplet, @ function

find_prod_of_triplet:
	xor		%edi, %edi
	xor		%ebx, %ebx
	xor 	%ecx, %ecx

fpot_loop1:
	cmpl	$500, %edi
	jge		fpot_not_found
	incl	%edi
	xor		%ebx, %ebx

fpot_loop2:	
	cmpl	$600, %ebx
	jge		fpot_loop1
	incl	%ebx
	xor 	%ecx, %ecx

fpot_loop3:
	cmpl	$700, %ecx
	jge		fpot_loop2
	incl	%ecx

	movl	%edi, %eax
	mul		%eax
	pushl	%eax			# a^2

	movl	%ebx, %eax
	mul		%eax			# b^2

	popl	%edx
	addl	%edx, %eax
	pushl	%eax			# a^2 + b^2

	movl	%ecx, %eax
	mul		%eax			# c^2

	popl	%edx
	cmpl	%edx, %eax		
	jne		fpot_loop3

	xor		%eax, %eax		
	addl	%edi, %eax		# a
	addl	%ecx, %eax		# + b
	addl	%ebx, %eax		# + c

	cmpl	$1000, %eax		# = 1000?
	jne		fpot_loop3
	movl	%edi, %eax
	mul		%ecx
	mul		%ebx
	jmp		fpot_exit

fpot_not_found:
	movl	$-1, %eax

fpot_exit:
	ret
