# Miguel Sanches Rocha
# Matricula: 11811BCC001
# Funcao seno


.data
numIter:  .word 15

str1: .asciiz	"Digite um valor: "
str2: .asciiz	"\nO valor do seno eh:" 
espaco: .asciiz  " "

# seno x = x - x³/3! + x⁵/5! - x⁷/7!


.text

		#contador de iteracoes $s7 tem 0
		li	$s7, 0
						
		#termo zero da serie
		li	$s0, 0
		mtc1	$s0, $f0
		cvt.s.w	$f0, $f0	#$f0 tem 0.0
		
		
		#Printa String
		li	$v0, 4
		la	$a0, str1
		syscall
		
		# Pega valor do teclado
		li $v0,5
		syscall		
		move $a0,$v0
		move $t1,$a0
		
		beq $t1,$zero,SAI1

		#Alguns registradores que vão ser utilizados
		li 	$s1, 1
		li 	$t9, 1

		
		la	$s6, numIter	#carrega o num de iteracoes
		lw	$s6, 0($s6)	#$s6 contem o valor de numIter
		
		
FOR:			
		
		beq	$s7, $s6, SAI1
		
		#Alguns registradores usados
	  	li $s3,1  
	  	li $s4,1
	 
	    	   
	  	
	  	
	fatorial:	#Denominador
		
		#Fazendo as operacoes para calcular o fatorial
		beq $s1,$s4,restaura
		
		mul $s3,$s3,$s1
		
		subi $s1, $s1, 1
		
       
	     	j fatorial
	
	restaura:
		#Restaura os valores de alguns registrados
		li $s1,0
		add $s1,$t9,$zero
		li $s5,0
		li $t8,1
		j exponencial
		

		
	exponencial: #Numerador
	
		
		#Guardando o valor do fatorial
		mtc1	$s3, $f1
		cvt.s.w	$f1, $f1

		#Fazendo as operacoes para calcular o exponencial
		beq $s5,$s1,mydiv
		mul $t8,$t8,$t1
		addi $s5,$s5,1

		
		j exponencial
		
		
	mydiv:
		#Guardando o valor do exponencial
		mtc1	$t8, $f8
		cvt.s.w	$f8, $f8
		
		#computa a fracao
		div.s	$f3, $f8, $f1 
		


		
		#testa se eh uma iteracao par ou impar
		#par -> termo positivo, impar -> termo negativo
		andi	$t0, $s7, 1 #se t0 for 1 eh impar, senao (0) eh par
		beq	$t0, $zero, PAR
		
		#impar
		sub.s	$f0, $f0, $f3
		j	SAIIF
PAR:	#par
		add.s	$f0, $f0, $f3
		
SAIIF:		

		# Incrementa os registradores
		addi	$s1, $s1, 2
		addi	$t9, $t9, 2
			
				
		addi	$s7, $s7, 1
					
	  	
		j FOR
		
		
SAI1:
		#Printa o resultado
		li	$v0, 4
		la	$a0, str2
		syscall
			
		
		li	$v0, 2
		mov.s 	$f12, $f0
		syscall
		 	
		#return 0
		li		$v0, 10
		syscall

