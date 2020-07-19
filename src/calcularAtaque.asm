
.text
.globl calcularAtaque

#Retorna el ataque total del pokemon, recibe en a0 el multiplicador
#----------------------------------------------Funcion calcular Ataque-------------------------------------------------	
calcularAtaque:
	addi $sp,$sp,-8
	sw   $s0,0($sp)
	sw   $s1,4($sp)
	sw   $ra,8($sp)
	
	
	li $s0,2		#ataque
	li $s1,3		#codigo mutiplicador 1/2
	
	beq $a0,$s1,division
	mul $v0,$s0,$a0		#t0=2*multiplicador
	j returnAtaque
	
division:
	srl $v0,$s0,1	
			


returnAtaque:
	
	lw   $s0,0($sp)
	lw   $s1,4($sp)
	lw   $ra,8($sp)
	addi $sp,$sp,8
	
	jr $ra
#--------------------------------------------------------------------------------------------------------------------	