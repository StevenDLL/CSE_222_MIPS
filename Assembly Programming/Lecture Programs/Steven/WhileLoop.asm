	.data
	
	.text
	
main: 	li $t0, 5	#load 5 into $t0 
	li $v0, 42	#random number
	addi $a1, $0, 10  #generate number from 
	
while: 	li $v0, 42	#generate number 
	syscall
	 
	beq $a0, $t0, done	#break if 5 is the number 
	
	li $v0, 1	#display integer if it is not 5 
	syscall 
	
	j while		#jump back 
	
done: 	li $v0, 10	#terminate 
	syscall 
		
	  
