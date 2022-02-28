	.data
	
	.text
	
	#load 0x1234ABCD into $s0 register
main:
	lui $s0, 0x1234
	ori $s0, $s0, 0xABCD
	
	#loads first 16 bits into 32 bit
	addi $s0, $0, 0x1234
	
	#shift to left by 16 bits
	sll $s0, $s0, 16
	
	ori $s0,$s0, 0xABCD
	
	li $v0, 1
	syscall