	.data

menu:		.asciiz	"1. Binary to Hexadecimal and Decimal \n2. Hexadecimal to Binary and Decimal \n3. Decimal to Binary and Hexadecimal \n4. Exit\n"
error:		.asciiz	"\nPLEASE ENTER A VALUE BETWEEN 1-4\n"
binary:		.asciiz	"\nBinary Number: "
hexadecimal:	.asciiz	"\nHexadecimal Number: "
decimal:		.asciiz	"\nDecimal Number: "

one:		.asciiz	"1"
two:		.asciiz "2"
three:		.asciiz	"3"
four:		.asciiz	"4"

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
	li $v0, 8
	#Set MAX Characters to read
	li $a1, 30
	syscall
	
	#Move input
	move $t0, $v0
	
	#Load Options Address
	la $t1, one
	la $t2, two
	la $t3, three
	la $t4, four
	
	beq $t0, $t1, from_binary
	beq $t0, $t2, from_hexadecimal
	beq $t0, $t3, from_decimal
	beq $t0, $t4, exit
	
	la $a0, error
	li $v0, 4
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
	
	#Take Input
	li $v0, 8
	#Set MAX Characters to read
	li $a1, 30
	syscall
	
	#Move value to t0(temporary register)
	move $t0, $v0
	
	#Exit back to menu
	j display_menu



#Move user input from a0 to a t0
#Check that all values in said input are either 1's or 0's
#If it meets all criteria then jump back to from_binary and continue
#If it DOES'T meet all criteria then jump to invalid_input method, display message and then jump back to display_menu 
verify_binary:



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
	
	#Take Input
	li $v0, 8
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
	
	#Take Input
	li $v0, 8
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


#Exit the application
exit:
	li $v0, 10
	syscall
