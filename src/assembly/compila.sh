gcc -g -O -c main.c
ld alocador.o main.o -o alocador  -dynamic-linker /lib/ld-linux-x86-64.so.2 -lc