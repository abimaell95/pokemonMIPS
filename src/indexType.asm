.globl indexType
indexType:
addi $sp, $sp, -4
sw $ra, ($sp)
li $t3, 0 ##indice a retornar
move $t0,$a0
move $t1,$a1
move $t2,$a2
##Hacemos la comparación con cada uno de los tipos
move $a0, $t0
move $a2, $t1
#normal
addi, $t2, $t2, 0
move $a1, $t2
jal compareStrings
bne $v0, $zero, returnIndex
addi, $t3, $t3, 1
#fight
addi, $t2, $t2, 7
move $a1, $t2
jal compareStrings
bne $v0, $zero, returnIndex
addi, $t3, $t3, 1
#flying
addi, $t2, $t2, 6
move $a1, $t2
jal compareStrings
bne $v0, $zero, returnIndex
addi, $t3, $t3, 1
#poison
addi, $t2, $t2, 7
move $a1, $t2
jal compareStrings
bne $v0, $zero, returnIndex
addi, $t3, $t3, 1
#ground
addi, $t2, $t2, 7
move $a1, $t2
jal compareStrings
bne $v0, $zero, returnIndex
addi, $t3, $t3, 1
#rock
addi, $t2, $t2, 7
move $a1, $t2
jal compareStrings
bne $v0, $zero, returnIndex
addi, $t3, $t3, 1
#bug
addi, $t2, $t2, 5
move $a1, $t2
jal compareStrings
bne $v0, $zero, returnIndex
addi, $t3, $t3, 1
#ghost
addi, $t2, $t2, 4
move $a1, $t2
jal compareStrings
bne $v0, $zero, returnIndex
addi, $t3, $t3, 1
#steel
addi, $t2, $t2, 6
move $a1, $t2
jal compareStrings
bne $v0, $zero, returnIndex
addi, $t3, $t3, 1
#fire
addi, $t2, $t2, 6
move $a1, $t2
jal compareStrings
bne $v0, $zero, returnIndex
addi, $t3, $t3, 1
#water
addi, $t2, $t2, 5
move $a1, $t2
jal compareStrings
bne $v0, $zero, returnIndex
addi, $t3, $t3, 1
#grass
addi, $t2, $t2, 6
move $a1, $t2
jal compareStrings
bne $v0, $zero, returnIndex
addi, $t3, $t3, 1
#electric
addi, $t2, $t2, 6
move $a1, $t2
jal compareStrings
bne $v0, $zero, returnIndex
addi, $t3, $t3, 1
#psychic
addi, $t2, $t2, 9
move $a1, $t2
jal compareStrings
bne $v0, $zero, returnIndex
addi, $t3, $t3, 1
#ice
addi, $t2, $t2, 8
move $a1, $t2
jal compareStrings
bne $v0, $zero, returnIndex
addi, $t3, $t3, 1
#dragon
addi, $t2, $t2, 4
move $a1, $t2
jal compareStrings
bne $v0, $zero, returnIndex
addi, $t3, $t3, 1
#dark
addi, $t2, $t2, 7
move $a1, $t2
jal compareStrings
bne $v0, $zero, returnIndex
addi, $t3, $t3, 1
#fairy
addi, $t2, $t2, 5
move $a1, $t2
jal compareStrings
bne $v0, $zero, returnIndex
returnIndex:
move $v0, $t3
lw $ra, ($sp)
addi $sp, $sp, 4
jr $ra

.include "compareStrings.asm"

