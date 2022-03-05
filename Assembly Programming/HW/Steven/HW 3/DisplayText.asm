	.data
msg1:	.asciiz "Computer Archetecture\n"
msg2:	.asciiz "SCCC - Suffolk County Community College"


	.text
main: 	la $a0, msg1
	li $v0, 4
	syscall
	
	la $a0, msg2
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall
