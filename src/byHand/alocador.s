.section .data
    TOP: .quad 0

.section .text

iniciaAlocador:
    pushq %rbp
    movq %rsp, %rbp
    movq $12, %rax
    movq $0, %rdi
    syscall
    movq %rax, TOP
    popq %rbp
    ret

finalizaAlocador:
    pushq %rbp
    movq %rsp, %rbp
    movq $12, %rax
    movq TOP, %rdi
    syscall
    popq %rbp
    ret

liberaMem:
	pushq	%rbp
	movq	%rsp, %rbp
#	movq	%rdi, -8(%rbp)
	movq	16(%rbp), %rax
	subq	$5, %rax
	movq	$0, (%rax)
	popq	%rbp
    ret

# alocaMem:
#     pushq %rbp
#     movq %rsp, %rbp
#     subq $8, %rbp
#     cmpq %rbx, %rax
#     addq $8, %rbp
#     popq %rbp
#     ret

#-8(%rbp) -> topo_atual
#-16(%rbp) -> aux_ptr
#-36(%rbp) -> num_bytes

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
	movq	TOP, %rax
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
