	.data
	
msg1:	.asciiz "First Message \n"
msg2:	.asciiz "Second Message \n"
msg3:	.asciiz "Third Message \n"
end:	.asciiz "Reached End Correctly"

	.text

main:
	#Jump to first function
	jal sayFirstMessage
	j terminate

sayFirstMessage:

	#Make space on $sp(stack) for address then save $ra(register address)
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	#Load message 1, then display via syscall
	li $v0, 4
	la $a0, msg1
	syscall
	
	#Jump to next function
	jal saySecondMessage
	
	#Load previous functions $ra(register address) and then delete it from $sp(the stack)
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	

saySecondMessage:

	li $v0, 4
	la $a0, msg2
	syscall
	
	#Make space on $sp(stack) for address then save $ra(register address)
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	jal sayThirdMessage
	
	#Load previous functions $ra(register address) and then delete it from $sp(the stack)
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
sayThirdMessage:

	li $v0, 4
	la $a0, msg3
	syscall
	
	#Load previous functions $ra(register address) and then delete it from $sp(the stack)
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

terminate:

	li $v0, 4
	la $a0, end
	syscall

	li $v0, 10
	syscall
