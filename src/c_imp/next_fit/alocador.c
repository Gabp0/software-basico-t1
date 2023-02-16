#include "alocador.h"
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>

void *initial_top;
void *last_allocated;
void *current_top;

void iniciaAlocador(void)
// salva o topo inicial da heap
{
    initial_top = sbrk(0);
    last_allocated = initial_top;
    current_top = initial_top;
}

void finalizaAlocador(void)
// restaura o topo da heap inicial
{
    brk(initial_top);
}

void *alocaMem(long long num_bytes)
{
    char *aux_ptr = last_allocated;

    short found = 0;
    if (aux_ptr != current_top)
    {
        do
        {
            long long current_block_size = *((long long *)(aux_ptr + 1));
            if ((*aux_ptr == 0) && (current_block_size >= num_bytes))
            {
                found = 1;
                break;
            }

            aux_ptr += current_block_size + 9;
            if (aux_ptr >= (char *)current_top)
            {
                aux_ptr = initial_top;
            }

        } while (aux_ptr != last_allocated);
    }

    // se nao achou, aloca um novo
    if (!found)
    {
        aux_ptr = current_top;
        // current_top = sbrk(num_bytes + 9) + num_bytes + 9;
        __asm__(
            "movq $12, %rax\n\t"
            "movq $0, %rdi\n\t"
            "syscall\n\t"
            "movq %rax, %rdi\n\t"
            "addq -40(%rbp), %rdi\n\t"
            "addq $9, %rdi\n\t"
            "movq %rdi, current_top(%rip)\n\t"
            "movq $12, %rax\n\t"
            "syscall\n\t");
    }

    // divide o bloco, caso tenha mais bytes
    if (*((long long *)(aux_ptr + 1)) > (num_bytes + 9))
    {
        long long size = *(long long *)(aux_ptr + 1) - num_bytes - 9;
        *(aux_ptr + num_bytes + 9) = 0;
        *((long long *)(aux_ptr + num_bytes + 10)) = size;
    }
    // caso ainda tenha mais bytes, mas n o suficiente para um bloco novo
    else if (*((long long *)(aux_ptr + 1)) > num_bytes)
    {
        num_bytes = *((long long *)(aux_ptr + 1));
    }

    last_allocated = aux_ptr;

    *aux_ptr = 1; // bloco ocupado
    aux_ptr++;
    *((long long *)aux_ptr) = num_bytes; // tamanho do bloco
    aux_ptr += 8;                        // inicio dos conteudo

    return aux_ptr;
}

int liberaMem(void *bloco)
{
    if (bloco)
    {
        *((char *)(bloco - 9)) = 0;
        return 0;
    }
    return 1;
}