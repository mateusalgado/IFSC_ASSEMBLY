#########################################################
# Qual é o valor do registrador $s0 após a execução das 
# instruções abaixo? O registrador $s1 possui o valor 
# 0x0000FEFE. Apresente a sua resposta em hexadecimal.
#########################################################
	add  $s0, $0, $0
LOOP:	
	beq  $s1, $0,  DONE
	andi $t0, $s1, 0x01
	beq  $t0, $0, SKIP
	addi $s0, $s0, 1
SKIP:
	srl	 $s1, $s1, 1 # 0x000FEFE0
	j    LOOP
DONE:
	addi $t0, $0, 12
	sll  $t0, $t0, 4
	xori $t0, $t0, 10
	sll  $t0, $t0, 8
	xori $t0, $t0, 255
	and  $s0, $s1, $t0
#########################################################
