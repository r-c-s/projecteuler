#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 16
#------------------------------------------------------------------------------
# 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
#
# What is the sum of the digits of the number 2^1000?
#------------------------------------------------------------------------------
# SOLUTION: 1366
#------------------------------------------------------------------------------
# as -32 16.s -o 16.o
# gcc -m32 16.o -o 16
#------------------------------------------------------------------------------

dec32_format:
	.string "%d\n"

.section .text
.globl main

main:
	pushl	$2
	pushl	$1000
	call	find_sum_of_digits
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
.type find_sum_of_digits, @ function

find_sum_of_digits:
	xor		%edi, %edi
	addl	$1, %edi
	pushl	%ebp			# save base pointer
	pushl	12(%esp)		# number
	pushl	$-1				# flag end of number
	addl	$4, %esp		# move behind flag

fsod_main_loop:
	cmpl	12(%esp), %edi	# power
	jge		fsod_done	
	incl	%edi
	movl	%esp, %ebp		# copy of stack pointer
	xor		%edx, %edx
	xor		%ecx, %ecx

fsod_multiply_loop:
	cmpl	$-1, (%ebp)		# check for flag
	jne		fsod_ml_continue
	cmpl	$0, %ecx		# check if there's a carry
	je		fsod_main_loop
	movl	%ecx, (%ebp)	# move carry into this location
	movl	$-1, -4(%ebp)	# move flag to next location
	jmp		fsod_main_loop

fsod_ml_continue:
	movl	(%ebp), %eax
	xor		%ebx, %ebx
	addl	$2, %ebx
	mul		%ebx
	addl	%ecx, %eax
	xor		%ebx, %ebx
	addl	$10, %ebx
	div		%ebx	
	movl	%edx, (%ebp)
	movl	%eax, %ecx		# ecx holds the carry
	addl	$-4, %ebp
	jmp		fsod_multiply_loop

fsod_done: 

	xor		%eax, %eax		# sum
	movl	%esp, %ebp		# copy of stack pointer - start at the bottom

fsod_add:	
	cmpl	$-1, (%ebp)		# check for flag
	je		fsod_exit
	addl	(%ebp), %eax
	addl	$-4, %ebp		
	jmp		fsod_add

fsod_exit:
	addl	$4, %esp		
	popl	%ebp			# restore base pointer
	ret
