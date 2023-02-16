.section    .data
	INITIAL_TOP: .quad	0	# inicio da heap
	CURRENT_TOP: .quad	0	# topo atual da heap
	
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

	jmp	while
	
	while1:

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
	addq	%rax, -40(%rbp)

	while:	# aux_ptr < current_top
	movq	CURRENT_TOP, %rax
	cmpq	%rax, -40(%rbp)
	jb	while1

	movq	-32(%rbp), %rax
	movq	%rax, -40(%rbp)
	movq	CURRENT_TOP, %rax
	cmpq	%rax, -40(%rbp)
	jne	fimIf2
	movq $12, %rax
	movq $0, %rdi
	syscall
	movq %rax, %rdi
	addq -56(%rbp), %rdi
	addq $9, %rdi
	movq %rdi, CURRENT_TOP
	movq $12, %rax
	syscall
	fimIf2:
	movq	-40(%rbp), %rax
	addq	$1, %rax
	movq	(%rax), %rax
	movq	-56(%rbp), %rdx
	addq	$9, %rdx
	cmpq	%rdx, %rax
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
.LFB10:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp
	movq	initial_top(%rip), %rax
	movq	%rax, -24(%rbp)
	jmp	.L15
.L20:
	movq	-24(%rbp), %rax
	movq	1(%rax), %rax
	movq	%rax, -8(%rbp)
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L16
	movb	$45, -25(%rbp)
	jmp	.L17
.L16:
	movb	$43, -25(%rbp)
.L17:
	movq	$0, -16(%rbp)
	jmp	.L18
.L19:
	movsbl	-25(%rbp), %eax
	movl	%eax, %edi
	call	putchar@PLT
	addq	$1, -16(%rbp)
.L18:
	movq	-8(%rbp), %rax
	cmpq	%rax, -16(%rbp)
	jb	.L19
	movq	-8(%rbp), %rax
	addq	$9, %rax
	addq	%rax, -24(%rbp)
.L15:
	movq	current_top(%rip), %rax
	cmpq	%rax, -24(%rbp)
	jb	.L20
	movl	$10, %edi
	call	putchar@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc