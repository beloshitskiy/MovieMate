/*
 * Copyright 2008, Dave Benson.
 * Copyright 2008 - 2009 Plausible Labs Cooperative, Inc.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with
 * the License. You may obtain a copy of the License
 * at http://www.apache.org/licenses/LICENSE-2.0 Unless
 * required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on
 * an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

#ifndef OKCRASH_LOG_WRITER_ENCODING_H
#define OKCRASH_LOG_WRITER_ENCODING_H

#ifdef __cplusplus
extern "C" {
#endif

#include "OKCrashAsync.h"

typedef enum {
        OKPROTOBUF_C_TYPE_INT32,
        OKPROTOBUF_C_TYPE_SINT32,
        OKPROTOBUF_C_TYPE_SFIXED32,
        OKPROTOBUF_C_TYPE_INT64,
        OKPROTOBUF_C_TYPE_SINT64,
        OKPROTOBUF_C_TYPE_SFIXED64,
        OKPROTOBUF_C_TYPE_UINT32,
        OKPROTOBUF_C_TYPE_FIXED32,
        OKPROTOBUF_C_TYPE_UINT64,
        OKPROTOBUF_C_TYPE_FIXED64,
        OKPROTOBUF_C_TYPE_FLOAT,
        OKPROTOBUF_C_TYPE_DOUBLE,
        OKPROTOBUF_C_TYPE_BOOL,
        OKPROTOBUF_C_TYPE_ENUM,
        OKPROTOBUF_C_TYPE_STRING,
        OKPROTOBUF_C_TYPE_BYTES,
        //OKPROTOBUF_C_TYPE_GROUP,          // NOT SUPPORTED
        OKPROTOBUF_C_TYPE_MESSAGE,
} OKProtobufCType;

typedef struct OKProtobufCBinaryData {
    size_t len;
    void *data;
} OKProtobufCBinaryData;

size_t okcrash_writer_pack (okcrash_async_file_t *file, uint32_t field_id, OKProtobufCType field_type, const void *value);
    
#ifdef __cplusplus
}
#endif

#endif /* OKCRASH_LOG_WRITER_ENCODING_H */
