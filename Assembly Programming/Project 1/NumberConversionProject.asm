	.data

menu:		.asciiz	"1. Binary to Hexadecimal and Decimal \n2. Hexadecimal to Binary and Decimal \n3. Decimal to Binary and Hexadecimal \n4. Exit\n"
error:		.asciiz	"\nPLEASE ENTER A VALUE BETWEEN 1-4\n"
binary:		.asciiz	"\nBinary Number: "
hexadecimal:	.asciiz	"\nHexadecimal Number: "
decimal:		.asciiz	"\nDecimal Number: "

one:		.word	1
two:		.word 	2
three:		.word	3
four:		.word	4

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
	syscall
	
	#Move input
	move $t0, $v0
	
	#Load Options Address
	la $t1, one
	la $t2, two
	la $t3, three
	la $t4, four
	
	beq $v0, $t1, from_binary
	beq $v0, $t2, from_hexadecimal
	beq $v0, $t3, from_decimal
	beq $v0, $t4, exit
	
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
	syscall
	
	#Move value to t0(temporary register)
	move $t0, $v0
	
	#Exit back to menu
	j display_menu

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
	syscall
	
	#Move value to t0(temporary register)
	move $t0, $v0
	
	#Exit back to menu
	j display_menu

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
	syscall
	
	#Move value to t0(temporary register)
	move $t0, $v0
	
	#Exit back to menu
	j display_menu

exit:
	li $v0, 10
	syscall
