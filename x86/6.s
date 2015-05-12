#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 6
#------------------------------------------------------------------------------
# The sum of the squares of the first ten natural numbers is,
#
# 1^2 + 2^2 + ... + 10^2 = 385
# The square of the sum of the first ten natural numbers is,
#
# (1 + 2 + ... + 10)2 = 55^2 = 3025
# Hence the difference between the sum of the squares of the first ten natural 
# numbers and the square of the sum is 3025  385 = 2640.
#
# Find the difference between the sum of the squares of the first one hundred 
# natural numbers and the square of the sum.
#------------------------------------------------------------------------------
# SOLUTION: 25164150
#------------------------------------------------------------------------------
# as -32 6.s -o 6.o
# gcc -m32 6.o -o 6
#------------------------------------------------------------------------------

dec32_format:
	.string "%d\n"

.section .text
.globl main

main:
	call	get_number
	pushl	%eax
	call	print32

#------------------------------------------------------------------------------
main_exit:
	xor	%eax, %eax
	incl	%eax
	xor	%ebx, %ebx
	int	$0x80

#------------------------------------------------------------------------------
.type print32, @ function

print32:
	pushl	4(%esp)
	pushl	$dec32_format
	call	printf
	addl	$8, %esp
	ret

#------------------------------------------------------------------------------
.type get_number, @ function

get_number:
	xor	%edi, %edi
	xor	%ebx, %ebx
	xor	%ecx, %ecx
	
gn_loop:
	cmpl	$100, %edi
	je	gn_exit
	inc	%edi		
	movl	%edi, %eax	# sum of squares
	mul	%eax
	addl	%eax, %ebx
	addl	%edi, %ecx	# sum
	jmp	gn_loop

gn_exit:
	movl	%ecx, %eax
	mul	%eax
	subl	%ebx, %eax
	ret
