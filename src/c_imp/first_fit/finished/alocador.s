	.file	"alocador.c"
	.text

	.globl	initial_top
	.bss
	.align 8
	.type	initial_top, @object
	.size	initial_top, 8
initial_top:
	.zero	8

	.globl	current_top
	.align 8
	.type	current_top, @object
	.size	current_top, 8
current_top:
	.zero	8

	.text
	.globl	iniciaAlocador
	.type	iniciaAlocador, @function
iniciaAlocador:
	pushq	%rbp
	movq	%rsp, %rbp
	movq $12, %rax
	movq $0, %rdi
	syscall
	movq %rax, initial_top(%rip)
	movq	initial_top(%rip), %rax
	movq	%rax, current_top(%rip)
	popq	%rbp
	ret

	.size	iniciaAlocador, .-iniciaAlocador
	.globl	finalizaAlocador
	.type	finalizaAlocador, @function
finalizaAlocador:
	pushq	%rbp
	movq	%rsp, %rbp
	movq initial_top(%rip), %rax
	movq %rax, %rdi
	movq $12, %rax
	syscall
	popq	%rbp
	ret

	.size	finalizaAlocador, .-finalizaAlocador
	.globl	alocaMem
	.type	alocaMem, @function
alocaMem:
	pushq	%rbp
	movq	%rsp, %rbp
	movq	%rdi, -40(%rbp)
	movq	initial_top(%rip), %rax
	movq	%rax, -24(%rbp)
	jmp	whileIf
if1:
	movq	-24(%rbp), %rax
	movq	1(%rax), %rax
	movq	%rax, -16(%rbp)
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	fimIf1
	movq	-16(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jge	fimWhile
fimIf1:
	movq	-16(%rbp), %rax
	addq	$9, %rax
	addq	%rax, -24(%rbp)
whileIf:
	movq	current_top(%rip), %rax
	cmpq	%rax, -24(%rbp)
	jb	if1
	jmp	fimWhile
fimWhile:
	movq	current_top(%rip), %rax
	cmpq	%rax, -24(%rbp)
	jne	fimIf2
	movq $12, %rax
	movq $0, %rdi
	syscall
	movq %rax, %rdi
	addq -40(%rbp), %rdi
	addq $9, %rdi
	movq %rdi, current_top(%rip)
	movq $12, %rax
	syscall
fimIf2:
	movq	-24(%rbp), %rax
	addq	$1, %rax
	movq	(%rax), %rax
	movq	-40(%rbp), %rdx
	addq	$9, %rdx
	cmpq	%rdx, %rax
	jle	else
	movq	-24(%rbp), %rax
	addq	$1, %rax
	movq	(%rax), %rax
	subq	-40(%rbp), %rax
	subq	$9, %rax
	movq	%rax, -8(%rbp)
	movq	-40(%rbp), %rax
	leaq	9(%rax), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
	movq	-40(%rbp), %rax
	leaq	10(%rax), %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movq	-8(%rbp), %rax
	movq	%rax, (%rdx)
	jmp	fimElse
else:
	movq	-24(%rbp), %rax
	addq	$1, %rax
	movq	(%rax), %rax
	cmpq	%rax, -40(%rbp)
	jge	fimElse
	movq	-24(%rbp), %rax
	movq	1(%rax), %rax
	movq	%rax, -40(%rbp)
fimElse:
	movq	-24(%rbp), %rax
	movb	$1, (%rax)
	addq	$1, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	-40(%rbp), %rdx
	movq	%rdx, (%rax)
	addq	$8, -24(%rbp)
	movq	-24(%rbp), %rax
	popq	%rbp
	ret

	.size	alocaMem, .-alocaMem
	.globl	liberaMem
	.type	liberaMem, @function
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