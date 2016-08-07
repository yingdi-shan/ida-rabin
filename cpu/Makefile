GCC_FLAG += -O3 -mavx2

test : main
	./main

main : ec-method.o test.o ec-gf.o
	gcc -o main ec-method.o test.o ec-gf.o -lpthread $(GCC_FLAG)

memory: memory.c
	gcc -o memory memory.c $(GCC_FLAG)

test.o: test.c ec-method.h ec-gf.h
	gcc -c test.c $(GCC_FLAG)

ec-method.o : ec-method.c ec-method.h ec-gf.h ec-worker.h
	gcc -c ec-method.c $(GCC_FLAG)

ec-gf.o : ec-gf.c ec-gf.h
	gcc -c ec-gf.c $(GCC_FLAG)

clean :
	$(RM) main memory ec-method.o ec-gf.o test.o

