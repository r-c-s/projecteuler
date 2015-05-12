#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 5
#------------------------------------------------------------------------------
# 2520 is the smallest number that can be divided by each of the numbers from 
# 1 to 10 without any remainder.
#
# What is the smallest positive number that is evenly divisible by all of the 
# numbers from 1 to 20?
#------------------------------------------------------------------------------
# SOLUTION: 232792560
#------------------------------------------------------------------------------
# as -32 5.s -o 5.o
# gcc -m32 5.o -o 5
#------------------------------------------------------------------------------

dec32_format:
	.string "%d\n"

.section .text
.globl main

main:	
	call	find_number
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
.type find_number, @ function

find_number:
	xor		%edi, %edi

fn_loop:
	addl	$20, %edi
	pushl	%edi
	call	is_divisible
	popl	%edi
	test	%eax, %eax
	jz		fn_loop

fn_exit:
	movl	%edi, %eax
	ret

#------------------------------------------------------------------------------
.type is_divisible, @ function

is_divisible:
	xor		%edi, %edi
	movl	$20, %edi

id_loop:
	cmpl	$1, %edi
	je		id_yes
	xor		%edx, %edx
	movl	4(%esp), %eax
	div		%edi
	cmpl	$0, %edx
	jne		id_no
	decl	%edi
	jmp		id_loop

id_yes:
	xor		%eax, %eax
	incl	%eax
	jmp 	id_exit

id_no:
	xor		%eax, %eax

id_exit:
	ret
