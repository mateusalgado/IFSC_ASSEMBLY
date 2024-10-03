#########################################################
# Laboratório 03 - MCP22105
# Estruturas de Controle
#
# Aluno: 
#########################################################

#########################################################
# Faça um programa para buscar um determinado valor em um 
# array de inteiros. O endereço inicial do vetor está 
# armazenado no endereço de memória 0x10010000, o tamanho 
# do vetor está no endereço 0x10010004 e valor que será 
# pesquisado está no endereço 0x10010008. Caso o valor 
# seja encontrado, escreva 0x01 no endereço 0x1001000C, 
# caso contrário, escreva 0x00.
#
#########################################################
.data
ptr_vector:   .word vector
vector_size:  .word 10
search_value: .word 89
result:	      .word 0

vector: .word 9, 78, 45, -134, 89, 15, 72, 31, 8, 720

.text

# implementacao 01
#
# result = 0;
# for (int i = 0; i < vector_size; i++) {
#    if( vector[i] == search_value) {
#	    result = 1;
#	    break;
#    }
# }

#implementacao02
# result = 0
# tmp = vector_size
# while (tmp > 0) {
#    tmp--;
#    if ( *ptr_vector == search_value ){
#        result = 1;
#        break;
#    }
#    ptr_vector++;
#  }
#












