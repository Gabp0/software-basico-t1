.section .text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp

	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	call	iniciaAlocador@PLT
	
	movl	$0, -12(%rbp)
	jmp	.L2
.L3:
	movl	$100, %edi
	call	alocaMem@PLT
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	liberaMem@PLT
	addl	$1, -12(%rbp)
.L2:
	cmpl	$99, -12(%rbp)
	jle	.L3
	call	finalizaAlocador@PLT
	movl	$0, %eax
	leave
	ret