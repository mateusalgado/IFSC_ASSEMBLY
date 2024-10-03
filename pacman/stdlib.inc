.text 0x00410000

###################################################################################
# int strResize(char * str, int size);
#
# O procedimento modifica o tamanho da string de acordo com o valor de `size`.
# Se `size` for maior que o tamanho atual da string, a função retorna -1.
# Caso contrário, ajusta a string para o novo tamanho e retorna o próprio `size`.
#
# Stack frame layout:
#  OLD_STACK_FRAME   
#  $a1                                 12  # Guarda o tamanho desejado da string
#  $a0                                 8   # Guarda o ponteiro para a string
#  $ra                                 4   # Guarda o retorno da função
###################################################################################

strResize:
  addiu  $sp, $sp, -8      # Cria espaço no stack para salvar registros
  sw     $ra, 4($sp)       # Salva o valor do registrador $ra no stack
  sw     $a0, 8($sp)       # Salva o ponteiro para a string no stack
  sw     $a1, 12($sp)      # Salva o valor do tamanho desejado no stack
  
  jal strlen               # Chama a função strlen para calcular o tamanho da string
  lw  	 $a0,  8($sp)      # Carrega o ponteiro para a string de volta
  lw  	 $a1,  12($sp)     # Carrega o tamanho desejado de volta
		
  blt 	 $v0, $a1, strResize_erro  # Se o tamanho da string for menor que o desejado, salta para erro
  addu 	 $t0, $a0, $a1      	   # Calcula o novo endereço (str + size)
  sb 	 $zero, 0($t0)        	   # Coloca um terminador nulo ('\0') no novo fim da string
  move 	 $v0, $a1           	   # Retorna o valor de `size`
  b 	 strResize_end         	   # Salta para o final da função

strResize_erro:
  li 	 $v0, -1           # Retorna -1 indicando erro (size > tamanho atual da string)

strResize_end:  
  lw     $ra, 4($sp)       # Restaura o valor do registrador $ra
  addiu  $sp, $sp, 8       # Libera o espaço do stack
  jr     $ra               # Retorna da função

###################################################################################
# int strlen(char * str) {
#   int len = 0;
#   while ( *str != 0 ){
#     str = str + 1;
#     len = len + 1;
#   }
#   return len;
#}
# Função que calcula o comprimento da string, retornando o número de caracteres
###################################################################################

strlen:
  li $v0, 0               # Inicializa o comprimento (len = 0)
strlen_L0:
  lb $t0, 0($a0)       	  # Carrega o byte atual da string (char)
  beqz $t0, strlen_L0_end # Se o caractere for nulo ('\0'), fim da string
  addi $v0, $v0, 1        # Incrementa o comprimento (len++)
  addi $a0, $a0, 1        # Avança para o próximo caractere (str++)
  j strlen_L0             # Repete até encontrar o terminador nulo
strlen_L0_end:
  jr $ra                  # Retorna o comprimento da string
