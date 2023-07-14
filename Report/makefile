all: main.o my_lib.o
	gcc -m32 -o project main.o my_lib.o

main.o: main.c
	gcc -std=c99 -m32 -c -o main.o main.c

my_lib.o: my_lib.asm
	nasm -f elf32 -o my_lib.o my_lib.asm

start:
	./project

test_root: 
	./project --test_p -5 10 -10 5 -5 10 

test_integral:
	./project --test_i -5 10 -10 5 -5 10

clean: 
	rm *.o