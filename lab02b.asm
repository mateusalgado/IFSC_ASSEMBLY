#########################################################
# Laboratório 02 - MCP22105
# Alocação de dados em memória e Chamada de Sistemas
#
# Aluno: Mateus Salgado Barboza Costa
#########################################################
# Faça um programa que imprime a cadeia de caracteres
# "Hello World!" em linguagem assembler para o MIPS
#########################################################

    .data                    # Seção de dados
hello_string:
    .asciiz "Hello World!"  # Define a string "Hello World!" com um null terminator

    .text                    # Seção de código
    .globl main              # Define o ponto de entrada do programa

main:
    li $v0, 4                # Carregar o código do serviço do sistema para imprimir string
    la $a0, hello_string     # Carregar o endereço da string em $a0
    syscall                  # Chamar o sistema para imprimir a string

    li $v0, 10               # Carregar o código do serviço do sistema para sair
    syscall                  # Chamar o sistema para terminar o programa




