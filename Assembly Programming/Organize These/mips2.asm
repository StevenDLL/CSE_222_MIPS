	.data
	
msg1:	.asciiz "Number is EVEN"
msg2:	.asciiz	"Number is ODD"

	.text
	
	
main:
	li $a1, 100
	li $v0, 42
	syscall 
	
	#display $a0
	li $v0, 1
	syscall
	
	#check random number is even or odd
	li $t0, 2 # puts 2 into register t0
	div  $a0, $t0 # number in t0 is divided by the number in a0
	mfhi $t1 #move remainder into t1
	
	beq $t1, $s0 lbl1 #if t1 is 0 then go to branch called lbl1
	la $a0, msg2 #load address of msg2 into a0
	li $v0, 4 
	syscall
	
	j lbl2 #jump to lbl2 to end program or lbl1 will be called regardless since its next in line
	
lbl1:
	la $a0, msg1 #loads address of msg1
	li $v0,4  #call 4 and display msg
	syscall
	
lbl2:
	li $v0, 10
	syscall
	