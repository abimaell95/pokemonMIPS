.text
.globl main
main:
	li $v0 13
	la $a0, fileName
	li $a1,0
	syscall
	move $s0,$v0
	
	li $v0, 14
	move $a0,$s0
	la $a1, fileWords
	la $a2, 2048
	syscall

	li $v0, 4
	la $a0, fileWords
	syscall
	
	li $v0, 16
	move $a0, $s0
	syscall
.data
fileName: .asciiz "/pokeTypes.txt"
fileWords: .space 2048