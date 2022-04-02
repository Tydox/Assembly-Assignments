.macro terminate
li $v0, 10
syscall
.end_macro

.data 
aArray: .space 400 #100 * 4 -  array[100] 
bArray: .space 400 #100 * 4 - array[100]

.text
Main: 

	#load arrays first location to register
	la $t6, aArray #a[0]
	la $t7, bArray #b[0]
	
	 li    $t1, 0 #start loop index i=0
	
	add $t2,$t1,$t6 #t1=a[i]
	lw $a0,0($t2) #get value of a[i]
	addi $t4,$t1,4
	add $t3,$t1,$t7 #t3=b[i+1]
	lw $a1,0($t3) #get value of b[i]
	add $t2,$t2,$t3 #t2=t2+t3


terminate
