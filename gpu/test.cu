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
        data[i] = rand() % 256;
}


int main(int argc,char *argv[]){

	int i,j;
	size_t size;
	struct timeval begin,end,result;

	init();
    printf("Finish init\n");

    gettimeofday(&begin,NULL);
    for (i = 0; i < COLUMN/4*5; i++) {
//         if(argc > 1 && !strcmp(argv[1],"-p"))
//            size = ec_method_parallel_encode(DATA_SIZE, COLUMN, i, data, output[i],get_nprocs());
//         else
            size = ec_method_encode(DATA_SIZE, COLUMN, i, data, output[i]);

    }
/*    if(argc > 1 && !strcmp(argv[1],"-p"))
        size = ec_method_batch_parallel_encode(DATA_SIZE, COLUMN, COLUMN/4*5, data, output,get_nprocs());
     else
        size = ec_method_batch_encode(DATA_SIZE, COLUMN, COLUMN/4*5, data, output);
*/
    gettimeofday(&end,NULL);
    timersub(&end,&begin,&result);

   
	printf("%sencode cost:%ld.%06lds\n",(argc>1 && !strcmp(argv[1],"-p")?"parallel ":""),result.tv_sec,result.tv_usec);

	 for(i=0;i<10;i++){
		        printf("%d :",i*10);
		        for(j=0;j<10;j++)
		            printf("%x ",output[0][i*10+j]);
		        printf("\n");
		    }

    gettimeofday(&begin,NULL);
 //   if(argc > 1 && !strcmp(argv[1],"-p"))
 //       ec_method_parallel_decode(size, COLUMN, row, output, decoded,get_nprocs());
//    else
     size = DATA_SIZE / COLUMN;
     ec_method_decode(size,COLUMN,row,output,decoded);

    gettimeofday(&end,NULL);
    timersub(&end,&begin,&result);

	printf("%sdecode cost:%ld.%06lds\n",(argc>1 && !strcmp(argv[1],"-p")?"parallel ":""),result.tv_sec,result.tv_usec);
	    for(i=0;i<100;i++){
	        printf("%d :",i*10);
	        for(j=0;j<10;j++)
	            printf("%x:%x ",decoded[i*10+j],data[i*10+j]);
	        printf("\n");
	    }


	return 0;
}
