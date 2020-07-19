
.text
.globl calcularVida

#recibe en a0 ataque de p1, y a1 vida de p2. Retorna nueva vida de p2
#-------------------------------------Calcular vida de p2------------------------------------------------------------
	
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
	
#-----------------------------------------------------------------------------------------------------------------------