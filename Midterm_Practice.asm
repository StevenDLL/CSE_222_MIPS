	.data
	
array:		.space	48	#Total space needed for the array(4 bits per item)
size:		.word	12	#Total amount of items being held

evenMsg:	.asciiz " Elements are EVEN in the array"
line:		.asciiz "\n"
evenCount:	.word	0

	.text

main:

	#Load base array address into argument 0
	la $a0, array
	
	#Load array size into arugment 1
	lw $a1, size
	
	#Jump to generateArray function
	jal generateArray
	
	#Load base arry address into argument 0
	la $a0, array
	
	#Load array size into arugment 1
	lw $a1, size
	
	#Jump to displayArray function
	jal displayArray
	
	#Load the address of evenCount
	la $s5, evenCount
	
	#Jump to displayCount function
	jal displayCount
	
	#Jump to our terminate funciton
	j terminate
	
#Given an Arrays base address and size as arguments, fill this array with random values
generateArray:
	#Make space in stack for new register address
	addi $sp, $sp, -4
	
	#Save register address to stack
	sw $ra, 0($sp)

	#Move base address to t0
	move $s3, $a0
	
	#Move size to t1
	move $s4, $a1
	
	#Set Current Index
	li $t2, 0
	
	#Set lower-bound
	li $a0, -5
	
	#Set upper-bound
	li $a1, 11
	
	#Jump into loop
	j generationLoop
	
	
generationLoop:
	#Check if our index is the same as the max size of the array, if it is then exit the loop
	beq $s4, $t2, exitLoop
	
	#Generate random number
	jal randomInterger
	
	#Save random interger into array
	sw $v0, 0($s3)
	
	#Increase base address by 4 to get next location
	addi $s3, $s3, 4
	
	#Increase current index by 1
	addi $t2, $t2, 1
	
	#Run this loop again
	j generationLoop
		
exitLoop:
	#Load the lastest register address found in the stack to ra
	lw $ra, 0($sp)
	
	#Erase the 4 bits said register address was using
	addi $sp, $sp, 4
	
	#Return to function that called this
	jr $ra

#Given the lower & upper bound as arguments, generate a number in this range
randomInterger:
	#Move a0(lower-bound) value into a temporary rigister(t0)
	move $t0, $a0
	#Move a1(upper-bound) value into a temporary rigister(t1)
	move $t1, $a1
	
	#Move lower bound to a temporary register since a0 will become the randomly generated number by system 42
	move $t3, $a0

	li $v0, 42
	syscall
	
	#Add or subtract whatever value was set as the lower-bound
	add $t4, $a0, $t0

	#Move lower-bound back to a0 since we already got the random value
	move $a0, $t3
	
	#Move value to v0 as return argument
	move $v0, $t4
	
	#Return to function that called this
	jr $ra
	

#Given a value as an argument check if this interger is EVEN or ODD, return 0 for EVEN, return 1 for ODD
checkInterger:
	#Move a0(interger) value into a temporary rigister(t0)
	move $t0, $a0
	li $t1, 2
	
	#Divide given interger by 2, if EVEN the remainder will be 0 else its ODD
	div $t0, $t1
	
	#Move remainder to temporaty register
	mfhi $t3
	
	#Make space in stack for new register address
	addi $sp, $sp, -4
	
	#Save new register address in stack
	sw $ra, 0($sp)
	
	#Check if the remainder is equal to zero, if so go to isEven Function
	beq $t3, $0, isEven
	
	#Check if t3 isn't equal to zero, if so go to isOdd function
	bnez $t3, isOdd
	
	#Return to function that called this
	jr $ra
	
isEven:
	#Load address of what called this function
	lw $ra, 0($sp)
	
	#Erase the 4 bits said register address was using
	addi $sp, $sp, 4
	
	#Load the address of our evenCount variable
	la $t0, evenCount
	
	#Increment value found in s5(evenCount) by 1
	addi $s5, $s5, 1
	
	#Save new value to t0(which holds the address of our count)
	sw $s5, 0($t0)
	
	#Since the value is even set return to 0
	li $v0, 0
	
	#Return to function that called this
	jr $ra


isOdd:
	#Load address of what called this function
	lw $ra, 0($sp)
	
	#Erase the 4 bits said register address was using
	addi $sp, $sp, 4
	
	#Since the value is odd set return to 1
	li $v0, 1
	
	#Return to function that called this
	jr $ra
	

#Given an Arrays base address and size as arguments, display said array.
displayArray:
	#Make space in stack for new register address
	addi $sp, $sp, -4
	
	#Save register address in stack
	sw $ra, 0($sp)

	#Move base address to t0
	move $s3, $a0
	
	#Move size to t1
	move $s4, $a1
	
	#Set Current Index
	li $t2, 0
	
	#Jump to displayLoop function
	j displayLoop
	
displayLoop:
	#Check to see if the array size and the current index are the same, if they are go to exitLoop function
	beq $s4, $t2, exitLoop
	
	#Load number found in current array address into a0
	lw $a0, 0($s3)
	
	#Display Interger
	li $v0, 1
	syscall
	
	#Jump to the checkInterger function
	jal checkInterger
	
	#Jump to the newLine function
	jal newLine
	
	#Add 4 bites to our current array address to get the next item
	addi $s3, $s3, 4
	
	#Increase our current index by 1
	addi $t2, $t2, 1
	
	#Jump to displayLoop function
	j displayLoop
	
displayCount:
	#Prepare to display interger
	li $v0, 1
	
	#Load interger found in evenCount as argument 0 
	lw $a0, evenCount
	
	#Display count
	syscall
	
	#Prepare to display message
	li $v0, 4
	
	#Load the address of our message as argument 0
	la $a0, evenMsg
	
	#Display message
	syscall
	
	#Return to function that called this
	jr $ra
	
newLine:
	#Prepare to display message
	li $v0, 4
	
	#Load the address of our message as argument 0
	la $a0, line
	
	#Display message
	syscall
	
	#Return to function that called this
	jr $ra

terminate:
	li $v0, 10
	syscall
