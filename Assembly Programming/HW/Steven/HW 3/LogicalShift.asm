	.data
msg:	.asciiz "\n"	


	.text
main: 	lui $s0, 0xEAFB
	ori $s0, $s0, 0x89CD
	
	sll $s1, $s0, 1
	srl $s2, $s0, 1
	sra $s3, $s0, 1
	
	move $a0, $s1 
	li $v0, 34
	syscall 
	
	la $a0, msg
	li $v0, 4
	syscall 
	
	#Move value from s2 into a0 and then display as hexadecimal
	move $a0, $s2 
	li $v0, 34
	syscall 
	
	la $a0, msg 
	li $v0, 4
	syscall 
	
	#Move value from s3 into a0 and then display as hexadecimal
	move $a0, $s3
	li $v0, 34
	syscall 
	
	la $a0, msg
	li $v0, 4
	syscall 
