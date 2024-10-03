.data 

var_a: .byte -1
.align 2
var_b: .space 12




.text

	lb  $t0, var_a
	lbu $t1, var_a
	lw  $t2, var_b
	


