#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 22
#------------------------------------------------------------------------------
# Using names.txt (right click and 'Save Link/Target As...'), a 46K text file 
# containing over five-thousand first names, begin by sorting it into 
# alphabetical order. Then working out the alphabetical value for each name, 
# multiply this value by its alphabetical position in the list to obtain a name 
# score.
# 
# For example, when the list is sorted into alphabetical order, COLIN, which is 
# worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN 
# would obtain a score of 938  53 = 49714.
#
# What is the total of all the name scores in the file?
#------------------------------------------------------------------------------
# SOLUTION: 871198282
#------------------------------------------------------------------------------
# as -32 22.s -o 22.o
# gcc -m32 22.o -o 22
#------------------------------------------------------------------------------

filename:
    .asciz  "22names.txt"

dec32_format:
	.string "%d\n"

.section .text
.globl main
 
main:
	pushl	$filename
	call	read_file
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
.type read_file, @ function

read_file:
    xor 	%edx, %edx
    mov  	$0x05, %al 
    mov 	4(%esp), %ebx  
    xor 	%ecx, %ecx  
    int 	$0x80
    mov 	%eax, %esi 

	xor		%edi, %edi
	addl	$1, %edi
	pushl	$0					# total
	addl	$-4, %esp
 
rf_read_loop:
    lea  	(%esp), %ecx  
	mov		$0x03, %eax
    mov  	$0x03, %al 
    mov 	%esi, %ebx
    mov  	$0x01, %dl    
    int  	$0x80         
    test  	%eax, %eax   		# EOF?
    jz   	rf_exit   

	movzx	(%ecx), %ecx		# move asci value into ecx
	cmpl	$10, %ecx			# check if it's a new line
	jne		rf_rl_skip
	incl	%edi				# increments edi if it is
	jmp		rf_read_loop
rf_rl_skip:
	addl	$-64, %ecx			# get number value
	movl	%ecx, %eax		
	mul		%edi				# multiply it by edi
	addl	%eax, 4(%esp)   	# add it into sum
    jmp  	rf_read_loop        		# read the next char

rf_exit: 
	movl	4(%esp), %eax
	addl	$8, %esp
	ret
