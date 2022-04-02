.macro terminate
li $v0, 10
syscall
.end_macro

.text

Main:
	#X=s1
	#Y=s2
	#X=X xor Y -> Y= Y xor X -> X=X xor Y
	xor $s1,$s1,$s2
	xor $s2,$s1,$s2
	xor $s1,$s1,$s2
End:
terminate