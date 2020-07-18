
.text
.globl compareStrings


#comparar strings retorna 1 si son iguales, 0 sino
#------------------------------------------------------Funcion comparar strings ---------------------------------
	
compareStrings:
	addi $sp,$sp,-16
	sw $a0,0($sp)
	sw $a1,4($sp)
	sw $t2,8($sp)
	sw $t3,12($sp)
	sw $ra,16($sp)
	


comparar:	
	lb $t2,0($a0)		#caracter de t2-->str1
	lb $t3,0($a1)		#caracter de t3-->str2
	
	beq $t2,$zero,correcto	#Termina de recorrer el string
	
	bne  $t2,$t3,incorrecto	#comparar si dos caracteres son diferentes
	addi  $a0,$a0,1
	addi  $a1,$a1,1
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
	addi $sp,$sp,16
	
	jr $ra
#-----------------------------------------------------------------