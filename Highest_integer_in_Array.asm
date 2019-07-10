.data
	msg1: .asciiz "Number of input(s) you want?" #asking user number of inputs
	msg2: .asciiz "Enter your number"	      #taking input by user
	result: .asciiz "the greatest number is: "
	array: .word 100                          #list creating
	



.text
.globl main
.ent main
main:
	li $v0,4
	la $a0,msg1
	syscall

	li $v0,5
	syscall
	move $t1,$v0	#t1 storing number of inputs user want

########### number of inputs taken above##################	 
		
	addi $t0,$zero,0	#INDEX INITIALIZED
	addi $t3,$0,0	




loop:	
	slt $t2,$t3,$t1
	beq $t2,$0,EXIT
	

	li $v0,4
	la $a0,msg2
	syscall

	li $v0,5
	syscall
	move $t2,$v0	#t2 storing inputs 

		
	sw $t2,array($t0)
	addi $t0,$t0,4

	
	addi $t3,$t3,1

	j loop

EXIT:
	la $t3, array
	addi $t4,$0,0	#t4 me index hai
	addi $t5,$0,0	#t5 me counter
	addi $t6,$0,0	#t6 me greatest number

loop2:
	slt $t2,$t4,$t1
	beq $t2,$0,endOfloop2
	
	add $t4,$t4,$t4
	add $t4,$t4,$t4

	add $t7,$t3,$t4

	lw $t8,0($t7)

	slt $t2,$t8,$t6
	beq $t2,$0,nextLine
	j out
nextLine:
	addi $t6,$t8,0
out:
	addi $t5,$t5,1
	addi $t4,$t5,0

	j loop2
	

endOfloop2:
	li $v0,4
	la $a0,result
	syscall

	li $v0,1
	move $a0,$t6
	syscalls


	li $v0,10
	syscall
	
















.end main