.data
pokemonList: .space 432
typeList: .space 432
pokemonNameLen: .space 432
typeNameLen: .space 432		 ## 432 = 108 pokemon * 4bytes direccion de memoria en el buffer o 4bytes len del string
matrix: .word 1,1,1,1,1,3,1,0,3,1,1,1,1,1,1,1,1,1,2,1,3,3,1,2,3,0,2,1,1,1,1,3,2,1,2,3,1,2,1,1,1,3,2,1,3,1,1,2,3,1,1,1,1,1,1,1,1,3,3,3,1,3,0,1,1,2,1,1,1,1,1,2,1,1,0,2,1,2,3,1,2,2,1,3,2,1,1,1,1,1,1,3,2,1,3,1,2,1,3,2,1,1,1,1,2,1,1,1,1,3,3,3,1,1,1,3,3,3,1,2,1,2,1,1,2,3,0,1,1,1,1,1,1,2,1,1,1,1,1,2,1,1,3,1,1,1,1,1,1,2,1,1,3,3,3,1,3,1,2,1,1,2,1,1,1,1,1,3,2,1,2,3,3,2,1,1,2,3,1,1,1,1,1,1,2,2,1,1,1,2,3,3,1,1,1,3,1,1,1,1,3,3,2,2,3,1,3,3,2,3,1,1,1,3,1,1,1,1,2,1,0,1,1,1,1,1,2,3,3,1,1,3,1,1,1,2,1,2,1,1,1,1,3,1,1,1,1,3,1,1,0,1,1,1,2,1,2,1,1,1,3,3,3,2,1,1,3,2,1,1,1,1,1,1,1,1,1,1,3,1,1,1,1,1,1,2,1,0,1,3,1,1,1,1,1,2,1,1,1,1,1,2,1,1,3,3,1,2,1,3,1,1,1,1,3,3,1,1,1,1,1,2,2,1
randomNum: .word 0 #Numero random entre 0-108
firstOptionVal: .word 0
firstOptionNum: .word 0
secondOptionVal: .word 0
secondOptionNum: .word 0
firstOptionType: .word 0
firstOptionTypeLen: .word 0
secondOptionType: .word 0
secondOptionTypeLen: .word 0
bufferOption1: .space 6
bufferOption2: .space 6
types: .asciiz "normal fight flying poison ground rock bug ghost steel fire water grass electric psychic ice dragon dark fairy"
fileName: .asciiz "/pokeTypes.txt"
fileWords: .space 1718 #Reserva 1718 bytes que es el numero de bytes dentro del archivo
welcomeMsg: .asciiz "Bienvenido al sistema de combates Pokemon:\n"
printSep: .asciiz ". "
newLine: .asciiz "\n"
lastOption: .asciiz "11. Salir\n"
firstOptionMsg: .asciiz "Ingrese el numero del primer Pokemon para el combate:"
secondOptionMsg: .asciiz "\nIngrese el numero del segundo Pokemon para el combate:"
versusMessage0: .asciiz "Combatientes: "
versusMessage1: .asciiz " vs. "
errorMessage: .asciiz "\nError, por favor ingrese un numero valido (1 al 11): "


