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
.data 
fin:   .asciiz "Allice.txt"      # filename for input
fout:   .asciiz "AlliceU.txt"      # filename for output
buffersize: .word 263 #263 chars
membuff: .space 1384
.text
Main:

#Open Allice.txt
la $a0,fin
jal OpenFile
move $s0,$a0 

#Open\Create AliceU.txt
la $a0,fout
jal CreateFile
move $s1,$a0 


#Read Allice.txt
la $a0,fin
la $a1, membuff
jal ReadFile


#Close Allice.txt
move $a0,$s0
jal CloseFile

#Close AlliceU.txt
move $a0,$s1
jal CloseFile



End:
	terminate

ReadFile:
#$a0 - file desc
#$a1, address to read from
li   $v0, 14       # system call for reading from file
la   $a1, ($a1)   # address of buffer from which to read
li   $a2,1536  # hardcoded buffer length
syscall            # read from file
jr $ra

OpenFile:
#a0 = la fin\fout
#return a0
li   $v0, 13       # system call for open file
la   $a0, ($a0)      # input file name
li   $a1, 0        # flag for reading
li   $a2, 0        # mode is ignored
syscall            # open a file 
move $a0, $v0      # save the file descriptor 

jr $ra


CloseFile:
#a0 - register to close 
  li   $v0, 16       # system call for close file
  move $a0, $a0      # file descriptor to close
  syscall            # close file

jr $ra

CreateFile:
 # Open (for writing) a file that does not exist
  li   $v0, 13       # system call for open file
  la   $a0, ($a0)     # output file name
  li   $a1, 1        # Open for writing (flags are 0: read, 1: write)
  li   $a2, 0        # mode is ignored
  syscall            # open a file (file descriptor returned in $v0)
move $a0, $v0      # save the file descriptor 

jr $ra

Copy:
blt $t0,123,Swap	#if t0<='z' swap char to Upper Case
j 