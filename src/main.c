#include "alocador.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char const *argv[])
{
    void *a;
    void *b;
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

    a = bestFit(100);
    strcpy(a, " TESTE ");
    printf("%p %s\n", a, (char *)a);
    liberaMem(a);

    b = bestFit(60);
    strcpy(b, " TESTE ");
    printf("%p %s\n", b, (char *)b);

    a = firstFit(30);
    strcpy(a, " TESTE ");
    printf("%p %s\n", a, (char *)a);
    liberaMem(a);
    liberaMem(b);

    a = bestFit(30);
    strcpy(a, " TESTE ");
    printf("%p %s\n", a, (char *)a);
    liberaMem(a);

    finalizaAlocador();

    // a = firstFit(100);
    // strcpy(a, " TESTE ");
    // printf("%p %s\n", a, (char *)a);
    // liberaMem(a);

    // a = firstFit(30);
    // strcpy(a, " TESTE ");
    // printf("%p %s\n", a, (char *)a);
    // liberaMem(a);

    // a = firstFit(60);
    // strcpy(a, " TESTE ");
    // printf("%p %s\n", a, (char *)a);
    // liberaMem(a);

    // a = firstFit(100);
    // strcpy(a, " TESTE ");
    // printf("%p %s\n", a, (char *)a);
    // liberaMem(a);

    // finalizaAlocador();

    return 0;
}
