#include "alocador.h"
#include <stdio.h>
#include <string.h>

int main(int argc, char const *argv[])
{
    void *a;
    void *b;
    printf("\n"); // coloca o buffer do printf antes do bloco do alocador
    iniciaAlocador();

    a = alocaMem(100);
    strcpy(a, " TESTE ");
    printf("%p %s\n", a, (char *)a);
    liberaMem(a);
    imprimeMapa();

    b = alocaMem(60);
    strcpy(a, " TESTE ");
    printf("%p %s\n", a, (char *)a);
    imprimeMapa();

    a = alocaMem(30);
    strcpy(a, " TESTE ");
    printf("%p %s\n", a, (char *)a);
    imprimeMapa();
    liberaMem(a);
    liberaMem(b);

    a = alocaMem(10);
    strcpy(a, " TESTE ");
    printf("%p %s\n", a, (char *)a);
    imprimeMapa();

    b = alocaMem(50);
    strcpy(b, " TESTE ");
    printf("%p %s\n", b, (char *)b);
    imprimeMapa();

    finalizaAlocador();

    return 0;
}
