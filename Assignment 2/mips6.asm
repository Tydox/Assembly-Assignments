
.macro terminate
li $v0, 10
syscall
.end_macro


.data 

.text
Main:
	#Each block is 20 words * 4 = 80 bytes ->
	la $t1, 0x10020000 #Source Addr
	la $t2, 0x10040000 #Destination Addr
	li    $t6, 1 #i=1
	li    $t4,  80 #end loop index 20*4bytes
 
   Loop:
 
	lw $a0,0($t1) #get value of a[i]
	sw $a0, 0($t2)

 	add $t1,$t1,4 #a[i++]
	add $t2,$t2,4 #b[i++]
	
	addi  $t6, $t6, 4 #i=i+4 incerement counter by 1
 	bne   $t6, $t4, Loop #i<20*4=80

Exit:	 	 

	terminate
