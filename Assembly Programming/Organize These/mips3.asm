	.data
msg3:	.asciiz "Greater than or equal 50 \n"
msg4:	.asciiz "Less than 50 \n"

	.text
main:
	li $a1, 100
	li $v0, 42
	syscall
	
	#display $a0
	li $v0, 1
	syscall
	
	li $t2, 50
	slt $t3, $a0,$t2
	beq $t3, $s0, lbl3
	la $a0, msg4
	j lbl4
	
lbl3:
	la $a0, msg3
	
lbl4:
	li $v0, 4
	syscall
	
	