.section    .data
	INITIAL_TOP: .quad	0	# inicio da heap
	CURRENT_TOP: .quad	0	# topo atual da heap

	block_info_string: .string "#########"
	newline: .string "\n"
	
.section    .text

.globl	iniciaAlocador	# inicia o alocador
iniciaAlocador:
	pushq	%rbp		
	movq	%rsp, %rbp

	movq 	$12, %rax	# chama o brk
	movq 	$0, %rdi
	syscall

	movq 	%rax, INITIAL_TOP	# inicializa os topos
	movq	INITIAL_TOP, %rax
	movq	%rax, CURRENT_TOP
	popq	%rbp
	ret

.globl	finalizaAlocador
finalizaAlocador:
	pushq	%rbp
	movq	%rsp, %rbp

	movq 	INITIAL_TOP, %rax

	movq 	%rax, %rdi	# restura o brk
	movq 	$12, %rax
	syscall

	popq	%rbp
	ret

.globl	alocaMem
alocaMem:
	pushq	%rbp
	movq	%rsp, %rbp

	movq	%rdi, -56(%rbp)		

	movq	INITIAL_TOP, %rax
	movq	%rax, -40(%rbp)		# aux_ptr

	movq	CURRENT_TOP, %rax
	movq	%rax, -32(%rbp)		# best_ptr

	movabsq	$9223372036854775807, %rax
	movq	%rax, -24(%rbp)		# best size

	jmp	fimWhile1
	
whileCont1:

	movq	-40(%rbp), %rax
	movq	1(%rax), %rax
	movq	%rax, -8(%rbp)
	movq	-40(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	fimIf1	# *aux_ptr == 0

	movq	-8(%rbp), %rax
	cmpq	-56(%rbp), %rax
	jl	fimIf1	# block_size < num_bytes

	movq	-8(%rbp), %rax
	cmpq	-24(%rbp), %rax
	jge	fimIf1  # block_size > best_size

	movq	-40(%rbp), %rax
	movq	%rax, -32(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, -24(%rbp)

fimIf1:
	movq	-8(%rbp), %rax
	addq	$9, %rax
	addq	%rax, -40(%rbp)	# aux_ptr += block_size + 9

fimWhile1:	# aux_ptr < CURRENT_TOP
	movq	CURRENT_TOP, %rax
	cmpq	%rax, -40(%rbp)
	jb	whileCont1

	movq	-32(%rbp), %rax
	movq	%rax, -40(%rbp)
	movq	CURRENT_TOP, %rax	# if aux_ptr == current_top
	cmpq	%rax, -40(%rbp)
	jne	fimIf2

	movq CURRENT_TOP, %rdi	# cria um bloco novo
	addq -56(%rbp), %rdi
	addq $9, %rdi

	movq %rdi, CURRENT_TOP	# chamada ao brk
	movq $12, %rax
	syscall
fimIf2:

	movq	-40(%rbp), %rax
	addq	$1, %rax
	movq	(%rax), %rax
	movq	-56(%rbp), %rdx
	addq	$9, %rdx
	
	cmpq	%rdx, %rax	# *(aux_ptr + 1) > (num_bytes + 9)
	jle	else

	movq	-40(%rbp), %rax
	addq	$1, %rax
	movq	(%rax), %rax
	subq	-56(%rbp), %rax
	subq	$9, %rax

	movq	%rax, -16(%rbp)
	movq	-56(%rbp), %rax
	leaq	9(%rax), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
	
	movq	-56(%rbp), %rax
	leaq	10(%rax), %rdx
	movq	-40(%rbp), %rax
	addq	%rax, %rdx
	movq	-16(%rbp), %rax
	movq	%rax, (%rdx)
	jmp	fimElse

else:
	movq	-40(%rbp), %rax
	addq	$1, %rax
	movq	(%rax), %rax
	cmpq	%rax, -56(%rbp)
	jge	fimElse
	movq	-40(%rbp), %rax
	movq	1(%rax), %rax
	movq	%rax, -56(%rbp)
fimElse:
	movq	-40(%rbp), %rax
	movb	$1, (%rax)
	addq	$1, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-56(%rbp), %rdx
	movq	%rdx, (%rax)
	addq	$8, -40(%rbp)
	movq	-40(%rbp), %rax
	popq	%rbp
	ret
	
.globl	liberaMem
liberaMem:
	pushq	%rbp
	movq	%rsp, %rbp
	movq	%rdi, -8(%rbp)
	cmpq	$0, -8(%rbp)
	je	fimIf
	movq	-8(%rbp), %rax
	subq	$9, %rax
	movb	$0, (%rax)
	movl	$0, %eax
	jmp	return
	fimIf:
	movl	$1, %eax
	return:
	popq	%rbp
	ret

.globl imprimeMapa
imprimeMapa:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp

	movq	INITIAL_TOP, %rax	# aux_ptr = initial_top
	movq	%rax, -24(%rbp)

	jmp	fimWhileImp

whileImp:
	movq	-24(%rbp), %rax
	movq	1(%rax), %rax
	movq	%rax, -8(%rbp)

	# print informacoes gerenciais
	# movq	$1, %rax 
	# movq 	$1, %rdi 
	# movq 	(block_info_string), %rsi
	# movq	$9, %rdx  
	# syscall 

	movq	-24(%rbp), %rax	# if (*aux_ptr == 0)
	movzbl	(%rax), %eax
	testb	%al, %al
	jne elseImp

	movb	$45, -25(%rbp)	# c = '-'
	jmp	fimIfImp
elseImp:
	movb	$43, -25(%rbp)	# c = '+'
fimIfImp:
	movq	$0, -16(%rbp)	# i = 0
	jmp	fimForImp
for:
	# print conteudo do bloco
	# movq	$1, %rax 
	# movq 	$1, %rdi 
	# movq 	%rbp, %rsi
	# subq 	$25, %rsi
	# movq	$1, %rdx  
	# syscall 

	addq	$1, -16(%rbp)	# i++
fimForImp:
	movq	-8(%rbp), %rax
	cmpq	%rax, -16(%rbp) # i < current_block_size
	jb	for	

	movq	-8(%rbp), %rax
	addq	$9, %rax		# aux_ptr += current_block_size + 9
	addq	%rax, -24(%rbp)

fimWhileImp:
	movq	CURRENT_TOP, %rax
	cmpq	%rax, -24(%rbp)
	jb	whileImp

	# print conteudo do bloco
	# movq	$1, %rax 
	# movq 	$1, %rdi 
	# movq 	(newline), %rsi
	# movq	$9, %rdx  
	# syscall 

	popq	%rbp
	ret