.text
.globl main
##----------Inicio del programa----------##
main:
##----------Procesamos el archivo----------##
	li $v0 13		
	la $a0, fileName
	li $a1,0
	syscall
	move $s0,$v0		

	li $v0, 14			#Le avisamos al sistema que vamos a leer un archivo desde su fd
	move $a0,$s0
	la $a1, fileWords		##Le pasamos por parametro el buffer para almacenar los datos del archivo
	la $a2, 1718
	syscall

	la $s0, fileWords    	##Cargamos la direccion de memoria del buffer
	li $t0, 0	 	
	add $t1,$t0,$s0			
	loopPokemonName:
	la $s1, pokemonList 		
	add $t2, $t0,$s1 		
	sw $t1, ($t2)
	li $t3, 0 		
	loopCounterPokemon:
		lb $t4, ($t1)
		beq $t4,44,saveCounterPokemon
		addi $t3, $t3, 1	 	
		addi $t1, $t1, 1		
		j loopCounterPokemon
	saveCounterPokemon:
		la $s1, pokemonNameLen
		add $t2,$t0,$s1
		sw $t3, ($t2)
		addi $t1, $t1, 1		
		j loopTypeName
	loopTypeName:
		la $s1, typeList
		add $t2,$t0,$s1
		sw $t1, ($t2)
		li $t3, 0 		
	loopCounterType:
		lb $t4, ($t1)
		beq $t4,0,isNull
		beq $t4,13,isNewLine
		addi $t3, $t3, 1	 	
		addi $t1, $t1, 1		
		j loopCounterType
	isNewLine:
		la $s1, typeNameLen
		add $t2,$t0,$s1
		sw $t3, ($t2)
		addi $t1, $t1, 2		
		addi $t0, $t0, 4		
		j loopPokemonName
	isNull:
		la $s1, typeNameLen
		add $t2,$t0,$s1
		sw $t3, ($t2)
##--------------------------------------##
getRandom:
li $v0, 42		##Le avisamos al sistema que nos retorne un numero random entre 0 y 98
li $a1, 98
syscall
la $t0, randomNum
sw $a0, ($t0) 		##Guardamos el numero generado en la variable randomNum
initGame:
li $v0, 4
la $a0, welcomeMsg
syscall
printPokemonList:
la $t0, randomNum
lw $s1, ($t0)
li $t0, 10
li $t1, 0 #Iterar los indices
li $t2, 0 #Iterar el arreglo
add $t2, $t2, $s1 			##t2 = random
sll $t2, $t2, 2 		##random*4 = direccion de memoria
printLoop:
beq $t0, $t1, printLastOption
li $v0, 1 			##Imprimir el numero del pokemon
addi $t3, $t1,1
move $a0, $t3
syscall
li $v0, 4
la $a0, printSep
syscall
initPokemonData:
li $t4, 0 
la $s1, pokemonList
add $t3, $t2, $s1
lw $a0, ($t3)
la $s2, pokemonNameLen
add $t3, $t2, $s2
lw $a1, ($t3)
jal printPokemon
printNewLine:
li $v0, 4
la $a0, newLine
syscall
addi $t1,$t1,1
addi $t2,$t2,4
j printLoop
printLastOption:
li $v0, 4
la $a0, lastOption
syscall
promptFirstPokemonUser:
li $v0, 4
la $a0, firstOptionMsg 		##Imprimo que requiero el primer pokemon
syscall
obtenerFirstInput:
li $v0, 8
la $a0, bufferOption1
li $a1, 3
syscall
jal parseInt
move $t8,$v0
bne $v0, $zero, loadDataPokemon1
#InputError
li $v0, 4
la $a0, errorMessage
syscall
j obtenerFirstInput
loadDataPokemon1:
move $t1, $v0
li $t0, 11
beq $t1, $t0, end 		##Si envia un 11 Se termina el programa.

la $s1, randomNum
lw $t0, ($s1)
addi $t1,$t1,-1
add $t1, $t1, $t0
sll $t1, $t1, 2

la $s1, pokemonList 		##Obtenemos el la direccion de memoria del arreglo de pokemon
add $t3, $t1, $s1
lw $s1, ($t3)
la $s0, firstOptionVal
sw $s1, ($s0)  		##Guardamos la direccion de memoria del nombre de la primera opcion


la $s2, pokemonNameLen
add $t3, $t1, $s2
lw $s2, ($t3)
la $s0, firstOptionNum
sw $s2, ($s0)  		##Guardamos el len del nombre del pokemon


