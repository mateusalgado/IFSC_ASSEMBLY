### c = ( a < b ) && ((a+b) % 3) == 2


  li $t0, 4
  li $t1, 10

  add  $t3, $t0, $t1
  li   $t4, 3 
  div  $t3, $t4
  mfhi $t3
  li   $t4, 2
  seq  $t3, $t3, $t4  # tmp1 = ((a+b) % 3) == 2
  
  slt  $t2, $t0, $t1  # c = (a < b)
  
  and  $t2, $t2, $t3  # c = c && tmp1 
  
