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
fNum: .asciiz "\nFirst Num: "
sNum: .asciiz "\nSecond Num: "
ADD: .asciiz "\nAdd: "
SUB: .asciiz "\nsub: "
MULT: .asciiz "\nMult: "
DIV: .asciiz "\nDiv: "
REM: .asciiz "\t R: "

.text
Main:

	printText(fNum)
	getUserInput($s6)	#s6=user_num
	printText(sNum)
	getUserInput($s7)	#s7=user_num
	
#add s7+s6
	add $t0,$s6,$s7
	printText(ADD)
	printRegister($t0)
#sub s6-s7
	sub $t0,$s6,$s7
	printText(SUB)
	printRegister($t0)
#multiple s6*s7
	mul $t0,$s6,$s7
	printText(MULT)
	printRegister($t0)
	
#div s6/s6
	div $s6,$s7
	mflo $t0 #whole number
	printText(DIV)
	printRegister($t0)
	mfhi $t0	#reminder
	printText(REM)
	printRegister($t0)
End:
	terminate
