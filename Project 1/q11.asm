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
Num: .asciiz "\nTotal Nums > 0: "

.text
Main:
#init block
	la $s0, block	#load block address
	addi $a3, $zero,20	#load block size 20 words = 80 bytes
#call function to generate random number into block
	move $a2,$s0	#func(a2-block adr,a3 - block size words)
	jal Func	#call functions

#copy loop
	addi $t0,$zero,0	#i=0
	addi $t1,$zero,80	#i=20*4 end of run
	addi $t7,$zero,0	#t7=sum=0
CopyLoop:
	beq $t0,$t1,ExitCopyLoop
	lw $t3,block($t0)	#a=t3=arr[i]
	blt $t3,$zero, aB	#if(t3<3) skip @aB
	addi $t7,$t7,1	#sum+1
aB:

	addi $t0,$t0,4	#i=i+4
	j CopyLoop

ExitCopyLoop:
	printText(Num)
	printRegister($t7)

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


