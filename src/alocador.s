	.file	"alocador.c"
	.text
	.globl	initial_top
	.bss
	.align 8
	.type	initial_top, @object
	.size	initial_top, 8
initial_top:
	.zero	8
	.globl	last_allocated
	.align 8
	.type	last_allocated, @object
	.size	last_allocated, 8
last_allocated:
	.zero	8
	.text
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
	movl	$0, %edi
	call	sbrk@PLT
	movq	%rax, initial_top(%rip)
	movq	initial_top(%rip), %rax
	movq	%rax, last_allocated(%rip)
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
	movq	initial_top(%rip), %rax
	movq	%rax, %rdi
	call	brk@PLT
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	finalizaAlocador, .-finalizaAlocador
	.globl	firstFit
	.type	firstFit, @function
firstFit:
.LFB8:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movl	$0, %edi
	call	sbrk@PLT
	movq	%rax, -8(%rbp)
	movq	initial_top(%rip), %rax
	movq	%rax, -16(%rbp)
	jmp	.L4
.L7:
	movq	-16(%rbp), %rax
	movl	1(%rax), %eax
	movl	%eax, -24(%rbp)
	movq	-16(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L5
	movl	-24(%rbp), %eax
	cltq
	cmpq	%rax, -40(%rbp)
	jle	.L11
.L5:
	movl	-24(%rbp), %eax
	cltq
	addq	$5, %rax
	addq	%rax, -16(%rbp)
.L4:
	movq	-16(%rbp), %rax
	cmpq	-8(%rbp), %rax
	jb	.L7
	jmp	.L6
.L11:
	nop
.L6:
	movq	-16(%rbp), %rax
	cmpq	-8(%rbp), %rax
	jne	.L8
	movq	-40(%rbp), %rax
	addq	$5, %rax
	movq	%rax, %rdi
	call	sbrk@PLT
	jmp	.L9
.L8:
	movq	-16(%rbp), %rax
	addq	$1, %rax
	movl	(%rax), %eax
	cltq
	cmpq	%rax, -40(%rbp)
	jge	.L9
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
.L9:
	movq	-16(%rbp), %rax
	movb	$1, (%rax)
	addq	$1, -16(%rbp)
	movq	-40(%rbp), %rax
	movl	%eax, %edx
	movq	-16(%rbp), %rax
	movl	%edx, (%rax)
	addq	$4, -16(%rbp)
	movq	-16(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	firstFit, .-firstFit
	.globl	bestFit
	.type	bestFit, @function
bestFit:
.LFB9:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movq	%rdi, -56(%rbp)
	movl	$0, %edi
	call	sbrk@PLT
	movq	%rax, -8(%rbp)
	movq	initial_top(%rip), %rax
	movq	%rax, -24(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, -16(%rbp)
	movl	$2147483647, -36(%rbp)
	jmp	.L13
.L15:
	movq	-24(%rbp), %rax
	movl	1(%rax), %eax
	movl	%eax, -28(%rbp)
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L14
	movl	-28(%rbp), %eax
	cltq
	cmpq	%rax, -56(%rbp)
	jg	.L14
	movl	-28(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jge	.L14
	movq	-24(%rbp), %rax
	movq	%rax, -16(%rbp)
	movl	-28(%rbp), %eax
	movl	%eax, -36(%rbp)
.L14:
	movl	-28(%rbp), %eax
	cltq
	addq	$5, %rax
	addq	%rax, -24(%rbp)
.L13:
	movq	-24(%rbp), %rax
	cmpq	-8(%rbp), %rax
	jb	.L15
	movq	-16(%rbp), %rax
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	cmpq	-8(%rbp), %rax
	jne	.L16
	movq	-56(%rbp), %rax
	addq	$5, %rax
	movq	%rax, %rdi
	call	sbrk@PLT
	jmp	.L17
.L16:
	movq	-24(%rbp), %rax
	addq	$1, %rax
	movl	(%rax), %eax
	cltq
	cmpq	%rax, -56(%rbp)
	jge	.L17
	movq	-24(%rbp), %rax
	addq	$1, %rax
	movl	(%rax), %eax
	movl	%eax, %edx
	movq	-56(%rbp), %rax
	movl	%eax, %ecx
	movl	%edx, %eax
	subl	%ecx, %eax
	subl	$5, %eax
	movl	%eax, -32(%rbp)
	movq	-56(%rbp), %rax
	leaq	5(%rax), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movl	$0, (%rax)
	movq	-56(%rbp), %rax
	leaq	6(%rax), %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movl	-32(%rbp), %eax
	movl	%eax, (%rdx)
.L17:
	movq	-24(%rbp), %rax
	movb	$1, (%rax)
	addq	$1, -24(%rbp)
	movq	-56(%rbp), %rax
	movl	%eax, %edx
	movq	-24(%rbp), %rax
	movl	%edx, (%rax)
	addq	$4, -24(%rbp)
	movq	-24(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	bestFit, .-bestFit
	.globl	nextFit
	.type	nextFit, @function
nextFit:
.LFB10:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movq	%rdi, -56(%rbp)
	movl	$0, %edi
	call	sbrk@PLT
	movq	%rax, -8(%rbp)
	movq	last_allocated(%rip), %rax
	movq	%rax, -24(%rbp)
	movw	$0, -38(%rbp)
	movq	initial_top(%rip), %rdx
	movq	-8(%rbp), %rax
	subq	%rdx, %rax
	movl	%eax, -36(%rbp)
	movq	$0, -16(%rbp)
	jmp	.L20
.L24:
	movq	-24(%rbp), %rax
	movl	1(%rax), %eax
	movl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L21
	movl	-32(%rbp), %eax
	cltq
	cmpq	%rax, -56(%rbp)
	jg	.L21
	movw	$1, -38(%rbp)
	jmp	.L22
.L21:
	movl	-32(%rbp), %eax
	cltq
	addq	$5, %rax
	addq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	cmpq	-8(%rbp), %rax
	jb	.L23
	movq	initial_top(%rip), %rax
	movq	%rax, -24(%rbp)
.L23:
	addq	$1, -16(%rbp)
.L20:
	movl	-36(%rbp), %eax
	cltq
	cmpq	%rax, -16(%rbp)
	jb	.L24
.L22:
	cmpw	$0, -38(%rbp)
	jne	.L25
	movq	-8(%rbp), %rax
	movq	%rax, -24(%rbp)
	movq	-56(%rbp), %rax
	addq	$5, %rax
	movq	%rax, %rdi
	call	sbrk@PLT
	jmp	.L26
.L25:
	movq	-24(%rbp), %rax
	addq	$1, %rax
	movl	(%rax), %eax
	cltq
	cmpq	%rax, -56(%rbp)
	jge	.L26
	movq	-24(%rbp), %rax
	addq	$1, %rax
	movl	(%rax), %eax
	movl	%eax, %edx
	movq	-56(%rbp), %rax
	movl	%eax, %ecx
	movl	%edx, %eax
	subl	%ecx, %eax
	subl	$5, %eax
	movl	%eax, -28(%rbp)
	movq	-56(%rbp), %rax
	leaq	5(%rax), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movl	$0, (%rax)
	movq	-56(%rbp), %rax
	leaq	6(%rax), %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movl	-28(%rbp), %eax
	movl	%eax, (%rdx)
.L26:
	movq	-24(%rbp), %rax
	movq	%rax, last_allocated(%rip)
	movq	-24(%rbp), %rax
	movb	$1, (%rax)
	addq	$1, -24(%rbp)
	movq	-56(%rbp), %rax
	movl	%eax, %edx
	movq	-24(%rbp), %rax
	movl	%edx, (%rax)
	addq	$4, -24(%rbp)
	movq	-24(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	nextFit, .-nextFit
	.globl	liberaMem
	.type	liberaMem, @function
liberaMem:
.LFB11:
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
.LFE11:
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
.LFB12:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	initial_top(%rip), %rax
	movq	%rax, -16(%rbp)
	movl	$0, %edi
	call	sbrk@PLT
	movq	%rax, -8(%rbp)
	movl	$0, -20(%rbp)
	jmp	.L30
.L32:
	movl	-20(%rbp), %eax
	andl	$7, %eax
	testl	%eax, %eax
	jne	.L31
	movq	-16(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
.L31:
	movq	-16(%rbp), %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	movl	%eax, %esi
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	addq	$1, -16(%rbp)
	addl	$1, -20(%rbp)
.L30:
	movq	-16(%rbp), %rax
	cmpq	-8(%rbp), %rax
	jb	.L32
	movl	$10, %edi
	call	putchar@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
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
