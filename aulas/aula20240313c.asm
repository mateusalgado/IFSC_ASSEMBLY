.data

# Variáveis
nums: 		.word 	-7, 20, -5, 56, -74, 21
result: 	.word	0

.text
		lw	 	$s1, nums
		lw		$s2, nums+4
		lw		$s3, nums+8
		lw		$s4, nums+12
		lw		$s5, nums+16
	 	lw		$s6, nums+20
		add		$s1, $s1, $s2
		add		$s1, $s1, $s3
		add		$s1, $s1, $s4
		add		$s1, $s1, $s5
		add		$s1, $s1, $s6
		sw		$s1, result
		