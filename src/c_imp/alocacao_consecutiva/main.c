#include <stdio.h>
#include "alocador.h"
#include <string.h>

// algoritmo da secao 6.2
int main(int argc, char **argv)
{
    void *a;
       
    printf("\n"); // coloca o buffer do printf antes do alocador
    iniciaAlocador();

    int i;
    for (i = 0; i < 100; i++)
    {
        a = alocaMem(100);
        strcpy(a, " TESTE ");
        printf("%p %s \n", a, (char *)a);
        liberaMem(a);
    }

    finalizaAlocador();

    return (0);
}