	.data
	
array:	.space 40
size:	.word 10

	.text
main:
	la $s0, array
	la $a0, size
	lw $s1, 0($a0)
	li $t0, 0
	
loop:
	beq $s1, $t0, step
	li $a0, 20
	jal generate
	sw $v0, 0($s0)
	addi $s0, $s0, 4 #Increase current base address by 1
	addi $t0, $t0, 1 #Increase current index by 1
	j loop		#Start the current loop again to generate another random number
	
	
check_number:
	li $t1, 2
	div  $a0, $t1
	mfhi $v0
	jr $ra
	
step:
	la $a0, array
	la $a2, size
	lw $a1, 0($a2)
	jal func1	
	
	li $v0, 10
	syscall
	
generate:
	move $a1, $a0
	li $v0, 42
	syscall
	move $v0, $a0
	jr $ra
	

func1: #Count even elements in array and display count
	li $s2, 0 #Current count of even elements
	li $t0, 0 #Current Index
	move $a2, $a0

	
loop2:
	beq $t0, $a1, done
	lw $a0, 0($a2)
	jal check_number
	beq $v0, $0, addOne
	j addFour
	
addOne:
	addi $s2, $s2, 1 #add one to the current even count
	
addFour:
	addi $a2, $a2, 4 #increase current address by 4
	addi $t0, $t0, 1
	j loop2
	
done:
	move $v0, $s2
	jr $ra