.text 0x00430000

#  int colors[8];
#  sprite sprites[20];
#  char sprite[49];
#=============================================================
# void draw_sprite(sprite_id, X, Y){
#       char * ptr_sprite =  sprites[sprite_id];
#       for(int i = 0; i < 49; i++){ 
#			color = colors[*ptr_sprite];
#           sX = i % 7 ;
#			sY = i / 7 ;
#           sX = X + sX;
#           sY = Y + sY;
#        	set_pixel(sX, sY, color)
#           ptr_sprite++;
#       }
# }

# old_stack      40($sp)
#########################
#  empty, 36($sp)
# -----------------------
#  $ra, 32($sp)
# -----------------------
#  $s4, 28($sp)
# -----------------------
#  $s3, 24($sp)
# -----------------------
#  $s2, 20($sp)
# -----------------------
#  $s1, 16($sp)
# -----------------------
#  $s0, 12($sp)
# -----------------------
#  $a2, 8($sp)
# -----------------------
#  $a1, 4($sp)
# -----------------------
#  $a0, 0($sp)
#=============================================================
# Função para desenhar um sprite
# void draw_sprite(sprite_id, X, Y)
draw_sprite:
    addiu $sp, $sp, -40         # Reserva espaço na pilha para salvamento de registradores
    sw $ra, 32($sp)            # Salva o endereço de retorno
    sw $s4, 28($sp)            # Salva o registrador $s4
    sw $s3, 24($sp)            # Salva o registrador $s3
    sw $s2, 20($sp)            # Salva o registrador $s2
    sw $s1, 16($sp)            # Salva o registrador $s1
    sw $s0, 12($sp)            # Salva o registrador $s0

    la  $s0, sprites           # Carrega o endereço base do array sprites
    mul $t0, $a0, 49           # Calcula o offset para o sprite_id no array (49 elementos por sprite)
    add $s0, $s0, $t0          # $s0 aponta para o início do sprite especificado

    move $s1, $a1              # $s1 = X (posição inicial X)
    move $s2, $a2              # $s2 = Y (posição inicial Y)

    la   $s3, colors           # Carrega o endereço base do array colors

    li  $s4, 0                 # $s4 = i (índice do loop)
draw_sprite_L0:
    bge $s4, 49, draw_sprite_L0_end # Se i >= 49, pula para o final do loop
    lb  $t0, 0($s0)            # Carrega o valor do pixel do sprite em $t0
    sll $t0, $t0, 2            # Multiplica o índice do pixel por 4 para indexar o array colors
    add $t0, $t0, $s3          # Calcula o endereço da cor usando o índice
    lw  $a2, 0($t0)            # Carrega a cor do pixel em $a2

    li  $t0, 7                 # Define o divisor 7 para calcular coordenadas na grid
    div $s4, $t0               # Divide i por 7
    mfhi $a0                   # $a0 = sX = i % 7 (coordenada X no sprite)
    mflo $a1                   # $a1 = sY = i / 7 (coordenada Y no sprite)
    add $a0, $s1, $a0          # Calcula a coordenada X global sX = X + sX
    add $a1, $s2, $a1          # Calcula a coordenada Y global sY = Y + sY

    # Chama a função para desenhar o pixel
    jal set_pixel

    addi $s0, $s0, 1           # Avança para o próximo pixel no sprite
    addi $s4, $s4, 1           # Incrementa o índice i
    j draw_sprite_L0           # Repete o loop
draw_sprite_L0_end:
    lw $ra, 32($sp)            # Restaura o endereço de retorno
    lw $s4, 28($sp)            # Restaura o registrador $s4
    lw $s3, 24($sp)            # Restaura o registrador $s3
    lw $s2, 20($sp)            # Restaura o registrador $s2
    lw $s1, 16($sp)            # Restaura o registrador $s1
    lw $s0, 12($sp)            # Restaura o registrador $s0
    addiu $sp, $sp, 40         # Libera o espaço da pilha
    jr $ra                     # Retorna da função
