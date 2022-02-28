	.data
var1:	.word 0
var2:	.word 0
msg1: 	.space 50
msg2:	.asciiz "Enter the FIRST number:"
msg3:	.asciiz "Enter the SECOND number:"

	.text
main:		

	la $a0, msg2
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	sw $v0, 0($a0)
	
	move $t0, $v0
	
	la $a0, msg3
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	sw $v0, 0($a0)
	
	add $s0, $t0, $v0
	li $v0, 1
	
	move $a0, $s0
	li $v0, 1
	syscall
	
	li $v0, 10

#	la $a0, var1
#	lw $t0, 0($a0)
	
#	move $a0, $t0
#	li $v0, 1
#	syscall
	
#	la $a0, msg2
#	li $v0, 4
#	syscall
	
#	li $v0, 5
#	syscall
	
#	li $v0, 10
#	syscall
	
#	la $a0, var2
#	lw $t0, 0($a0)
#	move $a0, $t0
#	li $v0, 1
#	syscall
	