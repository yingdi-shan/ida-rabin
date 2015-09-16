/*
  Copyright (c) 2012-2014 DataLab, s.l. <http://www.datalab.es>
  This file is part of GlusterFS.

  This file is licensed to you under your choice of the GNU Lesser
  General Public License, version 3 or any later version (LGPLv3 or
  later), or the GNU General Public License, version 2 (GPLv2), in all
  cases as published by the Free Software Foundation.
*/

#include "ec-gf.h"
#include <inttypes.h>
#include <string.h>

__device__ void gf8_muladd_00(uint8_t * out, uint8_t * in, unsigned int width)
{
	memcpy(out,in,sizeof(uint64_t) *8 * width);
}

__device__ void gf8_muladd_01(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        out_ptr[0] ^= in_ptr[0];
        out_ptr[width] ^= in_ptr[width];
        out_ptr[width * 2] ^= in_ptr[width * 2];
        out_ptr[width * 3] ^= in_ptr[width * 3];
        out_ptr[width * 4] ^= in_ptr[width * 4];
        out_ptr[width * 5] ^= in_ptr[width * 5];
        out_ptr[width * 6] ^= in_ptr[width * 6];
        out_ptr[width * 7] ^= in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_02(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out0 = in7;
        out1 = in0;
        out7 = in6;
        out5 = in4;
        out6 = in5;
        out3 = in2 ^ in7;
        out4 = in3 ^ in7;
        out2 = in1 ^ in7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_03(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out0 = in0 ^ in7;
        tmp0 = in2 ^ in7;
        out1 = in0 ^ in1;
        out7 = in6 ^ in7;
        out5 = in4 ^ in5;
        out6 = in5 ^ in6;
        out4 = in3 ^ in4 ^ in7;
        out2 = tmp0 ^ in1;
        out3 = tmp0 ^ in3;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_04(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out0 = in6;
        out1 = in7;
        out7 = in5;
        out6 = in4;
        tmp0 = in6 ^ in7;
        out2 = in0 ^ in6;
        out5 = in3 ^ in7;
        out3 = tmp0 ^ in1;
        out4 = tmp0 ^ in2;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}
__device__ void gf8_muladd_05(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out0 = in0 ^ in6;
        out1 = in1 ^ in7;
        out7 = in5 ^ in7;
        out6 = in4 ^ in6;
        out2 = out0 ^ in2;
        out3 = out1 ^ in3 ^ in6;
        out5 = out7 ^ in3;
        out4 = out6 ^ in2 ^ in7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_06(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out0 = in6 ^ in7;
        tmp0 = in1 ^ in6;
        out1 = in0 ^ in7;
        out7 = in5 ^ in6;
        out6 = in4 ^ in5;
        out4 = in2 ^ in3 ^ in6;
        out5 = in3 ^ in4 ^ in7;
        out3 = tmp0 ^ in2;
        out2 = tmp0 ^ out1;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_07(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in2 ^ in6;
        tmp1 = in5 ^ in6;
        tmp2 = in0 ^ in7;
        tmp3 = tmp0 ^ in3;
        out6 = tmp1 ^ in4;
        out7 = tmp1 ^ in7;
        out0 = tmp2 ^ in6;
        out1 = tmp2 ^ in1;
        out3 = tmp3 ^ in1;
        out4 = tmp3 ^ in4;
        out5 = out4 ^ out7 ^ in2;
        out2 = tmp0 ^ out1;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_08(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out0 = in5;
        out1 = in6;
        out7 = in4;
        out6 = in3 ^ in7;
        out3 = in0 ^ in5 ^ in6;
        out5 = in2 ^ in6 ^ in7;
        out2 = in5 ^ in7;
        out4 = out2 ^ in1 ^ in6;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_09(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out0 = in0 ^ in5;
        tmp0 = in3 ^ in6;
        out1 = in1 ^ in6;
        out7 = in4 ^ in7;
        out2 = in2 ^ in5 ^ in7;
        out3 = tmp0 ^ out0;
        out6 = tmp0 ^ in7;
        out4 = out1 ^ out7 ^ in5;
        out5 = out2 ^ in6;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_0A(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out0 = in5 ^ in7;
        out1 = in0 ^ in6;
        out7 = in4 ^ in6;
        out2 = in1 ^ in5;
        out6 = out0 ^ in3;
        out3 = out0 ^ out1 ^ in2;
        out5 = out7 ^ in2 ^ in7;
        out4 = out2 ^ in3 ^ in6;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_0B(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in2 ^ in5;
        tmp1 = in0 ^ in6;
        tmp2 = in4 ^ in7;
        out0 = in0 ^ in5 ^ in7;
        out2 = tmp0 ^ in1;
        out1 = tmp1 ^ in1;
        out6 = tmp1 ^ out0 ^ in3;
        out7 = tmp2 ^ in6;
        out4 = tmp2 ^ out6 ^ in1;
        out3 = out6 ^ in0 ^ in2;
        out5 = tmp0 ^ out7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_0C(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out0 = in5 ^ in6;
        out1 = in6 ^ in7;
        out7 = in4 ^ in5;
        tmp0 = in1 ^ in5;
        tmp1 = in0 ^ in7;
        out5 = in2 ^ in3 ^ in6;
        out6 = in3 ^ in4 ^ in7;
        out2 = tmp1 ^ out0;
        out4 = tmp0 ^ in2;
        out3 = tmp0 ^ tmp1;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_0D(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in4 ^ in5;
        tmp1 = in5 ^ in6;
        out1 = in1 ^ in6 ^ in7;
        out7 = tmp0 ^ in7;
        out4 = tmp0 ^ in1 ^ in2;
        out0 = tmp1 ^ in0;
        tmp2 = tmp1 ^ in3;
        out6 = tmp2 ^ out7;
        out2 = out0 ^ in2 ^ in7;
        out3 = out0 ^ out1 ^ in3;
        out5 = tmp2 ^ in2;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_0E(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in1;
        tmp1 = in2 ^ in5;
        tmp2 = in5 ^ in6;
        out1 = in0 ^ in6 ^ in7;
        out3 = tmp0 ^ tmp1;
        out2 = tmp0 ^ tmp2;
        tmp3 = tmp1 ^ in3;
        out7 = tmp2 ^ in4;
        out0 = tmp2 ^ in7;
        out4 = tmp3 ^ in1 ^ in7;
        out5 = tmp3 ^ out7;
        out6 = out0 ^ out5 ^ in2;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_0F(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in6 ^ in7;
        tmp1 = tmp0 ^ in1;
        tmp2 = tmp0 ^ in5;
        out1 = tmp1 ^ in0;
        out7 = tmp2 ^ in4;
        out0 = tmp2 ^ in0;
        out6 = out7 ^ in3;
        out5 = out6 ^ in2 ^ in7;
        tmp3 = tmp1 ^ out0 ^ in2;
        out4 = tmp1 ^ out5;
        out2 = tmp3 ^ in6;
        out3 = tmp3 ^ in3;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_10(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out0 = in4;
        out1 = in5;
        out7 = in3 ^ in7;
        tmp0 = in6 ^ in7;
        out2 = in4 ^ in6;
        tmp1 = out2 ^ in5;
        out6 = tmp0 ^ in2;
        out3 = tmp0 ^ tmp1;
        out5 = out2 ^ out3 ^ in1;
        out4 = tmp1 ^ in0;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_11(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out7 = in3;
        out0 = in0 ^ in4;
        out1 = in1 ^ in5;
        out6 = in2 ^ in7;
        out4 = in0 ^ in5 ^ in6;
        out5 = in1 ^ in6 ^ in7;
        out2 = in2 ^ in4 ^ in6;
        out3 = in3 ^ in4 ^ in5 ^ in7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_12(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out0 = in4 ^ in7;
        out1 = in0 ^ in5;
        out3 = in2 ^ in4 ^ in5;
        tmp0 = out0 ^ in6;
        out2 = tmp0 ^ in1;
        tmp1 = tmp0 ^ in3;
        out6 = tmp0 ^ out3;
        out5 = out2 ^ in5;
        out7 = tmp1 ^ in4;
        out4 = tmp1 ^ out1;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_13(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out7 = in3 ^ in6;
        tmp0 = in0 ^ in5;
        tmp1 = in4 ^ in7;
        out6 = in2 ^ in5 ^ in7;
        out4 = tmp0 ^ out7 ^ in7;
        out1 = tmp0 ^ in1;
        out0 = tmp1 ^ in0;
        out5 = tmp1 ^ in1 ^ in6;
        out3 = tmp1 ^ out6 ^ in3;
        out2 = out5 ^ in2;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_14(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out0 = in4 ^ in6;
        out1 = in5 ^ in7;
        out2 = in0 ^ in4;
        tmp0 = out0 ^ in5;
        out7 = out1 ^ in3;
        tmp1 = out1 ^ in2;
        out3 = tmp0 ^ in1;
        out6 = tmp0 ^ tmp1;
        out4 = tmp1 ^ out2;
        out5 = out3 ^ in3 ^ in4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_15(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out7 = in3 ^ in5;
        tmp0 = in0 ^ in4;
        out1 = in1 ^ in5 ^ in7;
        out5 = in1 ^ in3 ^ in6;
        out0 = tmp0 ^ in6;
        out2 = tmp0 ^ in2;
        out3 = out5 ^ in4 ^ in5;
        out6 = out2 ^ in0 ^ in7;
        out4 = tmp0 ^ out6 ^ in5;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_16(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in5;
        tmp1 = in4 ^ in7;
        tmp2 = in2 ^ in3 ^ in4;
        out1 = tmp0 ^ in7;
        out4 = tmp0 ^ tmp2;
        out0 = tmp1 ^ in6;
        tmp3 = tmp1 ^ in1;
        out6 = out0 ^ in2 ^ in5;
        out2 = tmp3 ^ in0;
        out3 = out6 ^ in1;
        out7 = tmp2 ^ out6;
        out5 = tmp3 ^ out7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_17(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in2 ^ in5;
        tmp1 = in3 ^ in6;
        tmp2 = tmp0 ^ in4;
        out4 = tmp0 ^ in0 ^ in3;
        out7 = tmp1 ^ in5;
        tmp3 = tmp1 ^ in1;
        out6 = tmp2 ^ in7;
        out5 = tmp3 ^ in4;
        out3 = tmp3 ^ out6;
        out0 = out3 ^ out4 ^ in1;
        out2 = out3 ^ out7 ^ in0;
        out1 = tmp2 ^ out2;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_18(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out0 = in4 ^ in5;
        out1 = in5 ^ in6;
        tmp0 = in4 ^ in7;
        out5 = in1 ^ in2 ^ in5;
        out6 = in2 ^ in3 ^ in6;
        out2 = tmp0 ^ out1;
        out7 = tmp0 ^ in3;
        tmp1 = tmp0 ^ in0;
        out3 = tmp1 ^ in6;
        out4 = tmp1 ^ in1;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_19(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out5 = in1 ^ in2;
        out7 = in3 ^ in4;
        tmp0 = in0 ^ in7;
        out6 = in2 ^ in3;
        out1 = in1 ^ in5 ^ in6;
        out0 = in0 ^ in4 ^ in5;
        out4 = tmp0 ^ in1;
        tmp1 = tmp0 ^ in6;
        out2 = tmp1 ^ out0 ^ in2;
        out3 = tmp1 ^ out7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_1A(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in4 ^ in5;
        tmp1 = in5 ^ in6;
        tmp2 = tmp0 ^ in1;
        out0 = tmp0 ^ in7;
        out1 = tmp1 ^ in0;
        tmp3 = tmp1 ^ in3;
        out5 = tmp2 ^ in2;
        out2 = tmp2 ^ in6;
        out7 = tmp3 ^ out0;
        out6 = tmp3 ^ in2;
        out4 = tmp3 ^ out2 ^ in0;
        out3 = tmp0 ^ out1 ^ in2;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_1B(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3, tmp4;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in2 ^ in4;
        tmp1 = in2 ^ in5;
        tmp2 = in3 ^ in6;
        out5 = tmp0 ^ in1;
        tmp3 = tmp0 ^ in0;
        out6 = tmp1 ^ in3;
        out0 = tmp1 ^ tmp3 ^ in7;
        out7 = tmp2 ^ in4;
        tmp4 = out5 ^ in6;
        out3 = tmp2 ^ tmp3;
        out2 = tmp4 ^ in5;
        out4 = tmp4 ^ out3;
        out1 = tmp3 ^ out2;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_1C(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3, tmp4;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in2 ^ in3;
        tmp1 = in4 ^ in6;
        tmp2 = in5 ^ in7;
        out6 = tmp0 ^ tmp1;
        out0 = tmp1 ^ in5;
        out1 = tmp2 ^ in6;
        tmp3 = tmp2 ^ in1;
        tmp4 = tmp2 ^ in4;
        out2 = tmp4 ^ in0;
        out7 = tmp4 ^ in3;
        out5 = tmp0 ^ tmp3;
        out3 = tmp3 ^ out2;
        out4 = out3 ^ in2 ^ in6;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_1D(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3, tmp4;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in1 ^ in3;
        tmp1 = in0 ^ in4;
        tmp2 = in3 ^ in4;
        tmp3 = in2 ^ in7;
        out3 = tmp0 ^ tmp1;
        out5 = tmp0 ^ tmp3;
        tmp4 = tmp1 ^ in5;
        out6 = tmp2 ^ in2;
        out7 = tmp2 ^ in5;
        out2 = tmp3 ^ tmp4;
        out4 = out3 ^ out6 ^ in6;
        out0 = tmp4 ^ in6;
        out1 = out2 ^ out4 ^ in4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_1E(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in4;
        tmp1 = in2 ^ in7;
        tmp2 = tmp0 ^ in1;
        out3 = tmp1 ^ tmp2;
        out2 = tmp2 ^ in5;
        out4 = out3 ^ in3 ^ in6;
        tmp3 = out4 ^ in7;
        out6 = tmp3 ^ out2 ^ in4;
        out7 = tmp1 ^ out6;
        out0 = out7 ^ in3;
        out1 = tmp0 ^ out0;
        out5 = tmp3 ^ out1;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_1F(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in4 ^ in6;
        tmp1 = tmp0 ^ in5;
        out7 = tmp1 ^ in3;
        out0 = tmp1 ^ in0 ^ in7;
        out6 = out7 ^ in2 ^ in6;
        out1 = out0 ^ in1 ^ in4;
        out4 = out0 ^ out6 ^ in1;
        out3 = tmp0 ^ out4;
        out2 = out4 ^ out7 ^ in7;
        out5 = out3 ^ in0;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_20(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out1 = in4;
        out0 = in3 ^ in7;
        tmp0 = in3 ^ in4;
        tmp1 = in6 ^ in7;
        out2 = out0 ^ in5;
        out4 = tmp0 ^ in5;
        out3 = tmp0 ^ tmp1;
        out7 = tmp1 ^ in2;
        out6 = tmp1 ^ in1 ^ in5;
        out5 = out2 ^ out3 ^ in0;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_21(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out1 = in1 ^ in4;
        tmp0 = in4 ^ in6;
        out4 = in3 ^ in5;
        out7 = in2 ^ in6;
        out0 = in0 ^ in3 ^ in7;
        out6 = in1 ^ in5 ^ in7;
        out3 = tmp0 ^ in7;
        out5 = tmp0 ^ in0;
        out2 = out4 ^ in2 ^ in7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_22(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out0 = in3;
        out1 = in0 ^ in4;
        out7 = in2 ^ in7;
        out4 = in4 ^ in5 ^ in7;
        out5 = in0 ^ in5 ^ in6;
        out6 = in1 ^ in6 ^ in7;
        out3 = in2 ^ in3 ^ in4 ^ in6;
        out2 = in1 ^ in3 ^ in5;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_23(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out7 = in2;
        out0 = in0 ^ in3;
        out4 = in5 ^ in7;
        out5 = in0 ^ in6;
        out6 = in1 ^ in7;
        out3 = in2 ^ in4 ^ in6;
        out1 = in0 ^ in1 ^ in4;
        out2 = out4 ^ out6 ^ in2 ^ in3;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_24(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out1 = in4 ^ in7;
        tmp0 = in3 ^ in4;
        out0 = in3 ^ in6 ^ in7;
        out3 = tmp0 ^ in1;
        tmp1 = out0 ^ in5;
        out6 = tmp1 ^ out3;
        out2 = tmp1 ^ in0;
        out7 = tmp1 ^ in2 ^ in3;
        out5 = out2 ^ in4;
        out4 = tmp0 ^ out7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_25(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out3 = in1 ^ in4;
        tmp0 = in2 ^ in5;
        out1 = out3 ^ in7;
        out7 = tmp0 ^ in6;
        out6 = out1 ^ in5;
        out4 = out7 ^ in3 ^ in7;
        out2 = out4 ^ in0;
        out0 = tmp0 ^ out2;
        out5 = out0 ^ in4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_26(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out0 = in3 ^ in6;
        tmp0 = in4 ^ in7;
        out7 = in2 ^ in5 ^ in7;
        tmp1 = out0 ^ in0 ^ in5;
        out1 = tmp0 ^ in0;
        tmp2 = tmp0 ^ in6;
        out2 = tmp1 ^ in1;
        out5 = tmp1 ^ in7;
        out6 = tmp2 ^ in1;
        out4 = tmp2 ^ out7;
        out3 = out0 ^ out6 ^ in2;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_27(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out7 = in2 ^ in5;
        out0 = in0 ^ in3 ^ in6;
        out6 = in1 ^ in4 ^ in7;
        out4 = out7 ^ in6;
        out2 = out0 ^ out7 ^ in1;
        out5 = out0 ^ in7;
        out1 = out6 ^ in0;
        out3 = out6 ^ in2;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_28(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out2 = in3;
        out1 = in4 ^ in6;
        out0 = in3 ^ in5 ^ in7;
        tmp0 = out1 ^ in7;
        tmp1 = out0 ^ in4;
        out7 = tmp0 ^ in2;
        tmp2 = tmp0 ^ in1;
        out3 = tmp1 ^ in0;
        out6 = tmp1 ^ tmp2;
        out4 = tmp2 ^ in3;
        out5 = out3 ^ in2 ^ in3;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_29(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out2 = in2 ^ in3;
        tmp0 = in1 ^ in3;
        tmp1 = in4 ^ in6;
        tmp2 = in0 ^ in4 ^ in7;
        out6 = tmp0 ^ in5;
        out4 = tmp0 ^ in6 ^ in7;
        out1 = tmp1 ^ in1;
        out7 = tmp1 ^ in2;
        out3 = tmp2 ^ in5;
        out5 = tmp2 ^ in2;
        out0 = out3 ^ in3 ^ in4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_2A(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out0 = in3 ^ in5;
        tmp0 = in1 ^ in3;
        tmp1 = in0 ^ in4;
        out7 = in2 ^ in4 ^ in7;
        out3 = tmp1 ^ out0 ^ in2;
        out2 = tmp0 ^ in7;
        out6 = tmp0 ^ in6;
        out1 = tmp1 ^ in6;
        out5 = tmp1 ^ out7 ^ in5;
        out4 = out1 ^ in0 ^ in1;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_2B(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out4 = in1 ^ in6;
        out7 = in2 ^ in4;
        tmp0 = in0 ^ in5;
        tmp1 = in2 ^ in7;
        out6 = in1 ^ in3;
        out1 = out4 ^ in0 ^ in4;
        out3 = tmp0 ^ out7;
        out0 = tmp0 ^ in3;
        out5 = tmp1 ^ in0;
        out2 = tmp1 ^ out6;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_2C(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in2 ^ in5;
        tmp1 = in2 ^ in3 ^ in4;
        tmp2 = tmp0 ^ in6;
        out4 = tmp1 ^ in1;
        out5 = tmp1 ^ in0 ^ in5;
        tmp3 = tmp2 ^ in4;
        out6 = tmp2 ^ out4;
        out7 = tmp3 ^ in7;
        out2 = tmp3 ^ out5;
        out3 = out6 ^ in0;
        out0 = tmp1 ^ out7;
        out1 = tmp0 ^ out7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_2D(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in2 ^ in3;
        out4 = tmp0 ^ in1;
        tmp1 = tmp0 ^ in0;
        out2 = tmp1 ^ in6;
        out5 = tmp1 ^ in4;
        tmp2 = out2 ^ in2;
        tmp3 = tmp2 ^ in5;
        out0 = tmp3 ^ in7;
        out7 = tmp3 ^ out5;
        out6 = out4 ^ out7 ^ in6;
        out3 = tmp2 ^ out6;
        out1 = out0 ^ out6 ^ in0;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_2E(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in4 ^ in7;
        out0 = in3 ^ in5 ^ in6;
        tmp1 = tmp0 ^ in0;
        tmp2 = tmp0 ^ in2;
        out1 = tmp1 ^ in6;
        out4 = tmp2 ^ in1;
        out7 = tmp2 ^ in5;
        out3 = out0 ^ out4 ^ in0;
        out2 = out3 ^ out7 ^ in7;
        out6 = tmp1 ^ out2;
        out5 = tmp1 ^ out7 ^ in3;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_2F(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in3;
        tmp1 = in2 ^ in5;
        out4 = in1 ^ in2 ^ in7;
        out6 = in1 ^ in3 ^ in4;
        out5 = tmp0 ^ in2;
        tmp2 = tmp0 ^ in6;
        out7 = tmp1 ^ in4;
        out0 = tmp2 ^ in5;
        out2 = tmp2 ^ out4;
        out1 = tmp2 ^ out6 ^ in7;
        out3 = tmp1 ^ out1;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_30(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out1 = in4 ^ in5;
        tmp0 = in3 ^ in6;
        tmp1 = in4 ^ in7;
        out6 = in1 ^ in2 ^ in5;
        out3 = tmp0 ^ in5;
        out4 = tmp0 ^ in0;
        out7 = tmp0 ^ in2;
        out0 = tmp1 ^ in3;
        out2 = tmp1 ^ out3;
        out5 = tmp1 ^ in0 ^ in1;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_31(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out3 = in5 ^ in6;
        tmp0 = in4 ^ in5;
        tmp1 = in0 ^ in3 ^ in4;
        tmp2 = out3 ^ in2;
        out1 = tmp0 ^ in1;
        out0 = tmp1 ^ in7;
        out4 = tmp1 ^ in6;
        out6 = tmp2 ^ in1;
        out2 = tmp2 ^ out0 ^ in0;
        out5 = out1 ^ in0 ^ in7;
        out7 = tmp0 ^ out2;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_32(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out0 = in3 ^ in4;
        out7 = in2 ^ in3;
        tmp0 = in5 ^ in6;
        tmp1 = in0 ^ in7;
        out6 = in1 ^ in2;
        out1 = in0 ^ in4 ^ in5;
        out2 = tmp0 ^ out0 ^ in1;
        out3 = tmp0 ^ out7 ^ in7;
        out4 = tmp1 ^ in6;
        out5 = tmp1 ^ in1;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_33(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3, tmp4;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in2 ^ in3;
        tmp1 = in0 ^ in4;
        tmp2 = in1 ^ in5;
        out6 = in1 ^ in2 ^ in6;
        out7 = tmp0 ^ in7;
        out0 = tmp1 ^ in3;
        out1 = tmp1 ^ tmp2;
        tmp3 = tmp2 ^ in7;
        tmp4 = tmp2 ^ in4 ^ in6;
        out5 = tmp3 ^ in0;
        out3 = tmp3 ^ out6;
        out4 = tmp4 ^ out5;
        out2 = tmp0 ^ tmp4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_34(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3, tmp4;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in3 ^ in4;
        tmp1 = in4 ^ in5;
        tmp2 = tmp0 ^ in1;
        tmp3 = tmp0 ^ in6;
        out1 = tmp1 ^ in7;
        tmp4 = tmp1 ^ in2;
        out5 = tmp2 ^ in0;
        out3 = tmp2 ^ out1;
        out0 = tmp3 ^ in7;
        out7 = tmp3 ^ tmp4;
        out6 = tmp4 ^ in1;
        out2 = out3 ^ out5 ^ in3;
        out4 = tmp4 ^ out2;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_35(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in2 ^ in6;
        tmp1 = in5 ^ in7;
        out7 = tmp0 ^ tmp1 ^ in3;
        out3 = tmp1 ^ in1;
        out1 = out3 ^ in4;
        tmp2 = out1 ^ in7;
        out5 = tmp2 ^ in0 ^ in3;
        out6 = tmp0 ^ tmp2;
        out0 = out3 ^ out5 ^ in6;
        out4 = tmp0 ^ out0;
        out2 = out4 ^ in5;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_36(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out4 = in0 ^ in2;
        tmp0 = in1 ^ in3;
        out0 = in3 ^ in4 ^ in6;
        out6 = in1 ^ in2 ^ in4;
        out5 = tmp0 ^ in0;
        tmp1 = out5 ^ in5;
        out2 = tmp1 ^ in4;
        out3 = tmp1 ^ out4;
        out1 = tmp0 ^ out2 ^ in7;
        out7 = out3 ^ in1;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_37(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in1 ^ in2;
        tmp1 = in2 ^ in4;
        tmp2 = tmp0 ^ in6;
        out3 = tmp0 ^ in5;
        out4 = tmp1 ^ in0;
        out6 = tmp2 ^ in4;
        out1 = out3 ^ out4 ^ in7;
        tmp3 = out4 ^ in1 ^ in3;
        out7 = tmp3 ^ out1;
        out2 = tmp3 ^ in5;
        out5 = tmp1 ^ out2;
        out0 = tmp2 ^ tmp3;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_38(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out3 = in0 ^ in3;
        tmp0 = in3 ^ in4;
        tmp1 = in5 ^ in7;
        tmp2 = out3 ^ in1;
        out2 = tmp0 ^ in6;
        out0 = tmp0 ^ tmp1;
        out4 = tmp1 ^ tmp2;
        out7 = out2 ^ in2;
        out1 = out2 ^ in3 ^ in5;
        out6 = out4 ^ in0 ^ in2;
        out5 = tmp2 ^ out7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_39(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out3 = in0;
        tmp0 = in1 ^ in5;
        tmp1 = tmp0 ^ in4;
        out1 = tmp1 ^ in6;
        out5 = out1 ^ in0 ^ in2;
        tmp2 = tmp0 ^ out5;
        out2 = tmp2 ^ in0 ^ in3;
        out7 = out2 ^ in7;
        out6 = tmp1 ^ out7;
        out4 = tmp2 ^ out6;
        out0 = out4 ^ in1;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_3A(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3, tmp4, tmp5;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in1;
        tmp1 = in0 ^ in2;
        tmp2 = in3 ^ in4;
        tmp3 = in1 ^ in6;
        tmp4 = in3 ^ in7;
        out4 = tmp0 ^ in5;
        out5 = tmp1 ^ tmp3;
        out3 = tmp1 ^ tmp4;
        out0 = tmp2 ^ in5;
        out7 = tmp2 ^ in2;
        tmp5 = tmp3 ^ in4;
        out2 = tmp4 ^ tmp5;
        out1 = tmp5 ^ out4;
        out6 = tmp0 ^ out3;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_3B(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in1 ^ in6;
        tmp1 = in2 ^ in7;
        tmp2 = tmp0 ^ in3;
        out3 = tmp1 ^ in0;
        out6 = tmp1 ^ tmp2;
        out2 = out6 ^ in4;
        out7 = tmp0 ^ out2;
        out0 = out3 ^ out7 ^ in5;
        out5 = out0 ^ out2 ^ in7;
        out1 = tmp2 ^ out0;
        out4 = out1 ^ in6;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_3C(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in3;
        tmp1 = in2 ^ in7;
        tmp2 = in1 ^ in6 ^ in7;
        out2 = tmp0 ^ in4;
        out3 = tmp0 ^ tmp2;
        out4 = tmp1 ^ out3 ^ in5;
        out5 = tmp2 ^ out2 ^ in2;
        out1 = out4 ^ out5 ^ in6;
        out0 = out1 ^ in3;
        out7 = tmp1 ^ out0;
        out6 = tmp2 ^ out7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_3D(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in2;
        tmp1 = tmp0 ^ in3;
        out2 = tmp1 ^ in4;
        tmp2 = out2 ^ in5;
        out4 = tmp2 ^ in1 ^ in6;
        out5 = out4 ^ in7;
        out6 = out5 ^ in0;
        out7 = out6 ^ in1;
        out0 = tmp0 ^ out7;
        out1 = tmp1 ^ out5;
        out3 = tmp2 ^ out6;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_3E(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in3 ^ in5;
        tmp1 = tmp0 ^ in4;
        out0 = tmp1 ^ in6;
        out7 = tmp1 ^ in2;
        out6 = out7 ^ in1 ^ in5 ^ in7;
        out2 = out6 ^ in0 ^ in2;
        out4 = out0 ^ out6 ^ in0;
        out5 = tmp0 ^ out4;
        out3 = out5 ^ in7;
        out1 = out3 ^ out6 ^ in5;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_3F(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in1;
        out3 = tmp0 ^ in2 ^ in6;
        tmp1 = out3 ^ in5 ^ in7;
        out4 = tmp1 ^ in4;
        out5 = tmp1 ^ in3;
        out1 = out4 ^ in2;
        out7 = out1 ^ out3 ^ in3;
        out2 = tmp0 ^ out7 ^ in5;
        tmp2 = out2 ^ in0;
        out6 = tmp2 ^ in6;
        out0 = tmp1 ^ tmp2;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_40(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out1 = in3 ^ in7;
        tmp0 = in3 ^ in4;
        tmp1 = in6 ^ in7;
        out4 = tmp0 ^ in2;
        out5 = tmp0 ^ in5;
        out0 = tmp1 ^ in2;
        out7 = tmp1 ^ in1 ^ in5;
        out2 = out0 ^ in4;
        out3 = out2 ^ out5 ^ in7;
        out6 = out3 ^ out4 ^ in0;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_41(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out4 = in2 ^ in3;
        tmp0 = in5 ^ in6;
        tmp1 = in6 ^ in7;
        out5 = in3 ^ in4;
        out1 = in1 ^ in3 ^ in7;
        out6 = in0 ^ in4 ^ in5;
        out3 = tmp0 ^ in2;
        out7 = tmp0 ^ in1;
        out2 = tmp1 ^ in4;
        out0 = tmp1 ^ in0 ^ in2;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_42(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out0 = in2 ^ in6;
        out5 = in3 ^ in5;
        out1 = in0 ^ in3 ^ in7;
        out7 = in1 ^ in5 ^ in7;
        out4 = in2 ^ in4 ^ in7;
        out6 = in0 ^ in4 ^ in6;
        out2 = out0 ^ in1 ^ in4;
        out3 = out5 ^ in6 ^ in7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_43(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out5 = in3;
        out7 = in1 ^ in5;
        out4 = in2 ^ in7;
        out6 = in0 ^ in4;
        out0 = in0 ^ in2 ^ in6;
        out3 = in5 ^ in6 ^ in7;
        out2 = in1 ^ in4 ^ in6;
        out1 = in0 ^ in1 ^ in3 ^ in7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_44(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out1 = in3;
        out0 = in2 ^ in7;
        tmp0 = in4 ^ in7;
        out7 = in1 ^ in6 ^ in7;
        out6 = in0 ^ in5 ^ in6;
        out4 = tmp0 ^ in3 ^ in6;
        out3 = out0 ^ in1 ^ in3 ^ in5;
        out2 = out0 ^ in0 ^ in4;
        out5 = tmp0 ^ in5;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_45(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out1 = in1 ^ in3;
        out7 = in1 ^ in6;
        out5 = in4 ^ in7;
        out6 = in0 ^ in5;
        out0 = in0 ^ in2 ^ in7;
        out4 = in3 ^ in6 ^ in7;
        out2 = out5 ^ in0;
        out3 = out0 ^ out6 ^ in1;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_46(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out0 = in2;
        out1 = in0 ^ in3;
        out7 = in1 ^ in7;
        out4 = in4 ^ in6;
        out5 = in5 ^ in7;
        out6 = in0 ^ in6;
        out3 = in1 ^ in3 ^ in5;
        out2 = out4 ^ out6 ^ in1 ^ in2;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_47(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out4 = in6;
        out7 = in1;
        out5 = in7;
        out6 = in0;
        tmp0 = in0 ^ in1;
        out3 = in1 ^ in5;
        out0 = in0 ^ in2;
        out1 = tmp0 ^ in3;
        out2 = tmp0 ^ in4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_48(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in2 ^ in3;
        out1 = in3 ^ in6 ^ in7;
        out3 = tmp0 ^ in0;
        out0 = tmp0 ^ out1 ^ in5;
        tmp1 = out0 ^ in4;
        out2 = tmp1 ^ in7;
        out5 = tmp1 ^ in3;
        out4 = out5 ^ in1;
        out7 = tmp0 ^ out4;
        out6 = tmp1 ^ out3;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_49(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out3 = in0 ^ in2;
        tmp0 = in2 ^ in5;
        out2 = in4 ^ in5 ^ in6;
        tmp1 = tmp0 ^ out2 ^ in3;
        out7 = out2 ^ in1;
        out5 = tmp1 ^ in7;
        out4 = out5 ^ out7 ^ in6;
        out1 = tmp0 ^ out4;
        out6 = out1 ^ out7 ^ in0;
        out0 = tmp1 ^ out6;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_4A(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in2 ^ in6;
        tmp1 = in3 ^ in7;
        out0 = tmp0 ^ in5;
        out3 = tmp1 ^ in0;
        out5 = tmp1 ^ out0;
        out4 = out0 ^ in1 ^ in4;
        out1 = out3 ^ in6;
        out2 = out4 ^ in7;
        out6 = out1 ^ in4;
        out7 = tmp0 ^ out2;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_4B(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out3 = in0 ^ in7;
        tmp0 = in1 ^ in5;
        tmp1 = in2 ^ in6;
        tmp2 = out3 ^ in3;
        out7 = tmp0 ^ in4;
        out4 = tmp0 ^ tmp1;
        tmp3 = tmp1 ^ in0;
        out6 = tmp2 ^ in4;
        out5 = tmp2 ^ tmp3;
        out1 = tmp2 ^ in1 ^ in6;
        out2 = out7 ^ in6 ^ in7;
        out0 = tmp3 ^ in5;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_4C(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out1 = in3 ^ in6;
        tmp0 = in2 ^ in5;
        tmp1 = out1 ^ in5 ^ in7;
        out0 = tmp0 ^ in7;
        tmp2 = tmp0 ^ in4;
        out6 = tmp1 ^ in0;
        out2 = tmp2 ^ in0;
        out5 = tmp2 ^ in6;
        out3 = tmp0 ^ out6 ^ in1;
        out7 = out0 ^ out5 ^ in1;
        out4 = tmp1 ^ out7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_4D(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in5;
        tmp1 = in1 ^ in6;
        out4 = in1 ^ in3 ^ in5;
        tmp2 = tmp0 ^ in7;
        out2 = tmp0 ^ in4;
        out1 = tmp1 ^ in3;
        out7 = tmp1 ^ in4;
        out0 = tmp2 ^ in2;
        out6 = tmp2 ^ in3;
        out5 = out7 ^ in1 ^ in2;
        out3 = tmp1 ^ out0 ^ in5;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_4E(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out0 = in2 ^ in5;
        out7 = in1 ^ in4 ^ in7;
        out1 = in0 ^ in3 ^ in6;
        out5 = out0 ^ in6;
        out4 = out7 ^ in5;
        out3 = out1 ^ in1;
        out6 = out1 ^ in7;
        out2 = out4 ^ in0 ^ in2;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_4F(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out5 = in2 ^ in6;
        out7 = in1 ^ in4;
        out3 = in0 ^ in1 ^ in6;
        out4 = in1 ^ in5 ^ in7;
        out0 = in0 ^ in2 ^ in5;
        out6 = in0 ^ in3 ^ in7;
        out1 = out3 ^ in3;
        out2 = out4 ^ in0 ^ in4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_50(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out2 = in2 ^ in7;
        tmp0 = in3 ^ in5;
        out0 = out2 ^ in4 ^ in6;
        out1 = tmp0 ^ in7;
        tmp1 = tmp0 ^ in6;
        out3 = out0 ^ in3;
        out7 = tmp1 ^ in1;
        tmp2 = tmp1 ^ in0;
        out5 = out3 ^ in1 ^ in2;
        out4 = tmp2 ^ in2;
        out6 = tmp2 ^ out3;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_51(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out2 = in7;
        out3 = in2 ^ in4 ^ in6 ^ in7;
        out0 = out3 ^ in0;
        out6 = out0 ^ in5;
        out4 = out6 ^ in3 ^ in7;
        out1 = out0 ^ out4 ^ in1;
        out7 = out1 ^ in6;
        out5 = out7 ^ in4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_52(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out2 = in1 ^ in2;
        tmp0 = in2 ^ in4;
        tmp1 = in3 ^ in5;
        tmp2 = in3 ^ in6;
        tmp3 = in0 ^ in7;
        out0 = tmp0 ^ in6;
        out6 = tmp0 ^ tmp3;
        out7 = tmp1 ^ in1;
        out1 = tmp1 ^ tmp3;
        out3 = tmp2 ^ in4;
        out5 = tmp2 ^ in1 ^ in7;
        out4 = tmp2 ^ out1 ^ in2;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_53(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out2 = in1;
        out3 = in4 ^ in6;
        out0 = out3 ^ in0 ^ in2;
        out6 = out0 ^ in7;
        out4 = out6 ^ in5;
        out7 = out0 ^ out4 ^ in1 ^ in3;
        out1 = out7 ^ in0;
        out5 = out7 ^ in6;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_54(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out1 = in3 ^ in5;
        tmp0 = in1 ^ in3;
        tmp1 = in2 ^ in4;
        tmp2 = in0 ^ in7;
        out5 = in1 ^ in4 ^ in6;
        out4 = tmp2 ^ out1;
        out7 = tmp0 ^ in6;
        out3 = tmp0 ^ tmp1;
        out0 = tmp1 ^ in7;
        tmp3 = tmp2 ^ in2;
        out2 = tmp3 ^ in6;
        out6 = tmp3 ^ in5;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_55(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in1 ^ in3;
        tmp1 = in1 ^ in4;
        tmp2 = in6 ^ in7;
        out7 = tmp0 ^ tmp2;
        out1 = tmp0 ^ in5;
        out3 = tmp1 ^ in2;
        out5 = tmp1 ^ in5 ^ in6;
        out2 = tmp2 ^ in0;
        out4 = out5 ^ out7 ^ in0;
        out6 = out2 ^ in2 ^ in5;
        out0 = out5 ^ out6 ^ in1;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_56(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out0 = in2 ^ in4;
        tmp0 = in0 ^ in2;
        out4 = in0 ^ in5;
        out7 = in1 ^ in3;
        out5 = in1 ^ in6;
        out6 = tmp0 ^ in7;
        out2 = tmp0 ^ out5;
        out1 = out4 ^ in3;
        out3 = out7 ^ in4 ^ in7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_57(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in5;
        tmp1 = in1 ^ in7;
        out0 = in0 ^ in2 ^ in4;
        out5 = in1 ^ in5 ^ in6;
        out4 = tmp0 ^ in4;
        out1 = tmp0 ^ in1 ^ in3;
        out2 = tmp0 ^ out5;
        out3 = tmp1 ^ in4;
        out7 = tmp1 ^ in3;
        out6 = tmp1 ^ out2 ^ in2;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_58(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out2 = in2 ^ in5;
        tmp0 = in2 ^ in3 ^ in4;
        out5 = tmp0 ^ in1;
        out6 = tmp0 ^ in0 ^ in5;
        out3 = out6 ^ in7;
        tmp1 = out2 ^ out5;
        out7 = tmp1 ^ in6;
        out4 = tmp1 ^ out3 ^ in3;
        out0 = out4 ^ out7 ^ in0;
        out1 = tmp0 ^ out0;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_59(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out2 = in5;
        tmp0 = in0 ^ in5 ^ in7;
        out3 = tmp0 ^ in2 ^ in4;
        out0 = out3 ^ in6;
        tmp1 = out0 ^ in7;
        out6 = tmp1 ^ in3;
        out5 = out6 ^ in0 ^ in1 ^ in6;
        out4 = tmp0 ^ out5;
        out1 = tmp1 ^ out4;
        out7 = out1 ^ in4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_5A(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in1 ^ in2;
        tmp1 = in2 ^ in5;
        out5 = tmp0 ^ in3;
        out4 = tmp0 ^ in0;
        tmp2 = tmp1 ^ in4;
        out2 = tmp1 ^ in1 ^ in7;
        out7 = tmp2 ^ out5;
        out6 = out4 ^ out7 ^ in5;
        out0 = tmp2 ^ in6;
        out1 = out0 ^ out6 ^ in7;
        out3 = tmp1 ^ out6;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_5B(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3, tmp4;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in2 ^ in3;
        tmp1 = in0 ^ in4;
        tmp2 = in1 ^ in5;
        out5 = tmp0 ^ tmp2;
        tmp3 = tmp1 ^ in6;
        out3 = tmp1 ^ in5;
        out2 = tmp2 ^ in7;
        tmp4 = out3 ^ in2;
        out7 = out2 ^ in3 ^ in4;
        out0 = tmp4 ^ in6;
        out6 = tmp0 ^ tmp3;
        out4 = tmp2 ^ tmp4;
        out1 = tmp3 ^ out7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_5C(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in3 ^ in6;
        tmp1 = in0 ^ in2 ^ in5;
        out1 = tmp0 ^ in5;
        tmp2 = tmp0 ^ in1;
        out2 = tmp1 ^ in6;
        out6 = tmp1 ^ in3;
        out4 = tmp2 ^ in0;
        out7 = tmp2 ^ in4;
        out3 = tmp1 ^ out7;
        out0 = out3 ^ out4 ^ in7;
        out5 = out0 ^ in1 ^ in5;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_5D(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3, tmp4;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in1;
        tmp1 = in0 ^ in6;
        out2 = tmp1 ^ in5;
        tmp2 = out2 ^ in3;
        out6 = tmp2 ^ in2;
        out1 = tmp0 ^ tmp2;
        tmp3 = out1 ^ in4 ^ in5;
        out4 = tmp3 ^ in0;
        out7 = tmp3 ^ in7;
        tmp4 = out4 ^ out6;
        out5 = tmp4 ^ in7;
        out0 = tmp0 ^ out5;
        out3 = tmp1 ^ tmp4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_5E(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3, tmp4;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in2 ^ in5;
        tmp1 = in3 ^ in5;
        tmp2 = in1 ^ in7;
        out7 = in1 ^ in3 ^ in4;
        out0 = tmp0 ^ in4;
        tmp3 = tmp1 ^ in0;
        out5 = tmp2 ^ in2;
        out1 = tmp3 ^ in6;
        out6 = tmp0 ^ tmp3;
        tmp4 = tmp2 ^ out1;
        out3 = tmp4 ^ in4;
        out4 = tmp1 ^ tmp4;
        out2 = tmp0 ^ out4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_5F(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in1 ^ in5;
        tmp1 = in0 ^ in6;
        tmp2 = tmp0 ^ in7;
        tmp3 = tmp1 ^ in3;
        out2 = tmp1 ^ tmp2;
        out5 = tmp2 ^ in2;
        out6 = tmp3 ^ in2;
        out3 = out2 ^ in4;
        out4 = out3 ^ in5;
        out1 = tmp0 ^ tmp3;
        out7 = tmp3 ^ out4;
        out0 = out4 ^ out5 ^ in6;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_60(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out4 = in2 ^ in5;
        tmp0 = in3 ^ in6;
        out1 = in3 ^ in4 ^ in7;
        out7 = out4 ^ in1;
        tmp1 = out4 ^ in4;
        out0 = tmp0 ^ in2;
        out5 = tmp0 ^ in0;
        out2 = tmp0 ^ tmp1;
        out3 = tmp1 ^ in7;
        out6 = out3 ^ out7 ^ in0;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_61(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in2 ^ in5;
        out4 = tmp0 ^ in4;
        tmp1 = out4 ^ in3;
        out3 = tmp1 ^ in7;
        out2 = tmp1 ^ in2 ^ in6;
        out1 = tmp0 ^ out3 ^ in1;
        out0 = out2 ^ out4 ^ in0;
        out7 = tmp1 ^ out1;
        out6 = out0 ^ out1 ^ in2;
        out5 = tmp0 ^ out0;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_62(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out3 = in4 ^ in5;
        tmp0 = in0 ^ in3 ^ in4;
        out1 = tmp0 ^ in7;
        out5 = tmp0 ^ in6;
        tmp1 = out1 ^ in0;
        tmp2 = tmp1 ^ out3;
        out4 = tmp2 ^ in2;
        tmp3 = tmp2 ^ in1;
        out0 = out4 ^ in5 ^ in6;
        out7 = tmp3 ^ out0;
        out6 = tmp0 ^ tmp3;
        out2 = tmp1 ^ out7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_63(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3, tmp4;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in3 ^ in4;
        tmp1 = in1 ^ in7;
        out3 = tmp0 ^ in5;
        tmp2 = out3 ^ in6;
        out4 = out3 ^ in2 ^ in7;
        out5 = tmp2 ^ in0;
        tmp3 = out5 ^ in3;
        out0 = tmp3 ^ out4;
        out2 = tmp1 ^ tmp2;
        out6 = tmp1 ^ tmp3;
        tmp4 = tmp0 ^ out2;
        out1 = tmp4 ^ out5;
        out7 = tmp4 ^ in2;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_64(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out0 = in2 ^ in3;
        out1 = in3 ^ in4;
        out7 = in1 ^ in2;
        tmp0 = in4 ^ in5;
        tmp1 = in0 ^ in7;
        out4 = in5 ^ in6 ^ in7;
        out2 = tmp0 ^ out0 ^ in0;
        out3 = tmp0 ^ out7 ^ in6;
        out5 = tmp1 ^ in6;
        out6 = tmp1 ^ in1;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_65(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in3;
        tmp1 = in4 ^ in5;
        tmp2 = in6 ^ in7;
        out7 = in1 ^ in2 ^ in7;
        out1 = in1 ^ in3 ^ in4;
        out0 = tmp0 ^ in2;
        out2 = tmp0 ^ tmp1;
        out4 = tmp1 ^ tmp2;
        tmp3 = tmp2 ^ in0;
        out3 = out4 ^ out7 ^ in3;
        out5 = tmp3 ^ in5;
        out6 = tmp3 ^ in1;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_66(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3, tmp4;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in1 ^ in2;
        tmp1 = in2 ^ in3;
        tmp2 = in0 ^ in4;
        out7 = tmp0 ^ in6;
        out0 = tmp1 ^ in7;
        out1 = tmp2 ^ in3;
        tmp3 = tmp2 ^ in6;
        tmp4 = out1 ^ in5;
        out5 = tmp3 ^ in7;
        out4 = tmp3 ^ tmp4;
        out2 = tmp0 ^ tmp4 ^ in7;
        out6 = tmp1 ^ out2 ^ in4;
        out3 = tmp3 ^ out6;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_67(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in3;
        tmp1 = tmp0 ^ in1;
        tmp2 = tmp0 ^ in7;
        out1 = tmp1 ^ in4;
        out0 = tmp2 ^ in2;
        tmp3 = out1 ^ in7;
        out2 = tmp3 ^ in5;
        out3 = out2 ^ in0 ^ in6;
        out7 = tmp1 ^ out0 ^ in6;
        out5 = tmp1 ^ out3;
        out4 = tmp2 ^ out5;
        out6 = tmp3 ^ out4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_68(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in3 ^ in4;
        tmp1 = in2 ^ in3 ^ in5;
        tmp2 = tmp0 ^ in1;
        tmp3 = tmp0 ^ in6;
        out0 = tmp1 ^ in6;
        out6 = tmp2 ^ in0;
        out7 = tmp1 ^ tmp2;
        out1 = tmp3 ^ in7;
        out2 = out1 ^ in2;
        out4 = tmp2 ^ out2;
        out3 = out4 ^ out6 ^ in3;
        out5 = tmp3 ^ out3;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_69(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in6 ^ in7;
        out2 = tmp0 ^ in3 ^ in4;
        out1 = out2 ^ in1;
        out3 = out2 ^ in0 ^ in2;
        out4 = out1 ^ in2 ^ in3;
        out6 = out1 ^ in0 ^ in7;
        out7 = out4 ^ in5 ^ in6;
        out5 = out4 ^ out6 ^ in5;
        out0 = tmp0 ^ out5;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_6A(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in2 ^ in6;
        out3 = in0 ^ in4 ^ in6;
        tmp1 = tmp0 ^ in3;
        out4 = tmp1 ^ in1;
        tmp2 = tmp1 ^ in7;
        out2 = out4 ^ in4;
        out0 = tmp2 ^ in5;
        out5 = tmp2 ^ out3;
        out7 = out2 ^ in3 ^ in5;
        out1 = tmp0 ^ out5;
        out6 = tmp1 ^ out7 ^ in0;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_6B(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in4 ^ in6;
        out2 = tmp0 ^ in1 ^ in3;
        out4 = out2 ^ in2;
        tmp1 = out2 ^ in0;
        out7 = out4 ^ in3 ^ in5 ^ in7;
        out1 = tmp1 ^ in7;
        out3 = tmp1 ^ in1;
        out6 = tmp1 ^ in5;
        out0 = tmp1 ^ out7 ^ in6;
        out5 = tmp0 ^ out0;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_6C(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out4 = in1;
        tmp0 = in2 ^ in3;
        out5 = in0 ^ in2;
        out1 = in3 ^ in4 ^ in6;
        tmp1 = out5 ^ in1;
        out0 = tmp0 ^ in5;
        out6 = tmp0 ^ tmp1;
        out3 = tmp1 ^ in4;
        out7 = out3 ^ in0;
        out2 = out6 ^ out7 ^ in7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_6D(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out4 = in1 ^ in4;
        tmp0 = in0 ^ in2;
        tmp1 = out4 ^ in3;
        out7 = out4 ^ in2 ^ in7;
        out5 = tmp0 ^ in5;
        out3 = tmp0 ^ tmp1;
        out1 = tmp1 ^ in6;
        out0 = out5 ^ in3;
        out2 = out3 ^ out7 ^ in4;
        out6 = out1 ^ in0 ^ in4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_6E(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in1 ^ in3;
        tmp1 = in0 ^ in4;
        out4 = tmp0 ^ in7;
        out6 = tmp0 ^ in0 ^ in5;
        out5 = tmp1 ^ in2;
        tmp2 = tmp1 ^ in3;
        out3 = tmp2 ^ out4;
        out1 = tmp2 ^ in6;
        out2 = tmp0 ^ out5;
        out0 = out2 ^ out3 ^ in5;
        out7 = out1 ^ out2 ^ in4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_6F(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in3 ^ in7;
        tmp1 = tmp0 ^ in4;
        tmp2 = tmp0 ^ in0 ^ in2;
        out4 = tmp1 ^ in1;
        out0 = tmp2 ^ in5;
        out3 = out4 ^ in0;
        out2 = out3 ^ in7;
        out1 = out2 ^ in6;
        out6 = out1 ^ in4 ^ in5;
        out7 = tmp2 ^ out1;
        out5 = tmp1 ^ out0;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_70(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out3 = in2;
        tmp0 = in2 ^ in4;
        out2 = in2 ^ in3 ^ in5;
        tmp1 = tmp0 ^ in6;
        tmp2 = out2 ^ in7;
        out0 = tmp1 ^ in3;
        out4 = tmp1 ^ in0;
        out7 = tmp2 ^ in1;
        out6 = out4 ^ in1;
        out5 = out7 ^ in0 ^ in2;
        out1 = tmp0 ^ tmp2;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_71(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out2 = in3 ^ in5;
        out3 = in2 ^ in3;
        tmp0 = in0 ^ in2;
        tmp1 = out2 ^ in1;
        out4 = tmp0 ^ in6;
        tmp2 = tmp0 ^ in1;
        out7 = tmp1 ^ in2;
        out1 = tmp1 ^ in4 ^ in7;
        out0 = out4 ^ in3 ^ in4;
        out6 = tmp2 ^ in4;
        out5 = tmp2 ^ out3 ^ in7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_72(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out3 = in7;
        tmp0 = in0 ^ in4;
        tmp1 = tmp0 ^ in3 ^ in7;
        out1 = tmp1 ^ in5;
        out5 = out1 ^ in1;
        tmp2 = tmp0 ^ out5;
        out2 = tmp2 ^ in2;
        out7 = out2 ^ in6;
        out6 = tmp1 ^ out7;
        out4 = tmp2 ^ out6;
        out0 = out4 ^ in0;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_73(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out3 = in3 ^ in7;
        out2 = out3 ^ in1 ^ in5;
        out1 = out2 ^ in0 ^ in4;
        out5 = out1 ^ in5;
        out6 = out1 ^ out3 ^ in2;
        out0 = out2 ^ out6 ^ in6;
        out7 = out0 ^ out1 ^ in3;
        out4 = out0 ^ in4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_74(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in3 ^ in4;
        tmp1 = in1 ^ in2 ^ in6;
        out4 = in0 ^ in4 ^ in7;
        out5 = in0 ^ in1 ^ in5;
        out0 = tmp0 ^ in2;
        out1 = tmp0 ^ in5;
        out3 = tmp1 ^ in7;
        out6 = tmp1 ^ in0;
        out2 = tmp1 ^ out5 ^ in3;
        out7 = out3 ^ in3 ^ in6;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_75(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out4 = in0 ^ in7;
        tmp0 = in1 ^ in3;
        out5 = in0 ^ in1;
        out7 = tmp0 ^ in2;
        tmp1 = tmp0 ^ in4;
        out6 = out5 ^ in2;
        tmp2 = out7 ^ in6;
        out1 = tmp1 ^ in5;
        out0 = tmp1 ^ out6;
        out3 = tmp2 ^ in7;
        out2 = tmp2 ^ out6 ^ in5;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_76(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out3 = in1 ^ in6;
        tmp0 = in0 ^ in5;
        tmp1 = in3 ^ in7;
        tmp2 = tmp0 ^ in4;
        tmp3 = tmp1 ^ in2;
        out5 = tmp2 ^ in1;
        out1 = tmp2 ^ in3;
        out0 = tmp3 ^ in4;
        out4 = out1 ^ in5;
        out7 = tmp3 ^ out3;
        out2 = tmp0 ^ out7;
        out6 = tmp1 ^ out2;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_77(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out4 = in0 ^ in3;
        tmp0 = in1 ^ in4;
        tmp1 = in1 ^ in6;
        tmp2 = out4 ^ in5;
        out5 = tmp0 ^ in0;
        out1 = tmp0 ^ tmp2;
        out3 = tmp1 ^ in3;
        out2 = tmp1 ^ tmp2 ^ in7;
        out7 = out3 ^ in2;
        tmp3 = out7 ^ in6;
        out6 = tmp2 ^ tmp3;
        out0 = tmp3 ^ out5 ^ in7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_78(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in3;
        tmp1 = in2 ^ in7;
        tmp2 = in0 ^ in5 ^ in6;
        out2 = tmp1 ^ in3;
        out3 = tmp2 ^ in2;
        out5 = out3 ^ in1 ^ in3;
        out0 = tmp0 ^ out3 ^ in4;
        out1 = tmp1 ^ out0;
        out4 = out1 ^ out5 ^ in5;
        out7 = tmp0 ^ out4;
        out6 = tmp2 ^ out7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_79(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out2 = in3 ^ in7;
        tmp0 = in3 ^ in4;
        tmp1 = in1 ^ in5;
        tmp2 = tmp1 ^ in2;
        out4 = tmp2 ^ in0 ^ in7;
        tmp3 = out4 ^ in5;
        out5 = tmp3 ^ out2 ^ in6;
        out7 = tmp0 ^ tmp2;
        out6 = tmp0 ^ tmp3;
        out3 = tmp1 ^ out5;
        out0 = out3 ^ in4;
        out1 = tmp3 ^ out0;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_7A(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in1 ^ in2;
        out2 = tmp0 ^ in3;
        tmp1 = out2 ^ in4;
        out4 = tmp1 ^ in0 ^ in5;
        out5 = out4 ^ in6;
        out6 = out5 ^ in7;
        out7 = out6 ^ in0;
        out0 = out7 ^ in1;
        out1 = tmp0 ^ out6;
        out3 = tmp1 ^ out6;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_7B(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out2 = in1 ^ in3;
        tmp0 = in0 ^ in5;
        out4 = tmp0 ^ out2 ^ in2;
        tmp1 = out4 ^ in4;
        out6 = tmp1 ^ in7;
        out5 = tmp1 ^ in5 ^ in6;
        out0 = out6 ^ in1 ^ in6;
        tmp2 = out0 ^ in2;
        out1 = tmp2 ^ in1;
        out3 = tmp2 ^ in4;
        out7 = tmp0 ^ out5;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_7C(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in3 ^ in5;
        tmp1 = tmp0 ^ in4;
        out0 = tmp1 ^ in2;
        out1 = tmp1 ^ in6;
        out7 = out0 ^ in1 ^ in5 ^ in7;
        out5 = out1 ^ out7 ^ in0;
        out3 = out5 ^ in6;
        out6 = tmp0 ^ out5;
        out2 = out6 ^ in1;
        out4 = out2 ^ out7 ^ in5;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_7D(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in1 ^ in2;
        tmp1 = tmp0 ^ in3;
        tmp2 = tmp0 ^ in6;
        out7 = tmp1 ^ in4;
        tmp3 = tmp2 ^ in0;
        out5 = tmp3 ^ in7;
        out4 = tmp3 ^ in2 ^ in5;
        out2 = tmp1 ^ out5;
        out6 = tmp2 ^ out2;
        out0 = out4 ^ out7 ^ in6;
        out1 = tmp3 ^ out0;
        out3 = out6 ^ in5;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_7E(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in3 ^ in4;
        tmp1 = in0 ^ in5;
        out1 = tmp0 ^ tmp1 ^ in6;
        out3 = tmp1 ^ in1;
        out4 = out1 ^ in1 ^ in7;
        tmp2 = out4 ^ in3;
        out5 = tmp2 ^ in2;
        out6 = tmp0 ^ out5;
        out7 = tmp1 ^ out4 ^ in2;
        out2 = out6 ^ in5 ^ in7;
        out0 = tmp2 ^ out2;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_7F(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in2 ^ in7;
        tmp1 = tmp0 ^ in3 ^ in5;
        tmp2 = tmp1 ^ in0;
        out0 = tmp2 ^ in4;
        out6 = tmp2 ^ in1;
        out3 = tmp0 ^ out6;
        tmp3 = out3 ^ in6;
        out1 = tmp3 ^ in4;
        out2 = tmp3 ^ in5;
        out4 = tmp3 ^ in7;
        out5 = tmp1 ^ out1;
        out7 = out0 ^ out4 ^ in3;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_80(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in2 ^ in3;
        tmp1 = in4 ^ in5;
        out1 = in2 ^ in6 ^ in7;
        out5 = tmp0 ^ in4;
        tmp2 = tmp0 ^ in1;
        out6 = tmp1 ^ in3;
        out7 = tmp1 ^ in0 ^ in6;
        out4 = tmp2 ^ in7;
        out3 = tmp2 ^ out6;
        out2 = out3 ^ out5 ^ in6;
        out0 = out2 ^ in3 ^ in7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_81(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in4 ^ in6;
        tmp1 = tmp0 ^ in3;
        out6 = tmp1 ^ in5;
        out5 = out6 ^ in2 ^ in6;
        out3 = out5 ^ in1;
        out2 = tmp0 ^ out3;
        out1 = out3 ^ out6 ^ in7;
        out4 = tmp1 ^ out1;
        out7 = out2 ^ out4 ^ in0;
        out0 = out7 ^ in1 ^ in4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_82(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out4 = in1 ^ in2;
        tmp0 = in6 ^ in7;
        out5 = in2 ^ in3;
        out6 = in3 ^ in4;
        out7 = in0 ^ in4 ^ in5;
        out0 = in1 ^ in5 ^ in6;
        out1 = tmp0 ^ in0 ^ in2;
        out2 = tmp0 ^ in3 ^ in5;
        out3 = tmp0 ^ out0 ^ in4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_83(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3, tmp4;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in1;
        tmp1 = in2 ^ in5;
        tmp2 = in3 ^ in6;
        out4 = in1 ^ in2 ^ in4;
        out0 = tmp0 ^ in5 ^ in6;
        out5 = tmp1 ^ in3;
        tmp3 = tmp1 ^ in7;
        out6 = tmp2 ^ in4;
        out2 = tmp2 ^ tmp3;
        tmp4 = tmp3 ^ out4;
        out1 = tmp3 ^ out0;
        out3 = tmp4 ^ in3;
        out7 = tmp0 ^ tmp4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_84(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out1 = in2 ^ in6;
        out6 = in3 ^ in5;
        out0 = in1 ^ in5 ^ in7;
        out7 = in0 ^ in4 ^ in6;
        out4 = in1 ^ in3 ^ in6;
        out5 = in2 ^ in4 ^ in7;
        out2 = out6 ^ in0 ^ in1;
        out3 = out5 ^ in5 ^ in6;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_85(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in1 ^ in6;
        tmp1 = in3 ^ in6;
        tmp2 = tmp0 ^ in4;
        out1 = tmp0 ^ in2;
        out6 = tmp1 ^ in5;
        out4 = tmp2 ^ in3;
        tmp3 = out1 ^ out6;
        out2 = tmp3 ^ in0;
        out3 = tmp2 ^ tmp3 ^ in7;
        out7 = out2 ^ out3 ^ in1;
        out5 = tmp1 ^ out3;
        out0 = tmp2 ^ out7 ^ in5;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_86(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out6 = in3;
        out7 = in0 ^ in4;
        out0 = in1 ^ in5;
        out5 = in2 ^ in7;
        out3 = in4 ^ in5 ^ in6;
        out1 = in0 ^ in2 ^ in6;
        out4 = in1 ^ in6 ^ in7;
        out2 = in0 ^ in3 ^ in5 ^ in7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_87(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out6 = in3 ^ in6;
        tmp0 = in0 ^ in1;
        out7 = in0 ^ in4 ^ in7;
        out5 = in2 ^ in5 ^ in7;
        out3 = out6 ^ in4 ^ in5;
        out0 = tmp0 ^ in5;
        tmp1 = tmp0 ^ in6;
        out2 = out5 ^ in0 ^ in3;
        out1 = tmp1 ^ in2;
        out4 = tmp1 ^ out7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_88(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out1 = in2 ^ in7;
        tmp0 = in5 ^ in6;
        out0 = in1 ^ in6 ^ in7;
        out6 = in4 ^ in5 ^ in7;
        out3 = out0 ^ out1 ^ in0 ^ in4;
        out7 = tmp0 ^ in0;
        tmp1 = tmp0 ^ in3;
        out2 = out0 ^ in3;
        out4 = tmp1 ^ in2;
        out5 = tmp1 ^ out6;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_89(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in7;
        tmp1 = in2 ^ in7;
        tmp2 = tmp0 ^ in6;
        out1 = tmp1 ^ in1;
        out7 = tmp2 ^ in5;
        out0 = tmp2 ^ in1;
        out2 = out1 ^ in3 ^ in6;
        out6 = out7 ^ in0 ^ in4;
        out5 = out6 ^ in3;
        out3 = tmp0 ^ out2 ^ in4;
        out4 = tmp1 ^ out5;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_8A(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out0 = in1 ^ in6;
        out7 = in0 ^ in5;
        out2 = in3 ^ in6;
        out6 = in4 ^ in7;
        out1 = in0 ^ in2 ^ in7;
        out3 = out0 ^ out6 ^ in0;
        out4 = out1 ^ out7 ^ in6;
        out5 = out2 ^ in7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_8B(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3, tmp4;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in1;
        tmp1 = in3 ^ in6;
        tmp2 = in5 ^ in7;
        tmp3 = tmp0 ^ in7;
        out0 = tmp0 ^ in6;
        out2 = tmp1 ^ in2;
        out5 = tmp1 ^ tmp2;
        out7 = tmp2 ^ in0;
        tmp4 = tmp3 ^ in4;
        out1 = tmp3 ^ in2;
        out6 = tmp4 ^ out0;
        out4 = out6 ^ in2 ^ in5;
        out3 = tmp1 ^ tmp4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_8C(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out1 = in2;
        out0 = in1 ^ in7;
        out7 = in0 ^ in6;
        out5 = in4 ^ in6;
        out6 = in5 ^ in7;
        out2 = out0 ^ in0 ^ in3;
        out3 = out5 ^ out7 ^ in2 ^ in7;
        out4 = out6 ^ in3;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_8D(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out1 = in1 ^ in2;
        tmp0 = in6 ^ in7;
        out0 = in0 ^ in1 ^ in7;
        out5 = in4 ^ in5 ^ in6;
        out6 = tmp0 ^ in5;
        out7 = tmp0 ^ in0;
        out4 = tmp0 ^ out5 ^ in3;
        out2 = out0 ^ in2 ^ in3;
        out3 = out2 ^ in1 ^ in4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_8E(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out0 = in1;
        out4 = in5;
        out7 = in0;
        out5 = in6;
        out6 = in7;
        out3 = in0 ^ in4;
        out1 = in0 ^ in2;
        out2 = in0 ^ in3;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_8F(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out0 = in0 ^ in1;
        tmp0 = in0 ^ in3;
        out4 = in4 ^ in5;
        out7 = in0 ^ in7;
        out5 = in5 ^ in6;
        out6 = in6 ^ in7;
        out1 = out0 ^ in2;
        out2 = tmp0 ^ in2;
        out3 = tmp0 ^ in4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_90(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in1 ^ in2;
        tmp1 = in2 ^ in6 ^ in7;
        out3 = tmp0 ^ in7;
        out1 = tmp1 ^ in5;
        tmp2 = out1 ^ in4;
        out6 = tmp2 ^ in3;
        out5 = out6 ^ in1;
        out4 = out5 ^ in0;
        out0 = tmp0 ^ tmp2;
        out7 = tmp0 ^ out4;
        out2 = tmp1 ^ out5;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_91(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in2 ^ in4;
        tmp1 = tmp0 ^ in3 ^ in5;
        out2 = tmp1 ^ in1;
        out6 = tmp1 ^ in7;
        tmp2 = out2 ^ in5 ^ in7;
        out3 = tmp2 ^ in4;
        out5 = tmp2 ^ in6;
        out1 = tmp1 ^ out5 ^ in2;
        tmp3 = out1 ^ in0;
        out4 = tmp3 ^ in3;
        out0 = tmp0 ^ tmp3;
        out7 = tmp2 ^ tmp3;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_92(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out3 = in1;
        tmp0 = in4 ^ in5;
        tmp1 = tmp0 ^ in1;
        out2 = tmp0 ^ in3 ^ in7;
        out0 = tmp1 ^ in6;
        out7 = out2 ^ in0;
        out4 = out0 ^ in0 ^ in2;
        out5 = out4 ^ out7 ^ in5;
        out6 = tmp1 ^ out5;
        out1 = out6 ^ out7 ^ in7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_93(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out3 = in1 ^ in3;
        tmp0 = in2 ^ in7;
        tmp1 = out3 ^ in6;
        tmp2 = tmp0 ^ in4;
        out5 = tmp0 ^ tmp1;
        out6 = tmp2 ^ in3;
        out2 = out6 ^ in5;
        out0 = out2 ^ out5 ^ in0;
        out7 = tmp1 ^ out0;
        out1 = tmp2 ^ out0;
        out4 = out1 ^ in7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_94(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out3 = in2 ^ in6;
        tmp0 = in1 ^ in4 ^ in5;
        out1 = out3 ^ in5;
        out5 = tmp0 ^ out3;
        out0 = tmp0 ^ in7;
        out4 = tmp0 ^ in0 ^ in3;
        out6 = out1 ^ in3 ^ in7;
        out2 = out4 ^ in6;
        out7 = out0 ^ out2 ^ in4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_95(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3, tmp4, tmp5;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in2 ^ in3;
        out3 = tmp0 ^ in6;
        tmp1 = tmp0 ^ in7;
        tmp2 = out3 ^ in0;
        out6 = tmp1 ^ in5;
        tmp3 = tmp2 ^ in4;
        out7 = tmp3 ^ in2;
        tmp4 = tmp3 ^ in5;
        out2 = tmp4 ^ in1;
        tmp5 = out2 ^ in6;
        out0 = tmp1 ^ tmp5;
        out1 = tmp5 ^ out7;
        out4 = tmp2 ^ out1;
        out5 = tmp4 ^ out4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_96(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out3 = in6 ^ in7;
        tmp0 = in1 ^ in5;
        tmp1 = in5 ^ in6;
        out6 = out3 ^ in2 ^ in3;
        out0 = tmp0 ^ in4;
        tmp2 = tmp1 ^ in2;
        out4 = out0 ^ in0 ^ in7;
        out1 = tmp2 ^ in0;
        out5 = tmp2 ^ in1;
        out7 = tmp0 ^ out4 ^ in3;
        out2 = tmp1 ^ out7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_97(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in4;
        tmp1 = in2 ^ in6;
        out3 = in3 ^ in6 ^ in7;
        out7 = tmp0 ^ in3;
        tmp2 = tmp0 ^ in5;
        out5 = tmp1 ^ in1;
        out6 = tmp1 ^ out3;
        out0 = tmp2 ^ in1;
        out2 = tmp2 ^ out3 ^ in2;
        tmp3 = out0 ^ in4;
        out4 = tmp3 ^ in7;
        out1 = tmp1 ^ tmp3;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_98(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in5 ^ in7;
        tmp1 = in1 ^ in4 ^ in7;
        out1 = tmp0 ^ in2;
        out0 = tmp1 ^ in6;
        out2 = tmp1 ^ in3;
        out6 = out0 ^ out1 ^ in1;
        out5 = tmp0 ^ out2;
        out3 = tmp1 ^ out6 ^ in0;
        out7 = out0 ^ out5 ^ in0;
        out4 = out6 ^ out7 ^ in7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_99(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in3;
        out5 = in1 ^ in3 ^ in4;
        out6 = in2 ^ in4 ^ in5;
        out4 = tmp0 ^ in2;
        tmp1 = tmp0 ^ in6;
        tmp2 = out5 ^ in7;
        out7 = tmp1 ^ in5;
        out0 = tmp1 ^ tmp2;
        out2 = tmp2 ^ in2;
        out3 = out0 ^ out6 ^ in3;
        out1 = tmp1 ^ out3;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_9A(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out2 = in3 ^ in4;
        tmp0 = in0 ^ in5;
        tmp1 = in1 ^ in6;
        out5 = in1 ^ in3 ^ in5;
        tmp2 = tmp0 ^ in7;
        out3 = tmp0 ^ tmp1;
        out0 = tmp1 ^ in4;
        out7 = tmp2 ^ in3;
        out1 = tmp2 ^ in2;
        out6 = out0 ^ in1 ^ in2;
        out4 = out1 ^ in4 ^ in5;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_9B(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out5 = in1 ^ in3;
        tmp0 = in3 ^ in5;
        out6 = in2 ^ in4;
        out4 = in0 ^ in2 ^ in7;
        out7 = tmp0 ^ in0;
        out2 = out6 ^ in3;
        out1 = out4 ^ in1 ^ in5;
        out3 = out7 ^ in1 ^ in6;
        out0 = tmp0 ^ out3 ^ in4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_9C(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out1 = in2 ^ in5;
        tmp0 = in0 ^ in3 ^ in6;
        out3 = out1 ^ in0;
        out6 = out1 ^ in6;
        out7 = tmp0 ^ in7;
        out4 = out7 ^ in4;
        out2 = out4 ^ in1;
        out0 = tmp0 ^ out2;
        out5 = out0 ^ in5;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_9D(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out6 = in2 ^ in5;
        tmp0 = in0 ^ in3;
        out5 = in1 ^ in4 ^ in7;
        out1 = out6 ^ in1;
        out3 = tmp0 ^ out6;
        out7 = tmp0 ^ in6;
        out0 = out5 ^ in0;
        out4 = out7 ^ in7;
        out2 = out5 ^ out7 ^ in2;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_9E(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out0 = in1 ^ in4;
        tmp0 = in0 ^ in5;
        out6 = in2 ^ in6;
        out7 = in0 ^ in3 ^ in7;
        out4 = in0 ^ in4 ^ in6;
        out5 = in1 ^ in5 ^ in7;
        out1 = tmp0 ^ in2;
        out3 = tmp0 ^ in7;
        out2 = out4 ^ in3;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_9F(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out6 = in2;
        out7 = in0 ^ in3;
        tmp0 = in0 ^ in1;
        out4 = in0 ^ in6;
        out5 = in1 ^ in7;
        out1 = tmp0 ^ in2 ^ in5;
        out2 = out7 ^ in2 ^ in4 ^ in6;
        out3 = out7 ^ in5 ^ in7;
        out0 = tmp0 ^ in4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_A0(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in1 ^ in6;
        out2 = tmp0 ^ in7;
        tmp1 = tmp0 ^ in5;
        out6 = out2 ^ in3 ^ in4;
        out0 = tmp1 ^ in3;
        tmp2 = out0 ^ in2;
        out3 = tmp2 ^ in7;
        tmp3 = tmp2 ^ in1;
        out5 = tmp3 ^ in0;
        out4 = tmp3 ^ out6;
        out7 = out5 ^ out6 ^ in1;
        out1 = tmp1 ^ out4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_A1(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in2 ^ in5;
        tmp1 = tmp0 ^ in1;
        tmp2 = tmp0 ^ in4;
        out4 = tmp1 ^ in7;
        out7 = tmp2 ^ in0;
        out6 = tmp2 ^ out4 ^ in3;
        out3 = out4 ^ in6;
        out2 = out3 ^ in5;
        out1 = out2 ^ in4;
        out5 = out1 ^ out6 ^ in0;
        out0 = tmp1 ^ out5;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_A2(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out2 = in6;
        tmp0 = in1 ^ in3 ^ in5;
        out3 = tmp0 ^ in6;
        out4 = tmp0 ^ in2 ^ in4;
        out0 = out3 ^ in7;
        out6 = out0 ^ in4;
        out1 = out0 ^ out4 ^ in0;
        out7 = out1 ^ in5;
        out5 = out7 ^ in3 ^ in7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_A3(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out2 = in2 ^ in6;
        out3 = in1 ^ in5 ^ in6;
        tmp0 = out2 ^ in0;
        out4 = out2 ^ out3 ^ in3;
        tmp1 = tmp0 ^ in4;
        out0 = tmp0 ^ out4 ^ in7;
        out5 = tmp1 ^ in3;
        out7 = tmp1 ^ in5;
        out1 = tmp1 ^ in1 ^ in7;
        out6 = tmp1 ^ out0 ^ in2;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_A4(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3, tmp4;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in1 ^ in3;
        tmp1 = in2 ^ in4;
        tmp2 = in2 ^ in5;
        tmp3 = in0 ^ in7;
        out0 = tmp0 ^ in5;
        out6 = tmp0 ^ in6 ^ in7;
        out1 = tmp1 ^ in6;
        out7 = tmp1 ^ tmp3;
        out3 = tmp2 ^ in3;
        tmp4 = tmp2 ^ out1;
        out2 = tmp3 ^ in1;
        out5 = tmp4 ^ out7;
        out4 = tmp4 ^ in1;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_A5(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out3 = in2 ^ in5;
        tmp0 = in1 ^ in6;
        tmp1 = in0 ^ in1;
        tmp2 = in2 ^ in4;
        out6 = in1 ^ in3 ^ in7;
        out4 = tmp0 ^ in5;
        out1 = tmp0 ^ tmp2;
        out0 = tmp1 ^ in3 ^ in5;
        out2 = tmp1 ^ in2 ^ in7;
        out7 = tmp2 ^ in0;
        out5 = tmp0 ^ out2;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_A6(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out2 = in0;
        out3 = in3 ^ in5 ^ in7;
        out1 = in0 ^ in2 ^ in4 ^ in6;
        out0 = out3 ^ in1;
        out7 = out1 ^ in7;
        out6 = out0 ^ in6;
        out5 = out7 ^ in5;
        out4 = out6 ^ in4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_A7(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out2 = in0 ^ in2;
        out3 = in5 ^ in7;
        out7 = out2 ^ in4 ^ in6;
        out6 = out3 ^ in1 ^ in3;
        out1 = out7 ^ in1;
        out5 = out7 ^ in7;
        out0 = out6 ^ in0;
        out4 = out6 ^ in6;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_A8(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in2 ^ in4;
        tmp1 = in1 ^ in6;
        tmp2 = in0 ^ in2 ^ in7;
        out1 = tmp0 ^ in7;
        out4 = tmp0 ^ in6;
        out0 = tmp1 ^ in3;
        out2 = tmp1 ^ in5;
        out6 = tmp1 ^ in4;
        out7 = tmp2 ^ in5;
        out3 = tmp2 ^ out0 ^ in6;
        out5 = out7 ^ in2 ^ in3;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_A9(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out4 = in2 ^ in6;
        out6 = in1 ^ in4;
        out7 = in0 ^ in2 ^ in5;
        out5 = in0 ^ in3 ^ in7;
        out2 = out4 ^ in1 ^ in5;
        out1 = out6 ^ in2 ^ in7;
        out0 = out2 ^ out7 ^ in3;
        out3 = out1 ^ in0 ^ in4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_AA(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in2;
        tmp1 = in1 ^ in3;
        tmp2 = in6 ^ in7;
        out1 = tmp0 ^ in4 ^ in7;
        out3 = tmp1 ^ in0;
        out0 = tmp1 ^ tmp2;
        out2 = tmp2 ^ in5;
        out7 = tmp0 ^ out2;
        out6 = out1 ^ out7 ^ in1;
        out5 = out0 ^ out6 ^ in0;
        out4 = out5 ^ out7 ^ in7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_AB(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out3 = in0 ^ in1;
        tmp0 = in1 ^ in4;
        tmp1 = in0 ^ in7;
        out6 = tmp0 ^ in5;
        out1 = tmp0 ^ tmp1 ^ in2;
        out5 = tmp1 ^ in3 ^ in4;
        out0 = tmp0 ^ out5 ^ in6;
        out4 = out0 ^ out3 ^ in2;
        out2 = out4 ^ in3 ^ in5;
        out7 = tmp1 ^ out2;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_AC(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out0 = in1 ^ in3;
        out1 = in2 ^ in4;
        tmp0 = in0 ^ in2;
        out4 = in4 ^ in7;
        out5 = in0 ^ in5;
        out6 = in1 ^ in6;
        out7 = tmp0 ^ in7;
        out3 = tmp0 ^ in3 ^ in6;
        out2 = out5 ^ in1;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_AD(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out4 = in7;
        out5 = in0;
        out6 = in1;
        out7 = in0 ^ in2;
        out0 = in0 ^ in1 ^ in3;
        out2 = out7 ^ in1 ^ in5;
        out1 = in1 ^ in2 ^ in4;
        out3 = out7 ^ in6;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_AE(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out4 = in3 ^ in4;
        tmp0 = in0 ^ in4;
        tmp1 = in0 ^ in7;
        out0 = in1 ^ in3 ^ in7;
        out1 = tmp0 ^ in2;
        out5 = tmp0 ^ in5;
        tmp2 = tmp1 ^ in6;
        out2 = tmp1 ^ in5;
        out3 = tmp2 ^ in3;
        out7 = tmp2 ^ in2;
        out6 = tmp2 ^ out2 ^ in1;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_AF(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out4 = in3;
        tmp0 = in0 ^ in7;
        out5 = in0 ^ in4;
        out6 = in1 ^ in5;
        out7 = in0 ^ in2 ^ in6;
        out0 = tmp0 ^ in1 ^ in3;
        out3 = tmp0 ^ in6;
        out2 = tmp0 ^ in2 ^ in5;
        out1 = out5 ^ in1 ^ in2;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_B0(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in1 ^ in4;
        tmp1 = in3 ^ in6;
        out2 = tmp0 ^ in7;
        tmp2 = tmp0 ^ tmp1;
        out0 = tmp2 ^ in5;
        out3 = tmp2 ^ in2;
        out6 = out3 ^ in6;
        tmp3 = out6 ^ in0 ^ in1;
        out7 = tmp3 ^ in5;
        out5 = tmp3 ^ out2;
        out1 = out0 ^ out5 ^ in0;
        out4 = tmp1 ^ out5;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_B1(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in1 ^ in4;
        out2 = tmp0 ^ in2 ^ in7;
        tmp1 = out2 ^ in6;
        out1 = tmp1 ^ in5;
        out3 = tmp1 ^ in7;
        out4 = tmp1 ^ in0;
        out6 = out3 ^ in3;
        out0 = out6 ^ in0 ^ in2 ^ in5;
        out5 = tmp1 ^ out0 ^ in1;
        out7 = tmp0 ^ out5;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_B2(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3, tmp4;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out2 = in4;
        tmp0 = in4 ^ in7;
        tmp1 = in1 ^ in3 ^ in6;
        out3 = tmp0 ^ tmp1;
        tmp2 = tmp1 ^ in0;
        out0 = out3 ^ in5;
        out4 = tmp2 ^ in2;
        tmp3 = out4 ^ in6;
        out5 = tmp0 ^ tmp3;
        out1 = tmp3 ^ out0;
        tmp4 = out1 ^ in7;
        out7 = tmp4 ^ in3;
        out6 = tmp2 ^ tmp4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_B3(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out2 = in2 ^ in4;
        tmp0 = in0 ^ in5;
        tmp1 = in1 ^ in6;
        out3 = tmp1 ^ in4 ^ in7;
        tmp2 = tmp0 ^ out3;
        out0 = tmp2 ^ in3;
        out1 = tmp2 ^ in2;
        out5 = out0 ^ in2 ^ in6;
        out7 = tmp1 ^ out5;
        out4 = out7 ^ in1 ^ in5 ^ in7;
        out6 = tmp0 ^ out4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_B4(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out4 = in0 ^ in1;
        out5 = out4 ^ in2;
        tmp0 = out4 ^ in4;
        out6 = out5 ^ in0 ^ in3;
        out7 = tmp0 ^ out6;
        out2 = tmp0 ^ in6 ^ in7;
        out3 = out7 ^ in0 ^ in7;
        out0 = out5 ^ out7 ^ in5;
        out1 = out0 ^ out6 ^ in6;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_B5(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in1;
        tmp1 = in2 ^ in4;
        out4 = tmp0 ^ in4;
        out3 = tmp1 ^ in7;
        tmp2 = out4 ^ in5;
        out7 = out3 ^ in0 ^ in3;
        out0 = tmp2 ^ in3;
        out2 = tmp0 ^ out3 ^ in6;
        out5 = tmp1 ^ tmp2;
        out6 = out2 ^ out7 ^ in2;
        out1 = tmp0 ^ out0 ^ out6;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_B6(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out3 = in3 ^ in4;
        tmp0 = in1 ^ in2;
        tmp1 = in0 ^ in4;
        tmp2 = in3 ^ in5;
        tmp3 = out3 ^ in1 ^ in7;
        out5 = tmp0 ^ tmp1;
        out6 = tmp0 ^ tmp2;
        out2 = tmp1 ^ in6;
        out4 = tmp1 ^ tmp3;
        out0 = tmp3 ^ in5;
        out1 = out2 ^ in2 ^ in5;
        out7 = tmp2 ^ out1;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_B7(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out3 = in4;
        tmp0 = in0 ^ in4;
        out2 = tmp0 ^ in2 ^ in6;
        tmp1 = out2 ^ in7;
        out1 = out2 ^ in1 ^ in5;
        out7 = tmp1 ^ in3;
        out5 = out1 ^ in6;
        out6 = tmp0 ^ out1 ^ in3;
        out0 = tmp1 ^ out6;
        out4 = out0 ^ in5;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_B8(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in1 ^ in4;
        tmp1 = in2 ^ in5;
        out2 = tmp0 ^ in5;
        out4 = tmp1 ^ in0;
        tmp2 = tmp1 ^ in7;
        out6 = tmp2 ^ out2;
        out7 = out4 ^ in3;
        out1 = tmp2 ^ in4;
        out3 = tmp0 ^ out7;
        out0 = out3 ^ out4 ^ in6;
        out5 = out0 ^ in0 ^ in4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_B9(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in2;
        tmp1 = in4 ^ in5;
        out4 = tmp0 ^ tmp1;
        tmp2 = tmp0 ^ in3 ^ in7;
        out3 = out4 ^ in1;
        out7 = tmp2 ^ in5;
        out2 = out3 ^ in0;
        out1 = out2 ^ in7;
        out6 = out1 ^ in5 ^ in6;
        out0 = tmp2 ^ out6;
        out5 = tmp1 ^ out0;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_BA(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in5 ^ in7;
        out2 = tmp0 ^ in4;
        tmp1 = out2 ^ in2;
        out1 = tmp1 ^ in0;
        out6 = tmp1 ^ in1;
        out4 = out1 ^ in3 ^ in4;
        tmp2 = out4 ^ out6;
        out7 = out4 ^ in6 ^ in7;
        out5 = tmp2 ^ in6;
        out3 = tmp0 ^ tmp2;
        out0 = out6 ^ out7 ^ in0;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_BB(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out2 = in2 ^ in4 ^ in5 ^ in7;
        tmp0 = out2 ^ in1;
        out4 = out2 ^ in0 ^ in3;
        out1 = tmp0 ^ in0;
        out6 = tmp0 ^ in6;
        out3 = out1 ^ in2;
        tmp1 = out4 ^ out6 ^ in4;
        out0 = tmp1 ^ in7;
        out5 = tmp1 ^ in5;
        out7 = tmp0 ^ tmp1;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_BC(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in2;
        tmp1 = in2 ^ in4;
        out0 = in1 ^ in3 ^ in4;
        out6 = in1 ^ in2 ^ in7;
        out7 = tmp0 ^ in3;
        out5 = tmp0 ^ out6 ^ in6;
        out1 = tmp1 ^ in5;
        tmp2 = out1 ^ out5 ^ in1;
        out3 = tmp2 ^ in3;
        out4 = tmp1 ^ tmp2;
        out2 = tmp2 ^ out6;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_BD(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in3;
        tmp1 = in1 ^ in4;
        out0 = tmp0 ^ tmp1;
        out7 = tmp0 ^ in2 ^ in7;
        out1 = tmp1 ^ in2 ^ in5;
        tmp2 = out1 ^ in0;
        out2 = tmp2 ^ in6;
        out3 = out2 ^ in1 ^ in7;
        out4 = out3 ^ in2;
        out5 = tmp1 ^ out4;
        out6 = tmp2 ^ out4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_BE(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in3 ^ in6;
        out4 = tmp0 ^ in5;
        out7 = tmp0 ^ in2;
        out3 = out4 ^ in4;
        out1 = out3 ^ out7 ^ in0;
        out2 = out3 ^ in3 ^ in7;
        out0 = out2 ^ out4 ^ in1;
        out5 = tmp0 ^ out0;
        out6 = out1 ^ out5 ^ in6;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_BF(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in4;
        out3 = tmp0 ^ in5 ^ in6;
        out4 = out3 ^ in3;
        tmp1 = out3 ^ in7;
        out2 = tmp1 ^ in2;
        out5 = tmp1 ^ in1;
        tmp2 = out2 ^ in5;
        out7 = tmp2 ^ in3 ^ in4;
        tmp3 = tmp0 ^ out5;
        out0 = tmp3 ^ out4;
        out1 = tmp2 ^ tmp3;
        out6 = tmp3 ^ in2;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_C0(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out5 = in2 ^ in5;
        tmp0 = in1 ^ in4;
        tmp1 = in3 ^ in6;
        out0 = out5 ^ in1;
        out4 = tmp0 ^ in7;
        out3 = tmp0 ^ tmp1;
        out1 = tmp1 ^ in2;
        out6 = tmp1 ^ in0;
        out7 = out4 ^ in0;
        out2 = out4 ^ out5 ^ in3;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_C1(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out5 = in2;
        tmp0 = in0 ^ in1;
        out4 = in1 ^ in7;
        out6 = in0 ^ in3;
        out3 = in1 ^ in4 ^ in6;
        tmp1 = tmp0 ^ in2;
        out7 = tmp0 ^ in4;
        out0 = tmp1 ^ in5;
        out1 = tmp1 ^ out6 ^ in6;
        out2 = out6 ^ out7 ^ in5 ^ in7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_C2(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out4 = in1 ^ in3 ^ in4;
        tmp0 = in0 ^ in3 ^ in6;
        out5 = in2 ^ in4 ^ in5;
        tmp1 = out4 ^ in7;
        out1 = tmp0 ^ in2;
        out6 = tmp0 ^ in5;
        out2 = out5 ^ in3;
        out7 = tmp0 ^ tmp1;
        out3 = tmp1 ^ in2 ^ in6;
        out0 = tmp1 ^ out2;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_C3(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out4 = in1 ^ in3;
        tmp0 = in0 ^ in2;
        tmp1 = in3 ^ in5;
        out5 = in2 ^ in4;
        tmp2 = tmp0 ^ out4;
        out2 = tmp1 ^ in4;
        out6 = tmp1 ^ in0;
        out0 = tmp1 ^ tmp2 ^ in7;
        out1 = tmp2 ^ in6;
        out7 = out1 ^ out5 ^ in3;
        out3 = tmp0 ^ out7 ^ in7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_C4(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in3 ^ in7;
        out3 = tmp0 ^ in4;
        tmp1 = tmp0 ^ in2;
        out1 = tmp1 ^ in6;
        out5 = tmp1 ^ in5;
        out4 = out1 ^ out3 ^ in1;
        out0 = out4 ^ in4 ^ in5;
        out2 = out0 ^ out3 ^ in0;
        out7 = out1 ^ out2 ^ in7;
        out6 = tmp1 ^ out0 ^ out7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_C5(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out3 = in4 ^ in7;
        tmp0 = in3 ^ in7;
        out4 = in1 ^ in2 ^ in6;
        out6 = in0 ^ in3 ^ in4;
        out5 = tmp0 ^ in2;
        out1 = tmp0 ^ out4;
        out0 = out4 ^ in0 ^ in5;
        out2 = out0 ^ out5 ^ in4;
        out7 = tmp0 ^ out2 ^ in6;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_C6(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3, tmp4, tmp5;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in5 ^ in6;
        tmp1 = in1 ^ in7;
        tmp2 = tmp0 ^ in0;
        tmp3 = tmp0 ^ tmp1;
        tmp4 = tmp2 ^ in4;
        out0 = tmp3 ^ in2;
        out6 = tmp4 ^ in3;
        out2 = out6 ^ in2;
        out7 = tmp1 ^ tmp4;
        out3 = tmp2 ^ out2;
        tmp5 = out3 ^ in5;
        out5 = tmp5 ^ in7;
        out4 = tmp3 ^ tmp5;
        out1 = tmp4 ^ out5;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_C7(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out3 = in2 ^ in4;
        tmp0 = in3 ^ in5;
        tmp1 = out3 ^ in7;
        out6 = tmp0 ^ in0 ^ in4;
        out5 = tmp1 ^ in3;
        out2 = out6 ^ in6;
        out7 = out2 ^ in1 ^ in3;
        out0 = tmp1 ^ out7;
        out1 = tmp0 ^ out0;
        out4 = out1 ^ in0;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_C8(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out0 = in1 ^ in2;
        out1 = in2 ^ in3;
        tmp0 = in5 ^ in6;
        tmp1 = in0 ^ in7;
        out2 = out1 ^ in1 ^ in4;
        out4 = tmp0 ^ in4;
        out5 = tmp0 ^ in7;
        out6 = tmp1 ^ in6;
        out7 = tmp1 ^ in1;
        out3 = out2 ^ in0 ^ in2 ^ in5;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_C9(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out4 = in5 ^ in6;
        out7 = in0 ^ in1;
        tmp0 = in1 ^ in3;
        out5 = in6 ^ in7;
        out6 = in0 ^ in7;
        out0 = out7 ^ in2;
        out3 = out7 ^ in4 ^ in5;
        out1 = tmp0 ^ in2;
        out2 = tmp0 ^ in4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_CA(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in7;
        tmp1 = in2 ^ in7;
        tmp2 = tmp0 ^ in6;
        out0 = tmp1 ^ in1;
        tmp3 = tmp1 ^ in3;
        out6 = tmp2 ^ in5;
        out7 = tmp2 ^ in1;
        out2 = tmp3 ^ in4;
        out5 = out6 ^ in0 ^ in4;
        out4 = out5 ^ in3;
        out1 = tmp0 ^ tmp3;
        out3 = tmp3 ^ out5 ^ out7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_CB(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in4 ^ in7;
        tmp1 = in5 ^ in7;
        out7 = in0 ^ in1 ^ in6;
        out5 = tmp0 ^ in6;
        out2 = tmp0 ^ in3;
        out6 = tmp1 ^ in0;
        out4 = tmp1 ^ in3 ^ in6;
        tmp2 = out5 ^ out7 ^ in2;
        out1 = tmp2 ^ out2;
        out0 = tmp2 ^ in4;
        out3 = tmp2 ^ in5;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_CC(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in3 ^ in5;
        tmp1 = in1 ^ in6;
        out1 = in2 ^ in3 ^ in7;
        out5 = tmp0 ^ in6;
        out0 = tmp1 ^ in2;
        tmp2 = out5 ^ in0 ^ in7;
        out3 = tmp2 ^ in4;
        out6 = tmp0 ^ out3;
        out7 = tmp1 ^ tmp2 ^ in3;
        tmp3 = out1 ^ out6;
        out4 = tmp2 ^ tmp3;
        out2 = tmp3 ^ in1;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_CD(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out5 = in3 ^ in6;
        tmp0 = in0 ^ in1;
        tmp1 = in2 ^ in7;
        out6 = in0 ^ in4 ^ in7;
        out2 = tmp0 ^ out5 ^ in4;
        out7 = tmp0 ^ in5;
        out0 = tmp0 ^ in2 ^ in6;
        out4 = tmp1 ^ in5;
        out1 = tmp1 ^ in1 ^ in3;
        out3 = out6 ^ in5 ^ in6;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_CE(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in2 ^ in5;
        tmp1 = tmp0 ^ in3;
        out4 = tmp1 ^ in4;
        tmp2 = out4 ^ in6;
        out3 = tmp2 ^ in0;
        out5 = tmp2 ^ in2;
        out2 = out3 ^ in5 ^ in7;
        out6 = tmp1 ^ out2;
        out7 = out2 ^ out4 ^ in1;
        out1 = tmp2 ^ out6;
        out0 = tmp0 ^ out7 ^ in0;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_CF(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in3 ^ in6;
        tmp1 = in0 ^ in1 ^ in5;
        out4 = in2 ^ in3 ^ in5;
        out5 = tmp0 ^ in4;
        out7 = tmp1 ^ in6;
        out1 = tmp1 ^ out4 ^ in7;
        tmp2 = out5 ^ in0;
        out2 = tmp2 ^ in7;
        out3 = tmp2 ^ out4;
        out6 = tmp0 ^ out2 ^ in5;
        out0 = tmp0 ^ out1;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_D0(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3, tmp4;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in3;
        tmp1 = in1 ^ in4;
        tmp2 = in2 ^ in5;
        out7 = tmp0 ^ tmp1;
        out0 = tmp1 ^ tmp2;
        tmp3 = tmp2 ^ in3;
        out1 = tmp3 ^ in6;
        tmp4 = out1 ^ in1;
        out2 = tmp4 ^ in7;
        out3 = out2 ^ in2;
        out4 = tmp0 ^ out3;
        out5 = tmp3 ^ out3;
        out6 = tmp4 ^ out4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_D1(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in3 ^ in5 ^ in6;
        tmp1 = tmp0 ^ in1;
        out1 = tmp1 ^ in2;
        out2 = tmp1 ^ in7;
        out3 = out2 ^ in3;
        out5 = out3 ^ in2;
        tmp2 = out3 ^ in0;
        out4 = tmp2 ^ in4;
        out7 = tmp0 ^ out4;
        out6 = tmp2 ^ out1 ^ in6;
        out0 = out2 ^ out6 ^ in4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_D2(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in5 ^ in6;
        out2 = tmp0 ^ in2 ^ in3;
        out1 = out2 ^ in0;
        out3 = out2 ^ in1;
        out4 = out1 ^ in1 ^ in2;
        out6 = out1 ^ in6 ^ in7;
        out7 = out4 ^ in4 ^ in5;
        out5 = out4 ^ out6 ^ in4;
        out0 = tmp0 ^ out5;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_D3(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out2 = in3 ^ in5 ^ in6;
        tmp0 = out2 ^ in2;
        tmp1 = tmp0 ^ in1;
        out1 = tmp1 ^ in0;
        out3 = tmp1 ^ in3;
        out4 = out1 ^ in2 ^ in4;
        tmp2 = out4 ^ in5;
        out7 = tmp2 ^ in7;
        out0 = tmp0 ^ out7;
        tmp3 = out0 ^ in0;
        out5 = tmp3 ^ in6;
        out6 = tmp2 ^ tmp3;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_D4(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out3 = in3 ^ in5;
        tmp0 = in1 ^ in5;
        tmp1 = tmp0 ^ in2;
        out4 = tmp1 ^ in0;
        tmp2 = tmp1 ^ in6;
        out2 = out4 ^ in3 ^ in7;
        out0 = tmp2 ^ in4;
        out5 = tmp2 ^ out3;
        out1 = tmp0 ^ out5 ^ in7;
        out6 = tmp0 ^ out2 ^ in4;
        out7 = tmp1 ^ out6 ^ in7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_D5(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out3 = in5;
        tmp0 = in0 ^ in4;
        tmp1 = tmp0 ^ in1 ^ in5;
        out4 = tmp1 ^ in2;
        out0 = out4 ^ in6;
        tmp2 = tmp0 ^ out0;
        out5 = tmp2 ^ in3;
        out1 = out5 ^ in7;
        out6 = tmp1 ^ out1;
        out7 = tmp2 ^ out6;
        out2 = out7 ^ in4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_D6(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in1 ^ in2 ^ in4 ^ in6;
        out5 = tmp0 ^ in3;
        out0 = tmp0 ^ in5 ^ in7;
        out3 = out0 ^ out5 ^ in2;
        tmp1 = out3 ^ in0;
        out1 = tmp1 ^ in6;
        out2 = tmp1 ^ in7;
        out4 = tmp1 ^ in1;
        out6 = tmp1 ^ in4;
        out7 = tmp0 ^ out2;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_D7(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in3;
        out3 = in2 ^ in5 ^ in7;
        out2 = tmp0 ^ in5;
        tmp1 = tmp0 ^ out3 ^ in1;
        out1 = tmp1 ^ in6;
        out4 = tmp1 ^ in4;
        tmp2 = out1 ^ in4;
        out6 = tmp2 ^ in1;
        out7 = tmp2 ^ in2;
        out0 = tmp2 ^ in3;
        out5 = tmp2 ^ in0 ^ in7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_D8(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out4 = in0;
        out5 = in1;
        tmp0 = in1 ^ in2;
        out6 = in0 ^ in2;
        out0 = tmp0 ^ in4;
        tmp1 = tmp0 ^ in3;
        out7 = tmp1 ^ out6;
        out2 = tmp1 ^ in6;
        out3 = out7 ^ in7;
        out1 = tmp1 ^ in1 ^ in5;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_D9(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out4 = in0 ^ in4;
        out5 = in1 ^ in5;
        out2 = in1 ^ in3 ^ in6;
        out3 = in0 ^ in1 ^ in7;
        out6 = in0 ^ in2 ^ in6;
        out0 = out4 ^ in1 ^ in2;
        out1 = out5 ^ in2 ^ in3;
        out7 = out3 ^ in3;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_DA(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out5 = in1 ^ in4;
        tmp0 = in2 ^ in7;
        tmp1 = in0 ^ in2 ^ in3;
        out0 = tmp0 ^ out5;
        out4 = tmp0 ^ tmp1;
        out2 = tmp0 ^ in3 ^ in6;
        out1 = tmp1 ^ in5;
        out3 = tmp1 ^ in1;
        out6 = out1 ^ in3;
        out7 = out3 ^ in2 ^ in6;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_DB(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3, tmp4;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in1;
        tmp1 = in1 ^ in5;
        tmp2 = in3 ^ in7;
        out3 = tmp0 ^ in2;
        out5 = tmp1 ^ in4;
        out6 = tmp1 ^ out3 ^ in6;
        out2 = tmp2 ^ in6;
        tmp3 = tmp2 ^ in4;
        tmp4 = out3 ^ in3;
        out4 = tmp3 ^ in0;
        out1 = tmp4 ^ in5;
        out0 = tmp3 ^ tmp4;
        out7 = tmp0 ^ out2;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_DC(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in2;
        tmp1 = in0 ^ in3;
        out6 = tmp0 ^ in4;
        tmp2 = tmp0 ^ in7;
        out3 = tmp1 ^ in6;
        tmp3 = tmp1 ^ in1;
        out1 = tmp1 ^ tmp2 ^ in5;
        out4 = tmp2 ^ in6;
        out2 = tmp3 ^ in2;
        out7 = tmp3 ^ in5;
        out5 = tmp2 ^ out2;
        out0 = out2 ^ out3 ^ in4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_DD(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out3 = in0 ^ in6;
        out2 = in0 ^ in1 ^ in3;
        out6 = out3 ^ in2 ^ in4;
        out7 = out2 ^ in5 ^ in7;
        out0 = out6 ^ in1;
        out4 = out6 ^ in7;
        out5 = out7 ^ in0;
        out1 = out5 ^ in2;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_DE(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in2 ^ in3 ^ in6;
        tmp1 = in3 ^ in4 ^ in7;
        out4 = tmp0 ^ in0;
        out5 = tmp1 ^ in1;
        out3 = out4 ^ in7;
        out2 = out3 ^ in6;
        out1 = out2 ^ in5;
        out6 = tmp1 ^ out1;
        out0 = tmp0 ^ out5;
        out7 = out0 ^ out1 ^ in4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_DF(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out2 = in0 ^ in3 ^ in7;
        tmp0 = out2 ^ in1 ^ in5;
        out1 = tmp0 ^ in2;
        out7 = tmp0 ^ in6;
        out5 = tmp0 ^ in0 ^ in4;
        tmp1 = out1 ^ out5 ^ in6;
        out4 = tmp1 ^ in3;
        out6 = tmp1 ^ in5;
        tmp2 = tmp1 ^ in7;
        out0 = tmp2 ^ in1;
        out3 = tmp2 ^ in4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_E0(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out3 = in1 ^ in7;
        tmp0 = in2 ^ in4;
        out4 = out3 ^ in3 ^ in5;
        out2 = tmp0 ^ in1;
        tmp1 = tmp0 ^ in6;
        out0 = out4 ^ in2;
        out6 = out4 ^ in0;
        out1 = tmp1 ^ in3;
        out5 = tmp1 ^ in0;
        out7 = out5 ^ in1;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_E1(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out2 = in1 ^ in4;
        tmp0 = in1 ^ in7;
        out3 = tmp0 ^ in3;
        tmp1 = out3 ^ in5;
        out4 = tmp1 ^ in4;
        tmp2 = tmp1 ^ in0;
        out0 = tmp2 ^ in2;
        out6 = tmp2 ^ in6;
        tmp3 = out0 ^ out4 ^ in6;
        out5 = tmp3 ^ in5;
        out7 = tmp0 ^ tmp3;
        out1 = tmp2 ^ out5 ^ in7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_E2(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out3 = in1 ^ in2;
        out4 = in1 ^ in5;
        out2 = in2 ^ in4 ^ in7;
        out5 = in0 ^ in2 ^ in6;
        out0 = out3 ^ in3 ^ in5;
        out7 = out3 ^ in0 ^ in4;
        out6 = out2 ^ out7 ^ in3;
        out1 = out5 ^ in3 ^ in4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_E3(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3, tmp4;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out2 = in4 ^ in7;
        tmp0 = in1 ^ in3;
        out3 = tmp0 ^ in2;
        tmp1 = out3 ^ in0;
        out0 = tmp1 ^ in5;
        tmp2 = tmp1 ^ in4;
        out1 = tmp2 ^ in6;
        tmp3 = tmp2 ^ in3;
        out7 = tmp3 ^ in7;
        out6 = out1 ^ out2 ^ in2;
        tmp4 = tmp0 ^ out0;
        out5 = tmp4 ^ in6;
        out4 = tmp3 ^ tmp4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_E4(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out3 = in6;
        tmp0 = in0 ^ in4;
        tmp1 = tmp0 ^ in2 ^ in6;
        out2 = tmp1 ^ in1;
        out7 = out2 ^ in5;
        tmp2 = tmp0 ^ out7;
        out4 = tmp2 ^ in3;
        out0 = out4 ^ in7;
        out6 = tmp1 ^ out0;
        out5 = tmp2 ^ out6;
        out1 = out5 ^ in0;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_E5(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out3 = in3 ^ in6;
        tmp0 = in0 ^ in1;
        tmp1 = in5 ^ in7;
        out2 = tmp0 ^ in4 ^ in6;
        tmp2 = tmp1 ^ out2;
        out6 = tmp2 ^ in3;
        out7 = tmp2 ^ in2;
        out0 = out6 ^ in2 ^ in4;
        out5 = out6 ^ in1 ^ in2;
        out1 = tmp0 ^ out5 ^ in5;
        out4 = tmp1 ^ out1;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_E6(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out3 = in2 ^ in6 ^ in7;
        out2 = out3 ^ in0 ^ in4;
        out4 = out3 ^ in1 ^ in5;
        out1 = out2 ^ in3;
        out7 = out2 ^ out4 ^ in2;
        out0 = out4 ^ in3 ^ in7;
        out5 = out1 ^ in4;
        out6 = out0 ^ out2 ^ in5;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_E7(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3, tmp4;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in2 ^ in3;
        out3 = tmp0 ^ in6 ^ in7;
        tmp1 = out3 ^ in0;
        out5 = tmp1 ^ in5;
        tmp2 = tmp1 ^ in4;
        tmp3 = out5 ^ in7;
        out1 = tmp2 ^ in1;
        out0 = tmp3 ^ in1;
        out6 = out1 ^ in2;
        out2 = tmp0 ^ tmp2;
        tmp4 = tmp3 ^ out6;
        out4 = tmp4 ^ in6;
        out7 = tmp4 ^ in0;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_E8(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out4 = in3 ^ in6;
        tmp0 = in4 ^ in7;
        out1 = in2 ^ in3 ^ in4;
        out5 = tmp0 ^ in0;
        tmp1 = tmp0 ^ in1;
        tmp2 = tmp1 ^ in5;
        out0 = tmp1 ^ out1;
        out2 = tmp2 ^ in2;
        out6 = tmp2 ^ out5;
        tmp3 = out6 ^ in6;
        out3 = tmp3 ^ in7;
        out7 = tmp3 ^ in2 ^ in5;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_E9(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in1;
        tmp1 = in3 ^ in6;
        tmp2 = tmp0 ^ in6;
        out4 = tmp1 ^ in4;
        out6 = tmp2 ^ in5;
        out7 = tmp2 ^ in2 ^ in7;
        out3 = out6 ^ in3 ^ in7;
        out0 = tmp1 ^ out7;
        out2 = out3 ^ out4 ^ in0;
        out5 = tmp0 ^ out2;
        out1 = out0 ^ out5 ^ in5;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_EA(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out4 = in6 ^ in7;
        out5 = in0 ^ in7;
        out6 = in0 ^ in1;
        out0 = in1 ^ in2 ^ in3;
        out2 = in2 ^ in4 ^ in5;
        out7 = out6 ^ in2;
        out1 = out0 ^ out6 ^ in4;
        out3 = out7 ^ in5 ^ in6;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_EB(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out2 = in4 ^ in5;
        tmp0 = in0 ^ in1;
        out4 = in4 ^ in6 ^ in7;
        out5 = in0 ^ in5 ^ in7;
        out6 = tmp0 ^ in6;
        tmp1 = tmp0 ^ in2;
        out0 = tmp1 ^ in3;
        out7 = tmp1 ^ in7;
        out1 = out0 ^ in4;
        out3 = out0 ^ in5 ^ in6;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_EC(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out3 = in0 ^ in5;
        out4 = in2 ^ in3 ^ in7;
        out5 = in0 ^ in3 ^ in4;
        out6 = out3 ^ in1 ^ in4;
        out1 = out4 ^ in4;
        out0 = out4 ^ in1 ^ in6;
        out2 = out0 ^ out5 ^ in5;
        out7 = out2 ^ in4 ^ in7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_ED(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in2 ^ in4;
        tmp1 = in3 ^ in5;
        out4 = tmp0 ^ in3 ^ in7;
        out3 = tmp1 ^ in0;
        out1 = out4 ^ in1;
        out5 = out3 ^ in4;
        out7 = out1 ^ out5 ^ in6;
        out2 = tmp0 ^ out7;
        out0 = tmp1 ^ out7;
        out6 = out2 ^ in7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_EE(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out4 = in2;
        tmp0 = in0 ^ in1;
        out5 = in0 ^ in3;
        tmp1 = tmp0 ^ in2;
        out6 = tmp0 ^ in4;
        tmp2 = tmp1 ^ out5;
        out7 = tmp1 ^ in5;
        out1 = tmp2 ^ out6 ^ in7;
        out0 = tmp2 ^ in6;
        tmp3 = out7 ^ in1;
        out3 = tmp3 ^ in7;
        out2 = tmp3 ^ in4 ^ in6;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_EF(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out4 = in2 ^ in4;
        tmp0 = in0 ^ in5;
        tmp1 = in4 ^ in6;
        out5 = tmp0 ^ in3;
        out2 = tmp0 ^ tmp1;
        out6 = tmp1 ^ in0 ^ in1;
        out3 = out5 ^ in2 ^ in7;
        out7 = out3 ^ in1 ^ in3;
        out0 = out4 ^ out6 ^ in3;
        out1 = tmp1 ^ out0 ^ in7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_F0(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in1 ^ in2;
        tmp1 = in4 ^ in5;
        out2 = tmp0 ^ in6;
        out3 = tmp1 ^ in1;
        tmp2 = tmp1 ^ in7;
        out1 = out2 ^ out3 ^ in3;
        tmp3 = tmp0 ^ tmp2;
        out0 = tmp3 ^ in3;
        out5 = tmp3 ^ in0;
        out4 = out1 ^ out5 ^ in4;
        out7 = out4 ^ in2;
        out6 = tmp2 ^ out7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_F1(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out2 = in1 ^ in6;
        tmp0 = in3 ^ in5;
        out3 = tmp0 ^ in1 ^ in4;
        tmp1 = out3 ^ in2;
        out1 = tmp1 ^ in6;
        tmp2 = tmp1 ^ in0;
        tmp3 = out1 ^ in5;
        out0 = tmp2 ^ in7;
        out6 = tmp2 ^ in4;
        out7 = tmp3 ^ in0;
        out5 = tmp0 ^ out0;
        out4 = tmp3 ^ out5 ^ in1;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_F2(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in4 ^ in5;
        out2 = in2 ^ in6 ^ in7;
        tmp1 = tmp0 ^ in1;
        tmp2 = tmp1 ^ in2;
        out0 = tmp2 ^ in3;
        out3 = tmp2 ^ in7;
        out5 = out3 ^ in0 ^ in4;
        tmp3 = tmp0 ^ out5;
        out7 = tmp3 ^ in3;
        out4 = tmp3 ^ out2;
        out1 = out0 ^ out4 ^ in4;
        out6 = tmp1 ^ out1;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_F3(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out2 = in6 ^ in7;
        tmp0 = in0 ^ in1;
        out4 = tmp0 ^ in6;
        tmp1 = tmp0 ^ in2;
        out5 = tmp1 ^ in7;
        out6 = tmp1 ^ in3;
        out7 = out6 ^ in4;
        out0 = out7 ^ in5;
        out1 = out0 ^ in6;
        out3 = out0 ^ in0 ^ in7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_F4(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out2 = in0 ^ in1 ^ in2;
        tmp0 = out2 ^ in3;
        out4 = tmp0 ^ in4;
        out5 = out4 ^ in5;
        out6 = out5 ^ in6;
        out7 = out6 ^ in7;
        out0 = out7 ^ in0;
        out1 = out0 ^ in1;
        out3 = tmp0 ^ out7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_F5(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out2 = in0 ^ in1;
        tmp0 = out2 ^ in2;
        out4 = tmp0 ^ in3;
        out5 = out4 ^ in4;
        out6 = out5 ^ in5;
        out7 = out6 ^ in6;
        out0 = out7 ^ in7;
        out1 = out0 ^ in0;
        out3 = tmp0 ^ out0;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_F6(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in7;
        out2 = tmp0 ^ in2;
        out4 = out2 ^ in1 ^ in4;
        out7 = out4 ^ in3 ^ in5;
        out5 = out7 ^ in4 ^ in7;
        out0 = tmp0 ^ out7 ^ in6;
        tmp1 = out0 ^ in1;
        out6 = out0 ^ in0 ^ in5;
        out3 = tmp1 ^ in3;
        out1 = tmp0 ^ tmp1;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_F7(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out2 = in0 ^ in7;
        tmp0 = out2 ^ in1;
        out4 = tmp0 ^ in2;
        out5 = out4 ^ in3 ^ in7;
        out6 = out5 ^ in4;
        out7 = out6 ^ in5;
        out0 = out7 ^ in6;
        out1 = out0 ^ in7;
        out3 = tmp0 ^ out1;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_F8(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in4;
        tmp1 = in3 ^ in5;
        tmp2 = tmp0 ^ in6;
        out4 = tmp0 ^ tmp1;
        out1 = tmp1 ^ in2 ^ in4;
        out3 = tmp2 ^ in1;
        out5 = out3 ^ in5;
        out7 = out1 ^ out5 ^ in7;
        out6 = tmp1 ^ out7;
        out0 = tmp2 ^ out7;
        out2 = out6 ^ in0;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_F9(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3, tmp4;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in3 ^ in5;
        tmp1 = in0 ^ in6;
        out4 = tmp0 ^ in0;
        tmp2 = tmp1 ^ in4;
        tmp3 = tmp1 ^ in2;
        out5 = tmp2 ^ in1;
        out3 = out5 ^ in3;
        tmp4 = tmp3 ^ out3;
        out1 = tmp4 ^ in5;
        out0 = tmp4 ^ in0 ^ in7;
        out6 = tmp0 ^ out0 ^ in4;
        out7 = tmp2 ^ tmp4;
        out2 = tmp3 ^ out6;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_FA(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in1;
        tmp1 = tmp0 ^ in2;
        tmp2 = tmp0 ^ in5;
        tmp3 = tmp1 ^ in7;
        out5 = tmp2 ^ in6;
        out6 = tmp3 ^ in6;
        out7 = tmp3 ^ in3;
        out3 = out6 ^ in4;
        out2 = tmp1 ^ out5;
        out4 = out2 ^ out3 ^ in1;
        out0 = out4 ^ out7 ^ in5;
        out1 = tmp2 ^ out0;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_FB(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out2 = in5 ^ in6;
        tmp0 = in0 ^ in1;
        out4 = in0 ^ in5 ^ in7;
        out5 = tmp0 ^ in6;
        tmp1 = tmp0 ^ in2;
        out6 = tmp1 ^ in7;
        out7 = tmp1 ^ in3;
        out0 = out7 ^ in4;
        out1 = out0 ^ in5;
        out3 = out0 ^ in6 ^ in7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_FC(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in1 ^ in2;
        tmp1 = in0 ^ in7;
        out2 = tmp0 ^ tmp1 ^ in5;
        out3 = tmp1 ^ in4;
        tmp2 = out2 ^ in6;
        out6 = tmp2 ^ in4;
        out7 = tmp2 ^ in3;
        out4 = out6 ^ in1 ^ in3;
        tmp3 = out4 ^ in0;
        out1 = tmp3 ^ in6;
        out0 = tmp3 ^ in1 ^ in5;
        out5 = tmp0 ^ out4;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_FD(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in5;
        tmp1 = in1 ^ in7;
        out2 = tmp0 ^ tmp1;
        out6 = out2 ^ in2 ^ in4;
        tmp2 = out6 ^ in0;
        out1 = tmp2 ^ in3;
        out0 = tmp0 ^ out1 ^ in6;
        out5 = out0 ^ in2;
        tmp3 = out5 ^ in1;
        out3 = tmp3 ^ in6;
        out7 = tmp2 ^ tmp3;
        out4 = tmp1 ^ out7;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_FE(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3, tmp4;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        tmp0 = in0 ^ in2;
        out2 = tmp0 ^ in5;
        out3 = tmp0 ^ in4;
        tmp1 = out3 ^ in6;
        out4 = tmp1 ^ in5;
        tmp2 = tmp1 ^ in1;
        out6 = tmp2 ^ in7;
        tmp3 = tmp2 ^ in0;
        out0 = tmp3 ^ in3;
        tmp4 = out0 ^ out4 ^ in7;
        out5 = tmp4 ^ in6;
        out7 = tmp4 ^ in2;
        out1 = tmp3 ^ out5;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void gf8_muladd_FF(uint8_t * out, uint8_t * in, unsigned int width)
{
    unsigned int i;
    uint64_t * in_ptr = (uint64_t *)in;
    uint64_t * out_ptr = (uint64_t *)out;

    for (i = 0; i < width; i++)
    {
        uint64_t out0, out1, out2, out3, out4, out5, out6, out7;
        uint64_t tmp0, tmp1, tmp2, tmp3;

        uint64_t in0 = out_ptr[0];
        uint64_t in1 = out_ptr[width];
        uint64_t in2 = out_ptr[width * 2];
        uint64_t in3 = out_ptr[width * 3];
        uint64_t in4 = out_ptr[width * 4];
        uint64_t in5 = out_ptr[width * 5];
        uint64_t in6 = out_ptr[width * 6];
        uint64_t in7 = out_ptr[width * 7];

        out2 = in0 ^ in5;
        tmp0 = in4 ^ in7;
        tmp1 = out2 ^ in2;
        out4 = tmp1 ^ in6;
        out7 = tmp1 ^ in1 ^ in3;
        out1 = tmp0 ^ out7;
        tmp2 = out1 ^ in5;
        out6 = tmp2 ^ in3;
        tmp3 = tmp2 ^ in7;
        out0 = tmp3 ^ in6;
        out3 = tmp3 ^ in1;
        out5 = tmp0 ^ out0 ^ in2;

        out_ptr[0] = out0 ^ in_ptr[0];
        out_ptr[width] = out1 ^ in_ptr[width];
        out_ptr[width * 2] = out2 ^ in_ptr[width * 2];
        out_ptr[width * 3] = out3 ^ in_ptr[width * 3];
        out_ptr[width * 4] = out4 ^ in_ptr[width * 4];
        out_ptr[width * 5] = out5 ^ in_ptr[width * 5];
        out_ptr[width * 6] = out6 ^ in_ptr[width * 6];
        out_ptr[width * 7] = out7 ^ in_ptr[width * 7];

        in_ptr++;
        out_ptr++;
    }
}

__device__ void ec_gf_muladd(uint32_t row,uint8_t *out, uint8_t *in,unsigned int width)
{
	switch(row)
	{
	case 0:
	gf8_muladd_00(out,in,width);
	break;
	case 1:
	gf8_muladd_01(out,in,width);
	break;
	case 2:
	gf8_muladd_02(out,in,width);
	break;
	case 3:
	gf8_muladd_03(out,in,width);
	break;
	case 4:
	gf8_muladd_04(out,in,width);
	break;
	case 5:
	gf8_muladd_05(out,in,width);
	break;
	case 6:
	gf8_muladd_06(out,in,width);
	break;
	case 7:
	gf8_muladd_07(out,in,width);
	break;
	case 8:
	gf8_muladd_08(out,in,width);
	break;
	case 9:
	gf8_muladd_09(out,in,width);
	break;
	case 10:
	gf8_muladd_0A(out,in,width);
	break;
	case 11:
	gf8_muladd_0B(out,in,width);
	break;
	case 12:
	gf8_muladd_0C(out,in,width);
	break;
	case 13:
	gf8_muladd_0D(out,in,width);
	break;
	case 14:
	gf8_muladd_0E(out,in,width);
	break;
	case 15:
	gf8_muladd_0F(out,in,width);
	break;
	case 16:
	gf8_muladd_10(out,in,width);
	break;
	case 17:
	gf8_muladd_11(out,in,width);
	break;
	case 18:
	gf8_muladd_12(out,in,width);
	break;
	case 19:
	gf8_muladd_13(out,in,width);
	break;
	case 20:
	gf8_muladd_14(out,in,width);
	break;
	case 21:
	gf8_muladd_15(out,in,width);
	break;
	case 22:
	gf8_muladd_16(out,in,width);
	break;
	case 23:
	gf8_muladd_17(out,in,width);
	break;
	case 24:
	gf8_muladd_18(out,in,width);
	break;
	case 25:
	gf8_muladd_19(out,in,width);
	break;
	case 26:
	gf8_muladd_1A(out,in,width);
	break;
	case 27:
	gf8_muladd_1B(out,in,width);
	break;
	case 28:
	gf8_muladd_1C(out,in,width);
	break;
	case 29:
	gf8_muladd_1D(out,in,width);
	break;
	case 30:
	gf8_muladd_1E(out,in,width);
	break;
	case 31:
	gf8_muladd_1F(out,in,width);
	break;
	case 32:
	gf8_muladd_20(out,in,width);
	break;
	case 33:
	gf8_muladd_21(out,in,width);
	break;
	case 34:
	gf8_muladd_22(out,in,width);
	break;
	case 35:
	gf8_muladd_23(out,in,width);
	break;
	case 36:
	gf8_muladd_24(out,in,width);
	break;
	case 37:
	gf8_muladd_25(out,in,width);
	break;
	case 38:
	gf8_muladd_26(out,in,width);
	break;
	case 39:
	gf8_muladd_27(out,in,width);
	break;
	case 40:
	gf8_muladd_28(out,in,width);
	break;
	case 41:
	gf8_muladd_29(out,in,width);
	break;
	case 42:
	gf8_muladd_2A(out,in,width);
	break;
	case 43:
	gf8_muladd_2B(out,in,width);
	break;
	case 44:
	gf8_muladd_2C(out,in,width);
	break;
	case 45:
	gf8_muladd_2D(out,in,width);
	break;
	case 46:
	gf8_muladd_2E(out,in,width);
	break;
	case 47:
	gf8_muladd_2F(out,in,width);
	break;
	case 48:
	gf8_muladd_30(out,in,width);
	break;
	case 49:
	gf8_muladd_31(out,in,width);
	break;
	case 50:
	gf8_muladd_32(out,in,width);
	break;
	case 51:
	gf8_muladd_33(out,in,width);
	break;
	case 52:
	gf8_muladd_34(out,in,width);
	break;
	case 53:
	gf8_muladd_35(out,in,width);
	break;
	case 54:
	gf8_muladd_36(out,in,width);
	break;
	case 55:
	gf8_muladd_37(out,in,width);
	break;
	case 56:
	gf8_muladd_38(out,in,width);
	break;
	case 57:
	gf8_muladd_39(out,in,width);
	break;
	case 58:
	gf8_muladd_3A(out,in,width);
	break;
	case 59:
	gf8_muladd_3B(out,in,width);
	break;
	case 60:
	gf8_muladd_3C(out,in,width);
	break;
	case 61:
	gf8_muladd_3D(out,in,width);
	break;
	case 62:
	gf8_muladd_3E(out,in,width);
	break;
	case 63:
	gf8_muladd_3F(out,in,width);
	break;
	case 64:
	gf8_muladd_40(out,in,width);
	break;
	case 65:
	gf8_muladd_41(out,in,width);
	break;
	case 66:
	gf8_muladd_42(out,in,width);
	break;
	case 67:
	gf8_muladd_43(out,in,width);
	break;
	case 68:
	gf8_muladd_44(out,in,width);
	break;
	case 69:
	gf8_muladd_45(out,in,width);
	break;
	case 70:
	gf8_muladd_46(out,in,width);
	break;
	case 71:
	gf8_muladd_47(out,in,width);
	break;
	case 72:
	gf8_muladd_48(out,in,width);
	break;
	case 73:
	gf8_muladd_49(out,in,width);
	break;
	case 74:
	gf8_muladd_4A(out,in,width);
	break;
	case 75:
	gf8_muladd_4B(out,in,width);
	break;
	case 76:
	gf8_muladd_4C(out,in,width);
	break;
	case 77:
	gf8_muladd_4D(out,in,width);
	break;
	case 78:
	gf8_muladd_4E(out,in,width);
	break;
	case 79:
	gf8_muladd_4F(out,in,width);
	break;
	case 80:
	gf8_muladd_50(out,in,width);
	break;
	case 81:
	gf8_muladd_51(out,in,width);
	break;
	case 82:
	gf8_muladd_52(out,in,width);
	break;
	case 83:
	gf8_muladd_53(out,in,width);
	break;
	case 84:
	gf8_muladd_54(out,in,width);
	break;
	case 85:
	gf8_muladd_55(out,in,width);
	break;
	case 86:
	gf8_muladd_56(out,in,width);
	break;
	case 87:
	gf8_muladd_57(out,in,width);
	break;
	case 88:
	gf8_muladd_58(out,in,width);
	break;
	case 89:
	gf8_muladd_59(out,in,width);
	break;
	case 90:
	gf8_muladd_5A(out,in,width);
	break;
	case 91:
	gf8_muladd_5B(out,in,width);
	break;
	case 92:
	gf8_muladd_5C(out,in,width);
	break;
	case 93:
	gf8_muladd_5D(out,in,width);
	break;
	case 94:
	gf8_muladd_5E(out,in,width);
	break;
	case 95:
	gf8_muladd_5F(out,in,width);
	break;
	case 96:
	gf8_muladd_60(out,in,width);
	break;
	case 97:
	gf8_muladd_61(out,in,width);
	break;
	case 98:
	gf8_muladd_62(out,in,width);
	break;
	case 99:
	gf8_muladd_63(out,in,width);
	break;
	case 100:
	gf8_muladd_64(out,in,width);
	break;
	case 101:
	gf8_muladd_65(out,in,width);
	break;
	case 102:
	gf8_muladd_66(out,in,width);
	break;
	case 103:
	gf8_muladd_67(out,in,width);
	break;
	case 104:
	gf8_muladd_68(out,in,width);
	break;
	case 105:
	gf8_muladd_69(out,in,width);
	break;
	case 106:
	gf8_muladd_6A(out,in,width);
	break;
	case 107:
	gf8_muladd_6B(out,in,width);
	break;
	case 108:
	gf8_muladd_6C(out,in,width);
	break;
	case 109:
	gf8_muladd_6D(out,in,width);
	break;
	case 110:
	gf8_muladd_6E(out,in,width);
	break;
	case 111:
	gf8_muladd_6F(out,in,width);
	break;
	case 112:
	gf8_muladd_70(out,in,width);
	break;
	case 113:
	gf8_muladd_71(out,in,width);
	break;
	case 114:
	gf8_muladd_72(out,in,width);
	break;
	case 115:
	gf8_muladd_73(out,in,width);
	break;
	case 116:
	gf8_muladd_74(out,in,width);
	break;
	case 117:
	gf8_muladd_75(out,in,width);
	break;
	case 118:
	gf8_muladd_76(out,in,width);
	break;
	case 119:
	gf8_muladd_77(out,in,width);
	break;
	case 120:
	gf8_muladd_78(out,in,width);
	break;
	case 121:
	gf8_muladd_79(out,in,width);
	break;
	case 122:
	gf8_muladd_7A(out,in,width);
	break;
	case 123:
	gf8_muladd_7B(out,in,width);
	break;
	case 124:
	gf8_muladd_7C(out,in,width);
	break;
	case 125:
	gf8_muladd_7D(out,in,width);
	break;
	case 126:
	gf8_muladd_7E(out,in,width);
	break;
	case 127:
	gf8_muladd_7F(out,in,width);
	break;
	case 128:
	gf8_muladd_80(out,in,width);
	break;
	case 129:
	gf8_muladd_81(out,in,width);
	break;
	case 130:
	gf8_muladd_82(out,in,width);
	break;
	case 131:
	gf8_muladd_83(out,in,width);
	break;
	case 132:
	gf8_muladd_84(out,in,width);
	break;
	case 133:
	gf8_muladd_85(out,in,width);
	break;
	case 134:
	gf8_muladd_86(out,in,width);
	break;
	case 135:
	gf8_muladd_87(out,in,width);
	break;
	case 136:
	gf8_muladd_88(out,in,width);
	break;
	case 137:
	gf8_muladd_89(out,in,width);
	break;
	case 138:
	gf8_muladd_8A(out,in,width);
	break;
	case 139:
	gf8_muladd_8B(out,in,width);
	break;
	case 140:
	gf8_muladd_8C(out,in,width);
	break;
	case 141:
	gf8_muladd_8D(out,in,width);
	break;
	case 142:
	gf8_muladd_8E(out,in,width);
	break;
	case 143:
	gf8_muladd_8F(out,in,width);
	break;
	case 144:
	gf8_muladd_90(out,in,width);
	break;
	case 145:
	gf8_muladd_91(out,in,width);
	break;
	case 146:
	gf8_muladd_92(out,in,width);
	break;
	case 147:
	gf8_muladd_93(out,in,width);
	break;
	case 148:
	gf8_muladd_94(out,in,width);
	break;
	case 149:
	gf8_muladd_95(out,in,width);
	break;
	case 150:
	gf8_muladd_96(out,in,width);
	break;
	case 151:
	gf8_muladd_97(out,in,width);
	break;
	case 152:
	gf8_muladd_98(out,in,width);
	break;
	case 153:
	gf8_muladd_99(out,in,width);
	break;
	case 154:
	gf8_muladd_9A(out,in,width);
	break;
	case 155:
	gf8_muladd_9B(out,in,width);
	break;
	case 156:
	gf8_muladd_9C(out,in,width);
	break;
	case 157:
	gf8_muladd_9D(out,in,width);
	break;
	case 158:
	gf8_muladd_9E(out,in,width);
	break;
	case 159:
	gf8_muladd_9F(out,in,width);
	break;
	case 160:
	gf8_muladd_A0(out,in,width);
	break;
	case 161:
	gf8_muladd_A1(out,in,width);
	break;
	case 162:
	gf8_muladd_A2(out,in,width);
	break;
	case 163:
	gf8_muladd_A3(out,in,width);
	break;
	case 164:
	gf8_muladd_A4(out,in,width);
	break;
	case 165:
	gf8_muladd_A5(out,in,width);
	break;
	case 166:
	gf8_muladd_A6(out,in,width);
	break;
	case 167:
	gf8_muladd_A7(out,in,width);
	break;
	case 168:
	gf8_muladd_A8(out,in,width);
	break;
	case 169:
	gf8_muladd_A9(out,in,width);
	break;
	case 170:
	gf8_muladd_AA(out,in,width);
	break;
	case 171:
	gf8_muladd_AB(out,in,width);
	break;
	case 172:
	gf8_muladd_AC(out,in,width);
	break;
	case 173:
	gf8_muladd_AD(out,in,width);
	break;
	case 174:
	gf8_muladd_AE(out,in,width);
	break;
	case 175:
	gf8_muladd_AF(out,in,width);
	break;
	case 176:
	gf8_muladd_B0(out,in,width);
	break;
	case 177:
	gf8_muladd_B1(out,in,width);
	break;
	case 178:
	gf8_muladd_B2(out,in,width);
	break;
	case 179:
	gf8_muladd_B3(out,in,width);
	break;
	case 180:
	gf8_muladd_B4(out,in,width);
	break;
	case 181:
	gf8_muladd_B5(out,in,width);
	break;
	case 182:
	gf8_muladd_B6(out,in,width);
	break;
	case 183:
	gf8_muladd_B7(out,in,width);
	break;
	case 184:
	gf8_muladd_B8(out,in,width);
	break;
	case 185:
	gf8_muladd_B9(out,in,width);
	break;
	case 186:
	gf8_muladd_BA(out,in,width);
	break;
	case 187:
	gf8_muladd_BB(out,in,width);
	break;
	case 188:
	gf8_muladd_BC(out,in,width);
	break;
	case 189:
	gf8_muladd_BD(out,in,width);
	break;
	case 190:
	gf8_muladd_BE(out,in,width);
	break;
	case 191:
	gf8_muladd_BF(out,in,width);
	break;
	case 192:
	gf8_muladd_C0(out,in,width);
	break;
	case 193:
	gf8_muladd_C1(out,in,width);
	break;
	case 194:
	gf8_muladd_C2(out,in,width);
	break;
	case 195:
	gf8_muladd_C3(out,in,width);
	break;
	case 196:
	gf8_muladd_C4(out,in,width);
	break;
	case 197:
	gf8_muladd_C5(out,in,width);
	break;
	case 198:
	gf8_muladd_C6(out,in,width);
	break;
	case 199:
	gf8_muladd_C7(out,in,width);
	break;
	case 200:
	gf8_muladd_C8(out,in,width);
	break;
	case 201:
	gf8_muladd_C9(out,in,width);
	break;
	case 202:
	gf8_muladd_CA(out,in,width);
	break;
	case 203:
	gf8_muladd_CB(out,in,width);
	break;
	case 204:
	gf8_muladd_CC(out,in,width);
	break;
	case 205:
	gf8_muladd_CD(out,in,width);
	break;
	case 206:
	gf8_muladd_CE(out,in,width);
	break;
	case 207:
	gf8_muladd_CF(out,in,width);
	break;
	case 208:
	gf8_muladd_D0(out,in,width);
	break;
	case 209:
	gf8_muladd_D1(out,in,width);
	break;
	case 210:
	gf8_muladd_D2(out,in,width);
	break;
	case 211:
	gf8_muladd_D3(out,in,width);
	break;
	case 212:
	gf8_muladd_D4(out,in,width);
	break;
	case 213:
	gf8_muladd_D5(out,in,width);
	break;
	case 214:
	gf8_muladd_D6(out,in,width);
	break;
	case 215:
	gf8_muladd_D7(out,in,width);
	break;
	case 216:
	gf8_muladd_D8(out,in,width);
	break;
	case 217:
	gf8_muladd_D9(out,in,width);
	break;
	case 218:
	gf8_muladd_DA(out,in,width);
	break;
	case 219:
	gf8_muladd_DB(out,in,width);
	break;
	case 220:
	gf8_muladd_DC(out,in,width);
	break;
	case 221:
	gf8_muladd_DD(out,in,width);
	break;
	case 222:
	gf8_muladd_DE(out,in,width);
	break;
	case 223:
	gf8_muladd_DF(out,in,width);
	break;
	case 224:
	gf8_muladd_E0(out,in,width);
	break;
	case 225:
	gf8_muladd_E1(out,in,width);
	break;
	case 226:
	gf8_muladd_E2(out,in,width);
	break;
	case 227:
	gf8_muladd_E3(out,in,width);
	break;
	case 228:
	gf8_muladd_E4(out,in,width);
	break;
	case 229:
	gf8_muladd_E5(out,in,width);
	break;
	case 230:
	gf8_muladd_E6(out,in,width);
	break;
	case 231:
	gf8_muladd_E7(out,in,width);
	break;
	case 232:
	gf8_muladd_E8(out,in,width);
	break;
	case 233:
	gf8_muladd_E9(out,in,width);
	break;
	case 234:
	gf8_muladd_EA(out,in,width);
	break;
	case 235:
	gf8_muladd_EB(out,in,width);
	break;
	case 236:
	gf8_muladd_EC(out,in,width);
	break;
	case 237:
	gf8_muladd_ED(out,in,width);
	break;
	case 238:
	gf8_muladd_EE(out,in,width);
	break;
	case 239:
	gf8_muladd_EF(out,in,width);
	break;
	case 240:
	gf8_muladd_F0(out,in,width);
	break;
	case 241:
	gf8_muladd_F1(out,in,width);
	break;
	case 242:
	gf8_muladd_F2(out,in,width);
	break;
	case 243:
	gf8_muladd_F3(out,in,width);
	break;
	case 244:
	gf8_muladd_F4(out,in,width);
	break;
	case 245:
	gf8_muladd_F5(out,in,width);
	break;
	case 246:
	gf8_muladd_F6(out,in,width);
	break;
	case 247:
	gf8_muladd_F7(out,in,width);
	break;
	case 248:
	gf8_muladd_F8(out,in,width);
	break;
	case 249:
	gf8_muladd_F9(out,in,width);
	break;
	case 250:
	gf8_muladd_FA(out,in,width);
	break;
	case 251:
	gf8_muladd_FB(out,in,width);
	break;
	case 252:
	gf8_muladd_FC(out,in,width);
	break;
	case 253:
	gf8_muladd_FD(out,in,width);
	break;
	case 254:
	gf8_muladd_FE(out,in,width);
	break;
	case 255:
	gf8_muladd_FF(out,in,width);
	break;
	}

}
