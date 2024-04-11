#########################################################
# Laboratório 03 - MCP22105
# Estruturas de Controle
# Aluno: Mateus Salgado Barboza Costa
#########################################################
# Faça um programa que leia o conteúdo da posição de 
# memória 0x10010000 e armazene-a na posição 0x10010004 
# se ela for positiva, ou 0x10010008 se for negativa.
#########################################################
.data 0x10010000
    mem_pos:   .word -1    # Endereço de memória para ler
    mem_pos_p: .word 0    # Endereço de memória para armazenar se positivo
    mem_pos_n: .word 0    # Endereço de memória para armazenar se negativo

.text
main:
    la $gp, 0x10010000

    lw $t0, 0($gp)         # Carrega o valor da posição de memória 0x10010000 em $t0

    # Verifica se o valor é positivo ou negativo
    bgez $t0, positive      # Se o valor for >= 0, vá para positive
    j negative              # Se o valor for < 0, vá para negative

positive:
    sw $t0,4($gp)          # Armazena o valor em $t0 na posição de memória 0x10010004
    j end_program           # Fim do programa

negative:
    sw $t0, 8($gp)          # Armazena o valor em $t0 na posição de memória 0x10010008
    j end_program           # Fim do programa

end_program:
#########################################################
# Faça um programa que teste se o conteúdo da posição de 
# memória 0x10010000 e 0x10010004 são iguais e, em caso 
# positivo, armazene o valor na posição 0x10010008.
#########################################################
.data 0x10010000
    mem_pos:   .word -1    # Endereço de memória para ler
    mem_pos_p: .word 0    # Endereço de memória para armazenar se positivo
    mem_pos_n: .word 0    # Endereço de memória para armazenar se negativo

.text
main:
    la $gp, 0x10010000

    lw $t0, 0($gp)         # Carrega o valor da posição de memória 0x10010000 em $t0

    # Verifica se o valor é positivo ou negativo
    bgez $t0, positive      # Se o valor for >= 0, vá para positive
    j negative              # Se o valor for < 0, vá para negative

positive:
    sw $t0,4($gp)          # Armazena o valor em $t0 na posição de memória 0x10010004
    j end_program           # Fim do programa

negative:
    sw $t0, 8($gp)          # Armazena o valor em $t0 na posição de memória 0x10010008
    j end_program           # Fim do programa

end_program:

#########################################################
# Faça um programa que leia o conteúdo da posição de 
# memória 0x10010000 e 0x10010004 e, armazene o maior 
# deles na posição 0x10010008.
#########################################################
.data 0x10010000
    num1:   .word -1   # Endereço de memória para ler
    num2:   .word 10   # Endereço de memória para armazenar se positivo
    res:    .word 0    # Endereço de memória para armazenar se negativo

.text
main:
    la $gp, 0x10010000

    lw $t0, 0($gp)      # Carrega o valor da posição de memória 0x10010000 em $t0
    lw $t1, 4($gp)	# Carrega o valor da posição de memória 0x10010004 em $t1
	
    # Verifica se o valor é positivo ou negativo
    bge $t0, $t1, maior      # Se o valor for >= 0, vá para positive
    sw $t1, 8($gp)          # Armazena o valor em $t0 na posição de memória 0x10010008
    j end_program           # Fim do programa
maior:
    sw $t0, 8($gp)          # Armazena o valor em $t0 na posição de memória 0x10010004
    j end_program           # Fim do programa

end_program:

#########################################################
# Faça um programa que leia 3 notas dos endereços 
# 0x10010000, 0x10010004 e 0x10010008 e, sabendo que a 
# média é 7, armazene 1 no endereço 0x1001000C caso ele 
# esteja aprovado ou no endereço 0x10010010 caso ele 
# esteja reprovado.
#########################################################
.data 0x10010000
	nota1:	.word -1   # Endereço de memória para ler nota1
    	nota2:	.word 10   # Endereço de memória para ler nota2
    	nota3:	.word 0    # Endereço de memória para ler nota3
.data 0x1001000C
	aprovado:.word 0
.data 0x10010010
	reprovado:.word 0

.text
main:
    	la $gp, 0x10010000
	
    	lw $t0, 0($gp)  # Carrega o valor da posição de memória 0x10010000 em $t0
    	lw $t1, 4($gp)	# Carrega o valor da posição de memória 0x10010004 em $t1
    	lw $t2, 8($gp)  # Carrega o valor da posição de memória 0x10010004 em $t1
	
	add $t0, $t0, $t1
	add $t0, $t0, $t2
		
	li $t1, 3

	div $t0, $t1
	mflo $t0
	
	li $t1, 7
	bge $t0, $t1, sim
	j nao

sim:
    	li $t1, 1
	sw $t1, 0xc($gp)
    	j end_program           # Fim do programa

nao:
	li $t1, 0
	sw $t1, 16($gp)
    	j end_program           # Fim do programa

end_program: