/*
  Copyright (c) 2012-2014 DataLab, s.l. <http://www.datalab.es>
  This file is part of GlusterFS.

  This file is licensed to you under your choice of the GNU Lesser
  General Public License, version 3 or any later version (LGPLv3 or
  later), or the GNU General Public License, version 2 (GPLv2), in all
  cases as published by the Free Software Foundation.
*/
#include <stdlib.h>
#include <string.h>
#include <inttypes.h>
#include <pthread.h>
#include "ec-method.h"

//There will be unknown bug if we put these two arrays in normal GPU memory.
__constant__ uint32_t GfPow_cuda[EC_GF_SIZE << 1]={1,2,4,8,16,32,64,128,29,58,116,232,205,135,19,38,76,152,45,90,180,117,234,201,143,3,6,12,24,48,96,192,157,39,78,156,37,74,148,53,106,212,181,119,238,193,159,35,70,140,5,10,20,40,80,160,93,186,105,210,185,111,222,161,95,190,97,194,153,47,94,188,101,202,137,15,30,60,120,240,253,231,211,187,107,214,177,127,254,225,223,163,91,182,113,226,217,175,67,134,17,34,68,136,13,26,52,104,208,189,103,206,129,31,62,124,248,237,199,147,59,118,236,197,151,51,102,204,133,23,46,92,184,109,218,169,79,158,33,66,132,21,42,84,168,77,154,41,82,164,85,170,73,146,57,114,228,213,183,115,230,209,191,99,198,145,63,126,252,229,215,179,123,246,241,255,227,219,171,75,150,49,98,196,149,55,110,220,165,87,174,65,130,25,50,100,200,141,7,14,28,56,112,224,221,167,83,166,81,162,89,178,121,242,249,239,195,155,43,86,172,69,138,9,18,36,72,144,61,122,244,245,247,243,251,235,203,139,11,22,44,88,176,125,250,233,207,131,27,54,108,216,173,71,142,1,2,4,8,16,32,64,128,29,58,116,232,205,135,19,38,76,152,45,90,180,117,234,201,143,3,6,12,24,48,96,192,157,39,78,156,37,74,148,53,106,212,181,119,238,193,159,35,70,140,5,10,20,40,80,160,93,186,105,210,185,111,222,161,95,190,97,194,153,47,94,188,101,202,137,15,30,60,120,240,253,231,211,187,107,214,177,127,254,225,223,163,91,182,113,226,217,175,67,134,17,34,68,136,13,26,52,104,208,189,103,206,129,31,62,124,248,237,199,147,59,118,236,197,151,51,102,204,133,23,46,92,184,109,218,169,79,158,33,66,132,21,42,84,168,77,154,41,82,164,85,170,73,146,57,114,228,213,183,115,230,209,191,99,198,145,63,126,252,229,215,179,123,246,241,255,227,219,171,75,150,49,98,196,149,55,110,220,165,87,174,65,130,25,50,100,200,141,7,14,28,56,112,224,221,167,83,166,81,162,89,178,121,242,249,239,195,155,43,86,172,69,138,9,18,36,72,144,61,122,244,245,247,243,251,235,203,139,11,22,44,88,176,125,250,233,207,131,27,54,108,216,173,71,142,1,0};
__constant__ uint32_t GfLog_cuda[EC_GF_SIZE << 1] = {256,255,1,25,2,50,26,198,3,223,51,238,27,104,199,75,4,100,224,14,52,141,239,129,28,193,105,248,200,8,76,113,5,138,101,47,225,36,15,33,53,147,142,218,240,18,130,69,29,181,194,125,106,39,249,185,201,154,9,120,77,228,114,166,6,191,139,98,102,221,48,253,226,152,37,179,16,145,34,136,54,208,148,206,143,150,219,189,241,210,19,92,131,56,70,64,30,66,182,163,195,72,126,110,107,58,40,84,250,133,186,61,202,94,155,159,10,21,121,43,78,212,229,172,115,243,167,87,7,112,192,247,140,128,99,13,103,74,222,237,49,197,254,24,227,165,153,119,38,184,180,124,17,68,146,217,35,32,137,46,55,63,209,91,149,188,207,205,144,135,151,178,220,252,190,97,242,86,211,171,20,42,93,158,132,60,57,83,71,109,65,162,31,45,67,216,183,123,164,118,196,23,73,236,127,12,111,246,108,161,59,82,41,157,85,170,251,96,134,177,187,204,62,90,203,89,95,176,156,169,160,81,11,245,22,235,122,117,44,215,79,174,213,233,230,231,173,232,116,214,244,234,168,80,88,175,255,1,25,2,50,26,198,3,223,51,238,27,104,199,75,4,100,224,14,52,141,239,129,28,193,105,248,200,8,76,113,5,138,101,47,225,36,15,33,53,147,142,218,240,18,130,69,29,181,194,125,106,39,249,185,201,154,9,120,77,228,114,166,6,191,139,98,102,221,48,253,226,152,37,179,16,145,34,136,54,208,148,206,143,150,219,189,241,210,19,92,131,56,70,64,30,66,182,163,195,72,126,110,107,58,40,84,250,133,186,61,202,94,155,159,10,21,121,43,78,212,229,172,115,243,167,87,7,112,192,247,140,128,99,13,103,74,222,237,49,197,254,24,227,165,153,119,38,184,180,124,17,68,146,217,35,32,137,46,55,63,209,91,149,188,207,205,144,135,151,178,220,252,190,97,242,86,211,171,20,42,93,158,132,60,57,83,71,109,65,162,31,45,67,216,183,123,164,118,196,23,73,236,127,12,111,246,108,161,59,82,41,157,85,170,251,96,134,177,187,204,62,90,203,89,95,176,156,169,160,81,11,245,22,235,122,117,44,215,79,174,213,233,230,231,173,232,116,214,244,234,168,80,88,175,0};

