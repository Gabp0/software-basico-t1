#include "alocador.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void printHeap(void)
{
    unsigned char *aux_ptr = initial_top;
    long long counter = 0;
    while (aux_ptr < (unsigned char *)current_top)
    {
        if ((counter % 8) == 0)
        {
            printf("\n%p : ", aux_ptr);
        }
        printf("0x%02x ", *(aux_ptr));
        aux_ptr++;
        counter++;
    }
    printf("\n");
}

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
    printHeap();

    b = alocaMem(60);
    strcpy(a, " TESTE ");
    printf("%p %s\n", a, (char *)a);
    printHeap();

    a = alocaMem(30);
    strcpy(a, " TESTE ");
    printf("%p %s\n", a, (char *)a);
    printHeap();
    liberaMem(a);
    liberaMem(b);

    a = alocaMem(10);
    strcpy(a, " TESTE ");
    printf("%p %s\n", a, (char *)a);
    printHeap();

    b = alocaMem(50);
    strcpy(b, " TESTE ");
    printf("%p %s\n", b, (char *)b);
    printHeap();

    finalizaAlocador();

    return 0;
}
