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
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
#APP
# 12 "alocador.c" 1
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
.LFE0:
	.size	iniciaAlocador, .-iniciaAlocador
	.globl	finalizaAlocador
	.type	finalizaAlocador, @function
finalizaAlocador:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
#APP
# 24 "alocador.c" 1
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
.LFE1:
	.size	finalizaAlocador, .-finalizaAlocador
	.globl	alocaMem
	.type	alocaMem, @function
alocaMem:
.LFB2:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -40(%rbp)
	movq	initial_top(%rip), %rax
	movq	%rax, -32(%rbp)
	jmp	.L4
.L7:
	movq	-32(%rbp), %rax
	movq	1(%rax), %rax
	movq	%rax, -24(%rbp)
	movq	-32(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L5
	movq	-24(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jge	.L12
.L5:
	movq	-24(%rbp), %rax
	addq	$9, %rax
	addq	%rax, -32(%rbp)
.L4:
	movq	current_top(%rip), %rax
	cmpq	%rax, -32(%rbp)
	jb	.L7
	jmp	.L6
.L12:
	nop
.L6:
	movq	current_top(%rip), %rax
	cmpq	%rax, -32(%rbp)
	jne	.L8
	movq	-40(%rbp), %rax
	leaq	4095(%rax), %rdx
	testq	%rax, %rax
	cmovs	%rdx, %rax
	sarq	$12, %rax
	addq	$1, %rax
	salq	$12, %rax
	movq	%rax, -16(%rbp)
#APP
# 51 "alocador.c" 1
	movq   $12, %rax
	movq   $0, %rdi
	syscall
	movq	%rax, %rdi
	movq	-16(%rbp), %rax
	addq	%rax, %rdi
	addq	$9, %rdi
	movq	%rdi, current_top(%rip)
	movq	$12, %rax
	syscall
	
# 0 "" 2
#NO_APP
	movq	-32(%rbp), %rax
	leaq	1(%rax), %rdx
	movq	-16(%rbp), %rax
	movq	%rax, (%rdx)
.L8:
	movq	-32(%rbp), %rax
	addq	$1, %rax
	movq	(%rax), %rax
	movq	-40(%rbp), %rdx
	addq	$9, %rdx
	cmpq	%rdx, %rax
	jle	.L9
	movq	-32(%rbp), %rax
	addq	$1, %rax
	movq	(%rax), %rax
	subq	-40(%rbp), %rax
	subq	$9, %rax
	movq	%rax, -8(%rbp)
	movq	-40(%rbp), %rax
	leaq	9(%rax), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
	movq	-40(%rbp), %rax
	leaq	10(%rax), %rdx
	movq	-32(%rbp), %rax
	addq	%rax, %rdx
	movq	-8(%rbp), %rax
	movq	%rax, (%rdx)
	jmp	.L10
.L9:
	movq	-32(%rbp), %rax
	addq	$1, %rax
	movq	(%rax), %rax
	cmpq	%rax, -40(%rbp)
	jge	.L10
	movq	-32(%rbp), %rax
	movq	1(%rax), %rax
	movq	%rax, -40(%rbp)
.L10:
	movq	-32(%rbp), %rax
	movb	$1, (%rax)
	addq	$1, -32(%rbp)
	movq	-32(%rbp), %rax
	movq	-40(%rbp), %rdx
	movq	%rdx, (%rax)
	addq	$8, -32(%rbp)
	movq	-32(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	alocaMem, .-alocaMem
	.globl	liberaMem
	.type	liberaMem, @function
liberaMem:
.LFB3:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	cmpq	$0, -8(%rbp)
	je	.L14
	movq	-8(%rbp), %rax
	subq	$9, %rax
	movb	$0, (%rax)
	movl	$0, %eax
	jmp	.L15
.L14:
	movl	$1, %eax
.L15:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
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
