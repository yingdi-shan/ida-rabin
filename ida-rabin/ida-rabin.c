#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#include"ida-rabin.h"

static uint8_t gf_mul_table[EC_GF_SIZE][EC_GF_SIZE];
static uint8_t gf_div_table[EC_GF_SIZE][EC_GF_SIZE];

static uint8_t gf_add(uint8_t a,uint8_t b)
{
    return a^b;
}
static uint8_t gf_sub(uint8_t a,uint8_t b)
{
    return a^b;
}
static uint8_t gf_mul(uint8_t a,uint8_t b)
{
    return gf_mul_table[a][b];
}
static uint8_t gf_div(uint8_t a,uint8_t b)
{
    return gf_div_table[a][b];
}

static uint8_t gf_slow_mul(uint8_t a,uint8_t b)
{
    uint32_t ret=0,tmp_a=a,tmp_b=b;
    int counter=0;
    for(counter=0; counter<EC_GF_BITS; counter++) {
        if(tmp_b & 1)
            ret ^= tmp_a;
        tmp_a <<= 1;
        if(tmp_a & EC_GF_SIZE)
            tmp_a ^= EC_GF_MOD;
        tmp_b >>= 1;
    }
    return ret;
}



void decode()
{


}

void encode()
{


}


static void init()
{
    int i,j,mul;
    for(i=0; i<EC_GF_SIZE; i++)
        for(j=i; j<EC_GF_SIZE; j++) {
            mul=gf_slow_mul(i,j);
            gf_mul_table[i][j]=gf_mul_table[j][i]=mul;
            gf_div_table[mul][i]=j,gf_div_table[mul][j]=i;
        }
}

