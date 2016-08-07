#include "ec-method.h"
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdio.h>
#include <sys/time.h>
#include <sys/sysinfo.h>

#define COLUMN (32)
#define ROW (32 + 8)
#define DATA_SIZE ((1<<30) - (1<<30)%(EC_METHOD_CHUNK_SIZE * COLUMN))

uint8_t *decoded,*data;
uint8_t * output[ROW];
uint8_t * out_ptr[ROW];
uint8_t row[ROW];
int g_seed = 1;
inline int fastrand(){
    g_seed = (214013 * g_seed + 2531011);
    return (g_seed>>16) & 0xFF;
}
void init(){
    int i;

    //Data should be aligned in order to use SIMD instructions.
    posix_memalign(&decoded,32,DATA_SIZE);
    posix_memalign(&data,32,DATA_SIZE);

    for(i=0;i<ROW;i++){
        posix_memalign(&output[i],32,DATA_SIZE/COLUMN);
		memset(output[i],0,DATA_SIZE/COLUMN);
        row[i] = i;
    }
    ec_method_initialize();

    for(i=0;i<DATA_SIZE;i++)
        data[i] = fastrand();
	memset(decoded,0,DATA_SIZE);

}

int main(int argc,char *argv[]){

    int i,j,times;
    size_t size;
    struct timeval begin,end,result;
    double total_time;
    int SEG_SIZE = 1<<30;


    //Produce random data.
    init();
    printf("Finish init\n");

	printf("Size:%d\n",sizeof(encode_t));


    gettimeofday(&begin,NULL);
    for(i=0;i<DATA_SIZE/SEG_SIZE;i++){
        for(j=0;j<ROW;j++)
            out_ptr[j] = output[j] + SEG_SIZE/COLUMN * i;
        size = ec_method_batch_encode(SEG_SIZE, COLUMN, ROW,row, data + i*SEG_SIZE ,out_ptr);
    }

    gettimeofday(&end,NULL);
    timersub(&end,&begin,&result);

    printf("%sencode cost:%ld.%06lds\n",(argc>1 && !strcmp(argv[1],"-p")?"parallel ":""),result.tv_sec,result.tv_usec);
    double time = result.tv_sec + result.tv_usec * 1e-6;
    printf("Encode Bandwidth:%.2fMB/s\n",DATA_SIZE / 1e6 / time);


    gettimeofday(&begin,NULL);
    for(i=0;i<DATA_SIZE/SEG_SIZE;i++) {
        for(j=0;j<ROW;j++)
            out_ptr[j] = output[j] + SEG_SIZE/COLUMN * i;
        ec_method_decode(SEG_SIZE / COLUMN, COLUMN, row, out_ptr, decoded + i*SEG_SIZE );
    }

    gettimeofday(&end,NULL);
    timersub(&end,&begin,&result);

    printf("%sdecode cost:%ld.%06lds\n",(argc>1 && !strcmp(argv[1],"-p")?"parallel ":""),result.tv_sec,result.tv_usec);

    time = result.tv_sec + result.tv_usec * 1e-6;
    printf("Decode Bandwidth:%.2fMB/s\n",DATA_SIZE / 1e6 / time);


    //Check whether data is correct.
    printf("Checked:%s\n",memcmp(data,decoded,DATA_SIZE)==0?"ok":"error");

    return 0;
}
