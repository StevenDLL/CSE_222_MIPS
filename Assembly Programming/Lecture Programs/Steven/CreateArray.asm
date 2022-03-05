
	.data
#Define array, reserve 40 bytes for it
array:	.space 40

#Define variable to keep trap of array size(10 in this case)
size:	.word 10

	.text
main:

#Load the arrays base address 
	la $s0, array

#Load size address array
	la $t0, size
	
#Load the arrays size number(10) from the s1 register	
	lw $s1, 0($t0)

#Check if the current array location is less than 10
	addi $t1, $0, 0
	
#Set the upper bound of the number being generated(actual max would be 20)
	addi $a1, $0, 21
	
#Generate a random number
	li $v0, 42
	
#Array loop
loop:

#Check if s1 is equal to 10, otherwise continue
	beq $t1, $s1, done
	syscall
	
#Save randomly generated number to s0
	sw $a0, 0($s0)
	
#Add 4bytes to s0 to get next index address
	addi $s0, $s0, 4
	
#Increase current index by 1
	addi $t1, $t1,1
	
#Run loop again
	j loop
done:
#Terminate program
	li $v0, 10
	syscall


