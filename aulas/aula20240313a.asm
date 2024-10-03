.data 0x10010000

# Quebrando textos longos em múltiplas linhas!
help: .ascii  "The best tool ever. (v.1.0)\n”
	  .ascii  "Options:\n"
	  .ascii " --h Print this help text.\n"
		
# Inicialização de vetores
fibs: .word  0, 1, 1, 2, 3, 5, 8, 13
      .word  21, 34, 55, 89, 144, 233


abc: .word 10

.text
	la $s0, fibs+28

	lw $t0, 0($s0)
	addi $t0, $t0, 1
	sw $t0, 0($s0)
	
	### 
	
	lw $t0, abc
	addi $t0, $t0, 1
	sw $t0, abc
	
	

