	.data
msg:	.asciiz "\n"	


	.text
main: 	

	lui $s0, 0xEAFB
	ori $s0, $s0, 0x89CD
	
	#Shift left by 1 bit and lose MSB, LSB becomes 0
	sll $s1, $s0, 1
	
	#Shift right by 1 bit and lose MSB, LSB becomes 0
	srl $s2, $s0, 1
	
	#Shift right arithmetically by 1 bit, MSB becomes number sign
	sra $s3, $s0, 1
	
	#Move s1 into a0 and display as hexidecimal
	move $a0, $s1 
	li $v0, 34
	syscall 

	#Load msg into a0 then display line break
	la $a0, msg
	li $v0, 4
	syscall 
	
	#Move value from s2 into a0 and then display as hexadecimal
	move $a0, $s2 
	li $v0, 34
	syscall 

	#Display line break
	la $a0, msg 
	li $v0, 4
	syscall 
	
	#Move value from s3 into a0 and then display as hexadecimal
	move $a0, $s3
	li $v0, 34
	syscall 
	
	#Display line break
	la $a0, msg
	li $v0, 4
	syscall 
