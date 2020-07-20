
.text
.globl calcularAtaque

#----------------------------------------------calcularAtaque-------------------------------------------------	
# Calcula el ataque total de un pokemon contra un pokemon específico, a partir de un multiplicador
# considerando como ataque base 2
#-------------------------------------------------------------------------------------------------------------
## $a0-> multiplicador
## $v0<- ataque total del pokemon
#-------------------------------------------------------------------------------------------------------------

calcularAtaque:
	addi $sp,$sp,-12
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
	addi $sp,$sp,12
	
	jr $ra
#-----------------------------------------------------------------------------------------------------------------	