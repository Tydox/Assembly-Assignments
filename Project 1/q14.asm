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

.macro getUserInput(%arg)
 # Getting user input
    li $v0, 5
    syscall
 # Moving the integer input to another register
    addi %arg, $v0,0
.end_macro    
              
.macro printRegister(%arg)
li $v0,1
add $a0,$zero, %arg
syscall
.end_macro

###############
.data 0X10010000
block: .space 80 #block size=20 words * 4 bytes
Num: .asciiz "\nSame Number hits: "
EnterNum: .asciiz "\nEnter A Number: "
.text
Main:
#init block
	addi $a3,$zero,20	#size=20words=80 bytes
	la $s1,block	#s1=block address
#call func to init the block
	addi $a2,$s1,0	#a2=s1=block address
	jal Func

#loop init
	addi $t0,$zero,0	#i=0
	addi $t1,$zero,80	#i_end=80bytes=20words
	addi $t3,$zero,0	#count=0
	printText(EnterNum)
	getUserInput($s7)	#s7=user_num

CompLoop:
	beq $t0,$t1,ExitCompLoop	#if(t0==t1)=if(i==i_end) j@ExitMultLoop
	lw $t7,block($t0)	#t7=block[i]
	bne $t7,$s7,FAIL
	addi $t3,$t3,1	#count++	
FAIL:

	#next iteration
	addi $t0,$t0,4	#i++=i+4
	j CompLoop

ExitCompLoop:
	printText(Num)
	printRegister($t3)	#t3=count

End:
	terminate
	
#############
###Functions###
#############
#func(a1,a2)
#a2 - block address
#a3 - block size in words\int 
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


