#########################################################
# Laboratório 03 - MCP22105
# Estruturas de Controle
# Aluno: Mateus Salgado Barboza Costa
#########################################################
# Converta para assembly os trechos de código C a seguir
# Faça a alocação das variáveis na memória (.data)
#########################################################
# a = 0;	$t0
# b = 0;	$t1
# 
# do {
#   if ( b % 2 ){
#      a++;
#   }
#   b++;
# } while (a < 10)

.data
a: .word 0     # Variável a inicializada com 0
b: .word 0     # Variável b inicializada com 0
result:  .asciiz "o valor é: "                  

.text
main:
    li $t0, 0             # Inicializa a com 0
    li $t1, 0             # Inicializa b com 0

loop:
    lw $t2, b             # Carrega o valor de b em $t2
    andi $t3, $t2, 1      # Verifica se b % 2 é verdadeiro (resto da divisão por 2 é 1)
    beqz $t3, else        # Se b % 2 != 0, vá para else
    addi $t0, $t0, 1      # Incrementa a
else:
    addi $t1, $t1, 1      # Incrementa b
    li $t4, 10            # Carrega 10 em $t4
    blt $t0, $t4, loop    # Se a < 10, volte para loop

endloop:
    li $v0, 4        # Carregar o código do serviço do sistema para imprimir string
    la $a0, result   # Carregar o endereço do result em $a0
    syscall	     # Chamar o sistema para imprimir a mensagem do resultado

    li $v0, 1	     # Carregar o código do serviço do sistema para imprimir inteiro
    move $a0, a      # Carregar o valor da soma em $a0
    syscall	     # Chamar o sistema para imprimir a soma
#########################################################


#########################################################
# if ( ( a < b ) &&  ( c == d ) ) {
#   a = a * (((c/b) * 2) + 10);
# } else {
#   a = a / ((c+4)/b);
# }
# a++;
#########################################################
# Inicialização de variáveis
.data
a:  .word 0        # Variável 'a'
b:  .word 0        # Variável 'b'
c:  .word 0        # Variável 'c'
d:  .word 0        # Variável 'd'

.text
main:
    # Carregar variáveis
    lw $t0, a       # $t0 = a
    lw $t1, b       # $t1 = b
    lw $t2, c       # $t2 = c
    lw $t3, d       # $t3 = d
    
    # Comparar a < b
    slt $t4, $t0, $t1   # $t4 = (a < b)
    beq $t4, $zero, else    # Se não (a < b), vá para else

    # Comparar c == d
    beq $t2, $t3, if_block  # Se c == d, vá para if_block

else:
    # Calcular a = a / ((c+4)/b)
    addi $t2, $t2, 4       # c+4
    div $t2, $t1            # (c+4)/b
    mflo $t5                # Armazenar o resultado da divisão inteira em $t5
    div $t0, $t5            # a / ((c+4)/b)
    mflo $t0                # Armazenar o resultado da divisão inteira em $t0
    
    j end_program           # Ir para o fim do programa

if_block:
    # Calcular a = a * (((c/b) * 2) + 10)
    div $t2, $t1            # c/b
    mflo $t5                # Armazenar o resultado da divisão inteira em $t5
    li $t6, 2               # $t6 = 2
    mul $t5, $t5, $t6       # (c/b) * 2
    addi $t5, $t5, 10       # ((c/b) * 2) + 10
    mul $t5, $t5, $t0       # a * (((c/b) * 2) + 10)
    move $t0, $t5           # Armazenar o resultado em $t0

    j end_program           # Ir para o fim do programa

end_program:
    addi $t0, $t0, 1 	    # Incrementar a
    # Fim do programa

#########################################################
# if ( a < 10 ) {
#   b = 20;
#   if ( a <= 5 ){
#     for(int i = 0; i < a; i++) {
#       b += a * i;
#     }
#   } else {
#       while( a-- > 5) {
#         b -= b / a;
#       }
#   }
# }
#########################################################
# Inicialização de variáveis
.data
a:  .word 0        # Variável 'a'
b:  .word 0        # Variável 'b'

.text
main:
    # Carregar variáveis
    lw $t0, a       # $t0 = a
    lw $t1, b       # $t1 = b
    # Comparar a < 10
    li $t2, 10
    slt $t2, $t0, $t2
    beq $t3, $zero, end_if # Se não (a < 10), vá para end_if
    # Inicia b
    li $t1, 20      # b = 20
    # Comparar a <= 5
    li $t2, 5
    ble $t0, $t2, loop_for   # Se a <= 5, vá para loop_for

    # Dentro do else do primeiro if
    while_loop:
        # Decrementar a
        addi $t0, $t0, -1   # a--
        # Comparar a > 5
        li $t2, 5       # $t2 = 5
        ble $t0, $t2, while_loop_end   # Se a > 5, vá para while_loop_end
        
	# Calculo: b -= b / a
        div $t1, $t0        # b / a
        mflo $t4            # Armazenar o resultado da divisão inteira em $t4
        sub $t1, $t1, $t4   # b -= (b / a)

        j while_loop        # Loop while_loop

    while_loop_end:
    j end_if

    loop_for:
        li $t5, 0       # $t5 = i    loop_for:

    for_loop:
        # Comparar i < a
        bge $t5, $t0, end_for_loop  # Se i >= a, vá para end_for_loop
        # Calculo: b += a * i
        mul $t6, $t0, $t5       # a * i
        add $t1, $t1, $t6       # b += (a * i)
        # Incrementar i
        addi $t5, $t5, 1        # i++

        j for_loop          # Loop for_loop

    end_for_loop:
end_if:
