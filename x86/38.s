#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 38
#------------------------------------------------------------------------------
# Take the number 192 and multiply it by each of 1, 2, and 3:
#
# 192 * 1 = 192
# 192 * 2 = 384
# 192 * 3 = 576
# By concatenating each product we get the 1 to 9 pandigital, 192384576. We
# will call 192384576 the concatenated product of 192 and (1,2,3)
#
# The same can be achieved by starting with 9 and multiplying by 1, 2, 3, 4,
# and 5, giving the pandigital, 918273645, which is the concatenated product
# of 9 and (1,2,3,4,5).
#
# What is the largest 1 to 9 pandigital 9-digit number that can be formed as
# the concatenated product of an integer with (1,2, ... , n) where n > 1?
#------------------------------------------------------------------------------
# SOLUTION: 932718654
#------------------------------------------------------------------------------
# as -32 38.s -o 38.o
# gcc -m32 38.o -o 38
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
	incl	%edi
	pushl	$0

fn_loop:
	xor		%ebx, %ebx
	xor		%ecx, %ecx

fn_inner_loop:
	incl	%ebx
	movl	%edi, %eax
	mul		%ebx
	pushl	%ecx
	pushl	%eax
	xor		%eax, %eax
	addl	$1, %eax
	xor		%ecx, %ecx
	addl	$10, %ecx
	
fn_il_get_power:
	cmpl	(%esp), %eax
	jg		fn_il_continue
	mul		%ecx
	jmp		fn_il_get_power
	
fn_il_continue:	
	movl	%eax, %edx
	movl	4(%esp), %eax
	mul		%edx
	addl	(%esp), %eax
	movl	%eax, %ecx
	addl	$8, %esp
	cmpl	$100000000, %ecx
	jl		fn_inner_loop
	cmpl	$999999999, %ecx
	jg		fn_loop_next
	pushl	%ebx
	pushl	%edi
	pushl	%ecx
	call	is_pandigital
	popl	%ecx
	popl	%edi
	popl	%ebx
	cmpl	$1, %eax
	jne		fn_loop_next
	cmpl	(%esp), %ecx
	jle		fn_loop_next
	movl	%ecx, (%esp)

fn_loop_next:
	cmpl	$10000, %edi
	jge		fn_exit
	incl	%edi
	jmp		fn_loop

fn_exit:
	popl	%eax
	ret

#------------------------------------------------------------------------------
.type is_pandigital, @ function

is_pandigital:
	cmpl	$999999999, 4(%esp)
	jge		ip_no
	cmpl	$100000000, 4(%esp)
	jle		ip_no
	xor		%ebx, %ebx
	addl	$1000000000, %ebx
	xor		%ecx, %ecx
	addl	$10, %ecx
	xor		%edi, %edi
	incl	%edi
	movl	%esp, %edx

ip_num_array:
	pushl	%edi
	incl	%edi
	cmpl	$10, %edi
	jne		ip_num_array
	movl	%edx, %esp
	movl	$4, %edi

ip_loop:
	movl	%ebx, %eax
	xor		%edx, %edx
	div		%ecx
	movl	%eax, %ebx

	cmpl	$0, %ebx
	je		ip_check
	
	movl	4(%esp), %eax
	xor		%edx, %edx
	div		%ebx
	xor		%edx, %edx
	div		%ecx

	cmpl	$0, %edx
	je		ip_no
	
	movl	%edx, %eax
	mul		%edi
	subl	%eax, %esp
	movl	$0, (%esp)
	addl	%eax, %esp

	jmp		ip_loop

ip_check:
	movl	%esp, %ebx
	xor		%edi, %edi

ip_check_loop:
	incl	%edi
	cmpl	$9, %edi
	jg		ip_yes
	addl	$-4, %ebx
	cmpl	$0, (%ebx)
	jne		ip_no
	jmp		ip_check_loop

ip_yes:
	xor		%eax, %eax
	incl	%eax
	jmp		ip_exit

ip_no:
	xor		%eax, %eax
	
ip_exit:
	ret
	
	


