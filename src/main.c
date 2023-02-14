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

    a = bestFit(100);
    strcpy(a, " TESTE ");
    printf("%p %s\n", a, (char *)a);
    liberaMem(a);
    printHeap();

    a = bestFit(60);
    strcpy(a, " TESTE ");
    printf("%p %s\n", a, (char *)a);
    printHeap();

    b = bestFit(30);
    strcpy(b, " TESTE ");
    printf("%p %s\n", b, (char *)b);
    printHeap();
    liberaMem(a);
    liberaMem(b);
    printf("bloco n sei\n");
    printHeap();

    a = bestFit(30);
    strcpy(a, " TESTE ");
    printf("%p %s\n", a, (char *)a);
    printHeap();

    finalizaAlocador();

    return 0;
}
