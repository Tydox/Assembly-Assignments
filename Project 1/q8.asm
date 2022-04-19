.macro terminate
li $v0, 10
syscall
.end_macro

###############
.data 0X10010000
block: .space 80 #block size=20 words * 4 bytes
text: .asciiz "\nMax Num: "

.text
Main:
	addi $a3,$zero,20 #a3=20
	
#Init Block 1
	la $s1,block	#s1=init block[0] adr
	move $a2,$s1	#a2=s1 func arg
	jal Func		#Func(block,20)
	
#Swap 		
	
#Loop - Swap byte 2n+1 <-> byte 2n
	#init start and end iterator
	addi $t0,$zero,0 #i=0
	addi $t1,$zero,76 #i=20*4=80
LoopCopy: 
	beq $t0,$t1,ExitLoopCopy		#if(t0==t1) j@exitloop
	lh $t3,block($t0)	#load word from mem @block[i] to reg t3
	addi $t0,$t0,2	#i++
	lh $t4,block($t0)
	addi $t0,$t0,-2	#i--
	sh $t4,block($t0)
	addi $t0,$t0,2	#i++
	sh $t3,block($t0)	#store word to mem @block2[i] from reg t3
	
	addi $t0,$t0,4	#i++
	j LoopCopy
	
ExitLoopCopy:

	

End:
	terminate
	
#############
###Functions###
#############

Func:
#Random Number Generator
	addi $v0, $zero,42 #set syscall mode to random int gen
	addi $a1,$zero,100 #set a1 upper bound range to 100
	addi $t0,$a2,0 #t0=a2=block[0]
	sll $t1,$a3,2 #t1=20*4
	add $t1,$t0,$t1	#init block[19] adr

Loop:
	beq $t0,$t1,ExitLoop	#if(t0==t1) j@Exit
	syscall
	subi $a0,$a0,50	#a0=a0-50
#Store Word Into Array Block
	sw $a0,0($t0)
	addi $t0,$t0,4	#block[i++]==block[k+4]
	j Loop

ExitLoop:
	jr $ra


