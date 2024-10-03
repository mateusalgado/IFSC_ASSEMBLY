.macro print_strptr (%ptr)
  li $v0, 4
  la $a0, %ptr
  syscall
.end_macro

.macro print_intReg (%reg)
  move $a0, %reg
  li $v0, 1
  syscall
.end_macro

.macro read_str (%ptr, %max_size)
  li $v0, 8
  la $a0, %ptr
  li $a1, %max_size
  syscall
.end_macro

.macro print_str (%str)
.data
mStr: .asciiz %str
.text
   li $v0, 4
   la $a0, mStr
   syscall
.end_macro

.macro exit
   li $v0, 10
   syscall
.end_macro


.data
data_c: .word 0
data_d: .word 0

.text
init:
	la $sp, 0x7fffeffc
	jal main
	li $v0, 10
	syscall

#
#  init            |  16
#======================
#   -empty-        |  12
#----------------------
#   $ra            |  8
#----------------------
#   $s0            |  4
#----------------------
#   $a0            |  0   <- $sp
#======================
main:
	addiu $sp, $sp, -16
	sw    $s0, 4($sp)
	sw    $ra, 8($sp)

	li $a0, 5
	jal fatorial
	move $s0, $v0
	
	print_str ("O fatorial de 5 e ")
	print_intReg($s0)
	
	lw    $s0, 4($sp)
	lw    $ra, 8($sp)
	addiu $sp, $sp, 16
	jr $ra
	
	
.text 0x00401000
sumOfSquares:
	mul $t0, $a0, $a0
	mul $t1, $a1, $a1
	add $v0, $t0, $t1
	jr  $ra
	
	
#  unsigned int fatorial ( unsigned int n ) {
#       unsigned int res = 1;
#		if( n != 0 ) {
#          res = n * fatorial(n-1);
#       }
#		return res;
#  }
#  res -> $v0, n -> $a0
#  
#
# prev_stack ($a0) |  8
#======================
#   $ra            |  4
#----------------------
#   $a0            |  0   <- $sp
#======================
fatorial:
	addiu $sp, $sp, -8  # crio o quadro de pilha
	sw    $ra, 4($sp)   # armazeno o valor do $ra na pilha
	sw    $a0, 8($sp)   # armazeno $a0 na pilha
	
	li $v0, 1 # unsigned int res = 1;
	
	beqz $a0, fatorial_if0_end
		addi $a0, $a0, -1
		jal fatorial
		lw  $a0, 8($sp)  # restauro o $a0
		mul $v0, $a0, $v0

		fatorial_if0_end:
		
	lw    $ra, 4($sp)   # restauro o valor do $ra
	addiu $sp, $sp, 8 # destruo o quadro de pilha
	jr $ra
	
	
	
	









	
	
