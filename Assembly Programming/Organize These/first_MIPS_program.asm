	.data	# must be called to save data
var1: 	.word	10	# saved variable with the number 10 in it.
var2:	.word	20
var3:	.word	0

	.text
code:
	la $t0, var1	# Load address var1 into register t0
	lw $s0, 0($t0)	# Load word from base address in $t0

	la $t0, var2	# Load address var2 into register t0
	lw $s1, 0($t0)	# Load word from base address in $t0
	
	add $s2, $s0, $s1	# Gets data from s0 & s1, adds them and saves it to s2
	
	la $t0, var3
	
	sw $s2, 0($t0)	# Save word to s2
	
	li $v0, 10
	syscall