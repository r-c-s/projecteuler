#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 32
#------------------------------------------------------------------------------
# We shall say that an n-digit number is pandigital if it makes use of all the 
# digits 1 to n exactly once; for example, the 5-digit number, 15234, is 1 
# through 5 pandigital.
# 
# The product 7254 is unusual, as the identity, 39  186 = 7254, containing 
# multiplicand, multiplier, and product is 1 through 9 pandigital.
# 
# Find the sum of all products whose multiplicand/multiplier/product identity
# can be written as a 1 through 9 pandigital.
#
# HINT: Some products can be obtained in more than one way so be sure to only 
# include it once in your sum.
#------------------------------------------------------------------------------
# SOLUTION: 45228
#------------------------------------------------------------------------------
# as -32 32.s -o 32.o
# gcc -m32 32.o -o 32
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
	addl	$1000, %edi
	xor		%ebx, %ebx

fs_loop:
	cmpl	$10000, %edi
	je		fs_exit
	incl	%edi
	pushl	%ebx
	pushl	%edi
	call	pandigital_factors
	popl	%edi
	popl	%ebx
	cmpl	$0, %eax
	je		fs_loop
	addl	%edi, %ebx
	jmp		fs_loop

fs_exit:
	movl	%ebx, %eax
	ret

#------------------------------------------------------------------------------
.type pandigital_factors, @ function

pandigital_factors:
	pushl	4(%esp)
	call	sqrt_approx
	popl	%ecx
	movl	%eax, %ebx
	xor		%edi, %edi

pf_loop:
	incl	%edi
	cmpl	%ebx, %edi
	jg		pf_no
	movl	%ecx, %eax
	xor		%edx, %edx
	div		%edi
	cmpl	$0, %edx
	jne		pf_loop
	pushl	%ebx
	pushl	%edi
	pushl	%eax
	pushl	%ecx
	call	combine
	pushl	%eax
	call	is_pandigital
	movl	%eax, %edx
	popl	%eax
	popl	%ecx
	popl	%eax
	popl	%edi
	popl	%ebx
	cmpl	$0, %edx
	je		pf_loop

pf_yes:
	xor		%eax, %eax
	incl	%eax
	jmp		pf_exit

pf_no:
	xor		%eax, %eax

pf_exit:
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

#------------------------------------------------------------------------------
.type sqrt_approx, @function

sqrt_approx:
	xor		%edi, %edi		# index/sqrt candidate
	incl	%edi

sqrt_loop:
	movl	%edi, %eax		# move sqrt into required mul register
	mul		%eax			# multiply said register by itself
	cmpl	4(%esp), %eax	# compare result with number
	jge		sqrt_exit		# if it's greater than or equal leave

continue:
	incl	%edi			# else increment sqrt
	jmp		sqrt_loop		# do it again

sqrt_exit:
	movl	%edi, %eax		# move sqrt value into return register	
	ret

#------------------------------------------------------------------------------
.type combine, @function

combine:
	movl	%esp, %ebx
	xor		%eax, %eax
	incl	%eax
	xor		%ecx, %ecx
	addl	$10, %ecx
	xor		%edi, %edi
	movl	$0, -4(%esp)

c_loop:
	incl	%edi
	cmpl	$3, %edi
	jg		c_exit
	addl	$4, %ebx
	mull	-4(%esp)
	movl	%eax, -4(%esp)
	movl	(%ebx), %edx
	addl	%edx, -4(%esp)
	xor		%eax, %eax
	incl	%eax

c_inner_loop:
	cmpl	4(%ebx), %eax
	jg		c_loop
	mul		%ecx
	jmp		c_inner_loop

c_exit:
	movl	-4(%esp), %eax
	ret



















