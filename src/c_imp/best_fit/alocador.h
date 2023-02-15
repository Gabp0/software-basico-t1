#ifndef __ALOCADOR__
#define __ALOCADOR__

extern void *initial_top;
extern void *current_top;

void iniciaAlocador(void);
void finalizaAlocador(void);
void *alocaMem(long long num_bytes);
int liberaMem(void *bloco);

#endif