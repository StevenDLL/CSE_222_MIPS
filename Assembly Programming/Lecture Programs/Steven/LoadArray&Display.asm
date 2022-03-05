
	.data

array:	.space 40		#Define array, reserve 40 bytes for it
size:	.word 10			#Define variable to keep trap of array size(10 in this case)

	.text
main:

	la $s0, array		#Load the arrays base address 
	la $t0, size		#Load size address array
	lw $s1, 0($t0)		#Load the arrays size number(10) from the s1 register	
	addi $t1, $0, 0		#Check if the current array location is less than 10
	addi $a1, $0, 21		#Set the upper bound of the number being generated(actual max would be 20)
	li $v0, 42		#Generate a random number
	
loop: 				#Array loop

	beq $t1, $s1, done	#Check if s1 is equal to 10, otherwise continue
	syscall
	sw $a0, 0($s0)		#Save randomly generated number to s0
	addi $s0, $s0, 4		#Add 4bytes to s0 to get next index address
	addi $t1, $t1,1		#Increase current index by 1
	j loop			#Run loop again
	
done:				#Terminate program
	li $v0, array
	addi $t1, $0, 0 		#Get index
	li $v0, 1

display:
	beq $t1, $s1, termiante
	lw $a0, 0($s0)
	syscall
	addi $s0, $a0, 4
	addi $t1, $t1, 1
	j display
	
terminate:
	li $v0, 10
	syscall

