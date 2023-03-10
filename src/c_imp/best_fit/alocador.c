#include "alocador.h"
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>

void *initial_top;
void *current_top;

void iniciaAlocador(void)
// salva o topo inicial da heap
{
    initial_top = sbrk(0);
    current_top = initial_top;
}

void finalizaAlocador(void)
// restaura o topo da heap inicial
{
    brk(initial_top);
}

void desfragmenta(void)
{
    char *cur_ptr = initial_top;

    while ((void *)cur_ptr < current_top)
    {
        long long current_block_size = *((long long *)(cur_ptr + 1));

        char *next_node = cur_ptr + current_block_size + 9;
        if ((*(next_node) == 0) && ((void *)next_node < current_top))
        {
            long long next_block_size = *((long long *)(next_node + 1));
            *((long long *)(cur_ptr + 1)) = current_block_size + next_block_size + 9;
        }
        else
        {
            cur_ptr = next_node;
        }
    }
}

void *alocaMem(long long num_bytes)
{
    char *aux_ptr = initial_top;

    // procura pelo menor bloco vazio com um tamanho >= a num_bytes
    void *best_ptr = current_top;
    long long best_size = __LONG_LONG_MAX__;
    while (aux_ptr < (char *)current_top)
    {
        long long current_block_size = *((long long *)(aux_ptr + 1));
        if (((*aux_ptr) == 0) && (current_block_size >= num_bytes) && (current_block_size < best_size))
        {
            best_ptr = aux_ptr;
            best_size = current_block_size;
        }
        aux_ptr += current_block_size + 9;
    }
    aux_ptr = best_ptr;

    // se nao achou, aloca um novo
    if (aux_ptr == current_top)
    {
        current_top = sbrk(num_bytes + 9) + num_bytes + 9;
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
        desfragmenta();
        return 0;
    }
    return 1;
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