	.data

menu:		.asciiz	"1. Binary to Hexadecimal and Decimal \n2. Hexadecimal to Binary and Decimal \n3. Decimal to Binary and Hexadecimal \n4. Exit\n"
error:		.asciiz	"\nINVALID INPUT\n"
binary:		.asciiz	"\nBinary Number: "
hexadecimal:	.asciiz	"\nHexadecimal Number: "
decimal:	.asciiz	"\nDecimal Number: "

one:		.word	1
two:		.word 	2
three:		.word	3
four:		.word	4

buffer:		.space	10
binary_num:	.space 	10
hexadecimal_num:.space	10
decimal_num:	.space	10

	.text

#Display Menu
#Read Input
#jump to correct method for said input.
display_menu:
	
	#Display Menu
	la $a0, menu
	li $v0, 4
	syscall
	
	#Read Input
	li $v0, 5
	syscall
	
	#Move input
	move $t0, $v0
	
	#Load Options Address
	lw $t1, one
	lw $t2, two
	lw $t3, three
	lw $t4, four
	
	beq $t0, $t1, from_binary
	beq $t0, $t2, from_hexadecimal
	beq $t0, $t3, from_decimal
	beq $t0, $t4, exit
	
	li $v0, 4
	la $a0, error
	syscall
	
	j display_menu



#Display give_input message
#Take in input
#Convert from binary to hexadecimal and decimal
#Display Results
#Exit back to menu
from_binary:

	#Display Message
	la $a0, binary
	li $v0, 4
	syscall
	
	#Read Input
	li $v0, 8
	#Set Address of input buffer
	la $a0, buffer
	#Set MAX Characters to read
	li $a1, 30
	syscall
		
	#Move value to a0
	move $a0, $v0
	
	#Make space in stack, save ra, then jump to verify
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	jal verify_binary
	
	#Make space in stack, save ra, then do conversions here
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal to_decimal
	
	#Print new values here
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	jal display_results
	
	#Exit back to menu
	j display_menu



#Move user input from a0 to a t0
#Check that all values in said input are either 1's or 0's
#If it meets all criteria then jump back to from_binary and continue
#If it DOES'T meet all criteria then jump to invalid_input method, display message and then jump back to display_menu 
verify_binary:
	move $t0, $a0
	
	#Save original buffer string Address
	la $s0, buffer
	
	#Set index
	addi $s1, $zero, 0
	

verify_loop:

	#Set t1 to address of buffer[i]
	add $t1, $s0, $s1
	
	#Set t2 to the contents of buffer[i]
	lbu $t2, 0($t1)
	
	#Increase index
	addi $s1, $s1, 1
	
	#Check if content = [NULL]
	beq $t2, $zero, exit
	#Check if content = [LINE FEED]
	beq $t2, 10, exit
	
	#Check if content = 0 or 1
	blt $t2, '0', return_error
	bgt $t2, '1', return_error
	
	j verify_loop

return_error:
	li $v0, 4
	la $a0, error
	syscall
	j display_menu
	
binary_verify_finished:
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	

#Display give_input message
#Take in input
#Convert from hexadecimal to binary and decimal
#Display Results
#Exit back to menu
from_hexadecimal:

	#Display Message
	la $a0, hexadecimal
	li $v0, 4
	syscall
	
	#Read Input
	li $v0, 8
	#Set Address of input buffer
	la $a0, buffer
	#Set MAX Characters to read
	li $a1, 30
	syscall
	
	#Move value to t0(temporary register)
	move $t0, $v0
	
	#Exit back to menu
	j display_menu

#Move user input from a0 to a t0
#Check that all values in said input contains values from 0-9 & A-F
#If it meets all criteria then jump back to from_hexadecimal and continue
#If it DOES'T meet all criteria then jump to invalid_input method, display message and then jump back to display_menu 
verify_hexadecimal:



#Display give_input message
#Take in input, 
#Convert from decimal to hexadecimal and binary
#Display Results
#Exit back to menu
from_decimal:

	#Display Message
	la $a0, decimal
	li $v0, 4
	syscall
	
	#Read Input
	li $v0, 8
	#Set Address of input buffer
	la $a0, buffer
	#Set MAX Characters to read
	li $a1, 30
	syscall
	
	#Move value to t0(temporary register)
	move $t0, $v0
	
	#Exit back to menu
	j display_menu



#Move user input from a0 to a t0
#Check that all values in said input are only numbers
#If it meets all criteria then jump back to from_decimal and continue
#If it DOES'T meet all criteria then jump to invalid_input method, display message and then jump back to display_menu 
verify_decimal:



to_binary:

to_hexadecimal:

to_decimal:	
	la $s0, buffer
	j to_decimal_loop
	
to_decimal_loop:

	#Check if s1 is 0, if it is then we looped and converted every value already
	beq $s1, $zero, binary_verify_finished
	
	#Set t1 to address of buffer[i]
	add $t1, $s0, $s1
	
	#Set t2 to the contents of buffer[i]
	lbu $t2, 0($t1)
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	beq $t2, '0', isZero
	beq $t2, '1' isOne
	
	addi $s1, $zero, -1
	
	j to_decimal_loop
	
isZero:
	mult $zero, $s1
	mfhi $t3
	
	addi $t4, $t3, 0
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
isOne:
	mult $zero, $s1
	mfhi $t3
	
	addi $t4, $t3, 0
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

display_results:

	#Display Binary Message & Number
	la $a0, binary
	li $v0, 4
	syscall
	
	la $a0, binary_num
	li $v0, 4
	syscall
	
	j display_menu
	

#Exit the application
exit:
	li $v0, 10
	syscall
