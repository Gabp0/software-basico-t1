#include "alocador.h"
#include <unistd.h>
#include <stdio.h>

void *initial_top;
void *current_top;

void iniciaAlocador(void)
// salva o topo inicial da heap
{
    // initial_top = sbrk(0);
    __asm__(
        "movq $12, %rax\n\t"
        "movq $0, %rdi\n\t"
        "syscall\n\t"
        "movq %rax, initial_top(%rip)\n\t");
    current_top = initial_top;
}

void finalizaAlocador(void)
// restaura o topo da heap inicial
{
    // brk(initial_top);
    __asm__(
        "movq initial_top(%rip), %rax\n\t"
        "movq %rax, %rdi\n\t"
        "movq $12, %rax\n\t"
        "syscall\n\t");
}

void *alocaMem(long long num_bytes)
{
    char *aux_ptr = initial_top;

    // procura por um bloco vazio com um tamanho >= a num_bytes
    while (aux_ptr < (char *)current_top)
    {
        long long cblock_size = *((long long *)(aux_ptr + 1));
        if ((*aux_ptr == 0) && (cblock_size >= num_bytes))
        {
            break;
        }
        aux_ptr += cblock_size + 9;
    }

    // se nao achou, aloca um novo
    if (aux_ptr == current_top)
    {
        long long bsize = (((long)(num_bytes / 4096)) + 1) * 4096;
        current_top = sbrk(bsize + 9) + bsize + 9;
        *((long long *)(aux_ptr + 1)) = bsize;
    }

    // divide o bloco, caso tenha mais bytes
    if (*((long long *)(aux_ptr + 1)) > (num_bytes + 9))
    {
        long long nblock_size = *(long long *)(aux_ptr + 1) - num_bytes - 9;
        *(aux_ptr + num_bytes + 9) = 0;
        *((long long *)(aux_ptr + num_bytes + 10)) = nblock_size;
    }
    // caso ainda tenha mais bytes, mas n o suficiente para um bloco novo
    else if (*((long long *)(aux_ptr + 1)) > num_bytes)
    {
        num_bytes = *((long long *)(aux_ptr + 1));
    }

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

void printHeap(void)
{
    unsigned char *aux_ptr = initial_top;
    long long counter = 0;

    while (aux_ptr < (unsigned char *)current_top)
    {
        if ((counter % 8) == 0)
        {
            printf("\n%p : ", aux_ptr);
        }
        printf("0x%02x ", *(aux_ptr));
        aux_ptr++;
        counter++;

        if (counter > 200)
        {
            break;
        }
    }
    printf("\n");
}

void imprimeMapa(void)
{
    unsigned char *aux_ptr = initial_top;
    char c;
    long long current_block_size;
    while (aux_ptr < (unsigned char *)current_top)
    {
        current_block_size = *((long long *)(aux_ptr + 1));

        printf("#########");

        if (*aux_ptr == 0)
        {
            c = '-';
        }
        else
        {
            c = '+';
        }

        for (size_t i = 0; i < current_block_size; i++)
        {
            printf("%c", c);
        }

        aux_ptr += current_block_size + 9;
    }
    printf("\n");
}