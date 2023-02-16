	.globl	initial_top
	.data
initial_top:
	.quad	8
	.globl	last_allocated
last_allocated:
	.quad	8
	.globl	current_top
current_top:
	.quad	8

	.text
	.globl	iniciaAlocador
iniciaAlocador:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$0, %edi
	call	sbrk@PLT
	movq	%rax, initial_top
	movq	initial_top, %rax
	movq	%rax, last_allocated
	movq	initial_top, %rax
	movq	%rax, current_top
	nop
	popq	%rbp
	ret
.LFE6:
	.size	iniciaAlocador, .-iniciaAlocador
	.globl	finalizaAlocador
	.type	finalizaAlocador, @function
finalizaAlocador:
.LFB7:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	initial_top, %rax
	movq	%rax, %rdi
	call	brk@PLT
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	finalizaAlocador, .-finalizaAlocador
	.globl	alocaMem
	.type	alocaMem, @function
alocaMem:
.LFB8:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -40(%rbp)
	movq	last_allocated, %rax
	movq	%rax, -24(%rbp)
	movw	$0, -26(%rbp)
	movq	current_top, %rax
	cmpq	%rax, -24(%rbp)
	je	.L4
.L7:
	movq	-24(%rbp), %rax
	movq	1(%rax), %rax
	movq	%rax, -16(%rbp)
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L5
	movq	-16(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jl	.L5
	movw	$1, -26(%rbp)
	jmp	.L4
.L5:
	movq	-16(%rbp), %rax
	addq	$9, %rax
	addq	%rax, -24(%rbp)
	movq	current_top, %rax
	cmpq	%rax, -24(%rbp)
	jb	.L6
	movq	initial_top, %rax
	movq	%rax, -24(%rbp)
.L6:
	movq	last_allocated, %rax
	cmpq	%rax, -24(%rbp)
	jne	.L7
.L4:
	cmpw	$0, -26(%rbp)
	jne	.L8
	movq	current_top, %rax
	movq	%rax, -24(%rbp)
#APP
# 54 "alocador.c" 1
	movq $12, %rax
	movq $0, %rdi
	syscall
	movq %rax, %rdi
	addq -40(%rbp), %rdi
	addq $9, %rdi
	movq %rdi, current_top
	movq $12, %rax
	syscall
	
# 0 "" 2
#NO_APP
.L8:
	movq	-24(%rbp), %rax
	addq	$1, %rax
	movq	(%rax), %rax
	movq	-40(%rbp), %rdx
	addq	$9, %rdx
	cmpq	%rdx, %rax
	jle	.L9
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
	jmp	.L10
.L9:
	movq	-24(%rbp), %rax
	addq	$1, %rax
	movq	(%rax), %rax
	cmpq	%rax, -40(%rbp)
	jge	.L10
	movq	-24(%rbp), %rax
	movq	1(%rax), %rax
	movq	%rax, -40(%rbp)
.L10:
	movq	-24(%rbp), %rax
	movq	%rax, last_allocated
	movq	-24(%rbp), %rax
	movb	$1, (%rax)
	addq	$1, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	-40(%rbp), %rdx
	movq	%rdx, (%rax)
	addq	$8, -24(%rbp)
	movq	-24(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	alocaMem, .-alocaMem
	.globl	liberaMem
	.type	liberaMem, @function
liberaMem:
.LFB9:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	cmpq	$0, -8(%rbp)
	je	.L13
	movq	-8(%rbp), %rax
	subq	$9, %rax
	movb	$0, (%rax)
	movl	$0, %eax
	jmp	.L14
.L13:
	movl	$1, %eax
.L14:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	liberaMem, .-liberaMem
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
