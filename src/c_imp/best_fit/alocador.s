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
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
#APP
# 13 "alocador.c" 1
	movq $12, %rax
	movq $0, %rdi
	syscall
	movq %rax, initial_top(%rip)
	
# 0 "" 2
#NO_APP
	movq	initial_top(%rip), %rax
	movq	%rax, current_top(%rip)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	iniciaAlocador, .-iniciaAlocador
	.globl	finalizaAlocador
	.type	finalizaAlocador, @function
finalizaAlocador:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
#APP
# 25 "alocador.c" 1
	movq initial_top(%rip), %rax
	movq %rax, %rdi
	movq $12, %rax
	syscall
	
# 0 "" 2
#NO_APP
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
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -56(%rbp)
	movq	initial_top(%rip), %rax
	movq	%rax, -40(%rbp)
	movq	current_top(%rip), %rax
	movq	%rax, -32(%rbp)
	movabsq	$9223372036854775807, %rax
	movq	%rax, -24(%rbp)
	jmp	.L4
.L6:
	movq	-40(%rbp), %rax
	movq	1(%rax), %rax
	movq	%rax, -8(%rbp)
	movq	-40(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L5
	movq	-8(%rbp), %rax
	cmpq	-56(%rbp), %rax
	jl	.L5
	movq	-8(%rbp), %rax
	cmpq	-24(%rbp), %rax
	jge	.L5
	movq	-40(%rbp), %rax
	movq	%rax, -32(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, -24(%rbp)
.L5:
	movq	-8(%rbp), %rax
	addq	$9, %rax
	addq	%rax, -40(%rbp)
.L4:
	movq	current_top(%rip), %rax
	cmpq	%rax, -40(%rbp)
	jb	.L6
	movq	-32(%rbp), %rax
	movq	%rax, -40(%rbp)
	movq	current_top(%rip), %rax
	cmpq	%rax, -40(%rbp)
	jne	.L7
#APP
# 55 "alocador.c" 1
	movq $12, %rax
	movq $0, %rdi
	syscall
	movq %rax, %rdi
	addq -56(%rbp), %rdi
	addq $9, %rdi
	movq %rdi, current_top(%rip)
	movq $12, %rax
	syscall
	
# 0 "" 2
#NO_APP
.L7:
	movq	-40(%rbp), %rax
	addq	$1, %rax
	movq	(%rax), %rdx
	movq	-56(%rbp), %rax
	addq	$9, %rax
	cmpq	%rax, %rdx
	jle	.L8
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
	jmp	.L9
.L8:
	movq	-40(%rbp), %rax
	addq	$1, %rax
	movq	(%rax), %rax
	cmpq	%rax, -56(%rbp)
	jge	.L9
	movq	-40(%rbp), %rax
	movq	1(%rax), %rax
	movq	%rax, -56(%rbp)
.L9:
	movq	-40(%rbp), %rax
	movb	$1, (%rax)
	addq	$1, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-56(%rbp), %rdx
	movq	%rdx, (%rax)
	addq	$8, -40(%rbp)
	movq	-40(%rbp), %rax
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
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	cmpq	$0, -8(%rbp)
	je	.L12
	movq	-8(%rbp), %rax
	subq	$9, %rax
	movb	$0, (%rax)
	movl	$0, %eax
	jmp	.L13
.L12:
	movl	$1, %eax
.L13:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	liberaMem, .-liberaMem
	.globl	imprimeMapa
	.type	imprimeMapa, @function
imprimeMapa:
.LFB10:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	initial_top(%rip), %rax
	movq	%rax, -24(%rbp)
	jmp	.L15
.L20:
	movq	-24(%rbp), %rax
	movq	1(%rax), %rax
	movq	%rax, -8(%rbp)

	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L16
	movb	$45, -25(%rbp)
	jmp	.L17
.L16:
	movb	$43, -25(%rbp)
.L17:
	movq	$0, -16(%rbp)
	jmp	.L18
.L19:
	movzbl	-25(%rbp), %eax
	addl	$1, %eax
	movb	%al, -25(%rbp)

	addq	$1, -16(%rbp)
.L18:
	movq	-8(%rbp), %rax
	cmpq	%rax, -16(%rbp)
	jb	.L19
	movq	-8(%rbp), %rax
	addq	$9, %rax
	addq	%rax, -24(%rbp)
.L15:
	movq	current_top(%rip), %rax
	cmpq	%rax, -24(%rbp)
	jb	.L20
	nop
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret

