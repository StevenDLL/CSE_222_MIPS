	.data
evenMSG:	.asciiz	"Even Number \n"
oddMSG:	.asciiz "Odd Number \n"
currentValue	.word 0
	
	.text
	
main:

#Generate random number between 0-100
	li $a1, 101
	li $v0, 42
	syscall
	
	li
	
	jal function1 #Jump to function 1
	
	li $v0, 10
	syscall
	
function1: #Check if number is even or odd
	
	li $t0, 2
	#Do division
	div $a0, $t0
	mfhi $t1
	beq $t1, $0, EVEN #if remainder is zero then display message
	la $a0, oddMSG
	j display
	
	#Check UPPER bound and see if value in it is equal to 0, if not then its ODD
	

EVEN:
	la $a0, evenMSG

	
display:
	li $v0, 4
	syscall
	jr $ra
	
terminate:
	