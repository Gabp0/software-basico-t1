#ifndef __ALOCADOR__
#define __ALOCADOR__

void iniciaAlocador(void);
void finalizaAlocador(void);
void *alocaMem(long long num_bytes);
int liberaMem(void *bloco);
void printHeap(void);

#endif