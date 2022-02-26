	.data 
	

	.text 

#program will add all numbers from 1-10 using for loop 

main:	addi $s1, $s0, 0 	#$s1 is where the final answer will be held 
	addi $t0, $0, 10 	#$t0 is the upper bound, in this case the loop will run 10 times
	addi $s0, $s0, 1	#index starts at 1 
	addi $a1, $0, 10 

 for: 	beq $s0, $t0, done	#break to done if $s0 = $t1 (if i = 10) 
 	add $s1, $s1, $s0	#add into $s1
 	addi $s0, $s0, 1	#increment $s0 
 	j for			#jump to beginning of for loop 
 
  
   
done:	 

	li $v0, 1
	move $a0, $s1 	#print
	syscall 
	
	li $v0, 10	#terminate 
	syscall 
