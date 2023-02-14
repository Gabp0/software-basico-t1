#include "alocador.h"
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>

void *topo_inicial;

void iniciaAlocador(void)
// salva o topo inicial da heap
{
    topo_inicial = sbrk(0);
}

void finalizaAlocador(void)
// restaura o topo da heap inicial
{
    brk(topo_inicial);
}

void *firstFit(int num_bytes)
{
    void *topo_atual = sbrk(0);
    char *aux_ptr = topo_inicial;

    // procura por um bloco vazio com um tamanho >= a num_bytes
    while (aux_ptr < (char *)topo_atual)
    {
        if ((*aux_ptr == 0) && (*((int *)(aux_ptr + 1)) > num_bytes))
        {
            break;
        }
        aux_ptr += *((int *)(aux_ptr + 1)) + 5;
    }

    // se nao achou, aloca um novo
    if (aux_ptr == topo_atual)
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
    void *topo_atual = sbrk(0);
    char *aux_ptr = topo_inicial;

    // procura pelo menor bloco vazio com um tamanho >= a num_bytes
    void *best_ptr = aux_ptr;
    int best_size = num_bytes + 1;
    while (aux_ptr < (char *)topo_atual)
    {
        int current_block_size = *((int *)(aux_ptr + 1));
        if ((*aux_ptr == 0) && (current_block_size >= num_bytes) && (current_block_size < best_size))
        {
            best_ptr = aux_ptr;
        }
        aux_ptr += current_block_size + 5;
    }
    aux_ptr = best_ptr;

    // se nao achou, aloca um novo
    if (aux_ptr == topo_atual)
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

int liberaMem(void *bloco)
{
    *((char *)(bloco - 5)) = 0;
}
