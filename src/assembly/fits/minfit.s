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
	movq	%rdi, -40(%rbp)
	movq	initial_top(%rip), %rax
	movq	%rax, -32(%rbp)
	jmp	while
whileCont:
	movq	-32(%rbp), %rax
	movq	1(%rax), %rax
	movq	%rax, -24(%rbp)
	movq	-32(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	fimIf1
	movq	-24(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jge	fimWhile
fimIf1:
	movq	-24(%rbp), %rax
	addq	$9, %rax
	addq	%rax, -32(%rbp)
while:
	movq	current_top(%rip), %rax
	cmpq	%rax, -32(%rbp)
	jb	whileCont
fimWhile:
	movq	current_top(%rip), %rax
	cmpq	%rax, -32(%rbp)
	jne	fimIf2
	movq	-40(%rbp), %rax
	leaq	4095(%rax), %rdx
	testq	%rax, %rax
	cmovs	%rdx, %rax
	sarq	$12, %rax
	addq	$1, %rax
	salq	$12, %rax
	movq	%rax, -16(%rbp)
	movq   $12, %rax
	movq   $0, %rdi
	syscall
	movq	%rax, %rdi
	movq	-16(%rbp), %rax
	addq	%rax, %rdi
	addq	$9, %rdi
	movq	%rdi, current_top(%rip)
	movq	$12, %rax
	syscall
	movq	-32(%rbp), %rax
	leaq	1(%rax), %rdx
	movq	-16(%rbp), %rax
	movq	%rax, (%rdx)
fimIf2:
	movq	-32(%rbp), %rax
	addq	$1, %rax
	movq	(%rax), %rax
	movq	-40(%rbp), %rdx
	addq	$9, %rdx
	cmpq	%rdx, %rax
	jle	if3
	movq	-32(%rbp), %rax
	addq	$1, %rax
	movq	(%rax), %rax
	subq	-40(%rbp), %rax
	subq	$9, %rax
	movq	%rax, -8(%rbp)
	movq	-40(%rbp), %rax
	leaq	9(%rax), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
	movq	-40(%rbp), %rax
	leaq	10(%rax), %rdx
	movq	-32(%rbp), %rax
	addq	%rax, %rdx
	movq	-8(%rbp), %rax
	movq	%rax, (%rdx)
	jmp	fimElse
if3:
	movq	-32(%rbp), %rax
	addq	$1, %rax
	movq	(%rax), %rax
	cmpq	%rax, -40(%rbp)
	jge	fimElse
	movq	-32(%rbp), %rax
	movq	1(%rax), %rax
	movq	%rax, -40(%rbp)
fimElse:
	movq	-32(%rbp), %rax
	movb	$1, (%rax)
	addq	$1, -32(%rbp)
	movq	-32(%rbp), %rax
	movq	-40(%rbp), %rdx
	movq	%rdx, (%rax)
	addq	$8, -32(%rbp)
	movq	-32(%rbp), %rax
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