#=============================================================
# old_stack      16($sp)
#########################
#  $ra, 12($sp)
# -----------------------
#  $a2, 8($sp)
# -----------------------
#  $a1, 4($sp)
# -----------------------
#  $a0, 0($sp)
#=============================================================
# Função para desenhar um sprite animado
# void draw_animated_sprite(animated_sprite*)
draw_animated_sprite:
    addiu $sp, $sp, -16        # Reserva espaço na pilha para salvamento de registradores
    sw $ra, 12($sp)           # Salva o endereço de retorno

    lw  $a1, 4($a0)           # Carrega pos_X do sprite animado em $a1
    lw  $a2, 8($a0)           # Carrega pos_Y do sprite animado em $a2
    lw  $a0, 0($a0)           # Carrega o ID do sprite animado em $a0
    jal draw_sprite           # Chama a função draw_sprite

    lw $ra, 12($sp)           # Restaura o endereço de retorno
    addiu $sp, $sp, 16        # Libera o espaço da pilha
    jr $ra                    # Retorna da função
#=============================================================
# Função para aplicar o movimento a um sprite animado
# void apply_movement(animated_sprite* ptr)
apply_movement:
    lw  $t0, 4($a0)           # Carrega pos_X do sprite animado em $t0
    lw  $t1, 12($a0)          # Carrega mov_X do sprite animado em $t1
    add $t0, $t0, $t1         # Atualiza pos_X = pos_X + mov_X
    sw  $t0, 4($a0)           # Armazena o novo valor de pos_X

    lw  $t0, 8($a0)           # Carrega pos_Y do sprite animado em $t0
    lw  $t1, 16($a0)          # Carrega mov_Y do sprite animado em $t1
    add $t0, $t0, $t1         # Atualiza pos_Y = pos_Y + mov_Y
    sw  $t0, 8($a0)           # Armazena o novo valor de pos_Y

    jr $ra                    # Retorna da função
#=============================================================
# Função para definir o movimento de um sprite animado
# void set_move_animated_sprite(animated_sprite* sp, int vx, int vy)
set_move_animated_sprite:
    sw   $a1, 12($a0)         # Armazena vx (mov_X) em animated_sprite
    sw   $a2, 16($a0)         # Armazena vy (mov_Y) em animated_sprite
    jr   $ra                  # Retorna da função
#=============================================================
# Função para parar o movimento de um sprite animado
# void stop_animated_sprite(animated_sprite* sp)
stop_animated_sprite:
    sw   $zero, 12($a0)       # Zera mov_X no sprite animado
    sw   $zero, 16($a0)       # Zera mov_Y no sprite animado
    jr   $ra                  # Retorna da função
#=============================================================
# Função para obter o elemento da grid
# char get_grid_element(column_x, row_y, grid_table*)
get_grid_element:
    mul  $a1, $a1, 35         # Calcula o deslocamento da linha Y * 35
    add  $a1, $a0, $a1        # Soma X ao deslocamento da linha
    add  $a2, $a1, $a2        # Adiciona o deslocamento à base da grid_table
    lb   $v0, 0($a2)          # Carrega o valor da grid
    addi $v0, $v0, -64        # Ajusta a tabela ASCII
    jr   $ra                  # Retorna da função
#=============================================================
# Função para desenhar a grid
# void draw_grid(width, height, grid_table*)
#	     	  X 35    Y 35      
draw_grid:
    addiu $sp, $sp, -40        # Reserva espaço na pilha
    sw $s0, 12($sp)            # Salva o registrador $s0
    sw $s1, 16($sp)            # Salva o registrador $s1
    sw $s2, 20($sp)            # Salva o registrador $s2
    sw $s3, 24($sp)            # Salva o registrador $s3
    sw $s4, 28($sp)            # Salva o registrador $s4
    sw $ra, 32($sp)            # Salva o endereço de retorno

    move $s0, $a0              # $s0 = width (largura da grid)
    move $s1, $a1              # $s1 = height (altura da grid)
    move $s2, $a2              # $s2 = grid_table* (ponteiro para a tabela da grid)
    
    li   $s3, 0                # Inicializa a variável row (linha) com 0
LOOP_ROW:
    beq $s3, $s1, LOOP_ROW_end # Se row == height, sai do loop
    
    li $s4, 0                  # Inicializa a variável col (coluna) com 0
    LOOP_COL:
    beq $s4, $s0, LOOP_COL_end # Se col == width, sai do loop
    
        move $a0, $s4          # Passa a coluna como argumento para get_grid_element
        move $a1, $s3          # Passa a linha como argumento para get_grid_element
        move $a2, $s2          # Passa o ponteiro da tabela da grid para get_grid_element
        jal get_grid_element   # Chama a função get_grid_element
        
        move $a0, $v0          # Salva o elemento da grid (valor ASCII) em $a0
        mul  $a1, $s4, 7       # Calcula o deslocamento X (coluna * 7)
        mul  $a2, $s3, 7       # Calcula o deslocamento Y (linha * 7)
        jal draw_sprite        # Chama a função draw_sprite para desenhar o sprite
    
        addi $s4, $s4, 1       # Incrementa a coluna
        j LOOP_COL             # Repete o loop de colunas
    
    LOOP_COL_end:
    addi $s3, $s3, 1           # Incrementa a linha
    j LOOP_ROW                 # Repete o loop de linhas

