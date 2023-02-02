#ifndef __ALOCADOR__
#define __ALOCADOR__

void iniciaAlocador(void);
void finalizaAlocador(void);
void *alocaMem(int num_bytes);
int liberaMem(void *bloco);
void breakp(void);

#endif