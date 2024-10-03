.data
data_c: .word 0
data_d: .word 0

.text
main:
	li $a0, 3
	li $a1, 5
	jal sumOfSquares
	sw $v0, data_c
	
	li $a0, 10
	li $a1, 15
	jal sumOfSquares
	sw $v0, data_d
	
	lw $t0, data_c
	add $t0, $t0, $v0
	
	li $v0, 10
	syscall
	
.text 0x00401000
sumOfSquares:
	mul $t0, $a0, $a0
	mul $t1, $a1, $a1
	add $v0, $t0, $t1
	jr  $ra
	
	
