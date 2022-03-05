	.data

MONDAY:		.word 1
mondayTEXT:	.asciiz "MONDAY"

TUESDAY:	.word 2	
tuesdayTEXT:	.asciiz "TUESDAY"

WEDNESDAY:	.word 3
wednesdayTEXT:	.asciiz "WEDNESDAY"

THURSDAY:	.word 4
thursdayTEXT:	.asciiz "THURSDAY"

FRIDAY:		.word 5
fridayTEXT:	.asciiz "FRIDAY"

SATURDAY:	.word 6
saturdayTEXT:	.asciiz "SATURDAY"

SUNDAY:		.word 7
sundayTEXT:	.asciiz "SUNDAY"

rn:		.word 0

	.text

#load in all the numbers for the equivelant day
main:
	lw $t1, MONDAY
	lw $t2, TUESDAY
	lw $t3, WEDNESDAY
	lw $t4, THURSDAY
	lw $t5, FRIDAY
	lw $t6, SATURDAY
	lw $t7, SUNDAY
		
#generate the random number
generateRandom:
	addi $a1, $0, 8 	#Set upper-bound of random number to 7
	li $v0, 42 		#Generate random number of range [0,7]
	syscall 		#Call generation
	la $t8, rn
	sw $a0, 0($t8)

#check to see which number was generated	
checkValue:
	beq $a0, $t1, isMonday
	beq $a0, $t2, isTuesday
	beq $a0, $t3, isWednesday
	beq $a0, $t4, isThursday
	beq $a0, $t5, isFriday
	beq $a0, $t6, isSaturday
	beq $a0, $t7, isSunday

isMonday:
	la $a0, mondayTEXT #Print new line
	li $v0, 4
	syscall
	
	j terminate

isTuesday:
	la $a0, tuesdayTEXT #Print new line
	li $v0, 4
	syscall
	
	j terminate

isWednesday:
	la $a0, wednesdayTEXT #Print new line
	li $v0, 4
	syscall
	
	j terminate

isThursday:
	la $a0, thursdayTEXT #Print new line
	li $v0, 4
	syscall
	
	j terminate

isFriday:
	la $a0, fridayTEXT #Print new line
	li $v0, 4
	syscall
	
	j terminate

isSaturday:
	la $a0, saturdayTEXT #Print new line
	li $v0, 4
	syscall
	
	j terminate

isSunday:
	la $a0, sundayTEXT #Print new line
	li $v0, 4
	syscall
	
	j terminate

terminate:
	li $v0, 10
	syscall