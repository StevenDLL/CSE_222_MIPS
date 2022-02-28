	.data
	
	.text
main:
	#load number 0xABCD1234 into $s0
	addi $t0, $0, 0xABCD
	sll $t0, $t0, 16
	addi $t1, $0, 0x1234
	or $s0, $t0, $t1
	
	move $a0, $s0
	li $v0, 34
	syscall
	
	li $v0, 35
	syscall
	
	li $v0, 10
	syscall
