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

    a = nextFit(200);
    strcpy(a, " TESTE ");
    printf("%p %s\n", a, (char *)a);
    liberaMem(a);
    printHeap();

    a = nextFit(100);
    strcpy(a, " TESTE ");
    printf("%p %s\n", a, (char *)a);
    printHeap();

    b = nextFit(30);
    strcpy(b, " TESTE ");
    printf("%p %s\n", b, (char *)b);
    printHeap();
    liberaMem(a);
    liberaMem(b);

    a = nextFit(30);
    strcpy(a, " TESTE ");
    printf("%p %s\n", a, (char *)a);
    printHeap();

    a = nextFit(90);
    strcpy(a, " TESTE ");
    printf("%p %s\n", a, (char *)a);
    printHeap();

    finalizaAlocador();

    return 0;
}
