.macro exit
	li $v0, 10
	syscall
.end_macro

.macro exit_value (%value) 
	li $a0, %value
	li $v0, 17
	syscall
.end_macro


.data
a: .word 10
b: .word 15
c: .word 0

.text
	la $gp, 0x10010000
	
	exit_value(2)
	
	lw $t0, 0($gp)
	lw $t1, 4($gp)
	add $t0, $t0, $t1
	sw $t0, 8($gp)
	
	exit_value(0)
	
