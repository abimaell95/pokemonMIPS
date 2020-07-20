
.text
.globl calcularVida


#---------------------------------------------CalcularVida----------------------------------------------------
# Calcula la vida del segundo pokemon después de recibir un ataque del primer pokemon
#-------------------------------------------------------------------------------------------------------------
## $a0-> ataque total del primer pokemon
## $a1-> vida del segundo pokemon
## $v0<- nueva vida del segundo pokemon
#-------------------------------------------------------------------------------------------------------------
	
calcularVida:	
	addi $sp,$sp,-8
	sw $t0,0($sp)
	sw $ra,4($sp)
	


	slt $t0,$a1,$a0
	bne $t0,$zero,lost
	sub $v0,$a1,$a0	
	j returnVida
	
		
lost:
	add $v0,$zero,$zero
	
returnVida:
	lw $t0,0($sp)
	lw $ra,4($sp)
	addi $sp,$sp,8
	
	jr $ra
	
#--------------------------------------------------------------------------------------------------------------