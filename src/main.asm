.data
pokemonList: .space 432
typeList: .space 432
pokemonNameLen: .space 432
typeNameLen: .space 432		 ## 432 = 108 pokemon * 4bytes dirección de memoria en el buffer o 4bytes len del string
randomNum: .word 0 #Número random entre 0-108
firstOptionVal: .word 0
SecondOptionVal: .word 0
fileName: .asciiz "/pokeTypes.txt"
fileWords: .space 1718 #Reserva 1714 bytes que es el número de bytes dentro del archivo
welcomeMsg: .asciiz "Bienvenido al sistema de combates Pokémon:\n"
printSep: .asciiz ". "
newLine: .asciiz "\n"
lastOption: .asciiz "11. Salir\n"
firstOptionMsg: .asciiz "Ingrese el número del primer Pokémon para el combate:\n"
SecondOptionMsg: .asciiz "Ingrese el número del segundo Pokémon para el combate:\n"


.text
.globl main
main:
li $v0 13	#Le avisamos al sistema que vamos a abrir un archivo
la $a0, fileName
li $a1,0
syscall
move $s0,$v0	#Movemos el fileDescriptor en el registro $s0

li $v0, 14	#Le avisamos al sistema que vamos a leer un archivo desde su fd
move $a0,$s0
la $a1, fileWords	#Le pasamos por parametro el buffer para almacenar los datos del archivo
la $a2, 1718
syscall

la $s0, fileWords    #Cargamos la dirección de memoria del buffer
li $t0, 0	 #Iterador inicia en 0
add $t1,$t0,$s0		#Buffer[i].index
loopPokemonName:
la $s1, pokemonList 	#Cargamos la dirección de memoria de la lista de pokemon
add $t2, $t0,$s1 	#PokemonList[i].index
sw $t1, ($t2)
li $t3, 0 	#Cargamos el contador de len del nombre del pokemon
loopCounterPokemon:
lb $t4, ($t1)
beq $t4,44,saveCounterPokemon
addi $t3, $t3, 1	 #Counter ++
addi $t1, $t1, 1	#Avanzo el iterador del buffer
j loopCounterPokemon
saveCounterPokemon:
la $s1, pokemonNameLen
add $t2,$t0,$s1
sw $t3, ($t2)
addi $t1, $t1, 1	#Avanzo el iterador para obtener el nombre del tipo 
j loopTypeName
loopTypeName:
la $s1, typeList
add $t2,$t0,$s1
sw $t1, ($t2)
li $t3, 0 	#Cargamos el contador de len del nombre del tipo
loopCounterType:
lb $t4, ($t1)
beq $t4,0,isNull
beq $t4,13,isNewLine
addi $t3, $t3, 1	 #Counter ++
addi $t1, $t1, 1	#Avanzo el iterador del buffer
j loopCounterType
isNewLine:
la $s1, typeNameLen
add $t2,$t0,$s1
sw $t3, ($t2)
addi $t1, $t1, 2	#Avanzo el iterador dos veces para saltar el salto de línea y pasar al otro pokemon
addi $t0, $t0, 4	#Avanzamos el iterador de los arreglos
j loopPokemonName
isNull:
la $s1, typeNameLen
add $t2,$t0,$s1
sw $t3, ($t2)
getRandom:
li $v0, 42	#Le avisamos al sistema que nos retorne un numero random entre 0 y 98
li $a1, 98
syscall
la $t0, randomNum
sw $a0, ($t0) 	#Guardamos el número generado en la variable randomNum
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
add $t2, $t2, $s1 #t2 = random
sll $t2, $t2, 2 #random*4 = dirección de memoria
printLoop:
beq $t0, $t1, printLastOption
li $v0, 1 #Imprimir el número del pokemon
addi $t3, $t1,1
move $a0, $t3
syscall
li $v0, 4 #Imprimir el separador
la $a0, printSep
syscall
initPokemonData:
li $t4, 0 #contador de caracteres del pokemon
la $s1, pokemonList
add $t3, $t2, $s1
lw $t5, ($t3)
la $s2, pokemonNameLen
add $t3, $t2, $s2
lw $t6, ($t3)
printPokemonLoop:
beq $t4, $t6, printNewLine
li $v0, 11 #Imprimir el nombre del pokemon
lb $a0, ($t5)
syscall
addi $t4, $t4, 1
addi $t5, $t5, 1
j printPokemonLoop
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
promptPokemonUser:
li $v0, 4
la $a0, firstOptionMsg
syscall








