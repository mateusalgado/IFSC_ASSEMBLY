.include "macros.inc"
.include "stdlib.inc"
.include "pacman.inc"
.include "sprites.inc"
.include "ringbuffer.inc"
.include "kernel.inc"

.eqv STACK_INIT 0x7FFFEFFC  # Define um valor equivalente para o endereço inicial da pilha.

.data
.align 2
key_rb: .space 28  	 # Espaço reservado para o buffer circular de teclas (keyboard ring buffer).

.text 0x00400000  	 ## Código de inicialização do sistema
init:
   la $sp, STACK_INIT    # Carrega o endereço de início da pilha em $sp.
   jal main              # Chama a função `main` que contém o loop principal do jogo.
   syscall_exit          # Realiza a syscall para encerrar a execução do programa.

.text 0x00420000  	 ## Funções de biblioteca do sistema
#####################################################################
# void enable_int
# Função vazia (stub), possivelmente futura implementação para habilitar interrupções.
enable_int:
   jr $ra  		 # Retorna da função (jump register).

#####################################################################
# void disable_int
# Função vazia (stub) para desabilitar interrupções.
disable_int:
   jr $ra  		 # Retorna da função.

#####################################################################
# void enable_irq(int irq_num)
# Função vazia (stub) para habilitar uma interrupção IRQ específica.
enable_irq:
   jr $ra  		 # Retorna da função.

#####################################################################
# void disable_irq(int irq_num)
# Função vazia (stub) para desabilitar uma interrupção IRQ específica.
disable_irq:
   jr $ra  		 # Retorna da função.

#####################################################################
# void enable_keyboard_int
# Função vazia (stub) para habilitar a interrupção do teclado.
enable_keyboard_int:
   jr $ra  		 # Retorna da função.

#####################################################################
# void set_pixel(X, Y, color)
# Função que define um pixel na tela, dados suas coordenadas (X, Y) e a cor.
set_pixel:
   la  $t0, FB_PTR       # Carrega o endereço base do framebuffer (FB_PTR).
   mul $a1, $a1, FB_XRES # Multiplica Y (a1) pela resolução X (FB_XRES) para calcular a posição linear.
   add $a0, $a0, $a1     # Adiciona o valor de X para completar o cálculo da posição do pixel.
   sll $a0, $a0, 2       # Multiplica por 4 (shifting left) para ajustar a posição de bytes.
   add $a0, $a0, $t0     # Adiciona o offset do framebuffer.
   sw  $a2, 0($a0)       # Armazena a cor (a2) na posição calculada no framebuffer.
   jr  $ra               # Retorna da função.

#####################################################################
# char getchar();
# Função que lê um caractere da entrada, aguardando até que um esteja disponível.
getchar:
   la $t0, 0xFFFF0000    # Carrega o endereço do registrador de controle de entrada (teclado).
getchar_L0:
   lw $t1, 0($t0)        # Carrega o valor do registrador de controle.
   andi $t1, $t1, 1      # Isola o bit de "pronto" (bit ready), verificando se há um caractere disponível.
   beqz $t1, getchar_L0  # Se o bit não estiver pronto (0), continua esperando.
   lb $v0, 4($t0)        # Lê o dado (caractere) do registrador de dados de entrada.
   jr $ra                # Retorna da função, com o caractere lido em $v0.

#####################################################################
# int get_nonblocking_char();
# Função que tenta ler um caractere sem bloquear, retornando -1 se não houver caractere.
get_nonblocking_char:
   li $v0, -1            # Define o valor de retorno padrão como -1 (nenhum caractere disponível).
   la $t0, 0xFFFF0000    # Carrega o endereço do registrador de controle de entrada (teclado).
   lw $t1, 0($t0)        # Carrega o valor do registrador de controle.
   andi $t1, $t1, 1      # Isola o bit de "pronto" (bit ready).
   beqz $t1, get_nonblocking_char_end  # Se não estiver pronto, pula para o fim (retornando -1).
   lb $v0, 4($t0)        # Caso contrário, lê o dado (caractere) do registrador de dados.
get_nonblocking_char_end:
   jr $ra                # Retorna da função, com o caractere ou -1 se não houver.

#####################################################################
# void putchar(char value);
# Função que escreve um caractere na saída (tela ou console).
putchar:
   la $t0, 0xFFFF0008    # Carrega o endereço do registrador de controle de saída.
putchar_L0:
   lw $t1, 0($t0)        # Carrega o valor do registrador de controle.
   andi $t1, $t1, 1      # Isola o bit de "pronto" (bit ready).
   beqz $t1, putchar_L0  # Se não estiver pronto para receber dados, continua esperando.
   sb $a0, 4($t0)        # Escreve o caractere (a0) no registrador de dados de saída.
   jr $ra                # Retorna da função.
