#ifndef __EC_GF8_H__
#define __EC_GF8_H__

#include <inttypes.h>

#define EC_GF_BITS 8
#define EC_GF_MOD 0x11D

#define EC_GF_SIZE (1 << EC_GF_BITS)
#define EC_GF_WORD_SIZE sizeof(uint64_t)

__device__ extern void ec_gf_muladd(uint32_t row,uint8_t *out, uint8_t *in,unsigned int width);

#endif
