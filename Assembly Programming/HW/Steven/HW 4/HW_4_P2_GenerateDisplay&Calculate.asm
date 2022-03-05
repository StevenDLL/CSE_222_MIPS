	.data
	
number:	.word 0

line:	.asciiz "\n"

	.text
	
generateRandom:
	addi $a1, $0, 21 	#Set upper-bound of random number to 10
	li $v0, 42 		#Generate random number of range [0,10]
	syscall 		#Call generation
	
	sub $t0, $a0, 10	#Subtract 10 from the value in a0(randomly generated number)
	sw $t0, number 		#Save the value found in t0 to our number variable
	
	li $v0,1 		#Display value
	move $a0, $t0 		#Move our value to a0 to display
	syscall			#Call Display
	
	
#Use mul to do 5 * number then display
doMultiplication:
	la $a0, line #Print new line
	li $v0, 4
	syscall
	
	addi $s0, $0, 5 #Set s0 to the value 5
	lw $s1, number #Set s1 to the random generated value
	
	mul $t0, $s0, $s1 #Do Multiplication
	
	li $v0, 1
	add $a0, $0, $t0
	syscall

#Use mult to get hi and lo values
doNewMultiplication:
	la $a0, line #Print new line
	li $v0, 4
	syscall
	
	addi $t0, $0, 5 #Set s0 to the value 5
	lw $t1, number #Set s1 to the random generated value
	
	mult $t0, $t1 #Do Multiplication
	
	mflo $s0 #Move quotient to register s0
	
	li $v0, 1
	add $a0, $0, $s0 #Add quotient to a0
	syscall
	
	la $a0, line #Print new line
	li $v0, 4
	syscall
	
	mfhi $s1 #Move remainder to register s1
	li $v0, 1
	add $a0, $0, $s1
	syscall
	
	
terminate:
	li $v0, 10
	syscall