.data

# Variáveis
nums: 		.word 	-7, 20, -5, 56, -74, 21
result: 	.word	0

.text
  		la 		$t1, nums
		lw	 	$s1, 0($t1)
		lw		$s2, 4($t1)
		lw		$s3, 8($t1)
		lw		$s4, 12($t1)
		lw		$s5, 16($t1)
		lw		$s6, 20($t1)
		add		$s1, $s1, $s2
		add		$s1, $s1, $s3
		add		$s1, $s1, $s4
		add		$s1, $s1, $s5
		add		$s1, $s1, $s6
		la		$t1, result
		sw		$s1, 0($t1)