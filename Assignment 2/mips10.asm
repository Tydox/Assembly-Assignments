.macro terminate
li $v0, 10
syscall
.end_macro

.text

Main:
	#A=s0
	#B=s1
	#C=s2
	#D=s3
	#E=s4
LoopC0:
	addi $s0,$s0,1	#A=A+1
LoopC1:	
	bgt $s0,$s1,Yes	#A>B -> j @Yes, else continue to no
No:
	addi $s3,$s2,0	#D=C
	j LoopC2		#j @LoopC2
Yes:
	addi $s2,$s3,0	#C=D
	#j LoopC2		#j@LoopC2
	
LoopC2:
	bgt $s2,$s4 LoopC0
	addi $s2, $s2,1
	j No

End:
terminate
