#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 27
#------------------------------------------------------------------------------
# Euler published the remarkable quadratic formula:
#
# n² + n + 41
#
# It turns out that the formula will produce 40 primes for the consecutive 
# values n = 0 to 39. However, when n = 40, 402 + 40 + 41 = 40(40 + 1) + 41 
# is divisible by 41, and certainly when n = 41, 41² + 41 + 41 is clearly 
# divisible by 41.
#
# Using computers, the incredible formula  n² - 79n + 1601 was discovered, 
# which produces 80 primes for the consecutive values n = 0 to 79. The
# product of the coefficients, -79 and 1601, is 126479.
#
# Considering quadratics of the form:
#
# n² + an + b, where |a| < 1000 and |b| < 1000
#
# where |n| is the modulus/absolute value of n
# e.g. |11| = 11 and |-4| = 4
#Find the product of the coefficients, a and b, for the quadratic expression 
# that produces the maximum number of primes for consecutive values of n,
# starting with n = 0.
#------------------------------------------------------------------------------
# SOLUTION: -59231
#------------------------------------------------------------------------------
# as -32 27.s -o 27.o
# gcc -m32 27.o -o 27
#------------------------------------------------------------------------------

dec32_format:
	.string "%d\n"

.section .text
.globl main

main:
	call	find_prod_of_coefficients
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
.type find_prod_of_coefficients, @ function

find_prod_of_coefficients:
	xor		%edi, %edi
	xor		%ecx, %ecx
	addl	$-1000, %ecx
	pushl	$0

fpoc_main_loop:
	incl	%ecx
	cmpl	$1000, %ecx
	je		fpoc_exit
	xor		%ebx, %ebx
	addl	$-1000, %ebx

fpoc_inner_loop:
	incl	%ebx
	cmpl	$1000, %ebx
	je		fpoc_main_loop
	pushl	%edi
	pushl	%ecx
	pushl	%ebx
	call	number_of_primes
	popl	%ebx
	popl	%ecx
	popl	%edi
	cmpl	%edi, %eax
	jle		fpoc_inner_loop
	movl	%eax, %edi
	movl	%ecx, %eax
	mul		%ebx
	movl	%eax, (%esp)
	jmp		fpoc_inner_loop

fpoc_exit:
	popl	%eax
	ret

#------------------------------------------------------------------------------
.type number_of_primes, @ function

number_of_primes:
	xor		%edi, %edi

nop_loop:
	xor		%ecx, %ecx

	movl	%edi, %eax		# N*N
	mul		%edi
	addl	%eax, %ecx

	movl	8(%esp), %eax	# a*N
	mul		%edi
	addl	%eax, %ecx

	addl	4(%esp), %ecx	# b
	
	pushl	%edi
	pushl	%ecx
	call	is_prime
	popl	%ecx
	popl	%edi

	test	%eax, %eax
	jz		nop_exit

	incl	%edi

	jmp		nop_loop

nop_exit:
	movl	%edi, %eax
	ret

#------------------------------------------------------------------------------
.type is_prime, @function

is_prime:
	pushl	%ebp			# save old base pointer
	movl	%esp, %ebp		# create new stack pointer
	cmpl	$2, 8(%ebp)		# compares argument to 2
	je		yes				# if it's equal it's prime
	jl		no				# if it's less than it's not prime
	movl	8(%ebp), %eax	
	andl	$1, %eax		# check if it's even
	cmpl	$0, %eax
	je		no
	pushl	$0				# high part of parameter
	pushl	8(%ebp)			# low part of parameter
	call	sqrt_approx		# call sqrt function
	addl	$8, %esp		# restores sp
	movl	%eax, %ecx		# assigns sqrt to ecx
	movl	$3, %edi		# i = 3

prime_loop:
	cmpl	%ecx, %edi 		# i >= sqrt(arg) ?
	jg		yes				# quit if it is
	xor		%edx, %edx		# higher part of dividend
	movl	8(%ebp), %eax	# lower part of dividend
	divl	%edi			# divides current by index
	test	%edx, %edx		# checks if remainder is 0
	jz		no				# if it is it's not a prime
	addl	$2, %edi		# index+=2
	jmp		prime_loop		# do it again

yes:
	xor		%eax, %eax		# clears register
	incl	%eax			# sets result to "true"
	jmp		prime_exit		# exits

no:
	xor     %eax, %eax		# sets result to "false"

prime_exit:
	movl	%ebp, %esp		# stack pointer
	popl	%ebp			# restores base pointer
	ret

#------------------------------------------------------------------------------
.type sqrt_approx, @function

sqrt_approx:
	xor		%edi, %edi		# index/sqrt candidate
	incl	%edi

sqrt_loop:
	movl	%edi, %eax		# move sqrt into required mul register
	mul		%eax			# multiply said register by itself
	cmpl	8(%esp), %edx 	# compare high part of result with high part of number
	jl		continue		# skip next statements if it's less than
	cmpl	4(%esp), %eax	# compare low part of result with low part of number
	jae		sqrt_exit		# if it's greater than or equal leave

continue:
	incl	%edi			# else increment sqrt
	jmp		sqrt_loop		# do it again

sqrt_exit:
	movl	%edi, %eax		# move sqrt value into return register	
	ret











