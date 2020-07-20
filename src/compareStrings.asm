
.text
.globl compareStrings


#------------------------------------------------compareStrings-----------------------------------------------
# Compara si dos string son iguales
#-------------------------------------------------------------------------------------------------------------
## $a0-> primer string
## $a1-> segundo string
## $a2-> tamaño del primer string
## $v0<- retorna 1 si son iguales y retorna 0 en caso contrario
#-------------------------------------------------------------------------------------------------------------
	
compareStrings:
	addi $sp,$sp,-24
	sw $a0,0($sp)
	sw $a1,4($sp)
	sw $t2,8($sp)
	sw $t3,12($sp)
	sw $ra,16($sp)
	sw $a2,20($sp)
	
	add $t0,$zero,$zero		#contador

comparar:
	beq $t0,$a2,correcto
	lb $t2,0($a0)		#caracter de t2-->str1
	lb $t3,0($a1)		#caracter de t3-->str2
	
	
	bne  $t2,$t3,incorrecto	#comparar si dos caracteres son diferentes
	addi  $a0,$a0,1
	addi  $a1,$a1,1
	addi  $t0,$t0,1		#Aumento el contador
	b comparar
	
	
correcto:	

	addi $v0,$zero,1
	j returnCompareString


incorrecto:
	add $v0,$zero,$zero
	
returnCompareString:
	
	lw $a0,0($sp)
	lw $a1,4($sp)
	lw $t2,8($sp)
	lw $t3,12($sp)
	lw $ra,16($sp)
	lw $a2,20($sp)
	addi $sp,$sp,24
	
	jr $ra
#-------------------------------------------------------------------------------------------------------------