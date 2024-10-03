.kdata
_kexception_msg:	.word  _e0, _eu, _eu, _eu, _e4,  _e5,  _e6,  _e7
			.word  _e8,  _e9,  _e10,  _eu,  _e12,  _e13,  _eu,  _e15
              
_eu:	.asciiz	"Exception Unknow \n"
_e0:	.asciiz	"Hardware Interrupt \n"
_e4:	.asciiz	"Address error exception caused by load or fetch instruction \n"
_e5:	.asciiz	"Address error exception caused by store instruction \n"
_e6:	.asciiz	"Bus error on instruction fetch \n"
_e7: 	.asciiz	"Bus error on data fetch \n"
_e8: 	.asciiz	"System call exception \n"
_e9: 	.asciiz	"Breakpoint exception \n"
_e10: 	.asciiz	"Reserved Instruction exception \n"
_e12: 	.asciiz	"Arithmetic Overflow \n"
_e13: 	.asciiz	"Trap instruction exception \n"
_e15: 	.asciiz	"Floating point exception caused by floating point instruction \n"
  		
.ktext 0x80000180
exception_handler:
  # Salva o contexto atual (registradores) na pilha
  addiu   $sp, $sp, -120
  sw      $at,  0($sp) 
  sw      $v0, 4($sp)
  sw      $v1, 8($sp)
  sw      $a0, 12($sp)  
  sw      $a1, 16($sp)
  sw      $a2, 20($sp)
  sw      $a3, 24($sp)
  sw      $t0, 28($sp)
  sw      $t1, 32($sp)
  sw      $t2, 36($sp)
  sw      $t3, 40($sp)
  sw      $t4, 44($sp)
  sw      $t5, 48($sp)
  sw      $t6, 52($sp)
  sw      $t7, 56($sp)
  sw      $s0, 60($sp)
  sw      $s1, 64($sp)
  sw      $s2, 68($sp)
  sw      $s3, 72($sp)
  sw      $s4, 76($sp)
  sw      $s5, 80($sp)
  sw      $s6, 84($sp)
  sw      $s7, 88($sp)
  sw      $t8, 92($sp)
  sw      $t9, 96($sp)
  mfhi    $k0  # Salva o registrador hi
  sw      $k0, 100($sp)
  mflo    $k1  # Salva o registrador lo
  sw      $k1, 104($sp)
  sw      $gp, 108($sp)
  sw      $fp, 112($sp)
  sw      $ra, 116($sp)
  
  # Identifica o tipo de exceção/interrupção (registrador Cause)
  mfc0	  $k0, $13  # Move o conteúdo do registrador Cause para $k0
  andi	  $k0, $k0, 0x007C  # Isola o código da exceção

  # Carrega e imprime a mensagem correspondente
  la	  $k1, _kexception_msg
  add	  $k1, $k1, $k0  # Seleciona a mensagem certa com base no código
  lw	  $a0, 0($k1)  # Carrega a mensagem
  li  	  $v0, 4       # Syscall de impressão
  syscall
	
  # Verifica se é interrupção de hardware (código 0)
  srl	  $k0, $k0, 2
  beqz 	  $k0, exception_handler_Hardware  # Se for hardware, vai para tratamento de interrupção
  
  # Caso contrário, trata exceção de software
  bge  	  $k0, 8, exception_handler_SoftException
  li	  $v0, 10
  syscall
	
#################################################################
exception_handler_SoftException:
  # Trata exceções de software (ajusta EPC para continuar a execução)
  mfc0	  $k0, $14      # Carrega o program counter (EPC)
  addiu	  $k0, $k0, 4   # Incrementa para evitar ciclo infinito
  mtc0	  $k0, $14      # Atualiza o EPC
  j	  exception_handler_Done  # Vai para conclusão

#################################################################
exception_handler_Hardware:
  # Tratamento de interrupção de hardware (leitura de teclado)
  la   	  $t0, getchar  # Carrega a função getchar
  jalr 	  $t0           # Chama getchar
  move 	  $a1, $v0      # Move o caractere lido para $a1
  la   	  $a0, key_rb   # Carrega o buffer de teclado
  la   	  $t0, rb_write # Carrega a função de escrita no buffer
  jalr 	  $t0           # Chama rb_write para armazenar o caractere

#################################################################
exception_handler_Done:
  # Limpa o registrador Cause
  mtc0	  $0, $13
	
  # Restaura o contexto salvo
  lw      $at,  0($sp) 
  lw      $v0, 4($sp)
  lw      $v1, 8($sp)
  lw      $a0, 12($sp)  
  lw      $a1, 16($sp)
  lw      $a2, 20($sp)
  lw      $a3, 24($sp)
  lw      $t0, 28($sp)
  lw      $t1, 32($sp)
  lw      $t2, 36($sp)
  lw      $t3, 40($sp)
  lw      $t4, 44($sp)
  lw      $t5, 48($sp)
  lw      $t6, 52($sp)
  lw      $t7, 56($sp)
  lw      $s0, 60($sp)
  lw      $s1, 64($sp)
  lw      $s2, 68($sp)
  lw      $s3, 72($sp)
  lw      $s4, 76($sp)
  lw      $s5, 80($sp)
  lw      $s6, 84($sp)
  lw      $s7, 88($sp)
  lw      $t8, 92($sp)
  lw      $t9, 96($sp)
  lw      $k0, 100($sp) # Restaura hi
  mthi    $k0
  lw      $k1, 104($sp) # Restaura lo
  mtlo    $k1
  lw      $gp, 108($sp)
  lw      $fp, 112($sp)
  lw      $ra, 116($sp)
  addiu   $sp, $sp, 120  # Ajusta a pilha
  eret                 # Retorna da exceção
