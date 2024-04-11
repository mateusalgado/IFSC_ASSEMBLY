#########################################################
# Laboratório 01 - MCP22105
# Expressões Aritméticas e Lógicas
#
# Aluno: Mateus Salgado Barboza Costa
#########################################################
# Realize a conversão das expressões abaixo considerando
# que os valores das variáveis já estão carregados nos
# registradores, conforme o mapeamento indicado abaixo
#
# Mapeamento dos registradores:
# a: $t0, b: $t1, c: $t2, d: $t3, res: $t4
#########################################################

######################################
# res = a + b + c
add $t4, $t0, $t1 
add $t4, $t4, $t2

######################################
# res = a - b - c
sub $t4, $t0, $t1 
sub $t4, $t4, $t2

######################################
# res = a * b - c
mul $t4, $t0, $t1
sub $t4, $t4, $t2

######################################
# res = a * (b + c)
add $t4, $t1, $t2
mul $t4, $t4, $t0

######################################
# res = a + (b - 5)
li $t4, 5
sub $t4, $t1, $t4
add  $t4, $t0, $t4

######################################
# res = ((b % 2) == 0)
andi $t4, $t1, 1
seq  $t4, $t4, $zero

######################################
# res = (a < b) && (((a+b) % 3) == 2)
add $t4, $t0, $t1
li $t5, 3
div $t4, $t5
mfhi $t4
li $t5, 2
seq $t4, $t4, $t5
slt $t5, $t0, $t1
and $t4, $t4, $t5 

######################################
# res = (a >= b) && (c != d)
sge $t0, $t0, $t1
sne $t2, $t2, $t3
and $t4, $t0, $t2 

#
# Mapeamento dos registradores:
# a: $t0, b: $t1, c: $t2, d: $t3, res: $t4
######################################
# res = (((a/2)+1) > b) || (d == (b-a))
li $t4, 2
div $t0, $t4 
mflo $t4
addi $t4, $t4, 1
sgt $t4, $t4, $t1
sub $t2, $t1, $t0
seq $t3, $t3, $t2
or $t4, $t4, $t3
