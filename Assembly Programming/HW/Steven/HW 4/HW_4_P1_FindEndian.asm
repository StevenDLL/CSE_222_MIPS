	.data

typeBigEndian:		.asciiz "Big Endian"
typeLittleEndian:	.asciiz "Little Endian"
number:			.word	0x00000001

	.text

main:
	lb $t0, number
	beq $t0, $0, bigEndian
	
	la $a0, typeLittleEndian
	li $v0, 4
	syscall
	
	j terminate
	
bigEndian:
	la $a0, typeBigEndian
	la $v0, 4
	syscall
	
terminate:
	li $v0, 10
	syscall