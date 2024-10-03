# total = 0
#
#  for( i = 0; i < n; i++) {
#      if( i % 5 > 2 ) { 
#		  continue 
#      }
#      total += i
#  }
# total - $t0, i = $t1, n = $t2

li $t0, 0 # total = 0
li $t1, 0 # i = 0 (init)
L0:
	bge $t1, $t2, L0_END ### !(condicao)
	IF0:
		rem $t3, $t1, 5 ## t3 <- i % 5
		bgt $t3, 2, L0_UPDATE ##!(condicao)
	add $t0, $t0, $t1 ## total += i -- total = total + i
L0_UPDATE:
	addi $t1, $t1, 1 ## i++ (update)
	j L0
L0_END:




#if (condicao) {
#   then-block
#   if(condicao2){
#     then2-block
#   } else {
#   	 else2-block
#   }
#} else {
#   else-block
#}

#IF0:
#	!(condição)-> IF0_ELSE
#	(then-block)
#	IF1:
#	!(condicao2)-> IF1_ELSE
#	(then2-block)
#	IF1_ELSE:
#	(else2-block)
#	IF1_end:
#	j IF0_END
#IF0_ELSE:
#	(else-block)
#IF0_END:


# for( init; condicao; update){
#   corpo_loop
# }
###
#(init)
#L0:
#	!(condicao) -> L0_END
#	(corpo_loop)
#L0_UPDATE:
#	(update)
#	j L0
#L0_END:


# while(condicao) {
#   corpo 
# }
####
#L1:
#	!(condicao) -> L1_END
#	(corpo)
#	j L1
#L1_END:






