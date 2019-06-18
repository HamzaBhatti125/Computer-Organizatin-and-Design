.data
	account: .word   100,101,102,103
	amount: .word 	 1000,2000,3000,4000
	input: .asciiz "Select what operation would you like to perform?\n1. Create Account\n2. Perform Transaction  "
	accountCreated: .asciiz "Your Account has been created.Your account number is: "
	depositAmount:	.asciiz "\n Please deposit some amount in your account "
	openingBalance: .asciiz "Thankyou for opening account. Your initial balance is: "
	continue:	.asciiz "\nPess 1 to continue: " 
	performTransaction: .asciiz "What do want?\n 1.Deposit Amount\n 2.Withdraw Amount\n 3.Check Balance\n 4.Third Party Transfer\n"
	accountNumber:	.asciiz "Please enter account number: "
	amountEnter:	.asciiz "Please enter amount: "
	amountDeposit:	.asciiz "Amount has been deposited. Current balance is: "
	amountWithdraw:	.asciiz "Amount has been withdrawn. Current balance is: "
	lowBalance:	.asciiz "Not Enough Balance "
	checkBalance:	.asciiz "Current Balance is: "
	error:		.asciiz "Does not have this account number "
	firstAccount:	.asciiz "Please enter your account number "
	secondAccount:	.asciiz "Please enter other account number " 
	 
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

#loop:
	li $v0,4
	la $a0,input
	syscall

	li $v0,5
	syscall

	move $t0,$v0	#input in t0

	add $a0,$0,$t6	#fist element of aay in $a0 
	addi $t6,$t6,1	#incement $t6


	beq $t0,$t2,option1
	addi $t2,$t2,1
	beq $t0,$t2,option2

option1:
	jal createAccount

	j out

#	li $v0,4
#	la $a0,continue
#	syscall

#	li $v0,5
#	syscall

#	move $t7,$v0
	
#	bne $t7,$t2,out
#	j loop

option2:			#for perform transaction
	li $v0,4
	la $a0,performTransaction
	syscall

	li $v0,5
	syscall

	move $t0,$v0	#ab $t0 me transaction k values ayengi
	addi $t2,$0,1

	beq $t0,$t2,option3
	addi $t2,$t2,1
	beq $t0,$t2,option4
	addi $t2,$t2,1
	beq $t0,$t2,option5
	addi $t2,$t2,1
	beq $t0,$t2,option6

option3:
	jal DepositAmount
	j out

option4:
	jal WithdrawAmount
	j out

option5:
	jal CheckBalances
	j out

option6:
	jal ThirdPartyTransfer
	j out



out:
	li $v0,10
	syscall


createAccount:
	addi $sp,$sp,-16

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


DepositAmount:
	addi $sp,$sp,-32

	sw $s0,0($sp)
	sw $s1,4($sp)
	sw $s2,8($sp)
	sw $s3,12($sp)
	sw $s4,16($sp)
	sw $s5,20($sp)
	sw $s6,24($sp)
	sw $s7,28($sp)
	sw $s8,32($sp)

	li $v0,4
	la $a0,accountNumber
	syscall

	li $v0,5
	syscall

	move $s0,$v0	#putting input account number in $s0

	li $s1,0	#making $s1 index check

	la $s2,account	#load address of account in s2

	la $s3,amount	#load address of amount in s3
	
	addi $s6,$0,0

loop:
	slt $s4,$s1,$a3
	beq $s4,$0,notFound	

	add $s1,$s1,$s1
	add $s1,$s1,$s1	#double the index
	
	
	add $s4,$s1,$s2

	lw $s5,0($s4)	#get the value in array cell
	
	beq $s5,$s0,outOfloop	#outOfloop matlab account number match hgya
	add $s1,$s6,$0	#to make index correct
	addi $s6,$s6,1	#to increase counter

	j loop
	
outOfloop:
	#addi $s1,$s1,-1	#index ko ek peechay krne k liye

	#add $s1,$s1,$s1
	#add $s1,$s1,$s1	#4 times the index

	addi $s8,$s6,0	#s8 me index hai mere paas
			
	add $s4,$s1,$s3	#s4 me ab overall address hai

	lw $s5,0($s4)	#ab $s5 me mere paas woh deposit account k amount ki value hai

	addi $s4,$0,4	#s4 me 4 hai ab
	mult $s8,$s4
	mflo $s8

	li $v0,4
	la $a0,amountEnter	#ab me amount ka input lunga
	syscall

	li $v0,5
	syscall

	move $s7,$v0		#input amount $s7 me hai
	add $s5,$s5,$s7		#amount update krdi hai

	sw $s5,amount($s8)	#amount update hgyi array me

	li $v0,4
	la $a0,amountDeposit	#ab me amount ka input lunga
	syscall

	li $v0,1
	move $a0,$s5
	syscall
	
	j outer

