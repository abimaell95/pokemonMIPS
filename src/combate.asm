.data
	vida:		.asciiz ": Vida: "
	ataque:		.asciiz " Ataque: "
	p1:		.asciiz "Squirtle"
	p2:		.asciiz "Charmander"
	ataca:		.asciiz " ataca a "
	resultado:	.asciiz "\nResultado del ataque: \n"
	abrir:		.asciiz "\n\n¡"
	ganador:	.asciiz " es el ganador!"
	enter:		.asciiz "\n"
	tripleEnter:	.asciiz "\n\n\n"

.text


	
	
	la $a0,p1			#a0 Nombre p1
	la $a1,p2			#a1 Nombre p2
	
	add $t2,$zero,$a0		#copia p1
	add $t3,$zero,$a1		#copia p2
	
	li $a2,8			#len p1
	li $a3,10			#len p2
	
	li $s0,2			#multiplicador p1
	li $s1,3			#multiplicador p2
	
	
	li $t0,5			#vida p1
	li $t1,5			#vida p2
	
	add $a0,$zero,$s0	
	jal calcularAtaque
	add $s2,$zero,$v0		#s2 ataque de p1
	
	add $a0,$zero,$s1
	jal calcularAtaque
	add $s3,$zero,$v0		#$3 ataque p2
	
	
pelear:	
	li $v0,4
	la $a0,tripleEnter		#imprime tripleEnter
	syscall
	
	add $a0,$zero,$t2		#imprime nombre de p1
	add $a1,$zero,$a2
	jal printPokemon
		
	li $v0,4
	la $a0,vida			#imprime " :vida: "
	syscall
	
	
	li $v0,1
	move $a0,$t0			#imprime vida de p1
	syscall
	
	li $v0,4
	la $a0,ataque			#imprime " Ataque: "
	syscall

	
	li $v0,1
	move $a0,$s2			#imprime ataque de p1
	syscall
	
	li $v0,4
	la $a0,ataca			#imprime " ataca a "
	syscall


	add $a0,$zero,$t3
	add $a1,$zero,$a3		#imprime nombre de p2
	jal printPokemon



	li $v0,4
	la $a0,vida			#imprime "vida: "
	syscall
		
	li $v0,1
	move $a0,$t1			#imprime vida de p2
	syscall
	
	li $v0,4
	la $a0,ataque			#imprime " Ataque: "
	syscall
	
	li $v0,1
	move $a0,$s3			#imprime ataque de p2
	syscall
	
	li $v0,4
	la $a0,resultado			#imprime "\nResultado del ataque \n"
	syscall
	
	add $a0,$zero,$s2
	add $a1,$zero,$t1
	jal calcularVida
	add $t1,$v0,$zero
	
	
	add $a0,$zero,$t2
	add $a1,$zero,$a2
	jal printPokemon		#imprime nombre de p1
	
	
	
	li $v0,4
	la $a0,vida			#imprime " :vida: "
	syscall
	
	
	li $v0,1
	move $a0,$t0			#imprime vida de p1
	syscall

	li $v0,4
	la $a0,ataque			#imprime " Ataque: "
	syscall

	
	li $v0,1
	move $a0,$s2			#imprime ataque de p1
	syscall
	
	li $v0,4
	la $a0,enter			#imprime enter
	syscall
	
	
	add $a0,$zero,$t3
	add $a1,$zero,$a3		#imprime nombre de p2
	jal printPokemon
	
	li $v0,4
	la $a0,vida			#imprime " :vida: "
	syscall
	
	
	li $v0,1
	move $a0,$t1			#imprime vida de p2
	syscall
	
	li $v0,4
	la $a0,ataque			#imprime " Ataque: "
	syscall

	
	li $v0,1
	move $a0,$s3			#imprime ataque de p2
	syscall
	
	
	beq $t0,$zero,Perdedor1
	beq $t1,$zero,Perdedor2
	
	#t4 es variable temporal para cambiar pokemons
	
	#cambio de lugares de pokemons	
	
	#cambio de vidas
	add $t4,$zero,$t1	
	add $t1,$zero,$t0
	add $t0,$zero,$t4
	
	#cambio de nombres
	add $t4,$zero,$t3
	add $t3,$zero,$t2
	add $t2,$zero,$t4
	
	#cambio de len
	add $t4,$zero,$a3
	add $a3,$zero,$a2
	add $a2,$zero,$t4
	
	#cambio ataques
	add $t4,$zero,$s3
	add $s3,$zero,$s2
	add $s2,$zero,$t4
	
	j pelear
	
Perdedor1:	
	li $v0,4
	la $a0,abrir			#imprime "¡"
	syscall
	
	add $a0,$zero,$t3
	add $a1,$zero,$a3
	jal printPokemon		#imprime nombre de p2

	j final
	
Perdedor2:
	li $v0,4
	la $a0,abrir			#imprime "¡"
	syscall
	
	add $a0,$zero,$t2
	add $a1,$zero,$a2
	jal printPokemon		#imprime nombre de p1

final:
	li $v0,4
	la $a0,ganador			#imprime " es el ganador!"
	syscall
	j exit

##Funciones importadas
.include "printPokemon.asm"
.include "calcularVida.asm"
.include "calcularAtaque.asm"
exit:	
	
	