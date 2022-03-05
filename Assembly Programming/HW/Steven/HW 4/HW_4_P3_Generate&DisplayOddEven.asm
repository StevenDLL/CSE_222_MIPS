	.data
EVEN:	.asciiz "Even Number.\n"
ODD:	.asciiz "Odd Number. \n"
line:	.asciiz "\n"

	.text
	
generateRandom:
	addi $a1, $0, 99 	#Set upper-bound of random number to 98
	li $v0, 42 		#Generate random number of range [0,98]
	syscall 		#Call generation
	
	add $t0, $a0, 1		#Add 1 to the value in a0(randomly generated number)
	li $v0,1 		#Display value
	
	move $a0, $t0 		#Move our value to a0 to display
	syscall			#Call Display
	
	
	
#Check if EVEN or ODD by using div
checkValue:
	la $a0, line #Print new line
	li $v0, 4
	syscall
	
	li $t1, 2		#Set value of t1 to 2
	div $t0, $t1		#Divide t0 by t1
	mfhi $t2		#Move remainder to t2
	beq $t2, $0, isEven	#Check if t2 is 0, if it is go to isEven label
	j isOdd			#If this is reached then the value must be odd
	
	
	
#Check if EVEN or ODD by using srl
newCheckValue:
	la $a0, line #Print new line
	li $v0, 4
	syscall
	
	srl $t3, $t0, 1
	sll $t3, $t3, 1
	beq $t0, $t3, isEven
	j isOdd

	j terminate

isEven:
	la $a0, line #Print new line
	li $v0, 4
	syscall
	
	la $a0, EVEN
	li $v0, 4
	syscall	
	
	j terminate
	
isOdd:
	la $a0, line #Print new line
	li $v0, 4
	syscall
	
	la $a0, ODD
	li $v0, 4
	syscall
	
	j terminate

terminate:
	li $v0, 10
	syscall