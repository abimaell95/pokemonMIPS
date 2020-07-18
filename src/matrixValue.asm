.data
matrix: .word 1,1,1,1,1,3,1,0,3,1,1,1,1,1,1,1,1,1

.globl getMatrixValue
getMatrixValue:
move $t0, $a0
move $t1, $a1
mul $t0, $t0, 18 #Obtenemos el padding de las filas
add $t0, $t1, $t0 #Obtenemos la posición del mutiplicador
sll $t0, $t0, 2 #Obtenemos el indice para indexar en la matriz
la $t1, matrix
add $t1, $t0, $t1
lw $v0, ($t1)
jr $ra