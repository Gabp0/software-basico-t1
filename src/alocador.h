#ifndef __ALOCADOR__
#define __ALOCADOR__

void iniciaAlocador(void);
void finalizaAlocador(void);
void *firstFit(int num_bytes);
void *bestFit(int num_bytes);
void *nextFit(int num_bytes);
int liberaMem(void *bloco);
void printHeap(void);

#endif