GCC_FLAG += -O3  -msse4.2 -mavx -mavx2

test : main
	./main -p

main : ec-method.o test.o ec-gf.o thpool.o
	gcc -o main ec-method.o test.o ec-gf.o thpool.o -lpthread $(GCC_FLAG)

test.o: test.c ec-method.h ec-gf.h
	gcc -c test.c $(GCC_FLAG)

ec-method.o : ec-method.c ec-method.h ec-gf.h
	gcc -c ec-method.c $(GCC_FLAG) 

ec-gf.o : ec-gf.c ec-gf.h
	gcc -c ec-gf.c $(GCC_FLAG)

thpool.o : thpool.h thpool.c
	gcc -c thpool.c $(GCC_FLAG)

clean :
	$(RM) main ec-method.o ec-gf.o test.o

avx : avx.c
	gcc -o avx avx.c $(GCC_FLAG)
