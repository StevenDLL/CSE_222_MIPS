		.data
		
line_break:	.asciiz	"\n"
	
		.text

#Entry point
code:
	#Get first random number
	jal generate_number
	add $t1, $0 ,$a0
	
	#Display a new line break
	la $a0, line_break
	li $v0, 4
	syscall
	
	#Get second random number
	jal generate_number
	add $t2, $0, $a0
	
	#Display a new line break
	la $a0, line_break
	li $v0, 4
	syscall
	
	#Move values to parameter registers
	move $a0, $t1
	move $a1, $t2
	
	#Get absolute difference
	jal absolute_difference
	add $t3, $0 ,$v0
	
	add $a0, $0 ,$t3
	li $v0, 1
	syscall
	
	j exit

#Number Generation	
generate_number:
	#Make space is stack and save ra
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	#Generate Random Number
	li $v0, 42
	#Set random number upper limit
	li $a1, 30
	#Call generation
	syscall
	
	#If needed add for lowerbound
	add $a0, $a0, 0
	
	#Move result to return register
	move $v0, $a0
	
	#display number
	li $v0, 1
	syscall

	#Pop stack after loading register address
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

#Get absolute difference between two values
absolute_difference:
	#Make space is stack and save ra
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	#Move values to temporary register
	add $t4, $0, $a0
	add $t5, $0, $a1
	
	sub $t6, $t4, $t5
	abs $t7, $t6
	
	move $v0, $t7
	
	#Pop stack after loading register address
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
	
exit:
	li $v0, 10
	syscall