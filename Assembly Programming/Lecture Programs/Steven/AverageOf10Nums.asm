	.data
	
	.text
	
#generate 10 random numbers and take the average 
		
main:	li $s0, 0 	#sum 
	li $t0, 0 	#counter 
	li $t2, 10	#upper bound 
	li $v0, 42	#generate random number
	li $a1, 100	#random number max 
	
	
for: 	syscall		#generate number 
	add $s0, $s0, $a0	#add it to $s0  
	addi $t0, $t0, 1	#increment by 1 
	beq $t0, $t2, avg	#break after 10 runs 
	j for			#jump back 

avg: 	div $a0, $s0, $t2 	#divide and store into $a0 
	li $v0, 1		#display 
	syscall 
	
	li $v0, 10	#terminate 
	syscall 
	