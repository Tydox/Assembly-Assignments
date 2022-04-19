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
BlockNum: .asciiz "\nNum: "

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
	addi $t1,$zero,20	#i=20*4 end of run
CopyLoop:
	beq $t0,$t1,ExitCopyLoop
	lb $t3,block($t0)	#a=t3=arr[i]
	addi $t0,$t0,1	#i++=i+4
	lb $t4,block($t0)	#b=t4=arr[i+1]
	subi $t0,$t0,1	#i--=i-4
	
	add $t4,$t4,$t3	#b=b+a
	sb $t4,block($t0)	#a[i]=b
	
	addi $t0,$t0,2	#i=i+4
	j CopyLoop

ExitCopyLoop:


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