LOOP_ROW_end:
    lw $s0, 12($sp)            # Restaura o registrador $s0
    lw $s1, 16($sp)            # Restaura o registrador $s1
    lw $s2, 20($sp)            # Restaura o registrador $s2
    lw $s3, 24($sp)            # Restaura o registrador $s3
    lw $s4, 28($sp)            # Restaura o registrador $s4
    lw $ra, 32($sp)            # Restaura o endereço de retorno
    addiu $sp, $sp, 40         # Libera o espaço da pilha
    jr   $ra                  # Retorna da função
#=============================================================
# struct mov_vector {
#    int valid;
#    int mov_x;
#    int mov_y;
# }
#########################
# old_stack ($a0)  8($sp)
#########################
#  < empty >       4($sp)
# -----------------------
#  $ra             0($sp)
#=============================================================
# Função para processar a entrada do usuário
# void process_input(mov_vector *vec)
process_input:
    addiu $sp, $sp, -8          # Reserva espaço na pilha
    sw $ra, 0($sp)             # Salva o endereço de retorno
    sw $a0, 8($sp)             # Salva o ponteiro para mov_vector

    jal get_nonblocking_char   # Obtém o próximo caractere não bloqueante
    beq $v0, -1, process_input_exit  # Se não há caractere, sai
    
    # Processa os caracteres de entrada
    bne $v0, ' ', process_input_a # Se o caractere não é espaço, verifica outros
    li $t0, 0                   # mov_x = 0
    li $t1, 0                   # mov_y = 0
    j process_input_end         # Vai para o final

process_input_a:
    bne $v0, 'a', process_input_s # Se o caractere não é 'a', verifica outros
    li $t0, -1                  # mov_x = -1
    li $t1, 0                   # mov_y = 0
    j process_input_end         # Vai para o final

process_input_s:
    bne $v0, 's', process_input_w # Se o caractere não é 's', verifica outros
    li $t0, 0                   # mov_x = 0
    li $t1, 1                   # mov_y = 1
    j process_input_end         # Vai para o final

process_input_w:
    bne $v0, 'w', process_input_d # Se o caractere não é 'w', verifica outros
    li $t0, 0                   # mov_x = 0
    li $t1, -1                  # mov_y = -1
    j process_input_end         # Vai para o final

process_input_d:
    bne $v0, 'd', process_input_exit # Se o caractere não é 'd', sai
    li $t0, 1                   # mov_x = 1
    li $t1, 0                   # mov_y = 0

process_input_end:
    lw $a0, 8($sp)             # Restaura o ponteiro para mov_vector
    sw $t0, 4($a0)             # Atualiza mov_x no mov_vector
    sw $t1, 8($a0)             # Atualiza mov_y no mov_vector
    li $t0, 1                  # Define valid = 1
    sw $t0, 0($a0)             # Atualiza valid no mov_vector

process_input_exit:
    lw $ra, 0($sp)             # Restaura o endereço de retorno
    addiu $sp, $sp, 8          # Libera o espaço da pilha
    jr $ra                     # Retorna da função
#=============================================================

