.data
	account: .word   100,101,102,103
	amount: .word 	 1000,2000,3000,4000
	input: .asciiz "Select what operation would you like to perform?\n
			1. Create Account
			2. Perform Transaction  "
	accountCreated: .asciiz "Your Account has been created.Your account number is: "
	depositAmount:	.asciiz "\n Please deposit some amount in your account "
	openingBalance: .asciiz "Thankyou for opening account. Your initial balance is: "
	continue:	.asciiz "\nPess 1 to continue: " 
.text
.globl main
main:


	
	addi $t1,$0,16	#next index 16 is in t1
	
	addi $t2,$0,1	#select option 1 in t2

	addi $t3,$0,4   #t3 me index h hai
	addi $t4,$0,4	#t4 me index hai a2 ko again sahi kne k liye

	add $a1,$0,$t1	#fist argument in a1=t1
	add $a2,$0,$t3	#second agument in a2 = t3 index hai array ki
	add $a3,$0,$t4  #thid agument

	la $t5,account
	lw $t6,12($t5)
	addi $t6,$t6,1	

loop:
	li $v0,4
	la $a0,input
	syscall

	li $v0,5
	syscall

	add $a0,$0,$t6	#fist element of aay in $a0 
	addi $t6,$t6,1	#incement $t6

	move $t0,$v0	#input in t0

	beq $t0,$t2,option1

option1:
	jal createAccount

	li $v0,4
	la $a0,continue
	syscall

	li $v0,5
	syscall

	move $t7,$v0
	
	bne $t7,$t2,out
	j loop

out:
	li $v0,10
	syscall


createAccount:
	addi $sp,$sp,16

	sw $s0,0($sp)
	sw $s1,4($sp)
	sw $s2,8($sp)
	sw $s3,12($sp)
	sw $s4,16($sp)

	add $s0,$0,$a0
	#addi $a0,$a0,1
		
	sw $s0,account($a1)
	#addi $a2,$a2,1	
	
	li $v0,4
	la $a0,accountCreated
	syscall

	la $s1,account	#addess of account in $s1

	add $a2,$a2,$a2
	add $a2,$a2,$a2	#making index 4times

	add $s2,$s1,$a2	#load addess in s2


	add  $a2,$0,$a3		#make $a2 again 4	

	lw $s3,0($s2)	#aay element in s3

	li $v0,1
	move $a0,$s3
	syscall

	li $v0,4
	la $a0,depositAmount
	syscall

	li $v0,5
	syscall	
	
	move $s4,$v0	#amount in $s4


	li $v0,4
	la $a0,openingBalance
	syscall	

	sw $s4,amount($a1)	#stoing amount in amount aray
	addi $a1,$a1,4
		

	la $s1,amount	#addess of account in $s1

	add $a2,$a2,$a2
	add $a2,$a2,$a2	#making index 4times

	add $s2,$s1,$a2	#load addess in s2


	add  $a2,$0,$a3		#make $a2 again 4	
	addi $a2,$a2,1
	addi $a3,$a3,1		#make a3 5

	lw $s3,0($s2)	#aay element in s3

	li $v0,1
	move $a0,$s3
	syscall

	lw $s0,0($sp)
	lw $s1,4($sp)
	lw $s2,8($sp)
	lw $s3,12($sp)
	lw $s4,16($sp)

	addi $sp,$sp,16
	
	jr $ra

.end createAccount



.end main