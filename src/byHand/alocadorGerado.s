	.text
	.globl	topo_inicial
	.bss
	.align 8
	.type	topo_inicial, @object
	.size	topo_inicial, 8
topo_inicial:
	.zero	8
	.text
	.globl	iniciaAlocador
	.type	iniciaAlocador, @function
iniciaAlocador:
    pushq %rbp
    movq %rsp, %rbp
    movq $12, %rax
    movq $0, %rdi
    syscall
    movq %rax, topo_inicial(%rip)
    popq %rbp
    ret
.LFE0:
	.size	iniciaAlocador, .-iniciaAlocador
	.globl	finalizaAlocador
	.type	finalizaAlocador, @function
finalizaAlocador:
    pushq %rbp
    movq %rsp, %rbp
    movq $12, %rax
    movq topo_inicial(%rip), %rdi
    syscall
    popq %rbp
    ret
.LFE1:
	.size	finalizaAlocador, .-finalizaAlocador
	.globl	alocaMem
	.type	alocaMem, @function
alocaMem:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$48, %rsp
    movq	%rdi, -40(%rbp) # parametro gcc
	
	# movl	$0, %edi
	# call	sbrk@PLT
    movq $0, %rdi
    syscall
	
    movq	%rax, -8(%rbp)
	movq	topo_inicial(%rip), %rax
	movq	%rax, -16(%rbp)

	jmp	whileIf
whileCont:
	movq	-16(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al 
	jne	else
	movq	-16(%rbp), %rax
	addq	$1, %rax
	movl	(%rax), %eax
	cltq
	cmpq	%rax, -40(%rbp) # if test
	jl	fimWhile # if for break
else:
	movq	-16(%rbp), %rax
	addq	$1, %rax
	movl	(%rax), %eax
	cltq
	addq	$5, %rax
	addq	%rax, -16(%rbp)
whileIf:
	movq	-16(%rbp), %rax
	cmpq	-8(%rbp), %rax
	jb	whileCont
	jmp	fimWhile
fimWhile:
	movq	-16(%rbp), %rax
	cmpq	-8(%rbp), %rax
	jne	else2 
    movq	-40(%rbp), %rax
	addq	$5, %rax
	movq	%rax, %rdi
    movq $12, %rax
    syscall
	jmp	fimElse2
else2:
	movq	-16(%rbp), %rax
	addq	$1, %rax
	movl	(%rax), %eax
	cltq
	cmpq	%rax, -40(%rbp)
	jge	fimElse2
	movq	-16(%rbp), %rax
	addq	$1, %rax
	movl	(%rax), %eax
	movl	%eax, %edx
	movq	-40(%rbp), %rax
	movl	%eax, %ecx
	movl	%edx, %eax
	subl	%ecx, %eax
	subl	$5, %eax
	movl	%eax, -20(%rbp)
	movq	-40(%rbp), %rax
	leaq	5(%rax), %rdx
	movq	-16(%rbp), %rax
	addq	%rdx, %rax
	movl	$0, (%rax)
	movq	-40(%rbp), %rax
	leaq	6(%rax), %rdx
	movq	-16(%rbp), %rax
	addq	%rax, %rdx
	movl	-20(%rbp), %eax
	movl	%eax, (%rdx)

fimElse2:
	movq	-16(%rbp), %rax
	movb	$1, (%rax)
	addq	$1, -16(%rbp)
	movq	-40(%rbp), %rax
	movl	%eax, %edx
	movq	-16(%rbp), %rax
	movl	%edx, (%rax)
	addq	$4, -16(%rbp)
	movq	-16(%rbp), %rax
	ret
.LFE2:
	.size	alocaMem, .-alocaMem
	.globl	liberaMem
	.type	liberaMem, @function
liberaMem:
.LFB3:
	pushq	%rbp
	movq	%rsp, %rbp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	subq	$5, %rax
	movb	$0, (%rax)
	popq	%rbp
	ret
.LFE3:
	.size	liberaMem, .-liberaMem