#=============================================================
# Função para tentar mudar o movimento do sprite animado
# void try_change_movement(animated_sprite* sp, mov_vector* mv)
try_change_movement:
    lw $t0, 0($a1)             # Carrega 'valid' do mov_vector
    beqz $t0, try_change_movement_end  # Se 'valid' é 0, não faz nada

    lw $t1, 4($a0)             # Carrega pos_X do sprite
    lw $t2, 8($a0)             # Carrega pos_Y do sprite

    # Verifica se o sprite está alinhado com a grid
    div $t0, $t1, 7            # Divide pos_X por 7
    mfhi $t0                   # Obtém o resto da divisão
    bnez $t0, try_change_movement_end  # Se não estiver alinhado, sai

    div $t0, $t2, 7            # Divide pos_Y por 7
    mfhi $t0                   # Obtém o resto da divisão
    bnez $t0, try_change_movement_end  # Se não estiver alinhado, sai

    # O sprite está alinhado com a grid
    # Reserva espaço na pilha
    addiu $sp, $sp, -24
    sw $a0, 24($sp)            # Salva o ponteiro para animated_sprite
    sw $a1, 28($sp)            # Salva o ponteiro para mov_vector
    sw $s0, 12($sp)            # Salva registradores usados
    sw $s1, 16($sp)
    sw $ra, 20($sp)

    lw $t0, 4($a0)            # Carrega pos_X do sprite
    lw $t1, 8($a0)            # Carrega pos_Y do sprite
    
    div $a0, $t0, 7           # Converte pos_X para coordenada na grid
    div $a1, $t1, 7           # Converte pos_Y para coordenada na grid
    
    # Verifica a nova posição na grid
    add $a0, $a0, $s0         # Nova posição X na grid
    add $a1, $a1, $s1         # Nova posição Y na grid
    la  $a2, grid             # Carrega o endereço da grid
    jal get_grid_element      # Obtém o elemento da grid na nova posição

    blt $v0, 5, change_movement  # Se o elemento não for uma parede, permite o movimento
    j skip_00                  # Caso contrário, pula a mudança

change_movement:
    # Muda a posição do sprite
    lw $a0, 24($sp)           # Restaura o ponteiro para animated_sprite
    lw $a1, 28($sp)           # Restaura o ponteiro para mov_vector
    
    lw $t0, 4($a1)           # Carrega mov_x
    lw $t1, 8($a1)           # Carrega mov_y
    
    # Reseta 'valid' para 0 após mover
    sw $zero, 0($a1)

    # Chama a função para definir o movimento do sprite
    move $a1, $t0
    move $a2, $t1
    jal set_move_animated_sprite

skip_00:
    lw $s0, 12($sp)          # Restaura os registradores
    lw $s1, 16($sp)
    lw $ra, 20($sp)
    addiu $sp, $sp, 24       # Libera o espaço da pilha

try_change_movement_end:
    jr $ra                  # Retorna da função
#=============================================================
# Função para verificar se o movimento do sprite é válido
# bool check_movement(animated_sprite*)
check_movement:
    addiu $sp, $sp, -40      # Reserva espaço na pilha
    sw $ra, 32($sp)         # Salva o endereço de retorno
    sw $s4, 28($sp)         # Salva registradores usados
    sw $s3, 24($sp)
    sw $s2, 20($sp)
    sw $s1, 16($sp)
    sw $s0, 12($sp)
    sw $a2, 8($sp)          # Salva o ponteiro para a grid
    sw $a1, 4($sp)          # Salva o ponteiro para mov_vector
    sw $a0, 0($sp)          # Salva o ponteiro para animated_sprite

    lw $s0, 4($a0)          # Carrega pos_X do sprite
    lw $s1, 8($a0)          # Carrega pos_Y do sprite
    lw $s2, 12($a0)         # Carrega mov_X do sprite
    lw $s3, 16($a0)         # Carrega mov_Y do sprite

    move $s4, $a0           # Salva o ponteiro para animated_sprite

    # Verifica se a posição do sprite está alinhada com a grid
    li $t9, 7
    div $s0, $t9
    mfhi $a0                # Resto da divisão para pos_X
    bnez $a0, check_movement_end  # Se não estiver alinhado, sai
    mflo $a0
    div $s1, $t9
    mfhi $a1                # Resto da divisão para pos_Y
    bnez $a1, check_movement_end  # Se não estiver alinhado, sai
    mflo $a1

    # Verifica a nova posição após aplicar o movimento
    add $a0, $a0, $s2       # Soma mov_X a pos_X
    add $a1, $a1, $s3       # Soma mov_Y a pos_Y
    la  $a2, grid           # Carrega o endereço da grid
    jal get_grid_element    # Obtém o elemento da grid na nova posição

    blt $v0, 5, check_movement_end  # Se o elemento não for uma parede, movimento válido
    move $a0, $s4           # Se for parede, para o sprite
    jal stop_animated_sprite

check_movement_end:
    lw $ra, 32($sp)         # Restaura os registradores e o endereço de retorno
    lw $s4, 28($sp)
    lw $s3, 24($sp)
    lw $s2, 20($sp)
    lw $s1, 16($sp)
    lw $s0, 12($sp)
    lw $a2, 8($sp)
    lw $a1, 4($sp)
    lw $a0, 0($sp)
    
    addiu $sp, $sp, 40      # Libera o espaço da pilha
    jr $ra                  # Retorna da função
#=============================================================