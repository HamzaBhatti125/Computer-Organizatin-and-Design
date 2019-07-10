.data
	sign: .asciiz "sign bit is: "
	positive: .asciiz "\n Number is positive "
	negative: .asciiz "\n number is negative "
	exp: .asciiz "\nTrue Exponent is: "
	sig: .asciiz "\nSignificand is: 1."

.text
.globl main
.ent main
main:
	
	li $s0,0x67092000

	srl $s1,$s0,31
	
	li $v0,4
	la $a0,sign
	syscall

	li $v0,1
	move $a0,$s1
	syscall

	beq $s1,$0,pos

	li $v0,4
	la $a0,negative
	syscall

	j out

pos:
	
	li $v0,4
	la $a0,positive
	syscall

out:
	srl $s2,$s0,22
	andi $s2,$s2,0xFF

	addi $s3,$s2,-127

	li $v0,4
	la $a0,exp
	syscall

	li $v0,1
	move $a0,$s3
	syscall
	

	addi $s4,$0,22
	
	li $v0,4
	la $a0,sig
	syscall

loop:
	slt $s5,$0,$s4
	beq $s5,$0,outOfloop
	srl $s6,$s0,$s4
	andi $s6,$s6,0x1
	
	li $v0,1
	move $a0,$s6
	syscall

	addi $s4,$s4,-1
	j loop

outOfloop:


	li $v0,10
	syscall
	
















.end main