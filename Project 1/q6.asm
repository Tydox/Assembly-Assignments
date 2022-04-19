.macro terminate
li $v0, 10
syscall
.end_macro

.macro printText(%arg)
# Printing out the text
    li $v0, 4
    la $a0, %arg
    syscall
.end_macro

.macro printRegister(%arg)
li $v0,1
add $a0,$zero, %arg
syscall
.end_macro

###############
.data 0X10010000
block: .space 80 #block size=20 words * 4 bytes
text: .asciiz "\nMin Num: "

.text
Main:
	addi $a3,$zero,20 #a3=20
	
#Init Block 1
	la $s1,block	#s1=init block[0] adr
	move $a2,$s1	#a2=s1 func arg
	jal Func		#Func(block,20)
	

#Find max number in block\array

		
MinNumber:	
	li $t0,0	#init i=0
	li $t1,80	#end i=80
	addi $t7,$zero,0x0000FFFF
	
MinNumberLoop:
	beq $t0,$t1,ExitMinNumber	#if(t0==t1) j@ExitFuncLoop
	lw $t2,block($t0)	#Load word from block[i]
	blt $t7,$t2,NotMin	#if(t2<t7) don't update max num
	addi $t7,$t2,0	#update max num t2=t7
	printText(text)
	printRegister($t7)
NotMin:
	addi $t0,$t0,4	#i++
	j MinNumberLoop	#restart loop
	
ExitMinNumber:


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


