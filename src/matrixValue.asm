#------------------getMatrixValue-------------------#
#      Funcion que obtiene el multiplicador
#      del ataque del pokemon.
#---------------------------------------------------#
##
# $a0-> Indice del tipo del Pokemon1 en el arreglo
# $a1-> Indice del tipo del Pokemon2 en el arreglo
# $a2-> Tabla de tipos
# #v0 <-Multiplicador de atk del Pokemon1
##
#---------------------------------------------------#

.globl getMatrixValue
getMatrixValue:
move $t0, $a0
move $t1, $a1
move $t2, $a2
li $t3, 18
mul $t0, $t0, $t3       #Obtenemos el padding de las filas
add $t0, $t1, $t0       #Obtenemos la posicion del mutiplicador
sll $t0, $t0, 2         #Obtenemos el indice para indexar en la matriz
add $t1, $t0, $t2
lw $v0, ($t1)
jr $ra
