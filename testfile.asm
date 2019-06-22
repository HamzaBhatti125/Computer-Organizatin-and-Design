.data
	account: .word 100, 101, 102, 103 
	amount:	 .word 1000, 2000, 3000, 4000
	press:	 .asciiz "Press 1 for create account "
	create:	 .asciiz "Your account has been created. Your account number is: "
	enterAmount: .asciiz "\nKindly add some amount: "
	balance:     .asciiz "Thankyou for opening account.Your initial balance is: "
	continue:    .asciiz "\nPress 1 to continue"
.text
.globl main
main:

	addi $t0,$0,16	#t0 me index hai wrt 4byte
	addi $t1,$0,4
	addi $t2,$0,104	#t2 me 104 save h

	add $a1,$0,$t0	#a1 me 4byte ka index hai
	add $a2,$0,$t2
	add $a3,$0,$t1	#a3 me length hai array ka
	
continuee:
	
	li $v0,4
	la $a0,press
	syscall

	li $v0,5
	syscall

	move $t4, $v0
	
	addi $t5,$0,1
	beq $t4,$t5,opt1
	
	j out	

opt1:
	jal createAccount
	
	li $v0,4
	la $a0,continue
	syscall

	li $v0,5
	syscall

	move $t6, $v0
	beq $t6,$t5,continuee

	j out

createAccount:

	sw $s0,0($sp)


	sw $a2,account($a1)


	li $v0,4
	la $a0,create
	syscall

	li $v0,1
	move $a0, $a2
	syscall

	li $v0,4
	la $a0,enterAmount
	syscall

	li $v0,5
	syscall

	move $s0, $v0

	sw $s0, amount($a1)

	addi $a1,$a1,4	#a1 ko brhane k liye wrt 4byte
	addi $a2,$a2,1
	addi $a3,$a3,1	#length brhane k liye

	li $v0,4
	la $a0,balance
	syscall

	li $v0,1
	move $a0,$s0
	syscall

	add $a0,$0,$0

	lw $s0,0($sp)

	jr $ra

.end createAccount	

out:
	li $v0,10
	syscall

.end main