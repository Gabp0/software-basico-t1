.section .text
	.globl	main
	.globl _start
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

	call	imprimeMapa@PLT

	movq	%rax, %rdi
	call	liberaMem@PLT

	addl	$1, -12(%rbp)	# i++
fimFor:
	cmpl	$99, -12(%rbp)
	jle	for

	call	imprimeMapa@PLT
	call	finalizaAlocador@PLT
	movl	$0, %eax

	ret

_start:
	call 	main
