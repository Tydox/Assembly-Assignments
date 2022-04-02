
.macro terminate
li $v0, 10
syscall
.end_macro

#.macro print(%arg)
#li $v0,1
#add $a0,$zero, %arg
#syscall
#.end_macro

#.macro printMSG
#li $v0,4
#la $a0, message
#syscall
#.end_macro

.data
#g: .word 0x5
#h: .word 0x6
#message: .asciiz "\n Value: \t"

.text
Main:
	lw $t1, 1000($zero) # load a from adr 1000
	lw $t2, 2000($zero) # load b from adr 2000
	li    $t0, 1 #i=1
	#TEST
	#lw $t1,g
	#lw $t2,h
	#addi $t7,$t1,0

 Loop:
 	add $t1,$t1,$t7 #a=a+a
 	addi  $t0, $t0, 1 # ++i
	 bne   $t0, $t2, Loop # i< b

Exit:	 	 
	#printMSG 
	#print($t1)
	terminate
