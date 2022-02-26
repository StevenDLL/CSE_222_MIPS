	.data
v1:	.word 0
v2:	.word 0
v3:	.word 0
msg1:	.asciiz "Enter a number: "
msg2:	.asciiz "\n"

	.text 
main: 	
	#Load address of msg1 and display
	la $a0, msg1
	li $v0, 4
	syscall 
	
	#Load address
	la $v0, 5
	syscall
	la $a0, v1
	sw $v0, 0($a0)
	
	move $t1, $v0 
	
	la $a0, msg1
	li $v0, 4
	syscall 
	
	la $v0, 5
	syscall
	la $a0, v2
	sw $v0, 0($a0)
	
	#Move value in v0 to t2
	move $t2, $v0 
	
	#Add t1 & t2, save it to t3
	add $t3, $t1, $t2
	
	#Move value in t1 to a0
	move $a0, $t1
	li $v0, 1
	syscall
	
	la $a0, msg2 
	li $v0, 4
	syscall
	
	#Move value in t2 to a0
	move $a0, $t2
	li $v0, 1
	syscall
	
	la $a0, msg2 
	li $v0, 4
	syscall
	
	#Move value in t3 to a0
	move $a0, $t3
	li $v0, 1
	syscall
