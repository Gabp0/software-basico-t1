	.file	"alocador.c"
	.text
	.globl	initial_top
	.bss
	.align 8
	.type	initial_top, @object
	.size	initial_top, 8
initial_top:
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
# 11 "alocador.c" 1
	movq $12, %rax
	movq $0, %rdi
	syscall
	movq %rax, initial_top(%rip)
	
# 0 "" 2
#NO_APP
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
# 22 "alocador.c" 1
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
#APP
# 33 "alocador.c" 1
	movq $12, %rax
	movq $0, %rdi
	syscall
	movq %rax, -24(%rbp)
	
# 0 "" 2
#NO_APP
	movq	initial_top(%rip), %rax
	movq	%rax, -32(%rbp)
	jmp	.L4
.L7:
	movq	-32(%rbp), %rax
	movq	1(%rax), %rax
	movq	%rax, -16(%rbp)
	movq	-32(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L5
	movq	-16(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jge	.L11
.L5:
	movq	-16(%rbp), %rax
	addq	$9, %rax
	addq	%rax, -32(%rbp)
.L4:
	movq	-32(%rbp), %rax
	cmpq	-24(%rbp), %rax
	jb	.L7
	jmp	.L6
.L11:
	nop
.L6:
	movq	-32(%rbp), %rax
	cmpq	-24(%rbp), %rax
	jne	.L8
#APP
# 55 "alocador.c" 1
	movq $12, %rax
	movq $0, %rdi
	syscall
	movq -40(%rbp), %rdi
	addq %rax, %rdi
	addq $10, %rdi
	movq $12, %rax
	syscall
	
# 0 "" 2
#NO_APP
	jmp	.L9
.L8:
	movq	-32(%rbp), %rax
	addq	$1, %rax
	movq	(%rax), %rax
	cmpq	%rax, -40(%rbp)
	jge	.L9
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
.L9:
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
	movq	-8(%rbp), %rax
	subq	$5, %rax
	movb	$0, (%rax)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	liberaMem, .-liberaMem
	.section	.rodata
.LC0:
	.string	"\n%p : "
.LC1:
	.string	"0x%02x "
	.text
	.globl	printHeap
	.type	printHeap, @function
printHeap:
.LFB4:
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
	movl	$0, %edi
	call	sbrk@PLT
	movq	%rax, -8(%rbp)
	movq	$0, -16(%rbp)
	jmp	.L14
.L16:
	movq	-16(%rbp), %rax
	andl	$7, %eax
	testq	%rax, %rax
	jne	.L15
	movq	-24(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
.L15:
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	movl	%eax, %esi
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	addq	$1, -24(%rbp)
	addq	$1, -16(%rbp)
.L14:
	movq	-24(%rbp), %rax
	cmpq	-8(%rbp), %rax
	jb	.L16
	movl	$10, %edi
	call	putchar@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	printHeap, .-printHeap
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
