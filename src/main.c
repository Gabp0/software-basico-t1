#include "alocador.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char const *argv[])
{
    void *a;
    int i;
    printf("\n"); // coloca o buffer do printf antes do bloco do alocador
    iniciaAlocador();

    // for (i = 0; i < 100; i++)
    // {
    //     a = alocaMem(100);
    //     strcpy(a, " TESTE ");

    //     printf("%p %s\n", a, (char *)a);

    //     liberaMem(a);
    // }

    a = alocaMem(100);
    strcpy(a, " TESTE ");
    printf("%p %s\n", a, (char *)a);
    liberaMem(a);

    a = alocaMem(30);
    strcpy(a, " TESTE ");
    printf("%p %s\n", a, (char *)a);
    liberaMem(a);

    a = alocaMem(60);
    strcpy(a, " TESTE ");
    printf("%p %s\n", a, (char *)a);
    liberaMem(a);

    a = alocaMem(100);
    strcpy(a, " TESTE ");
    printf("%p %s\n", a, (char *)a);
    liberaMem(a);

    finalizaAlocador();

    return 0;
}
