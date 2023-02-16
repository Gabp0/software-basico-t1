.section .text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp

	call	iniciaAlocador@PLT

	movl	$0, -12(%rbp)	# i
	jmp	fimFor
for:
	movl	$100, %edi
	call	alocaMem@PLT
	movq	%rax, -8(%rbp)

	call	imprimeMapa@PLT

	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	liberaMem@PLT

	addl	$1, -12(%rbp)	# i++
fimFor:
	cmpl	$99, -12(%rbp)
	jle	for


	call	finalizaAlocador@PLT
	movl	$0, %eax

	ret
