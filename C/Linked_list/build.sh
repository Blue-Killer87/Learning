#!/usr/bin/sh

gcc -O3 -g3 -DHAVE_ATOMIC_GCC -I. -o list.o -c list.c
gcc -O3 -g3 -DHAVE_ATOMIC_GCC -I. -o xlist.o -c xlist.c
gcc -O3 -g3 -DHAVE_ATOMIC_GCC -I. -o reverse.o -c reverse.c
gcc -o reverse reverse.o xlist.o list.o