uint32_t GfPow[EC_GF_SIZE << 1]={1,2,4,8,16,32,64,128,29,58,116,232,205,135,19,38,76,152,45,90,180,117,234,201,143,3,6,12,24,48,96,192,157,39,78,156,37,74,148,53,106,212,181,119,238,193,159,35,70,140,5,10,20,40,80,160,93,186,105,210,185,111,222,161,95,190,97,194,153,47,94,188,101,202,137,15,30,60,120,240,253,231,211,187,107,214,177,127,254,225,223,163,91,182,113,226,217,175,67,134,17,34,68,136,13,26,52,104,208,189,103,206,129,31,62,124,248,237,199,147,59,118,236,197,151,51,102,204,133,23,46,92,184,109,218,169,79,158,33,66,132,21,42,84,168,77,154,41,82,164,85,170,73,146,57,114,228,213,183,115,230,209,191,99,198,145,63,126,252,229,215,179,123,246,241,255,227,219,171,75,150,49,98,196,149,55,110,220,165,87,174,65,130,25,50,100,200,141,7,14,28,56,112,224,221,167,83,166,81,162,89,178,121,242,249,239,195,155,43,86,172,69,138,9,18,36,72,144,61,122,244,245,247,243,251,235,203,139,11,22,44,88,176,125,250,233,207,131,27,54,108,216,173,71,142,1,2,4,8,16,32,64,128,29,58,116,232,205,135,19,38,76,152,45,90,180,117,234,201,143,3,6,12,24,48,96,192,157,39,78,156,37,74,148,53,106,212,181,119,238,193,159,35,70,140,5,10,20,40,80,160,93,186,105,210,185,111,222,161,95,190,97,194,153,47,94,188,101,202,137,15,30,60,120,240,253,231,211,187,107,214,177,127,254,225,223,163,91,182,113,226,217,175,67,134,17,34,68,136,13,26,52,104,208,189,103,206,129,31,62,124,248,237,199,147,59,118,236,197,151,51,102,204,133,23,46,92,184,109,218,169,79,158,33,66,132,21,42,84,168,77,154,41,82,164,85,170,73,146,57,114,228,213,183,115,230,209,191,99,198,145,63,126,252,229,215,179,123,246,241,255,227,219,171,75,150,49,98,196,149,55,110,220,165,87,174,65,130,25,50,100,200,141,7,14,28,56,112,224,221,167,83,166,81,162,89,178,121,242,249,239,195,155,43,86,172,69,138,9,18,36,72,144,61,122,244,245,247,243,251,235,203,139,11,22,44,88,176,125,250,233,207,131,27,54,108,216,173,71,142,1,0};
uint32_t GfLog[EC_GF_SIZE << 1] = {256,255,1,25,2,50,26,198,3,223,51,238,27,104,199,75,4,100,224,14,52,141,239,129,28,193,105,248,200,8,76,113,5,138,101,47,225,36,15,33,53,147,142,218,240,18,130,69,29,181,194,125,106,39,249,185,201,154,9,120,77,228,114,166,6,191,139,98,102,221,48,253,226,152,37,179,16,145,34,136,54,208,148,206,143,150,219,189,241,210,19,92,131,56,70,64,30,66,182,163,195,72,126,110,107,58,40,84,250,133,186,61,202,94,155,159,10,21,121,43,78,212,229,172,115,243,167,87,7,112,192,247,140,128,99,13,103,74,222,237,49,197,254,24,227,165,153,119,38,184,180,124,17,68,146,217,35,32,137,46,55,63,209,91,149,188,207,205,144,135,151,178,220,252,190,97,242,86,211,171,20,42,93,158,132,60,57,83,71,109,65,162,31,45,67,216,183,123,164,118,196,23,73,236,127,12,111,246,108,161,59,82,41,157,85,170,251,96,134,177,187,204,62,90,203,89,95,176,156,169,160,81,11,245,22,235,122,117,44,215,79,174,213,233,230,231,173,232,116,214,244,234,168,80,88,175,255,1,25,2,50,26,198,3,223,51,238,27,104,199,75,4,100,224,14,52,141,239,129,28,193,105,248,200,8,76,113,5,138,101,47,225,36,15,33,53,147,142,218,240,18,130,69,29,181,194,125,106,39,249,185,201,154,9,120,77,228,114,166,6,191,139,98,102,221,48,253,226,152,37,179,16,145,34,136,54,208,148,206,143,150,219,189,241,210,19,92,131,56,70,64,30,66,182,163,195,72,126,110,107,58,40,84,250,133,186,61,202,94,155,159,10,21,121,43,78,212,229,172,115,243,167,87,7,112,192,247,140,128,99,13,103,74,222,237,49,197,254,24,227,165,153,119,38,184,180,124,17,68,146,217,35,32,137,46,55,63,209,91,149,188,207,205,144,135,151,178,220,252,190,97,242,86,211,171,20,42,93,158,132,60,57,83,71,109,65,162,31,45,67,216,183,123,164,118,196,23,73,236,127,12,111,246,108,161,59,82,41,157,85,170,251,96,134,177,187,204,62,90,203,89,95,176,156,169,160,81,11,245,22,235,122,117,44,215,79,174,213,233,230,231,173,232,116,214,244,234,168,80,88,175,0};

