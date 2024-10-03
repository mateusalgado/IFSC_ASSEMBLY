
li $t0, 2
li $t1, 5
li $t3, 10
li $t4, 42


addi $t4, $t1, 2

li   $t5, 3
mult $t4, $t5
mflo $t4

add  $t2, $t0, $t4
