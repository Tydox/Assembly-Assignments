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
 text:  .asciiz "\nEnter a number: "
 oldNum:  .asciiz "\nOld number: "
 newNum:  .asciiz "\nNew number: "
.text

Main:

printText(text)
getUserInput
copyInputTo($s0)
printText(oldNum)
printRegister($s0)
#x=$s0
#y=$s1
#y=5*X -> y=X*4+X = X<<2 + X
sll $s1,$s0,2 #y= X<<2 = X*4
add $s1,$s1,$s0 #y=y + X = 5X
printText(newNum)
printRegister($s1)

End:
terminate