	.data 
array:	.space 	40
size:	.word	10
msg:	.asciiz "Amount of ODD numbers: "
line:	.asciiz "\n"
 
	.text
	
main:

	la $s0, array		# get array base address
	la $a0, size		# get size varibale base address
	lw $s1, 0($a0)		# get actual size of array
	li $t0, 0		# index of array
	
loop:	beq $s1, $t0, load_info
	li  $a0, 90		# Set random number range to [0,89]
	jal random_number
	sw  $v0, 0($s0)
	addi $s0, $s0, 4
	addi $t0, $t0, 1
	j   loop
	
	
load_info:	
	la $a0, array
	la $a2, size
	lw $a1, 0($a2)
	jal do_odd_count
	
	j print
	
	li $v0, 10
	syscall
	
	
# count ODD elements in array. return count 	
do_odd_count:  
	addi $sp, $sp, -4
	sw   $ra, 0($sp)

	li $s2, 0	# $s2: count of ODD elements
	li $t0, 0	# $t0: index
	move $a3, $a0
	
	
loop1:	
	beq $t0, $a1, done
	lw  $a0, 0($a3)
	jal check_input
	bne $v0, $0, add_one
	j   loop2	
	
	
add_one: 
	addi $s2, $s2, 1
	
	
	
loop2:	addi $a3, $a3, 4
	addi $t0, $t0, 1
	j    loop1



done:	
	move $v0, $s2
	lw   $ra, 0($sp)
	addi $sp, $sp, 4

	jr   $ra

	
# generate a random number
random_number:	
	move $a1, $a0
	li $v0, 42
	syscall
	move $v0, $a0
	addi $v0, $a0, 10 #Add 10 to the random number to convert to a range of [10,99]
	
	move $t9, $v0
	
	li $v0, 1
	syscall
	
	la $a0, line #Print new line
	li $v0, 4
	syscall
	
	move $v0, $t9
	
	jr $ra
	
	
# check input to see if ODD or not
check_input:	
	li  $t1, 2
	div $a0, $t1
	mfhi $v0
	jr  $ra

print:
	la $a0, msg
	li $v0, 4
	syscall
	
	la $a0, 0($s2)
	li $v0, 1
	syscall
	