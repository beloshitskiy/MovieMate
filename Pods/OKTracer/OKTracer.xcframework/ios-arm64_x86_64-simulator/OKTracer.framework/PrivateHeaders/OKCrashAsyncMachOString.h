/*
 * Author: Mike Ash <mikeash@plausiblelabs.com>
 *
 * Copyright (c) 2012-2013 Plausible Labs Cooperative, Inc.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */

#ifndef OKCRASH_ASYNC_MACHO_STRING_H
#define OKCRASH_ASYNC_MACHO_STRING_H

#ifdef __cplusplus
extern "C" {
#endif
    
/**
 * @internal
 * @ingroup okcrash_async_image
 * @{
 */

#include "OKCrashAsyncMachOImage.h"
#include "OKCrashAsyncMObject.h"


typedef struct okcrash_async_macho_string {
    /** The Mach-O image the string is found in. */
    okcrash_async_macho_t *image;
    
    /** The address of the start of the string. */
    ok_vm_address_t address;
    
    /** The memory object for the string contents. */
    okcrash_async_mobject_t mobj;

    /** Whether the memory object is initialized. */
    bool mobjIsInitialized;

    /** The string's length, in bytes, not counting the terminating NUL. */
    ok_vm_size_t length;
} okcrash_async_macho_string_t;


okcrash_error_t okcrash_async_macho_string_init (okcrash_async_macho_string_t *string, okcrash_async_macho_t *image, ok_vm_address_t address);

okcrash_error_t okcrash_async_macho_string_get_length (okcrash_async_macho_string_t *string, ok_vm_size_t *outLength);

okcrash_error_t okcrash_async_macho_string_get_pointer (okcrash_async_macho_string_t *string, const char **outPointer);

void okcrash_async_macho_string_free (okcrash_async_macho_string_t *string);
    
/*
 * @}
 */
    
#ifdef __cplusplus
}
#endif

#endif /* OKCRASH_ASYNC_MACHO_STRING_H */