static uint32_t ec_method_mul(uint32_t a, uint32_t b)
{
    if (a && b)
    {
        return GfPow[GfLog[a] + GfLog[b]];
    }

    return 0;
}

__device__ static uint32_t ec_method_div_cuda(uint32_t a, uint32_t b)
{
    if (b)
    {
        if (a)
        {
            return GfPow_cuda[EC_GF_SIZE - 1 + GfLog_cuda[a] - GfLog_cuda[b]];
        }
        return 0;
    }
    return EC_GF_SIZE;
}
static uint32_t ec_method_div(uint32_t a, uint32_t b)
{
    if (b)
    {
        if (a)
        {
            return GfPow[EC_GF_SIZE - 1 + GfLog[a] - GfLog[b]];
        }
        return 0;
    }
    return EC_GF_SIZE;
}

__global__ void ec_method_encode_kernel(uint32_t columns,uint32_t row,uint8_t* cuda_in,uint8_t *cuda_out,size_t total_trunk)
{
    uint32_t i;
    int trunk_id =(blockIdx.x * blockDim.x + threadIdx.x);
    if(trunk_id>=total_trunk)
        return;

    cuda_out += trunk_id*EC_METHOD_CHUNK_SIZE;
    cuda_in += trunk_id * columns * EC_METHOD_CHUNK_SIZE;

    ec_gf_muladd(0,cuda_out, cuda_in, EC_METHOD_WIDTH);
    cuda_in += EC_METHOD_CHUNK_SIZE;
    for (i = 1; i < columns; i++)
    {
        ec_gf_muladd(row,cuda_out,cuda_in, EC_METHOD_WIDTH);
        cuda_in += EC_METHOD_CHUNK_SIZE;
    }

}

