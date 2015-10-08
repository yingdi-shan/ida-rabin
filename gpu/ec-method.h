/*
  Copyright (c) 2012-2014 DataLab, s.l. <http://www.datalab.es>
  This file is part of GlusterFS.

  This file is licensed to you under your choice of the GNU Lesser
  General Public License, version 3 or any later version (LGPLv3 or
  later), or the GNU General Public License, version 2 (GPLv2), in all
  cases as published by the Free Software Foundation.
*/

#ifndef __EC_METHOD_H__
#define __EC_METHOD_H__

#include <stdio.h>
#include <inttypes.h>
#define EC_GF_SIZE 256

typedef uint64_t encode_t;
#define TRUNK_SIZE (8*8*sizeof(encode_t))

void ec_method_initialize(void);
size_t ec_method_decode(size_t size, uint32_t columns, uint32_t * rows,
                        uint8_t ** in, uint8_t * out);
size_t ec_method_batch_encode(size_t size, uint32_t columns, uint32_t total_rows,
        uint8_t * in, uint8_t ** out);

#define NUMBER_OF_STREAM 8

#endif /* __EC_METHOD_H__ */

