#########################################################
# Realize a conversão das expressões abaixo considerando
# que os valores das variáveis já estão carregados nos
# registradores, conforme o mapeamento indicado abaixo
# Mapeamento dos registradores:
# f: $t0, g: $t1, h: $t2, i: $t3, j: $t4
# Endereço base A: $s0, Endereço base B: $s1
#########################################################
# f = ((g+1) * h) - 3
addi $t1, $t1, 1
mul $t1, $t1, $t2
subi $t0, $t1, 3
#########################################################
# f = (h*h + 2) / f - g
mul $t2, $t2, $t2
addi $t2, $t2, 2
sub $t0, $t0, $t1
div $t0, $t2, $t0 
#########################################################
# B[i] = 2 * A[i]
sll $t0, $t3, 2
add $s0, $s0, $t0
lw $s0, 0($s0)
add $s0, $s0, $s0
add $s1, $s1, $t0
sw $s0, 0($s1)
#########################################################
# B[f+g] = A[i] / (A[j] - B[j])
sll $t2, $t3, 2
add $t5, $s0, $t2
lw $t5, 0($t5)

sll $t2, $t4, 2
add $t6, $s0, $t2
add $t7, $s1, $t2
lw $t6, 0($t6)
lw $t7, 0($t7)

sub $t6, $t6, $t7
div $t5, $t5, $t6

add $t0, $t0, $t1
sll $t0, $t0, 2
add $t0, $s0, $t0
sw $t5, 0($t0)