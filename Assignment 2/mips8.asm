.macro terminate
li $v0, 10
syscall
.end_macro

.text

Main:
	jal Func #jump to function

End:
	terminate

Func:
	blt $a0,$zero,NegNum #if a0<0 -> number is neg -> jump @NegNum to reverse it
					   #otherwise set return v0 to a0 and return
	addi $v0,$a0,0
	jr
NegNum:
	sub $v0,$zero,$a0 #t0=0-X
	jr
