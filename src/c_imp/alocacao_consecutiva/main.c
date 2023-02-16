#include <stdio.h>
#include "alocador.h"
#include <string.h>

// void printHeap(void)
// {
//     unsigned char *aux_ptr = initial_top;
//     long long counter = 0;

//     while (aux_ptr < (unsigned char *)current_top)
//     {
//         if ((counter % 8) == 0)
//         {
//             printf("\n%p : ", aux_ptr);
//         }
//         printf("0x%02x ", *(aux_ptr));
//         aux_ptr++;
//         counter++;
//     }
//     printf("\n");
// }

// algoritmo da secao 6.2
int main(void)
{
    void *a;

    // printf("\n"); // coloca o buffer do printf antes do alocador
    iniciaAlocador();

    int i;
    for (i = 0; i < 100; i++)
    {
        a = alocaMem(100);
        // strcpy(a, " TESTE ");
        // printf("%p %s \n", a, (char *)a);
        liberaMem(a);
    }
    // printHeap();

    finalizaAlocador();

    return (0);
}