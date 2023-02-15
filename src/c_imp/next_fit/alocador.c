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
    }
    printf("\n");
}