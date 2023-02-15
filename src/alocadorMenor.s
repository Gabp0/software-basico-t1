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

alocaMem:
    pushq %rbp
    movq %rsp, %rbp
    movq $12, %rax
    movq $0, %rdi
    syscall
    movq %rax, TOP
    popq %rbp
    ret
    