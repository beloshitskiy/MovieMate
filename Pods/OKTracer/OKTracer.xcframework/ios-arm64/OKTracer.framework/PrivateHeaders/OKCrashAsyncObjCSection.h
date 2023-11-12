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

#ifndef OKCRASH_ASYNC_OBJC_SECTION_H
#define OKCRASH_ASYNC_OBJC_SECTION_H

#ifdef __cplusplus
extern "C" {
#endif

#include "OKCrashAsyncMachOImage.h"
#include "OKCrashAsyncMachOString.h"
    
/**
 * @internal
 * @ingroup okcrash_async_image_objc
 * @{
 */

/**
 * @internal
 *
 * Caches Objective-C data across API calls.
 *
 * This is used to speed up ObjC parsing.
 *
 * @warning It is invalid to reuse this context for multiple Mach tasks.
 * @warning Any okcrash_async_macho_t pointers passed in must be valid across all
 * calls using this context.
 */
typedef struct okcrash_async_objc_cache {
    /**
     * Whether any ObjC info has ever been successfully obtained. If it has, then
     * ObjC1 info can be skipped.
     */
    bool gotObjC2Info;
    
    /** The last MachO image seen. The image for which the memory objects below are valid. */
    okcrash_async_macho_t *lastImage;
    
    /** Whether the objcConst object is initialized. */
    bool objcConstMobjInitialized;
    
    /** A memory object for the __objc_const section. */
    okcrash_async_mobject_t objcConstMobj;

    /** Whether the objcConstAx object is initialized. */
    bool objcConstAxMobjInitialized;

    /** A memory object for the __objc_const_ax section. */
    okcrash_async_mobject_t objcConstAxMobj;
    
    /** Whether the objcMethListMobj object is initialized. */
    bool objcMethListMobjInitialized;

    /** A memory object for the __objc_methlist section. */
    okcrash_async_mobject_t objcMethListMobj;

    /** Whether the objcSelRefsMobj object is initialized. */
    bool objcSelRefsMobjInitialized;
    
    /** A memory object for the __objc_selrefs section. */
    okcrash_async_mobject_t objcSelRefsMobj;

    /** Whether the class memory object is initialized. */
    bool classMobjInitialized;
    
    /** A memory object for the __objc_classlist section. */
    okcrash_async_mobject_t classMobj;
    
    /** Whether the category memory object is initialized. */
    bool catMobjInitialized;
    
    /** A memory object for the __objc_catlist section. */
    okcrash_async_mobject_t catMobj;
    
    /** Whether the objcData object is initialized. */
    bool objcDataMobjInitialized;
    
    /** A memory object for the __objc_data section. */
    okcrash_async_mobject_t objcDataMobj;

    /** Whether the data object is initialized. */
    bool dataMobjInitialized;

    /** A memory object for the __data section. */
    okcrash_async_mobject_t dataMobj;
    
    /** The size of the class cache, in entries. */
    size_t classCacheSize;
    
    /** Array of class cache keys. These are class data pointers. */
    ok_vm_address_t *classCacheKeys;
    
    /** Array of class cache values. These are pointers to class_ro data. */
    ok_vm_address_t *classCacheValues;
} okcrash_async_objc_cache_t;

okcrash_error_t okcrash_async_objc_cache_init (okcrash_async_objc_cache_t *context);
void okcrash_async_objc_cache_free (okcrash_async_objc_cache_t *context);

/**
 * A callback to invoke when an Objective-C method is found.
 *
 * @param isClassMethod If true, the method is a class (rather than an instance) method.
 * @param className The class's name.
 * @param methodName The method's name.
 * @param imp The method's IMP (function pointer to the method's implementation).
 * @param ctx The context pointer specified by the original caller.
 */
typedef void (*okcrash_async_objc_found_method_cb)(bool isClassMethod, okcrash_async_macho_string_t *className, okcrash_async_macho_string_t *methodName, ok_vm_address_t imp, void *ctx);

okcrash_error_t okcrash_async_objc_find_method (okcrash_async_macho_t *image, okcrash_async_objc_cache_t *cache, ok_vm_address_t imp, okcrash_async_objc_found_method_cb callback, void *ctx);
    
/*
 * @}
 */

#ifdef __cplusplus
}
#endif

#endif /* OKCRASH_ASYNC_OBJECT_SECTION_H */
