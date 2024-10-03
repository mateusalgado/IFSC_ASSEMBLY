.include "system.inc"  # Inclui o arquivo de cabeçalho que contém definições e macros do sistema.

# Cria sprites animados
# animated_sprite(nome_sprite, numero_frames, pos_x, pos_y, direcao_x, direcao_y)
animated_sprite(pacman, 3, 119, 140, 0, 0)  # Define o sprite do Pacman com 3 frames de animação na posição (119, 140).
animated_sprite(ghost, 2, 7, 7, 0, 0)       # Define o sprite do fantasma com 2 frames de animação na posição (7, 7).

mov_vector(input_move)  # Define o vetor de movimento que captura as entradas do usuário (direções que o Pacman tentará se mover).

.text 0x00401000  # Inicia o segmento de texto (código), a partir do endereço 0x00401000.

main:
	addiu $sp, $sp, -16  # Ajusta a pilha, reservando espaço para salvar registros (16 bytes).
	sw $ra, 12($sp)      # Salva o valor do registrador $ra (return address) na pilha.

	# Desenha o grid do jogo na tela
	li $a0, GRID_ROWS    # Carrega o número de linhas da grade na tela (quantidade de linhas do grid).
	li $a1, GRID_COLS    # Carrega o número de colunas da grade na tela (quantidade de colunas do grid).
	la $a2, grid         # Carrega o endereço da grade na memória.
	jal draw_grid        # Chama a função 'draw_grid' para desenhar o grid na tela.

main_L0:
	# Desenha o sprite animado do Pacman na tela
	la $a0, pacman       # Carrega o endereço do sprite do Pacman.
	jal draw_animated_sprite  # Chama a função para desenhar o sprite animado na posição atual.

	# Desenha o sprite animado do fantasma na tela
	la $a0, ghost        # Carrega o endereço do sprite do fantasma.
	jal draw_animated_sprite  # Chama a função para desenhar o sprite do fantasma.

	# Verifica se o Pacman pode se mover
	la  $a0, pacman      # Carrega o endereço do sprite do Pacman.
	jal check_movement   # Chama a função para verificar se o movimento é permitido (sem colisão com paredes).

	# Aplica o vetor de movimento ao Pacman
	la  $a0, pacman      # Carrega o endereço do sprite do Pacman.
	jal apply_movement   # Aplica o movimento atual ao Pacman (se permitido).

	# Aplica o vetor de movimento ao fantasma
	la  $a0, ghost       # Carrega o endereço do sprite do fantasma.
	jal apply_movement   # Aplica o movimento atual ao fantasma.

	# Processa a entrada do usuário (teclado)
	la  $a0, input_move  # Carrega o endereço do vetor de movimento que contém as entradas do usuário.
	jal process_input    # Chama a função para processar a entrada do usuário e atualizar o vetor de movimento.

	# Tenta alterar o movimento do Pacman baseado na entrada do usuário
	la  $a0, pacman      # Carrega o endereço do sprite do Pacman.
	la  $a1, input_move  # Carrega o endereço do vetor de movimento (novo comando de movimento do usuário).
	jal try_change_movement  # Chama a função para tentar alterar o movimento do Pacman baseado na nova entrada.

main_sleep:
	# Faz uma pausa curta para controlar a velocidade do jogo
	syscall_sleep(30)    # Chama a syscall para pausar a execução por 30 milissegundos.

	# Volta ao loop principal
	j main_L0            # Pula de volta para o rótulo 'main_L0', reiniciando o ciclo de atualização.

	# Restaura o valor do registrador $ra da pilha
	lw $ra, 12($sp)      # Carrega o valor de retorno da pilha para o registrador $ra.
	addiu $sp, $sp, 16   # Restaura o ponteiro da pilha, desfazendo a reserva de espaço feita no início.
	jr $ra               # Retorna da função (salta para o endereço armazenado em $ra).
