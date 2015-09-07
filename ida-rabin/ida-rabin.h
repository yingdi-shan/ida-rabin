#include<stdint.h>

#define EC_GF_BITS 8
#define EC_GF_MOD 0x11D

#define EC_GF_SIZE (1 << EC_GF_BITS)
#define EC_GF_WORD_SIZE sizeof(uint64_t)


/* Determines the maximum size of the matrix used to encode/decode data */
#define EC_METHOD_MAX_FRAGMENTS 16
/* Determines the maximum number of usable elements in the Galois Field */
#define EC_METHOD_MAX_NODES     (EC_GF_SIZE - 1)

#define EC_METHOD_WORD_SIZE 64

#define EC_METHOD_CHUNK_SIZE (EC_METHOD_WORD_SIZE * EC_GF_BITS)
#define EC_METHOD_WIDTH (EC_METHOD_WORD_SIZE / EC_GF_WORD_SIZE)

