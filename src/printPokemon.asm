#-------------------printPokemon--------------------#
#       Funcion que imprime al pokemon que
#       se le pase como paramentro.
#---------------------------------------------------#
##
# $a0-> Direccion de memoria del nombre del pokemon
# $a1-> Len del nombre del pokemon
##
#---------------------------------------------------#

.globl printPokemon
printPokemon:
addi $sp, $sp, -16
sw $t0, ($sp)
sw $t1, 4($sp) 
sw $t2, 8($sp)
sw $ra, 12($sp)

li $t0, 0       #Contador de caracteres del pokemon
move $t1, $a0
move $t2, $a1
loopPrint:
beq $t0, $t2, endloop
li $v0, 11      
lb $a0, ($t1)
syscall
addi $t0, $t0, 1
addi $t1, $t1 1
j loopPrint
endloop:
lw $t0, ($sp)
lw $t1, 4($sp) 
lw $t2, 8($sp)
lw $ra, 12($sp)
addi $sp, $sp, 16

jr $ra
