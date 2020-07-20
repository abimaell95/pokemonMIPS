.text
.globl parseInt


#Retorna 0 si es un numero invalido y retorna el numero si es valido
#-------------------------------------------------parseInt----------------------------------------------------
# Convierte un string de dos caracteres en un número de 2 digitos entre el 1 y el 11 si fuera posible
#-------------------------------------------------------------------------------------------------------------
## v0<- retorna 0 si no es número válido o el número si este fuera válido
#-------------------------------------------------------------------------------------------------------------
### ver otras funciones: validarSaltoLinea,


parseInt:
	addi $sp, $sp,-28
	sw   $a0, 0($sp)	#Guarando a0
	sw   $ra, 4($sp)	#Guardando punto de retorno
	sw   $t1, 8($sp)
	sw   $t2, 12($sp)
	sw   $t3, 16($sp)
	sw   $t4, 20($sp)
	sw   $t5, 24($sp)
	
			
		
	add   $t3,$a0,$zero
	addi   $t4,$a0,1
				
	lbu   $t3, 0($t3)		#Primer termino
	
	lbu   $t4,0($t4)		#segundo termino
	
	add $a0,$zero,$t4		#segundo termino es argumento de ValidarSaltoLinea
	
	addi  $t3,$t3,-48		#obtengo n1
	
	jal validarSaltoLinea
	beq $v0,$zero,n2NoEsSalto
	
	
	slti  $t1,$t3,10		#t3<10 ? 1:0
	beq   $t1,$zero,addZero
	slti  $t1,$t3,1			#t3<0 ? 1:0
	bne   $t1,$zero,addZero
	add   $t5,$zero,$t3
	j goodExit
	
addZero:	add $t5,$zero,$zero
	j badExit
	

	
n2NoEsSalto:	
		#addi  $t4,$t4,-48		#obtengo n2
		addi $t2,$zero,1
		add $t4,$t4,-48
		beq $t4,$zero,sumarDiez
		beq $t4,$t2,sumarDiez
		j badExit
		
sumarDiez:	add $t5,$t4,10 
		bne $t3,$t2,badExit

goodExit:	add $v0,$zero,$t5
		j returnNumber
		
badExit:	add $v0,$zero,$zero
	
	
returnNumber:	lw   $a0, 0($sp)	
		lw   $ra, 4($sp)	
		lw   $t1, 8($sp)
		lw   $t2, 12($sp)
		lw   $t3, 16($sp)
		lw   $t4, 20($sp)
		lw   $t5, 24($sp)
		addi $sp, $sp,28
		
		jr $ra	
	
	
	
	
#-----------------------------------------------------------------------------------------------------------
				
					





						
#-----------------------------------isArrayNumbers-----------------------------------------------------------
# Verifica si un string de compuesto por dos caracteres está compuesto sólo por dos número o un número
# un salto de linea
#-------------------------------------------------------------------------------------------------------------	
## $a0-> string a Verificar
## $v0<- retorna 1 si es un arreglo de número y 0 en caso contrario	
#-------------------------------------------------------------------------------------------------------------
### ver otras funciones: validarSaltoLinea, validateNumber

isArrayNumbers:
	addi $sp, $sp,-32
	sw   $a0, 0($sp)	#Guarando a0
	sw   $ra, 4($sp)	#Guardando punto de retorno
	sw   $t0, 8($sp)
	sw   $t1, 12($sp)
	sw   $t2, 16($sp)
	sw   $t3, 20($sp)
	sw   $t4, 24($sp)
	sw   $t5, 28($sp)	
  	

	add $t1,$zero,$zero
	add $t4,$zero,$zero	#variable a retornar
	move $t5, $a0

	
loop:	slti $t2,$t1,2		
	beq $t2,$zero,return
	
	add $t3,$t1,$t5
	
	lbu   $t0, 0($t3)
	add   $a0,$zero,$t0
	
	addi $t1,$t1,1
	
	#Verificar que el segundo caracter sea salto de linea
	addi $t3, $zero,2
	beq  $t1,$t2,validar
	
	jal validarSaltoLinea
	bne $v0,$zero,valido
	
	
validar:jal validateNumber
	
	add $t0,$zero,$v0	#t0 tiene en valor que retorna la funcion
	
	
	bne $t0,$zero,valido
	
	
	

invalido: add $t4,$zero,$zero
	
	  j return

valido:   addi $t4,$zero,1

	  j loop
	  



	
return: add $v0,$zero,$t4

	lw   $a0, 0($sp)	
	lw   $ra, 4($sp)	
	lw   $t0, 8($sp)
	lw   $t1, 12($sp)
	lw   $t2, 16($sp)
	lw   $t3, 20($sp)
	lw   $t4, 24($sp)
	sw   $t5, 28($sp)
	addi $sp, $sp,32
	
	jr    $ra		#retorno
#-------------------------------------------------------------------------------------------------------------






#----------------------------------------validateNumber-------------------------------------------------------
# verifica si un caracter es un número entre 0 y 9 considerando el código ascii del mismo
#-------------------------------------------------------------------------------------------------------------
## a0-> caracter a ser evaluado
## v0<- retorna 1 si es un dígito y 0 sino
#-------------------------------------------------------------------------------------------------------------
	#Validar si un input es un número
	
validateNumber:
	#Compara si es un numero entre 0 y 9
	addi $sp, $sp,-12
	sw   $a0, 0($sp)	#Guarando a0
	sw   $ra, 4($sp)	#Guardando punto de retorno
	sw   $t1, 8($sp)	
      

      	
      	#a0-> argumento
    	sltiu $t1, $a0, 48	# t1 = (x < 48) ? 1 : 0
    	bne $t1,$zero,zero
   	sltiu $t1, $a0, 58	# t1 = (x < 58) ? 1 : 0
   	beq $t1,$zero,zero
    	addi $t0,$zero,1
    	j resultado
    	
    	
zero:	add $t0,$zero,$zero
    	
resultado:add   $v0,$zero,$t0	#resultado
    	
    	lw    $a0,0($sp)
    	lw    $ra,4($sp)
    	lw    $t1, 8($sp)
    	addi  $sp,$sp,12
    	
    	jr    $ra		#Punto de retorno 

#------------------------------------------------------------------------------------------------------------- 	








#------------------------------------validarSaltoLinea-------------------------------------------------------
# Verifica que el caracter recibido sea un salto de linea
#-------------------------------------------------------------------------------------------------------------
## $a0-> caracter a evaluar
## $v0<- rtorna 1 si es un salto de linea y 0 en caso contrario
#-------------------------------------------------------------------------------------------------------------


validarSaltoLinea:	
	addi  $sp,$sp,-12
	sw    $a0,0($sp)
	sw    $ra,4($sp)
	sw    $t0, 8($sp)
	
	
	addi  $t0,$zero,10
	bne   $a0, $t0, noSalto

	addi $v0,$zero,1
	j returnSalto
		
noSalto: add $v0,$zero,$zero
	
	

returnSalto:
	
	lw    $a0,0($sp)
	lw    $ra,4($sp)
	lw    $t0, 8($sp)
	addi  $sp,$sp,12
	jr    $ra
	
#---------------------------------------------------------------------------------------------------
