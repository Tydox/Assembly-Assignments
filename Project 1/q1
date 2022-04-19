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

.macro getUserInput
 # Getting user input
    li $v0, 5
    syscall
.end_macro    
 
.macro copyInputTo(%arg)
# Moving the integer input to another register
    addi %arg, $v0,0
.end_macro
              
.macro printRegister(%arg)
li $v0,1
add $a0,$zero, %arg
syscall
.end_macro


###############################
.data 0X10010000
block: .space 80 #block size=20 words * 4 bytes


.text
Main:
	
	la $t0,block	#init block[0] adr
	addi $t1,$t0,80	#init block[19] adr

#Random Number Generator
	addi $v0, $zero,42 #set syscall mode to random int gen
	addi $a1,$zero,100 #set a1 upper bound range to 100

Loop:
	beq $t0,$t1,ExitLoop	#if(t0==t1) j@Exit
	syscall
	subi $a0,$a0,50	#a0=a0-50
#Store Word Into Array Block
	sw $a0,0($t0)
	addi $t0,$t0,4	#block[i++]==block[k+4]
	j Loop

ExitLoop:


End: 
	terminate
