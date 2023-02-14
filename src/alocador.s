
.section .data
    topo_inicial: .quad 0

.section .text

iniciaAlocador:
    pushq %rbp
    movq %rsp, %rbp
    movq $12, %rax
    movq $0, %rdi
    syscall
    movq %rax, topo_inicial
    popq %rbp
    ret

finalizaAlocador:
    pushq %rbp
    movq %rsp, %rbp
    movq $12, %rax
    movq topo_inicial, %rdi
    syscall
    popq %rbp
    ret

liberaMem:
	pushq	%rbp
	movq	%rsp, %rbp
#	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	subq	$5, %rax
	movq	$0, (%rax)
	popq	%rbp
    ret

alocaMem:
    pushq %rbp
    movq %rsp, %rbp
    subq $8, %rbp

    cmpq %rbx, %rax

    addq $8, %rbp
    popq %rbp
    ret