notFound:
	li $v0,4
	la $a0,error
	syscall

outer:
	lw $s0,0($sp)
	lw $s1,4($sp)
	lw $s2,8($sp)
	lw $s3,12($sp)
	lw $s4,16($sp)
	lw $s5,20($sp)
	lw $s6,24($sp)
	lw $s7,28($sp)
	lw $s8,32($sp)

	addi $sp,$sp,32		
	jr $ra	
.end DepositAmount

WithdrawAmount:
	addi $sp,$sp,-32

	sw $s0,0($sp)
	sw $s1,4($sp)
	sw $s2,8($sp)
	sw $s3,12($sp)
	sw $s4,16($sp)
	sw $s5,20($sp)
	sw $s6,24($sp)
	sw $s7,28($sp)
	sw $s8,32($sp)

	li $v0,4
	la $a0,accountNumber
	syscall

	li $v0,5
	syscall

	move $s0,$v0	#putting input account number in $s0

	li $s1,0	#making $s1 index check

	la $s2,account	#load address of account in s2

	la $s3,amount	#load address of amount in s3
	
	addi $s6,$0,0

loops:
	slt $s4,$s1,$a3
	beq $s4,$0,notFounds	

	add $s1,$s1,$s1
	add $s1,$s1,$s1	#double the index
	
	
	add $s4,$s1,$s2

	lw $s5,0($s4)	#get the value in array cell
	
	beq $s5,$s0,outOfloops	#outOfloop matlab account number match hgya
	add $s1,$s6,$0	#to make index correct
	addi $s6,$s6,1	#to increase counter

	j loops
	
outOfloops:
	addi $s8,$s6,0	#s8 me index hai mere paas
			
	add $s4,$s1,$s3	#s4 me ab overall address hai

	lw $s5,0($s4)	#ab $s5 me mere paas woh deposit account k amount ki value hai

	addi $s4,$0,4	#s4 me 4 hai ab
	mult $s8,$s4
	mflo $s8

	li $v0,4
	la $a0,amountEnter	#ab me amount ka input lunga
	syscall

	li $v0,5
	syscall



	move $s7,$v0		#input amount $s7 me hai

	slt $s1,$s7,$s5
	beq $s1,$0,balanceKam

	sub $s5,$s5,$s7		#amount update krdi hai

	sw $s5,amount($s8)	#amount update hgyi array me

	li $v0,4
	la $a0,amountWithdraw	#ab me amount ka output btaunga
	syscall

	li $v0,1
	move $a0,$s5
	syscall
	
	j outers

balanceKam:
	li $v0,4
	la $a0,lowBalance
	syscall

	j outers

notFounds:
	li $v0,4
	la $a0,error
	syscall

outers:
	lw $s0,0($sp)
	lw $s1,4($sp)
	lw $s2,8($sp)
	lw $s3,12($sp)
	lw $s4,16($sp)
	lw $s5,20($sp)
	lw $s6,24($sp)
	lw $s7,28($sp)
	lw $s8,32($sp)

	addi $sp,$sp,32		
	jr $ra	

.end WithdrawAmount

CheckBalances:
	addi $sp,$sp,-24

	sw $s0,0($sp)
	sw $s1,4($sp)
	sw $s2,8($sp)
	sw $s3,12($sp)
	sw $s4,16($sp)
	sw $s5,20($sp)
	sw $s6,24($sp)

	li $v0,4
	la $a0,accountNumber
	syscall

	li $v0,5
	syscall

	move $s0,$v0	#putting input account number in $s0

	li $s1,0	#making $s1 index check

	la $s2,account	#load address of account in s2

	la $s3,amount	#load address of amount in s3
	
	addi $s6,$0,0

loopss:
	slt $s4,$s1,$a3
	beq $s4,$0,notFoundss	

	add $s1,$s1,$s1
	add $s1,$s1,$s1	#double the index
	
	
	add $s4,$s1,$s2

	lw $s5,0($s4)	#get the value in array cell
	
	beq $s5,$s0,outOfloopss	#outOfloop matlab account number match hgya
	add $s1,$s6,$0	#to make index correct
	addi $s6,$s6,1	#to increase counter

	j loopss
	
outOfloopss:
			
	add $s4,$s1,$s3	#s4 me ab overall address hai

	lw $s5,0($s4)	#ab $s5 me mere paas woh value hai jo show krni hai


	li $v0,4
	la $a0,checkBalance	#ab me amount ka output btaunga
	syscall

	li $v0,1
	move $a0,$s5
	syscall

	j outerss

