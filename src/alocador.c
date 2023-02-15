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

void *firstFit(long long int num_bytes)
{
    void *current_top = sbrk(0);
    char *aux_ptr = initial_top;

    // procura por um bloco vazio com um tamanho >= a num_bytes
    while (aux_ptr < (char *)current_top)
    {
        int current_block_size = *((int *)(aux_ptr + 1));
        if ((*aux_ptr == 0) && (current_block_size >= num_bytes))
        {
            break;
        }
        aux_ptr += current_block_size + 5;
    }

    // se nao achou, aloca um novo
    if (aux_ptr == current_top)
    {
        sbrk(num_bytes + 5);
    }
    // divide o bloco, caso tenha mais bytes
    else if (*((int *)(aux_ptr + 1)) > num_bytes)
    {
        unsigned int size = *(int *)(aux_ptr + 1) - num_bytes - 5;
        *((int *)(aux_ptr + num_bytes + 5)) = 0;
        *((int *)(aux_ptr + num_bytes + 6)) = size;
    }

    *aux_ptr = 1; // bloco ocupado
    aux_ptr++;
    *((int *)aux_ptr) = num_bytes; // tamanho do bloco
    aux_ptr += 4;                  // inicio dos conteudo

    return aux_ptr;
}

void *bestFit(int num_bytes)
{
    void *current_top = sbrk(0);
    char *aux_ptr = initial_top;

    // procura pelo menor bloco vazio com um tamanho >= a num_bytes
    void *best_ptr = current_top;
    int best_size = __INT32_MAX__;
    while (aux_ptr < (char *)current_top)
    {
        int current_block_size = *((int *)(aux_ptr + 1));
        if (((*aux_ptr) == 0) && (current_block_size >= num_bytes) && (current_block_size < best_size))
        {
            best_ptr = aux_ptr;
            best_size = current_block_size;
        }
        aux_ptr += current_block_size + 5;
    }
    aux_ptr = best_ptr;

    // se nao achou, aloca um novo
    if (aux_ptr == current_top)
    {
        sbrk(num_bytes + 5);
    }
    // divide o bloco, caso tenha mais bytes
    else if (*((int *)(aux_ptr + 1)) > num_bytes)
    {
        unsigned int size = *(int *)(aux_ptr + 1) - num_bytes - 5;
        *((int *)(aux_ptr + num_bytes + 5)) = 0;
        *((int *)(aux_ptr + num_bytes + 6)) = size;
    }

    *aux_ptr = 1; // bloco ocupado
    aux_ptr++;
    *((int *)aux_ptr) = num_bytes; // tamanho do bloco
    aux_ptr += 4;                  // inicio dos conteudo

    return aux_ptr;
}

void *nextFit(int num_bytes)
{
    void *current_top = sbrk(0);
    char *aux_ptr = last_allocated;

    // procura por um bloco vazio com um tamanho >= a num_bytes a partir do ultimo alocado
    short found = 0;
    int search_range = current_top - initial_top;
    for (size_t i = 0; i < search_range; i++)
    {
        int current_block_size = *((int *)(aux_ptr + 1));
        if ((*aux_ptr == 0) && (current_block_size >= num_bytes))
        {
            found = 1;
            break;
        }
        aux_ptr += current_block_size + 5;

        if (aux_ptr >= (char *)current_top) // rotaciona a lista
        {
            aux_ptr = initial_top;
        }
    }

    // se nao achou, aloca um novo
    if (!found)
    {
        aux_ptr = current_top;
        sbrk(num_bytes + 5);
    }
    // divide o bloco, caso tenha mais bytes
    else if (*((int *)(aux_ptr + 1)) > num_bytes)
    {
        unsigned int size = *(int *)(aux_ptr + 1) - num_bytes - 5;
        *((int *)(aux_ptr + num_bytes + 5)) = 0;
        *((int *)(aux_ptr + num_bytes + 6)) = size;
    }

    last_allocated = aux_ptr;

    *aux_ptr = 1; // bloco ocupado
    aux_ptr++;
    *((int *)aux_ptr) = num_bytes; // tamanho do bloco
    aux_ptr += 4;                  // inicio dos conteudo

    return aux_ptr;
}

int liberaMem(void *bloco)
{
    *((char *)(bloco - 5)) = 0;
}

void printHeap(void)
{
    char *aux_ptr = initial_top;
    char *current_top = sbrk(0);
    int counter = 0;
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
