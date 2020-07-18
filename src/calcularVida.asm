
.text
.globl calcularVida

#Retorna la vida restante del pokemon, recibe en a0 la vida el contrincante y en a1 el multiplicador del ataque	
#----------------------------------------------Funcion calcular vida-------------------------------------------------	
calcularVida:
	addi $sp,$sp,-20
	sw   $s0,0($sp)
	sw   $s1,4($sp)
	sw   $t0,8($sp)
	sw   $t1,16($sp)
	sw   $ra,20($sp)
	
	
	li $s0,2		#ataque
	li $s1,3		#codigo mutiplicador 1/2
	
	beq $a1,$s1,division
	mul $t0,$s0,$a1		#t0=2*multiplicador
	j restarVida
	
division:
	srl $t0,$s0,1
	
restarVida:
	slt $t1,$a0,$t0
	beq $t1,$zero,restar
	add $v0,$zero,$zero
	j returnVida
	
			

restar:
	sub $v0,$a0,$t0

returnVida:
	
	sw   $s0,0($sp)
	sw   $s1,4($sp)
	sw   $t0,8($sp)
	sw   $t1,16($sp)
	sw   $ra,20($sp)
	addi $sp,$sp,20
	
	jr $ra
#--------------------------------------------------------------------------------------------------------------------	