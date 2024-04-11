#########################################################
# Laboratório 02 - MCP22105
# Alocação de dados em memória e Chamada de Sistemas
#
# Aluno: Mateus Salgado Barboza Costa
#########################################################

#########################################################
# Considere o seguinte programa em linguagem 
# Assembly do MIPS
#
#    .data 0x10010400 # segmento de dados
#      palavra1: .word 13
#      palavra2: .word 0x15
#
# Indique, em hexadecimal, os endereços de memória dos 
# símbolos palavra1 e palavra2
#
# R: palavra1 está armazenada em 0x10010400
#    palavra2 está armazenada em 0x10010404
#
##########################################################


#########################################################
# Considere o seguinte programa em linguagem 
# Assembly do MIPS
#
#    .data 0x10010800 # segmento de dados
#
#      variavel_a: .word 13
#      nums:       .word 2, 6, 8, 5, 98, 74, 28
#
# Indique, em hexadecimal, o endereço do elemento comz o
# valor 74 do vetor nums
#
# R: nums com valor 74 está armazenada em 0x10010824
#
##########################################################


#########################################################
# Realize a conversão das expressões abaixo considerando
# que os valores das variáveis já estão carregados nos
# registradores, conforme o mapeamento indicado abaixo
#
# Mapeamento dos registradores:
# i: $s3, j: $s4
# Endereço base dos vetores: A: $s6 e B: $s7
#########################################################

#########################################################
# B[8] = A [i-j]
sub $t0, $s3, $s4
sll $t0, $t0, 2
add $t0, $t0, $s6
lw $s0, 0($t0)
sw $s0, 32($s7)
#########################################################


#########################################################
# B[32] = A[i] + A[j]
sll $t0, $s3, 2
sll $t1, $s4, 2

add $t0, $t0, $s6 
add $t1, $t1, $s6

lw $s0, 0($t0)
lw $s1, 0($t1)

add $s0, $s0, $s1  
sw $s0, 128($s7)
#########################################################