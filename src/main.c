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

    a = nextFit(100);
    strcpy(a, " TESTE ");
    printf("%p %s\n", a, (char *)a);
    liberaMem(a);
    printHeap();

    b = nextFit(60);
    strcpy(a, " TESTE ");
    printf("%p %s\n", a, (char *)a);
    printHeap();

    a = nextFit(30);
    strcpy(a, " TESTE ");
    printf("%p %s\n", a, (char *)a);
    printHeap();
    liberaMem(a);
    liberaMem(b);

    a = nextFit(10);
    strcpy(a, " TESTE ");
    printf("%p %s\n", a, (char *)a);
    printHeap();

    b = nextFit(50);
    strcpy(b, " TESTE ");
    printf("%p %s\n", b, (char *)b);
    printHeap();

    finalizaAlocador();

    return 0;
}
