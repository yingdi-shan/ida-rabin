#include "ec-method.h"
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdio.h>
#include <sys/time.h>
#include <sys/sysinfo.h>
#define DATA_SIZE (1<<28)
#define COLUMN (64)
uint8_t *decoded,*data;
uint8_t * output[COLUMN/4*5];
uint32_t row[COLUMN/4*5];
void init(){
	int i;
	decoded = (uint8_t *)malloc(DATA_SIZE);
	data = (uint8_t *)malloc(DATA_SIZE);

	for(i=0;i<COLUMN/4*5;i++)
		output[i] = (uint8_t *)malloc(DATA_SIZE/COLUMN),row[i]=i;
    
    for(i=0;i<DATA_SIZE;i++)
        data[i] = rand()%256;
}


int main(int argc,char *argv[]){

	int i,j;
	size_t size;
	struct timeval begin,end,result;

	init();
    printf("Finish init\n");

    gettimeofday(&begin,NULL);

    size = ec_method_batch_encode(DATA_SIZE, COLUMN, COLUMN/4*5, data, output);

    gettimeofday(&end,NULL);
    timersub(&end,&begin,&result);

   
	printf("encode cost:%ld.%06lds\n",result.tv_sec,result.tv_usec);
    gettimeofday(&begin,NULL);

     ec_method_decode(size,COLUMN,row,output,decoded);

    gettimeofday(&end,NULL);
    timersub(&end,&begin,&result);

	printf("decode cost:%ld.%06lds\n",result.tv_sec,result.tv_usec);
	    for(i=0;i<10;i++){
	        printf("%d :",i*10);
	        for(j=0;j<10;j++)
	            printf("%x:%x ",decoded[i*10+j],data[i*10+j]);
	        printf("\n");
	    }


	return 0;
}

