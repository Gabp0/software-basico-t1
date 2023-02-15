#include "alocador.h"
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>

void *initial_top;
void *last_allocated;

void iniciaAlocador(void)
// salva o topo inicial da heap
{
    initial_top = sbrk(0);
    last_allocated = initial_top;
}

void finalizaAlocador(void)
// restaura o topo da heap inicial
{
    brk(initial_top);
}

void *firstFit(long long num_bytes)
{
    void *current_top = sbrk(0);
    char *aux_ptr = initial_top;

    // procura por um bloco vazio com um tamanho >= a num_bytes
    while (aux_ptr < (char *)current_top)
    {
        long long current_block_size = *((long long *)(aux_ptr + 1));
        if ((*aux_ptr == 0) && (current_block_size >= num_bytes))
        {
            break;
        }
        aux_ptr += current_block_size + 9;
    }

    // se nao achou, aloca um novo
    if (aux_ptr == current_top)
    {
        sbrk(num_bytes + 9);
    }
    // divide o bloco, caso tenha mais bytes
    else if (*((long long *)(aux_ptr + 1)) > num_bytes)
    {
        long long size = *(long long *)(aux_ptr + 1) - num_bytes - 9;
        *((char *)(aux_ptr + num_bytes + 9)) = 0;
        *((long long *)(aux_ptr + num_bytes + 10)) = size;
    }

    *aux_ptr = 1; // bloco ocupado
    aux_ptr++;
    *((long long *)aux_ptr) = num_bytes; // tamanho do bloco
    aux_ptr += 8;                        // inicio dos conteudo

    return aux_ptr;
}

void *bestFit(long long num_bytes)
{
    void *current_top = sbrk(0);
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
        sbrk(num_bytes + 9);
    }
    // divide o bloco, caso tenha mais bytes
    else if (*((long long *)(aux_ptr + 1)) > num_bytes)
    {
        long long size = *(long long *)(aux_ptr + 1) - num_bytes - 9;
        *((long long *)(aux_ptr + num_bytes + 9)) = 0;
        *((long long *)(aux_ptr + num_bytes + 10)) = size;
    }

    *aux_ptr = 1; // bloco ocupado
    aux_ptr++;
    *((long long *)aux_ptr) = num_bytes; // tamanho do bloco
    aux_ptr += 8;                        // inicio dos conteudo

    return aux_ptr;
}

void *nextFit(long long num_bytes)
{
    void *current_top = sbrk(0);
    char *aux_ptr = last_allocated;

    // procura por um bloco vazio com um tamanho >= a num_bytes a partir do ultimo alocado
    short found = 0;
    long long search_range = current_top - initial_top;
    for (size_t i = 0; i < search_range; i++)
    {
        long long current_block_size = *((long long *)(aux_ptr + 1));
        if ((*aux_ptr == 0) && (current_block_size >= num_bytes))
        {
            found = 1;
            break;
        }
        aux_ptr += current_block_size + 9;

        if (aux_ptr >= (char *)current_top) // rotaciona a lista
        {
            aux_ptr = initial_top;
        }
    }

    // se nao achou, aloca um novo
    if (!found)
    {
        aux_ptr = current_top;
        sbrk(num_bytes + 9);
    }
    // divide o bloco, caso tenha mais bytes
    else if (*((long long *)(aux_ptr + 1)) > num_bytes)
    {
        long long size = *(long long *)(aux_ptr + 1) - num_bytes - 9;
        *((long long *)(aux_ptr + num_bytes + 9)) = 0;
        *((long long *)(aux_ptr + num_bytes + 10)) = size;
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
    *((char *)(bloco - 9)) = 0;
}

void printHeap(void)
{
    unsigned char *aux_ptr = initial_top;
    unsigned char *current_top = sbrk(0);
    long long counter = 0;
    while (aux_ptr < current_top)
    {
        if ((counter % 8) == 0)
        {
            printf("\n%p : ", aux_ptr);
        }
        printf("0x%02x ", *(aux_ptr));
        aux_ptr++;
        counter++;
    }
    printf("\n");
}