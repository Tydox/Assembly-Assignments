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



.data
 A:  .asciiz "\nA= "
 B:  .asciiz "\nB= "
 C:  .asciiz "\nC= "
 D:  .asciiz "\nD= "
 newC:  .asciiz "\nNew C= "

.text
#A=s1, B=s2, C=s3, D=s4
Main:
printText(A)
getUserInput
copyInputTo($s1)

printText(B)
getUserInput
copyInputTo($s2)

printText(C)
getUserInput
copyInputTo($s3)

printText(D)
getUserInput
copyInputTo($s4)

bne $s1,$s2,NotEQ #if(s1>s2) -> j@NotEQ
	addi $s3,$s1,0 #C=A
	j End
NotEQ: 
	addi $s3,$s4,0 #C=D

End:
printText(newC)
printRegister($s3)
terminate