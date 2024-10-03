#########################################################
# Laboratório 02 - MCP22105
# Alocação de dados em memória e Chamada de Sistemas
#
# Aluno: Mateus Salgado Barboza Costa
#########################################################

# Faça um programa que solicite dois números para o
# usuário e exiba a soma destes dois números
#########################################################

    .data                    # Seção de dados
prompt1: .asciiz "Digite o primeiro número: "  # Prompt para o primeiro número
prompt2: .asciiz "Digite o segundo número: "   # Prompt para o segundo número
result:  .asciiz "A soma é: "                  # Mensagem para exibir o resultado

    .text                    # Seção de código
    .globl main              # Define o ponto de entrada do programa

main:
    # Solicitar o primeiro número ao usuário
    li $v0, 4                 # Carregar o código do serviço do sistema para imprimir string
    la $a0, prompt1           # Carregar o endereço do prompt1 em $a0
    syscall                   # Chamar o sistema para imprimir o prompt1

    # Ler o primeiro número digitado pelo usuário
    li $v0, 5                 # Carregar o código do serviço do sistema para ler inteiro
    syscall                   # Chamar o sistema para ler o primeiro número
    move $s0, $v0             # Armazenar o primeiro número em $s0

    # Solicitar o segundo número ao usuário
    li $v0, 4                 # Carregar o código do serviço do sistema para imprimir string
    la $a0, prompt2           # Carregar o endereço do prompt2 em $a0
    syscall                   # Chamar o sistema para imprimir o prompt2

    # Ler o segundo número digitado pelo usuário
    li $v0, 5                 # Carregar o código do serviço do sistema para ler inteiro
    syscall                   # Chamar o sistema para ler o segundo número
    move $s1, $v0             # Armazenar o segundo número em $s1

    # Calcular a soma dos dois números
    add $s2, $s0, $s1         # $s2 = $s0 + $s1

    # Exibir o resultado
    li $v0, 4                 # Carregar o código do serviço do sistema para imprimir string
    la $a0, result            # Carregar o endereço do result em $a0
    syscall                   # Chamar o sistema para imprimir a mensagem do resultado

    # Exibir o valor da soma
    li $v0, 1                 # Carregar o código do serviço do sistema para imprimir inteiro
    move $a0, $s2             # Carregar o valor da soma em $a0
    syscall                   # Chamar o sistema para imprimir a soma

    # Sair do programa
    li $v0, 10                # Carregar o código do serviço do sistema para sair
    syscall                   # Chamar o sistema para terminar o programa
