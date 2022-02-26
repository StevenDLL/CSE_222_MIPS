	.data
v1:	.word 0
v2:	.word 0
msg1:	.asciiz "Enter a number to divide: "
msg2:	.asciiz "Enter the number to divide by: "
msg3:	.asciiz "Quotient: "
msg4:	.asciiz " Remainder: "


	.text 
main: 	
	#Load msg1 into a0 and display
	la $a0, msg1
	li $v0, 4
	syscall 
	
	#Get user input and save to v1
	la $v0, 5
	syscall
	la $a0, v1
	sw $v0, 0($a0)
	
	#Move value in v0 into t1
	move $t1, $v0 
	
	#Load msg2 into a0 and display
	la $a0, msg2
	li $v0, 4
	syscall 
	
	#Get user input and save to v2
	la $v0, 5
	syscall
	la $a0, v2
	sw $v0, 0($a0)
	
	#Move value in v0 into t2
	move $t2, $v0 
	
	#Divide t1 by t2
	div $t1, $t2
	
	#Load upper 32 bit from t2
	mfhi $t2
	
	#Load lower 32 bit from t1
	mflo $t1
	
	#Load msg3 into a0 and display
	la $a0, msg3
	li $v0, 4
	syscall 
	
	#Move value in t1(Quotient) into a0 then display
	move $a0, $t1
	li $v0, 1
	syscall
	
	#Load msg4 into a0 and display
	la $a0, msg4
	li $v0, 4
	syscall 
	
	#Move value in t2(Remainder) into a0 then display
	move $a0, $t2
	li $v0, 1
	syscall
	
	
