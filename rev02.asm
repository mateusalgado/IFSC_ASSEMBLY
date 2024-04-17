#########################################################
# Realize a conversão das expressões abaixo considerando
# que os valores das variáveis já estão carregados nos
# registradores, conforme o mapeamento indicado abaixo
#
# Mapeamento dos registradores:
# a: $s0, b: $s1, c: $s2, d: $s3
#########################################################
# if (a != b) {
#    a = b;
#    if( c < 3 ){
#      a++;
#    } else {
#      for(int i = 3; i < 15; i += 2) {
#         b += i;
#      }
#    }
# }
.macro exit
	li $v0, 10
	syscall
.end_macro

main:
	bne $s0, $s1, exit
	addi $s0, $s1, 0
	li $s4, 3
	bgeu $s4, $s2, loop_for
	addi $s0, $s0, 1
	exit

    	loop_for:
        	li $s4, 3

    	for_loop:
    		li $s5, 15
        	bgtu $s4, $s5, end_for_loop
        	add $s1, $s1, $s4
        	addi $s4, $s4, 2
        	j for_loop

    	end_for_loop:
    		exit
#########################################################