	.data
	
msg:	.asciiz "\n"	

	.text
main: 	
	#Add Immediately 
	addi $t0, $0, 0xAB24
	
	#Shift left by 16 bits and lose MSB, LSB becomes 0
	sll $t0, $t0, 16
	addi $t1, $0, 0xCD68
	or $s0, $t0, $t1
	
	move $a0, $s0 
	
	#Display as hexadecimal
	li $v0, 34
	syscall
	
	#Shift left by 16 bits and lose MSB, LSB becomes 0
	sll $s1, $s0, 16
	
	#Shift right by 16 bits and lose LSB, MSB becomes 0
	srl $s2, $s0, 16
	
	#Add s1 and s2, save in s3
	add $s3, $s1, $s2
	
	#Display line break
	la $a0, msg
	li $v0, 4
	syscall 
	
	#Move value in s3 into a0 to display
	move $a0, $s3
	
	#Display as hexadecimal
	li $v0, 34
	syscall
	
	la $a0, msg
	li $v0, 4
	syscall 
	
	#Filter position
	andi $s2, $s2, 0x5555
	srl $s1, $s1, 16
	#Filter by position
	andi $s1, $s1, 0x5555
	sll $s1, $s1, 16
	
	add $s3, $s1, $s2
	
	move $a0, $s3
	
	#Display as binary
	li $v0, 35
	syscall
	
	li $v0, 10
	syscall
	
	
