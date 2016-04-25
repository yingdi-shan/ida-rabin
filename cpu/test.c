#include "ec-method.h"
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdio.h>
#include <sys/time.h>
#include <sys/sysinfo.h>

#define COLUMN (64)
#define ROW (64 + 16)
#define DATA_SIZE (1<<30)

uint8_t *decoded,*data;
uint8_t * output[ROW];
uint32_t row[ROW];
void init(){
    int i;

    posix_memalign(&decoded,32,DATA_SIZE);
    posix_memalign(&data,32,DATA_SIZE);

    for(i=0;i<ROW;i++){
        posix_memalign(&output[i],32,DATA_SIZE/COLUMN);
        row[i] = i;
    }
    ec_method_initialize();


    for(i=0;i<DATA_SIZE;i++)
        data[i] = 0xaa;
}


int main(int argc,char *argv[]){

    int i,j,times;
    size_t size;
    struct timeval begin,end,result;
    double total_time;


    init();
    printf("Finish init\n");

    gettimeofday(&begin,NULL);
    if(argc > 1 && !strcmp(argv[1],"-p"))
        size = ec_method_batch_parallel_encode(DATA_SIZE, COLUMN, ROW, data, output,get_nprocs());
    else
        size = ec_method_batch_encode(DATA_SIZE, COLUMN, ROW, data, output);

    gettimeofday(&end,NULL);
    timersub(&end,&begin,&result);

    printf("%sencode cost:%ld.%06lds\n",(argc>1 && !strcmp(argv[1],"-p")?"parallel ":""),result.tv_sec,result.tv_usec);


    gettimeofday(&begin,NULL);
    if(argc > 1 && !strcmp(argv[1],"-p"))
        ec_method_parallel_decode(size, COLUMN, row, output, decoded,get_nprocs());
    else
        ec_method_decode(size,COLUMN,row,output,decoded);

    gettimeofday(&end,NULL);
    timersub(&end,&begin,&result);

    printf("%sdecode cost:%ld.%06lds\n",(argc>1 && !strcmp(argv[1],"-p")?"parallel ":""),result.tv_sec,result.tv_usec);

    printf("Checked:%s\n",memcmp(data,decoded,DATA_SIZE)==0?"ok":"error");


    return 0;
}
