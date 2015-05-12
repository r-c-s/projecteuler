#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 11
#------------------------------------------------------------------------------
# What is the greatest product of four adjacent numbers in any direction
# (up, down, left, right, or diagonally) in the 2020 grid?
#------------------------------------------------------------------------------
# SOLUTION: 70600674
#------------------------------------------------------------------------------
# as -32 11.s -o 11.o
# gcc -m32 11.o -o 11
#------------------------------------------------------------------------------

data:
	.int 8,2,22,97,38,15,0,40,0,75,4,5,7,78,52,12,50,77,91,8,49,49,99,40,17,81,18,57,60,87,17,40,98,43,69,48,4,56,62,0,81,49,31,73,55,79,14,29,93,71,40,67,53,88,30,3,49,13,36,65,52,70,95,23,4,60,11,42,69,24,68,56,1,32,56,71,37,2,36,91,22,31,16,71,51,67,63,89,41,92,36,54,22,40,40,28,66,33,13,80,24,47,32,60,99,3,45,2,44,75,33,53,78,36,84,20,35,17,12,50,32,98,81,28,64,23,67,10,26,38,40,67,59,54,70,66,18,38,64,70,67,26,20,68,2,62,12,20,95,63,94,39,63,8,40,91,66,49,94,21,24,55,58,5,66,73,99,26,97,17,78,78,96,83,14,88,34,89,63,72,21,36,23,9,75,0,76,44,20,45,35,14,0,61,33,97,34,31,33,95,78,17,53,28,22,75,31,67,15,94,3,80,4,62,16,14,9,53,56,92,16,39,5,42,96,35,31,47,55,58,88,24,0,17,54,24,36,29,85,57,86,56,0,48,35,71,89,7,5,44,44,37,44,60,21,58,51,54,17,58,19,80,81,68,5,94,47,69,28,73,92,13,86,52,17,77,4,89,55,40,4,52,8,83,97,35,99,16,7,97,57,32,16,26,26,79,33,27,98,66,88,36,68,87,57,62,20,72,3,46,33,67,46,55,12,32,63,93,53,69,4,42,16,73,38,25,39,11,24,94,72,18,8,46,29,32,40,62,76,36,20,69,36,41,72,30,23,88,34,62,99,69,82,67,59,85,74,4,36,16,20,73,35,29,78,31,90,1,74,31,49,71,48,86,81,16,23,57,5,54,1,70,54,71,83,51,54,69,16,92,33,48,61,43,52,1,89,19,67,48

dec32_format:
	.string "%d\n"

.section .text
.globl main

main:
	call	horizontally
	movl	%eax, %edx
	call	vertically
	popl	%edx
	cmpl	%edx, %eax
	jle		skip0
	movl	%eax, %edx	
skip0:
	pushl	%edx
	call	diagonally_forward
	popl	%edx
	cmpl	%edx, %eax
	jle		skip1
	movl	%eax, %edx
skip1:
	pushl	%edx
	call	diagonally_backward
	popl	%edx
	cmpl	%edx, %eax
	jle		skip2
	movl	%eax, %edx
skip2:
	pushl	%edx
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
	ret		$4

#------------------------------------------------------------------------------
.type horizontally, @ function

horizontally:
	xor		%edi, %edi
	xor		%edx, %edx
	movl	$-20, %edi
	pushl	$0

h_loop:
	cmpl	$396, %edi			# last possible index
	je		h_exit
	addl	$20, %edi
	xor		%ebx, %ebx
	xor		%eax, %eax
	incl	%eax
	cmpl	$380, %edi			# last line?
	jle		h_inner_loop
	incl	%edx
	movl	%edx, %edi			# go back to first line incrementing by 1 every time

h_inner_loop:
	cmpl	$4, %ebx
	je		h_update_prod
	movl	%ebx, %ecx
	addl	%edi, %ecx
	pushl	%edx				# save increment
	mull	data(, %ecx, 4)
	popl	%edx				# restore increment
	incl	%ebx
	jmp		h_inner_loop

h_update_prod:
	popl	%ecx
	cmpl	%ecx, %eax
	pushl	%ecx
	jl		h_loop
	popl	%ecx
	pushl	%eax
	jmp		h_loop

h_exit:
	popl	%eax
	ret

#------------------------------------------------------------------------------
.type vertically, @ function

vertically:
	xor		%edi, %edi
	movl	$-1, %edi
	pushl	$0

v_loop:
	incl	%edi
	xor		%ebx, %ebx
	xor		%eax, %eax
	incl	%eax
	cmpl	$320, %edi			# last possible index
	jg		v_exit

v_inner_loop:
	cmpl	$80, %ebx
	je		v_update_prod
	movl	%ebx, %ecx
	addl	%edi, %ecx
	mull	data(, %ecx, 4)
	addl	$20, %ebx
	jmp		v_inner_loop

v_update_prod:
	popl	%ecx
	cmpl	%ecx, %eax
	pushl	%ecx
	jl		v_loop
	popl	%ecx
	pushl	%eax
	jmp		v_loop

v_exit:
	popl	%eax
	ret

#------------------------------------------------------------------------------
.type diagonally_forward, @ function

diagonally_forward:
	xor		%edi, %edi
	xor		%edx, %edx
	movl	$-20, %edi
	pushl	$0

df_loop:
	cmpl	$336, %edi			# last possible index
	je		df_exit
	addl	$20, %edi
	xor		%ebx, %ebx
	xor		%eax, %eax
	incl	%eax
	cmpl	$320, %edi			# last line - 3 lines?
	jle		df_inner_loop
	incl	%edx
	movl	%edx, %edi			# go back to first line incrementing by 1 every time

df_inner_loop:
	cmpl	$84, %ebx
	je		df_update_prod
	movl	%ebx, %ecx
	addl	%edi, %ecx
	pushl	%edx				# save increment
	mull	data(, %ecx, 4)
	popl	%edx				# restore increment
	addl	$21, %ebx			# diagonally forwards
	jmp		df_inner_loop

df_update_prod:
	popl	%ecx
	cmpl	%ecx, %eax
	pushl	%ecx
	jl		df_loop
	popl	%ecx
	pushl	%eax
	jmp		df_loop

df_exit:
	popl	%eax
	ret

#------------------------------------------------------------------------------
.type diagonally_backward, @ function

diagonally_backward:
	xor		%edi, %edi
	movl	$2, %edi
	pushl	$0

db_loop:
	incl	%edi
	xor		%ebx, %ebx
	xor		%eax, %eax
	incl	%eax
	cmpl	$340, %edi			# last possible index
	jg		db_exit

db_inner_loop:
	cmpl	$76, %ebx
	je		db_update_prod
	movl	%ebx, %ecx
	addl	%edi, %ecx
	mull	data(, %ecx, 4)
	addl	$19, %ebx			# diagonally backwards
	jmp		db_inner_loop

db_update_prod:
	popl	%ecx
	cmpl	%ecx, %eax
	pushl	%ecx
	jl		db_loop
	popl	%ecx
	pushl	%eax
	jmp		db_loop

db_exit:
	popl	%eax
	ret
