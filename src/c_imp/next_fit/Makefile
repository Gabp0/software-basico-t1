# Makefile
CC = gcc
TARGET = nextFit

# flags
CPPFLAGS = -Wall -g

objs = main.o alocador.o

.PHONY: all clean purge

all: $(TARGET)

# ligacao
$(TARGET): $(objs)
	$(CC) $(CPPFLAGS) $(objs) -o $(TARGET)

# compilacao
main.o: alocador.h
alocador.o: alocador.h

# limpeza
clean:
	-rm -f $(objs) *~
purge: clean
	-rm -f $(TARGET)

