#include "ec-method.h"
#include <stdlib.h>
#include <time.h>
#include <stdio.h>
#include <omp.h>
#define DATA_SIZE (1<<29)
#define COLUMN (8)
uint8_t *decoded,*data;
uint8_t * output[COLUMN];
uint32_t row[COLUMN];
void init(){
	int i;
	decoded = (uint8_t *)malloc(DATA_SIZE);
	data = (uint8_t *)malloc(DATA_SIZE);
	
	for(i=0;i<COLUMN;i++)
		output[i] = (uint8_t *)malloc(DATA_SIZE/COLUMN),row[i]=i;
	ec_method_initialize();
	memset(data,0xaa,DATA_SIZE);
}
#define TEST_SIZE 100000000
int main(){
	
	int i,times,current_time;
	size_t size;
	clock_t total_time = 0;
	init();

	for (times = 0; times < 10; times++) {
		current_time = clock();
		for (i = 0; i < COLUMN; i++) {
			size = ec_method_encode(DATA_SIZE, COLUMN, i, data, output[i]);
		}
		total_time += clock() - current_time;
	}
	total_time /= 10;
	printf("encode cost:%f s\n",(double)(total_time)/CLOCKS_PER_SEC);
	
	total_time = 0;
	for (times = 0; times < 10; times++) {
		current_time = clock();
		ec_method_decode(size, COLUMN, row, output, decoded);
		total_time += clock() - current_time;
	}
	total_time /= 10;
	printf("decode cost:%f s\n",(double)(total_time)/CLOCKS_PER_SEC);

	/*
	for (int i = 0; i < 10; i++) {
		printf("%d: ", i * 10);
			
		for (int j = 0; j < 10; j++)
			printf("%x ", decoded[i * 10 + j]);
		printf("\n");
	}
	*/

	printf("Over\n");
	getchar();
	



	


	return 0;
}
