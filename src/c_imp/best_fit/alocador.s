	.file	"alocador.c"
	.text
	.comm	initial_top,8,8
	.comm	current_top,8,8
	.globl	iniciaAlocador
	.type	iniciaAlocador, @function
iniciaAlocador:
.LFB6:
	.cfi_startproc
	endbr64
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
	endbr64
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
	.globl	desfragmenta
	.type	desfragmenta, @function
desfragmenta:
.LFB8:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	initial_top(%rip), %rax
	movq	%rax, -32(%rbp)
	jmp	.L4
.L6:
	movq	-32(%rbp), %rax
	movq	1(%rax), %rax
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	leaq	9(%rax), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L5
	movq	current_top(%rip), %rax
	cmpq	%rax, -16(%rbp)
	jnb	.L5
	movq	-16(%rbp), %rax
	movq	1(%rax), %rax
	movq	%rax, -8(%rbp)
	movq	-24(%rbp), %rdx
	movq	-8(%rbp), %rax
	addq	%rax, %rdx
	movq	-32(%rbp), %rax
	addq	$1, %rax
	addq	$9, %rdx
	movq	%rdx, (%rax)
	jmp	.L4
.L5:
	movq	-16(%rbp), %rax
	movq	%rax, -32(%rbp)
.L4:
	movq	current_top(%rip), %rax
	cmpq	%rax, -32(%rbp)
	jb	.L6
	nop
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	desfragmenta, .-desfragmenta
	.globl	alocaMem
	.type	alocaMem, @function
alocaMem:
.LFB9:
	.cfi_startproc
	endbr64
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
	jmp	.L8
.L10:
	movq	-40(%rbp), %rax
	movq	1(%rax), %rax
	movq	%rax, -8(%rbp)
	movq	-40(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L9
	movq	-8(%rbp), %rax
	cmpq	-56(%rbp), %rax
	jl	.L9
	movq	-8(%rbp), %rax
	cmpq	-24(%rbp), %rax
	jge	.L9
	movq	-40(%rbp), %rax
	movq	%rax, -32(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, -24(%rbp)
.L9:
	movq	-8(%rbp), %rax
	addq	$9, %rax
	addq	%rax, -40(%rbp)
.L8:
	movq	current_top(%rip), %rax
	cmpq	%rax, -40(%rbp)
	jb	.L10
	movq	-32(%rbp), %rax
	movq	%rax, -40(%rbp)
	movq	current_top(%rip), %rax
	cmpq	%rax, -40(%rbp)
	jne	.L11
#APP
# 76 "alocador.c" 1
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
.L11:
	movq	-40(%rbp), %rax
	addq	$1, %rax
	movq	(%rax), %rax
	movq	-56(%rbp), %rdx
	addq	$9, %rdx
	cmpq	%rdx, %rax
	jle	.L12
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
	jmp	.L13
.L12:
	movq	-40(%rbp), %rax
	addq	$1, %rax
	movq	(%rax), %rax
	cmpq	%rax, -56(%rbp)
	jge	.L13
	movq	-40(%rbp), %rax
	movq	1(%rax), %rax
	movq	%rax, -56(%rbp)
.L13:
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
.LFE9:
	.size	alocaMem, .-alocaMem
	.globl	liberaMem
	.type	liberaMem, @function
liberaMem:
.LFB10:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$8, %rsp
	movq	%rdi, -8(%rbp)
	cmpq	$0, -8(%rbp)
	je	.L16
	movq	-8(%rbp), %rax
	subq	$9, %rax
	movb	$0, (%rax)
	call	desfragmenta
	movl	$0, %eax
	jmp	.L17
.L16:
	movl	$1, %eax
.L17:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	liberaMem, .-liberaMem
	.section	.rodata
.LC0:
	.string	"#########"
	.text
	.globl	imprimeMapa
	.type	imprimeMapa, @function
imprimeMapa:
.LFB11:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	initial_top(%rip), %rax
	movq	%rax, -24(%rbp)
	jmp	.L19
.L24:
	movq	-24(%rbp), %rax
	movq	1(%rax), %rax
	movq	%rax, -8(%rbp)
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L20
	movb	$45, -25(%rbp)
	jmp	.L21
.L20:
	movb	$43, -25(%rbp)
.L21:
	movq	$0, -16(%rbp)
	jmp	.L22
.L23:
	movsbl	-25(%rbp), %eax
	movl	%eax, %edi
	call	putchar@PLT
	addq	$1, -16(%rbp)
.L22:
	movq	-8(%rbp), %rax
	cmpq	%rax, -16(%rbp)
	jb	.L23
	movq	-8(%rbp), %rax
	addq	$9, %rax
	addq	%rax, -24(%rbp)
.L19:
	movq	current_top(%rip), %rax
	cmpq	%rax, -24(%rbp)
	jb	.L24
	movl	$10, %edi
	call	putchar@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	imprimeMapa, .-imprimeMapa
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
