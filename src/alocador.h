#ifndef __ALOCADOR__
#define __ALOCADOR__

void iniciaAlocador(void);
void finalizaAlocador(void);
void *firstFit(long long num_bytes);
void *bestFit(long long num_bytes);
void *nextFit(long long num_bytes);
int liberaMem(void *bloco);
void printHeap(void);

#endif