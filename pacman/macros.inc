##############################################
.macro syscall_exit
    li $v0, 10              # Coloca o código da syscall 'exit' no registrador $v0 (10 indica fim de execução)
    syscall                 # Executa a syscall para encerrar o programa
.end_macro
##############################################
.macro syscall_exit (%status)
    li $v0, 17              # Carrega o código da syscall 'exit2' no registrador $v0 (17 permite passar status)
    add $a0, $zero, %status # O parâmetro %status é colocado no registrador $a0
    syscall                 # Chama a syscall para encerrar o programa com um código de status
.end_macro
##############################################
.macro syscall_sleep (%milli)
    li $v0, 32         	    # Carrega o código da syscall 'sleep' no registrador $v0 (32 corresponde a dormir)
    add $a0, $zero, %milli  # Coloca o tempo de espera (em milissegundos) no registrador $a0
    syscall                 # Chama a syscall para colocar o programa para dormir por um tempo
.end_macro
##############################################
.macro syscall_print_intReg (%intReg)
    li $v0, 1          	    # Código da syscall 'print integer' no registrador $v0
    add $a0, $zero, %intReg # Coloca o valor do registrador %intReg no registrador $a0 para impressão
    syscall                 # Chama a syscall para imprimir o número inteiro
.end_macro
##############################################
.macro syscall_print_intMem (%intPtr)
    li   $v0, 1             # Código da syscall 'print integer' no registrador $v0
    lw   $a0, %intPtr       # Carrega o valor da memória apontada por %intPtr no registrador $a0
    syscall                 # Chama a syscall para imprimir o valor inteiro da memória
.end_macro
##############################################
.macro syscall_print_charReg (%char)
    li $v0, 11         	    # Código da syscall 'print char' no registrador $v0
    add $a0, $zero, %char   # Coloca o caractere no registrador $a0 para impressão
    syscall                 # Chama a syscall para imprimir o caractere
.end_macro
##############################################
.macro syscall_print_charMem (%charPtr)
    li $v0, 11         	    # Código da syscall 'print char' no registrador $v0
    lw $a0, %charPtr        # Carrega o valor da memória apontada por %charPtr no registrador $a0
    syscall                 # Chama a syscall para imprimir o caractere da memória
.end_macro
##############################################
.macro syscall_print_str (%str)
.data 
mStr: .asciiz %str     	    # Define a string %str como uma constante ASCII
.text
    li $v0, 4               # Código da syscall 'print string' no registrador $v0
    la $a0, mStr            # Carrega o endereço da string no registrador $a0
    syscall                 # Chama a syscall para imprimir a string
.end_macro
##############################################
.macro syscall_print_strMem (%strPtr)
	li $v0, 4           # Código da syscall 'print string' no registrador $v0
	la $a0, %strPtr     # Carrega o endereço da string armazenada em %strPtr no registrador $a0
	syscall             # Chama a syscall para imprimir a string
.end_macro
##############################################
.macro syscall_get_intReg (%reg)
	li $v0, 5           # Código da syscall 'read integer' no registrador $v0
	syscall             # Chama a syscall para ler um valor inteiro
	move %reg, $v0      # Move o valor lido para o registrador %reg
.end_macro
##############################################
.macro syscall_get_intMem (%x)
	li $v0, 5           # Código da syscall 'read integer' no registrador $v0
	syscall             # Chama a syscall para ler um número inteiro
	sw $v0, %x          # Armazena o valor lido na posição de memória %x
.end_macro
##############################################
.macro syscall_get_strMem (%strPtr, %buf_size)
	li $v0, 8           # Código da syscall 'read string' no registrador $v0
	la $a0, %strPtr     # Carrega o endereço do buffer no registrador $a0
	li $a1, %buf_size   # Define o tamanho do buffer (limite de caracteres)
	syscall             # Chama a syscall para ler a string e armazenar no buffer
.end_macro
##############################################