size_t ec_method_encode(size_t size, uint32_t columns, uint32_t row,
                        uint8_t * in, uint8_t * out)
{
    
    uint32_t trunk = size /(EC_METHOD_CHUNK_SIZE * columns);
    uint8_t* cuda_in,*cuda_out;
    cudaMalloc(&cuda_in,size);
    cudaMalloc(&cuda_out,size/columns);

    cudaMemcpy(cuda_in,in,size,cudaMemcpyHostToDevice);

    int threadsPerBlock = 4;
    int blocksPerGrid = (trunk + threadsPerBlock - 1) / threadsPerBlock;

    ec_method_encode_kernel<<<blocksPerGrid,threadsPerBlock>>>(columns,row+1,cuda_in,cuda_out,trunk);
    //cudaDeviceSynchronize();
    cudaMemcpy(out,cuda_out,size/columns,cudaMemcpyDeviceToHost);

    cudaFree(cuda_in);
    cudaFree(cuda_out);
    
    return size * EC_METHOD_CHUNK_SIZE;
}

void ec_method_test(){
    printf("Test\n");
}


__global__ void ec_method_decode_kernel(uint32_t columns,uint8_t * in,uint8_t *out,uint8_t *dummy,uint8_t *inv,size_t total_trunk)
{
    uint32_t i,j,last,value,tmp;
    int trunk_id = (blockIdx.x * blockDim.x + threadIdx.x);
    uint32_t inv_stride = EC_METHOD_MAX_FRAGMENTS+1;
    uint32_t in_stride = total_trunk*EC_METHOD_CHUNK_SIZE;
    if(trunk_id>=total_trunk)
        return;
    out+=trunk_id * EC_METHOD_CHUNK_SIZE *columns;

    for(i = 0;i<columns;i++)
    {
        last=0;
        j=0;
        do
        {
            while(j<columns && inv[i*inv_stride+j] == 0)
                j++;
            if(j<columns){
            	tmp = inv[i*inv_stride+j];
            	value = ec_method_div_cuda(last,tmp);
                last = tmp;
                ec_gf_muladd(value,out,in+j*in_stride+trunk_id*EC_METHOD_CHUNK_SIZE,EC_METHOD_WIDTH);
                j++;
            }
        }while(j<columns);
        ec_gf_muladd(last,out,dummy,EC_METHOD_WIDTH);
        out+=EC_METHOD_CHUNK_SIZE;
    }


}

