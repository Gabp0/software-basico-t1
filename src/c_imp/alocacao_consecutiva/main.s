	.text
	.globl	main
main:
.LFB1:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	movl	$10, %edi
	call	putchar@PLT
	call	iniciaAlocador@PLT
	movl	$0, -12(%rbp)
	jmp	.L6
.L7:
	movl	$100, %edi
	call	alocaMem@PLT
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movabsq	$9083427731362848, %rcx
	movq	%rcx, (%rax)
	movq	-8(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	liberaMem@PLT
	addl	$1, -12(%rbp)
.L6:
	cmpl	$99, -12(%rbp)
	jle	.L7
	call	printHeap
	call	finalizaAlocador@PLT
	movl	$0, %eax
	leave
	ret
