#########################################################
# Laboratório 02 - MCP22105
# Alocação de dados em memória e Chamada de Sistemas
#
# Aluno: Mateus Salgado Barboza Costa
#########################################################
# Faça um programa no MARS, utilizando as chamadas de 
# sistema que implementa um papagaio :)
#
# O programa imprime no terminal a mesma frase que
# foi digitada pelo usuário.
#
#  # Diga alguma coisa que eu irei dizer também!
#  # Entre com o seu texto: ...
#  # O seu texto é: ...
#########################################################
    .data                    # Seção de dados
prompt1: .asciiz "Diga alguma coisa que eu irei dizer também! \n"  
prompt2: .asciiz "Entre com o seu texto (máx 10 caracteres): ... "
output: .asciiz "\n O seu texto é: ... "

    .text                    # Seção de código
    .globl main              # Define o ponto de entrada do programa

main:
    # Solicitar o primeiro número ao usuário
    li $v0, 4                 # Carregar o código do serviço do sistema para imprimir string
    la $a0, prompt1           # Carregar o endereço do prompt1 em $a0
    syscall                   # Chamar o sistema para imprimir o prompt1
    la $a0, prompt2           # Carregar o endereço do prompt2 em $a0
    syscall

    # Ler string digitado pelo usuário
    li $v0, 8
    la $a0, input_buffer
    li $a1, 10    # Tamanho máximo da entrada (ajuste conforme necessário)
    syscall

    # Imprimir a saída (texto do usuário)
    li $v0, 4
    la $a0, output
    syscall

    # Imprimir o texto do usuário
    la $a0, input_buffer
    syscall

    # Sair do programa
    li $v0, 10         
    syscall               

    .data
input_buffer: .space 10  # Buffer para armazenar a entrada do usuário

