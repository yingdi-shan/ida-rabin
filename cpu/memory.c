#include<sys/time.h>
#include<stdlib.h>
#include "mem.h"
#define DATA_SIZE (1<<30)

char *src,*dst;

int main(){
    struct timeval begin,end,result;
    double time;
    src = calloc(DATA_SIZE,1);
    dst = calloc(DATA_SIZE,1);
	memset(src,0xaa,DATA_SIZE);
	memset(dst,0xcc,DATA_SIZE);
    gettimeofday(&begin,NULL);
	memcpy_fast(dst,src,DATA_SIZE);
    gettimeofday(&end,NULL);
    timersub(&end,&begin,&result);
    printf("Time for copying 1GB data:%d.%03ds\n",result.tv_sec,result.tv_usec/1000);
    time = result.tv_sec + result.tv_usec * 1e-6;
    printf("Memcpy bandwidth:%.2fMB/s\n",DATA_SIZE / 1e6 / time);

    return 0;
}
