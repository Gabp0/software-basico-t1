#include "alocador.h"

void *topo_inicial;

void iniciaAlocador(void)
// salva o topo inicial da heap
{
    topo_inicial = 0;
}

void finalizaAlocador(void)
// restaura o topo da heap inicial
{
    topo_inicial = 0;
}

void *firstFit(long long int num_bytes)
{
    void *topo_atual = 0;
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
        void *topo_atual = 0;;
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
