	.globl	initial_top
	.globl	current_top
	.section    .data

initial_top: 
	.quad	0

current_top:
	.quad	0
	
	.section    .text
	.globl	iniciaAlocador
iniciaAlocador:
	pushq	%rbp
	movq	%rsp, %rbp
	movq 	$12, %rax
	movq 	$0, %rdi
	syscall
	movq 	%rax, initial_top(%rip)
	movq	initial_top(%rip), %rax
	movq	%rax, current_top(%rip)
	popq	%rbp
	ret

	.globl	finalizaAlocador
finalizaAlocador:
	pushq	%rbp
	movq	%rsp, %rbp
	movq 	initial_top(%rip), %rax
	movq 	%rax, %rdi
	movq 	$12, %rax
	syscall
	popq	%rbp
	ret

	.globl	alocaMem
alocaMem:
	pushq	%rbp
	movq	%rsp, %rbp
	movq	%rdi, -56(%rbp)
	movq	initial_top(%rip), %rax
	movq	%rax, -40(%rbp)
	movq	current_top(%rip), %rax
	movq	%rax, -32(%rbp)
	movabsq	$9223372036854775807, %rax
	movq	%rax, -24(%rbp)
	jmp	while
whileCont:
	movq	-40(%rbp), %rax
	movq	1(%rax), %rax
	movq	%rax, -8(%rbp)
	movq	-40(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	fimIf1
	movq	-8(%rbp), %rax
	cmpq	-56(%rbp), %rax
	jl	fimIf1
	movq	-8(%rbp), %rax
	cmpq	-24(%rbp), %rax
	jge	fimIf1
	movq	-40(%rbp), %rax
	movq	%rax, -32(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, -24(%rbp)
fimIf1:
	movq	-8(%rbp), %rax
	addq	$9, %rax
	addq	%rax, -40(%rbp)
while:
	movq	current_top(%rip), %rax
	cmpq	%rax, -40(%rbp)
	jb	whileCont
	movq	-32(%rbp), %rax
	movq	%rax, -40(%rbp)
	movq	current_top(%rip), %rax
	cmpq	%rax, -40(%rbp)
	jne	fimIf2
	movq $12, %rax
	movq $0, %rdi
	syscall
	movq %rax, %rdi
	addq -56(%rbp), %rdi
	addq $9, %rdi
	movq %rdi, current_top(%rip)
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