size_t ec_method_decode(size_t size, uint32_t columns, uint32_t * rows,
                        uint8_t ** in, uint8_t * out)
{
    uint32_t i, j, k;
    uint32_t f;
    uint8_t **inv;
    uint8_t **mtx;
    uint8_t *dummy,*in_ptr;
    size /= EC_METHOD_CHUNK_SIZE;

    //Use some tricks to allocate 2-d array which is cache-friendly.
    inv = (uint8_t **)malloc(sizeof(uint8_t *) *EC_METHOD_MAX_FRAGMENTS);
    mtx = (uint8_t **)malloc(sizeof(uint8_t *) *EC_METHOD_MAX_FRAGMENTS);
    dummy =(uint8_t *)malloc(EC_METHOD_CHUNK_SIZE * sizeof(uint8_t));

    inv[0] = (uint8_t *)malloc((EC_METHOD_MAX_FRAGMENTS + 1)*EC_METHOD_MAX_FRAGMENTS * sizeof(uint8_t));
    mtx[0] = (uint8_t *)malloc(EC_METHOD_MAX_FRAGMENTS*EC_METHOD_MAX_FRAGMENTS * sizeof(uint8_t ));
    in_ptr = (uint8_t *)malloc(size* EC_METHOD_CHUNK_SIZE * columns);

    for(i=0;i<columns;i++)
    	memcpy(in_ptr+EC_METHOD_CHUNK_SIZE*size*i,in[i],EC_METHOD_CHUNK_SIZE*size);

    for(i=0;i<EC_METHOD_MAX_FRAGMENTS;i++)
        inv[i] = (*inv + (EC_METHOD_MAX_FRAGMENTS+1) * i),mtx[i]=(*mtx + EC_METHOD_MAX_FRAGMENTS * i);


    for(i=0;i<EC_METHOD_MAX_FRAGMENTS;i++){
        for(j=0;j<EC_METHOD_MAX_FRAGMENTS;j++)
            inv[i][j]=mtx[i][j]=0;
        inv[i][EC_METHOD_MAX_FRAGMENTS] = 0;
    }
    for(i=0;i<EC_METHOD_CHUNK_SIZE;i++)
        dummy[i]=0;

    for (i = 0; i < columns; i++)
    {
        inv[i][i] = 1;
        inv[i][columns] = 1;
    }
    for (i = 0; i < columns; i++)
    {
        mtx[i][columns - 1] = 1;
        for (j = columns - 1; j > 0; j--)
        {
            mtx[i][j - 1] = ec_method_mul(mtx[i][j], rows[i] + 1);
        }
    }

    for (i = 0; i < columns; i++)
    {
        f = mtx[i][i];
        for (j = 0; j < columns; j++)
        {
            mtx[i][j] = ec_method_div(mtx[i][j], f);
            inv[i][j] = ec_method_div(inv[i][j], f);
        }
        for (j = 0; j < columns; j++)
        {
            if (i != j)
            {
                f = mtx[j][i];
                for (k = 0; k < columns; k++)
                {
                    mtx[j][k] ^= ec_method_mul(mtx[i][k], f);
                    inv[j][k] ^= ec_method_mul(inv[i][k], f);
                }
            }
        }
    }
    
    uint8_t *cuda_in,*cuda_out,*cuda_dummy,*cuda_inv;


    cudaMalloc(&cuda_in,sizeof(uint8_t )*columns*size*EC_METHOD_CHUNK_SIZE);
    cudaMalloc(&cuda_out,size * EC_METHOD_CHUNK_SIZE * columns * sizeof(uint8_t));
    cudaMalloc(&cuda_dummy,EC_METHOD_CHUNK_SIZE * sizeof(uint8_t));
    cudaMalloc(&cuda_inv,sizeof(uint8_t) * EC_METHOD_MAX_FRAGMENTS *(EC_METHOD_MAX_FRAGMENTS+1));


    cudaMemcpy(cuda_in,in_ptr,sizeof(uint8_t )*columns*size*EC_METHOD_CHUNK_SIZE,cudaMemcpyHostToDevice);
    cudaMemcpy(cuda_dummy,dummy,EC_METHOD_CHUNK_SIZE * sizeof(uint8_t),cudaMemcpyHostToDevice);
    cudaMemcpy(cuda_inv,*inv,sizeof(uint8_t) * EC_METHOD_MAX_FRAGMENTS *(EC_METHOD_MAX_FRAGMENTS+1),cudaMemcpyHostToDevice);

    printf("Begin to decode\n");
	int threadsPerBlock = 4;
    int blocksPerGrid = (size + threadsPerBlock - 1) / threadsPerBlock;
    ec_method_decode_kernel<<<blocksPerGrid,threadsPerBlock>>>(columns,cuda_in,cuda_out,cuda_dummy,cuda_inv,size);
    //ec_method_test_kernel<<<blocksPerGrid,threadsPerBlock>>>(cuda_out);
    //cudaDeviceSynchronize();
    cudaMemcpy(out,cuda_out,size * EC_METHOD_CHUNK_SIZE * columns * sizeof(uint8_t),cudaMemcpyDeviceToHost);


    cudaFree(cuda_in);
    cudaFree(cuda_out);
    cudaFree(cuda_dummy);
    cudaFree(cuda_inv);

    free(dummy);
    free(inv[0]);
    free(mtx[0]);
    free(inv);
    free(mtx);

    return size * EC_METHOD_CHUNK_SIZE * columns;
}




