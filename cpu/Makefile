GCC_FLAG = -O3 

test : main
	./main -p

main : ec-method.o test.o ec-gf.o
	gcc -o main ec-method.o test.o ec-gf.o -lpthread $(GCC_FLAG)

test.o: test.c
	gcc -c test.c $(GCC_FLAG)

ec-method.o : ec-method.c ec-method.h 
	gcc -c ec-method.c $(GCC_FLAG) 

ec-gf.o : ec-gf.c ec-gf.h
	gcc -c ec-gf.c $(GCC_FLAG)

clean :
	rm main ec-method.o ec-gf.o test.o

