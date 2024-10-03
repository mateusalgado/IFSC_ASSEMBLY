.eqv ROW_SIZE 256
.eqv FRAMEBUFFER 0x10040000

.text
	la $s0, FRAMEBUFFER
	
	# for($s1 = 64; $s1 > 0; $s1--){
	#   for (s2 = 256; $s2 > 0; $s2--) {
	
	li $s1, 64
	# Padrão Branco	
w_coluna:
	li $s2, 256
w_row:
	subi $s2, $s2, 1
	add  $t0, $zero, $s2
	sll  $t0, $t0, 8
	add  $t0, $t0, $s2
	sll  $t0, $t0, 8
	add  $t0, $t0, $s2
	sw   $t0, 0($s0)
	addi $s0, $s0, 4
	bnez $s2, w_row
	subi $s1, $s1, 1
	bnez $s1, w_coluna
	
	#Padrão Vermelho
	li $s1, 64
r_coluna:
	li $s2, 256
r_row:
	subi $s2, $s2, 1
	sll  $t0, $s2, 16
	sw   $t0, 0($s0)
	addi $s0, $s0, 4
	bnez $s2, r_row
	subi $s1, $s1, 1
	bnez $s1, r_coluna
	
	#Padrão verde
	li $s1, 64
g_coluna:
	li $s2, 256
g_row:
	subi $s2, $s2, 1
	sll  $t0, $s2, 8
	sw   $t0, 0($s0)
	addi $s0, $s0, 4
	bnez $s2, g_row
	subi $s1, $s1, 1
	bnez $s1, g_coluna
	
	# Padrão Azul
	li $s1, 64
b_coluna:
	li $s2, 256
b_row:
	subi $s2, $s2, 1
	sw   $s2, 0($s0)
	addi $s0, $s0, 4
	bnez $s2, b_row
	subi $s1, $s1, 1
	bnez $s1, b_coluna
	
	
## setPixel(int x, int y, int color)
setPixel:
	mul $t0, $a1, ROW_SIZE  ## y * numero de colunas
	add $t0, $t0, $a0       ## + x
	sll $t0, $t0, 2         ## multiplico por 4
	la  $t1, FRAMEBUFFER
	add $t0, $t0, $t1		## endereco final do pixel
	lw  $a2, 0 ($t0)
	jr $ra
##---



