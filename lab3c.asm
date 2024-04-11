#########################################################
# Laboratório 03 - MCP22105
# Estruturas de Controle
# Aluno: Mateus Salgado Barboza Costa
#########################################################
# Faça um programa para buscar um determinado valor em um 
# array de inteiros. O endereço inicial do vetor está 
# armazenado no endereço de memória 0x10010000, o tamanho 
# do vetor está no endereço 0x10010004 e valor que será 
# pesquisado está no endereço 0x10010008. Caso o valor 
# seja encontrado, escreva 0x01 no endereço 0x1001000C, 
# caso contrário, escreva 0x00.
#########################################################
.data
ptr_vector:   .word vector	# 0x10010000
vector_size:  .word 10		# 0x10010004
search_value: .word 89		# 0x10010008
result:	      .word 0		# 0x1001000C

vector: .word 9, 78, 45, -134, 89, 15, 72, 31, 8, 720

# implementacao 01
#
# result = 0;
# for (int i = 0; i < vector_size; i++) {
#    if( vector[i] == search_value) {
#	    result = 1;
#	    break;
#    }
# }

###### JEITO 1 #######
.text
	lw $t0, ptr_vector		# endereço inicial do vetor
	lw $t1, vector_size
	lw $t2, search_value
	lw $t3, result
	
	li $t4, 0 			# contador = 0

loop:
	bge $t4, $t1, nao_encontrado	# Caso i >= Tamanho_vetor -> nao encontrado
	sll $t5, $t4, 2			# Calcula o deslocamento para acessar vetor[i] * 4 bytes
	add $t5, $t0, $t5		# somando offset com o inicio do vetor, vetor[0], vetor[1], vetor[2]
	lw $t6, ($t5)			# carregando vetor[i], no reg $t6
	beq $t6, $t2, encontrado	# caso $t6(Vetor[i]) = Vetor_result 
	addi $t4, $t4, 1		# i = i+1
	j loop
	
nao_encontrado:	
	li $t3, 0			# carrega valor "0" no endereço 
	j end
encontrado:
	li $t3, 1
end:	
	sw $t3, result
	
######	JEITO 2 ######
.text
	lw $t0, ptr_vector		# endereço inicial do vetor
	lw $t1, vector_size
	lw $t2, search_value
	lw $t3, result   		# result

loop:
	beqz $t1, end	# Caso i >= Tamanho_vetor -> nao encontrado
	addi $t1, $t1, -1
	lw   $t4, ($t0)
	addi $t0, $t0, 4		# ptr++
	beq  $t4, $t2, encontrado	# caso $t6(Vetor[i]) = Vetor_result 
	j loop
encontrado:
	li $t3, 1
end:	
	sw $t3, result
#########################################################
# Faça um programa para contar o número de elementos 
# encontrados em um array de inteiros. O endereço inicial 
# do vetor está armazenado no endereço de memória 0x10010000, 
# o tamanho do vetor está no endereço 0x10010004 e valor que 
# será contado está no endereço 0x10010008. Armazene no 
# endereço 0x1001000C o número de elementos encontrados 
# na procura.
#########################################################
.data
    array_start:    .word 0x10010000    # Endereço inicial do vetor
    array_size:     .word 0x10010004    # Tamanho do vetor
    search_value:   .word 0x10010008    # Valor a ser procurado
    count_result:   .word 0x1001000C    # Resultado do contador

.text
main:
    lw $t0, array_start        # Carrega o endereço inicial do vetor em $t0
    lw $t1, array_size         # Carrega o tamanho do vetor em $t1
    lw $t2, search_value       # Carrega o valor a ser procurado em $t2
    lw $t3, count_result       # Carrega o endereço para armazenar o resultado em $t3
    
    li $t4, 0                  # Inicializa o contador ($t4) com 0
    li $t5, 0                  # Inicializa o índice ($t5) com 0
    
search_loop:
    bge $t5, $t1, end_search   # Se o índice for maior ou igual ao tamanho do vetor, sai do loop
    lw $t6, 0($t0)             # Carrega o elemento atual do vetor em $t6
    beq $t6, $t2, increment_count  # Se o elemento atual for igual ao valor procurado, incrementa o contador
    addi $t0, $t0, 4           # Avança para o próximo elemento do vetor
    addi $t5, $t5, 1           # Incrementa o índice
    j search_loop              # Loop de busca
    
increment_count:
    addi $t4, $t4, 1           # Incrementa o contador
    addi $t0, $t0, 4           # Avança para o próximo elemento do vetor
    addi $t5, $t5, 1           # Incrementa o índice
    j search_loop              # Loop de busca

end_search:
    sw $t4, 0($t3)             # Armazena o resultado (número de elementos encontrados) no endereço indicado

