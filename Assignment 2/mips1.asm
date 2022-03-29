.macro terminate
li $v0, 10
syscall
.end_macro

.macro print(%arg)
li $v0,1
add $a0,$zero, %arg
syscall
.end_macro

.macro printMSG
li $v0,4
la $a0, message
syscall
.end_macro

#########################################
.data
g: .word 0x5
h: .word 0x6
message: .asciiz "\n Value: \t"

.text
Main:
	#load g,h from mem into registers
	lw $t0,g
	lw $t1,h

	# print for debug
	printMSG
	print($t0)
	printMSG
	print($t1)


	# assuming g=a0, h=a1
	slt $t3,$t0,$t1  # if g<h     -> t0=1
		       # if  g>=h -> t0=0

	bne $t3,$zero, Subz # if  t3!=0 -> jump @Subz ~ if(g<h)
			       # else continue
	add $t0,$t0,$t1	 #g=g+h
	
	j DONE #jump @Done to continue

Subz: 
	sub $t0,$t0,$t1	#g=g-h

DONE:
	#debugging printing
	printMSG
	print($t3) #comparator value g>h or g<h
	printMSG
	print($t0) #final g value

terminate # close the program