la $s3, typeList 		##Obtenemos el la direccion de memoria del arreglo de tipos
add $t3, $t1, $s3
lw $s3, ($t3)
la $s0, firstOptionType
sw $s3, ($s0)			##Guardamos al direccion de memoria del nombre del tipo del pokemon


la $s4, typeNameLen
add $t3, $t1, $s4
lw $s4, ($t3)
la $s0, firstOptionTypeLen
sw $s4, ($s0)  		##Guardamos el len del tipo del pokemon

promptSecondPokemonUser:
li $v0, 4
la $a0, secondOptionMsg 		##Imprimo que requiero el segundo pokemon
syscall

obtenerSecondInput:
li $v0, 8
la $a0, bufferOption2
li $a1, 3
syscall
jal parseInt
move $t9,$v0
bne $v0, $zero, loadDataPokemon2
#InputError
li $v0, 4
la $a0, errorMessage
syscall
j obtenerSecondInput
loadDataPokemon2:
move $t1, $v0
li $t0, 11
beq $t1, $t0, end 		##Si envia un 11 Se termina el programa.

la $s1, randomNum
lw $t0, ($s1)
addi $t1,$t1,-1
add $t1, $t1, $t0
sll $t1, $t1, 2

la $s1, pokemonList 		##Obtenemos el la direccion de memoria del arreglo de pokemon
add $t3, $t1, $s1
lw $s1, ($t3)
la $s0, secondOptionVal
sw $s1 ($s0)  		##Guardamos la direccion de memoria del nombre de la primera opcion


la $s2, pokemonNameLen
add $t3, $t1, $s2
lw $s2, ($t3)
la $s0, secondOptionNum
sw $s2 ($s0)  		##Guardamos el len del nombre del pokemon


la $s3, typeList
add $t3, $t1, $s3
lw $s3, ($t3)
la $s0, secondOptionType
sw $s3 ($s0)  		##Guardamos el nombre del tipo del pokemon


la $s4, typeNameLen
add $t3, $t1, $s4
lw $s4, ($t3)
la $s0, secondOptionTypeLen
sw $s4 ($s0)  		##Guardamos el len del tipo del pokemon

printVs0:
li $v0, 4
la $a0, versusMessage0
syscall

la $s0, firstOptionVal
lw  $a0, ($s0)
la $s0, firstOptionNum
lw  $a1, ($s0)
jal printPokemon

printVs1:
li $v0, 4
la $a0, versusMessage1
syscall

la $s0, secondOptionVal
lw  $a0, ($s0)
la $s0, secondOptionNum
lw  $a1, ($s0)
jal printPokemon

##Calcular datos de los pokemon
	la $t0, firstOptionType
	lw $a0, ($t0)
	la $t1, firstOptionTypeLen
	lw $a1, ($t1)
	la $a2, types
	jal indexType
	move $s0, $v0 ##Fila
	
	la $t0, secondOptionType
	lw $a0, ($t0)
	la $t1, secondOptionTypeLen
	lw $a1, ($t1)
	la $a2, types
	jal indexType
	move $s1, $v0 ##Columna
	
	move $a0, $s0
	move $a1, $s1
	la $a2, matrix
	jal getMatrixValue
	move $s3, $v0
	
	move $a0, $s1
	move $a1, $s0
	la $a2, matrix
	jal getMatrixValue
	move $s4,$v0
	
	move $s0, $s3
	move $s1, $s4 		##Obtenemos los mutiplicadores
	
	la $s2, firstOptionVal
	lw  $t2, ($s2)
	la $s2, firstOptionNum
	lw  $a2, ($s2)
	
	la $s2, secondOptionVal
	lw  $t3, ($s2)
	la $s2, secondOptionNum
	lw  $a3, ($s2)
	
	jal combatePokemon

end:
li $v0 10
syscall
##----------Fin del programa----------##

##funciones importadas
.include "indexType.asm"
.include "matrixValue.asm"
.include "parseInt.asm"
.include "combate.asm"

