	.data

#MESSAGES
line_break:	.asciiz	"\n"
explanation:	.asciiz	"Input a value between 1-4(each corresponds to an option on the menu below) \n"	
menu:		.asciiz	"1. Binary to Hexadecimal and Decimal \n2. Hexadecimal to Binary and Decimal \n3. Decimal to Binary and Hexadecimal \n4. Exit\n"
error:		.asciiz	"\nINVALID INPUT\n"

get_message:	.asciiz	"Enter A Value...\n"
binary:		.asciiz	"\nBinary Number: "
hexadecimal:	.asciiz	"\nHexadecimal Number: "
decimal:	.asciiz	"\nDecimal Number: "

#VALUES
buffer:		.space	32
one:		.word	1
two:		.word 	2
three:		.word	3
four:		.word	4
	.text
	
display_menu:

	#Display a new line break
	la $a0, line_break
	li $v0, 4
	syscall

	#Print explanation
	la $a0, explanation
	li $v0, 4
	syscall
	
	#Print menu options
	la $a0, menu
	li $v0, 4
	syscall
	
	#Read user-input
	li $v0, 5
	syscall
	
	#Save user-input
	move $s0, $v0
	
	#Load options address
	lw $t1, one
	lw $t2, two
	lw $t3, three
	lw $t4, four
	
	#Check user-input against possible options
	beq $s0, $t1, from_binary
	beq $s0, $t2, from_hexadecimal
	beq $s0, $t3, from_decimal
	beq $s0, $t4, exit
	
	#Display error message
	li $v0, 4
	la $a0, error
	syscall
	
	j display_menu
	
from_binary:

	#Display entry message
	la $a0, get_message
	li $v0, 4
	syscall
	
	#Display entry message
	la $a0, binary
	li $v0, 4
	syscall
	
	#Get user-input and run main loop
	jal get_user_input
	jal loop_start
	
	#Display Binary message
	la $a0, binary
	li $v0, 4
	syscall
	
	#Display Binary value
	li $v0, 35
	move $a0, $t2
	syscall
	
	#Display Hexadecimal message
	la $a0, hexadecimal
	li $v0, 4
	syscall
	
	#Display Hexadecimal value
	li $v0, 34
	move $a0, $t2
	syscall
	
	#Display Decimal message
	la $a0, decimal
	li $v0, 4
	syscall
	
	#Display Decimal value
	li $v0, 1
	move $a0, $t2
	syscall
	
	#Display a new line break
	la $a0, line_break
	li $v0, 4
	syscall
	
	j display_menu

from_hexadecimal:
	#Display entry message
	la $a0, get_message
	li $v0, 4
	syscall
	
	#Display entry message
	la $a0, hexadecimal
	li $v0, 4
	syscall
	
	#Get user-input and run main loop
	jal get_user_input
	jal loop_start
	
	#Display Binary message
	la $a0, binary
	li $v0, 4
	syscall
	
	#Display Binary value
	li $v0, 35
	move $a0, $t2
	syscall
	
	#Display Hexadecimal message
	la $a0, hexadecimal
	li $v0, 4
	syscall
	
	#Display Hexadecimal value
	li $v0, 34
	move $a0, $t2
	syscall
	
	#Display Decimal message
	la $a0, decimal
	li $v0, 4
	syscall
	
	#Display Decimal value
	li $v0, 1
	move $a0, $t2
	syscall
	
	#Display a new line break
	la $a0, line_break
	li $v0, 4
	syscall
	
	j display_menu

from_decimal:
	#Display entry message
	la $a0, get_message
	li $v0, 4
	syscall
	
	#Display entry message
	la $a0, decimal
	li $v0, 4
	syscall
	
	#Get user-input and run main loop
	jal get_user_input
	jal loop_start
	
	#Display Binary message
	la $a0, binary
	li $v0, 4
	syscall
	
	#Display Binary value
	li $v0, 35
	move $a0, $t2
	syscall
	
	#Display Hexadecimal message
	la $a0, hexadecimal
	li $v0, 4
	syscall
	
	#Display Hexadecimal value
	li $v0, 34
	move $a0, $t2
	syscall
	
	#Display Decimal message
	la $a0, decimal
	li $v0, 4
	syscall
	
	#Display Decimal value
	li $v0, 1
	move $a0, $t2
	syscall
	
	#Display a new line break
	la $a0, line_break
	li $v0, 4
	syscall
	
	j display_menu		
						
						
get_user_input:

	#Make space is stack and save ra
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	#Set max length of input then read user-input
	li $v0, 8
	la $a0, buffer
	li $a1, 32
	syscall
	
	#Get buffer address, setup temporary total variable, save value of a new line
	la $t0, buffer
	addi $t2, $0, 0
	li $t3, 0x0A
	
	#Pop stack after loading register address
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
loop_start:

	#Make space is stack and save ra
	addi $sp, $sp, -4
	sw $ra, 0($sp)

loop:
	#Get buffer[i]
	lbu $t1, 0($t0)
	#Check place in string loop
	beq $t1, $t3, loop_end
	beq $t1, $0, loop_end
	
	#Check which criteria input meets
	beq $s0, 1, verify_binary
	beq $s0, 2, verify_hexadecimal
	beq $s0, 3, verify_decimal
	
loop_middle:
	#Get value of current character
	add $t2, $t2, $t1
	
	#Increment index and continue loop
	addi $t0, $t0, 1
	j loop
	
loop_end:
	#Save value found in stack into ra then pop and jump back
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
verify_binary:
	#Check if current value is either 0 or 1
	blt $t1, '0', invalid_input
	bgt $t1, '1', invalid_input
	
	#Valid input so convert to binary representation by shifting
	subi $t1, $t1, '0'
	j do_binary_shift
	
verify_hexadecimal:
	#Check if current value is between 0-9
	check_hexadecimal_digit:
	blt $t1, '0', invalid_input
	bgt $t1, '9', check_upper_hexadecimal
	subi $t1, $t1, '0'
	j do_hexadecimal_shift
	
	#Check if current value is between a-f
	check_lower_hexadecimal:
	blt $t1, 'a', invalid_input
	bgt $t1, 'f', invalid_input
	subi $t1, $t1, 'a'
	addi $t1, $t1, 10
	j do_hexadecimal_shift
	
	#Check if current value is between A-F
	check_upper_hexadecimal:
	blt $t1, 'A', invalid_input
	bgt $t1, 'F', check_lower_hexadecimal
	subi $t1, $t1, 'A'
	addi $t1, $t1, 10
	j do_hexadecimal_shift



verify_decimal:
	#Check if current value is between 0-9
	blt $t1, '0', invalid_input
	bgt $t1, '9', invalid_input
	
	#Valid input so convert to decimal representation by shifting
	subi $t1, $t1, '0'
	j do_decimal_shift
	
	
	
invalid_input:
	#Display error message
	la $a0, error
	li $v0, 4
	syscall
	
	#Try to jump back to correct method/function
	beq $s0, 1, from_binary
	beq $s0, 2, from_hexadecimal
	beq $s0, 3, from_decimal
	
	#If all else fails then just jump back to menu display(i.e restart the process)
	j display_menu



do_binary_shift:
	#Shift left by 1 bit to get binary value
	sll $t2, $t2, 1
	j loop_middle
	
	
	
do_hexadecimal_shift:
	#Shift left by 4 bits to get hexadecimal value
	sll $t2, $t2, 4
	j loop_middle
	
	
	
do_decimal_shift:
	#Multiply left by 10 to get decimal value
	mul $t2, $t2, 10
	j loop_middle




exit:
	#Exit the application
	li $v0, 10
	syscall