notFoundss:
	li $v0,4
	la $a0,error
	syscall

outerss:
	lw $s0,0($sp)
	lw $s1,4($sp)
	lw $s2,8($sp)
	lw $s3,12($sp)
	lw $s4,16($sp)
	lw $s5,20($sp)
	lw $s6,24($sp)


	addi $sp,$sp,24	
	jr $ra	

.end CheckBalances

ThirdPartyTransfer:
	addi $sp,$sp,-32

	sw $s0,0($sp)
	sw $s1,4($sp)
	sw $s2,8($sp)
	sw $s3,12($sp)
	sw $s4,16($sp)
	sw $s5,20($sp)
	sw $s6,24($sp)
	sw $s7,28($sp)
	sw $s8,32($sp)


	li $v0,4
	la $a0,firstAccount
	syscall

	li $v0,5
	syscall

	move $s0,$v0	#putting fir account input in $s0

	li $v0,4
	la $a0,secondAccount
	syscall

	li $v0,5
	syscall

	move $s1,$v0	#putting second account input in $s1



	li $s2,0	#index check

	la $s3,account	#address of account array

	la $s4,amount	#address of amount array

	addi $s5,$0,0	#s5 me counter hai

looping1:
	slt $s6,$s2,$a3
	beq $s4,$0,notFoundAccount

	add $s2,$s2,$s2
	add $s2,$s2,$s2	#double the index

	add $s6,$s2,$s3	#ab s6 me overall address ajaega account wali array ka

	lw $s7,0($s6)	#ab s7 me mere paas account1 ki value agyi h

	beq $s7,$s0,outOfloop1
	addi $s5,$s5,1	#to increase counter
	add $s2,$s0,$s5		#to correct the value of s2

	j looping1

	#abhi mere paas $s7 me account number hai aur $s2 me woh index hai jahan account number match hua hai

outOfloop1:
	#addi $s8,$s5,0	
	add $s6,$s2,$s4

	lw $s8,0($s6)	#ab s8 me mere paas woh amount h jo mjhy used krni hai

	addi $s6,$0,4
	mult $s6,$s5
	mflo $s5	#s5 me ab woh index jo 4 se multiply ho chuka hai

	li $v0,4
	la $a0,amountEnter
	syscall

	li $v0,5
	syscall

	move $s7,$v0	#ab $s7 me input amount hai mere paas

	slt $s6,$s7,$s8
	beq $s1,$0,balancekam1
	sub $s8,$s8,$s7	#amount update hgyi account1 ki

	sw $s8,amount($s5)	#amount update hgyi array me account1 ki

	li $v0,1
	move $a0,$s8
	syscall
	


#for second account
	add $s0,$s1,$0		#ab input account 2 ka $s0 me hai
	
	li $s1,0		#s1 me index hai
	addi $s2,$0,0		#s2 me counter hai
	###s3 me account ki array ka adrress hai aur s4 me amount ki array ka


looping2:
	slt $s5,$s1,$a3
	beq $s5,$0,notFoundAccount

	add $s1,$s1,$s1
	add $s1,$s1,$s1	#double the index

	add $s5,$s1,$s3	#s5 me account ki array ka address hai

	lw $s6,0($s5)	#get the value in the array

	beq $s6,$s0,outOfloop2
	addi $s2,$s2,1
	add $s1,$s2,$0	#to correct index

	j looping2

outOfloop2:
	#s2 me counter hai aur s1 me index ka address hai mere paas

	add $s5,$s1,$s4	#s5 me overall address hai amount ki array ka

	lw $s4,0($s5)	#ab s4 me mere paas woh account2 ki value hai mere paas
	addi $s6,$0,4	#s6 me 4 hai mere paas

	mult $s6,$s2	
	mflo $s6	#index hai s6 me wrt 4byte
	
	add $s4,$s4,$s7	#ab account me mere paas account1 ki value add hjaegi

	sw $s4,amount($s6)

	li $v0,1
	move $a0,$s4
	syscall

	j outing

notFoundAccount:
	li $v0,4
	la $a0,error
	syscall

	j outing

balancekam1:
	li $v0,4
	la $a0,lowBalance
	syscall
	
	j outing


outing:
	lw $s0,0($sp)
	lw $s1,4($sp)
	lw $s2,8($sp)
	lw $s3,12($sp)
	lw $s4,16($sp)
	lw $s5,20($sp)
	lw $s6,24($sp)
	lw $s7,28($sp)
	lw $s8,32($sp)	

	addi $sp,$sp,32	
	jr $ra	

.end ThirdPartyTransfer


.end main