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

#ifndef OKCRASH_ASYNC_SYMBOLICATION_H
#define OKCRASH_ASYNC_SYMBOLICATION_H

#ifdef __cplusplus
extern "C" {
#endif
    
/**
 * @internal
 *
 * @defgroup okcrash_async_symbol Async-Safe Symbol Lookup
 * @ingroup okcrash_async
 * @{
 */

#include "OKCrashAsyncMachOImage.h"
#include "OKCrashAsyncObjCSection.h"
    
/**
 * @internal
 * @ingroup enums
 *
 * Supported mechanisms for performing local symbolication.
 *
 * Local symbolication is performed using inexact heuristics and symbol data available at runtime; it may
 * return information that is incorrect. This may still be useful in the case where DWARF data is unavailable
 * for a given build; in that case, it can provide function and method names (though not line numbers) for a
 * crash report that may otherwise be unusable.
 */
typedef enum {
    /** No symbolication. */
    OKCRASH_ASYNC_SYMBOL_STRATEGY_NONE = 0,
    
    /**
     * Use the standard binary symbol table. On iOS, this alone will return
     * incomplete results, as most symbols are rewritten to the common '\<redacted>' string.
     */
    OKCRASH_ASYNC_SYMBOL_STRATEGY_SYMBOL_TABLE = 1 << 0,
    
    /**
     * Use Objective-C metadata to find method and class names. This relies on detailed parsing
     * of the Objective-C runtime data, including undefined flags and other runtime internals. As such,
     * it may return incorrect data should the runtime be changed incompatibly.
     */
    OKCRASH_ASYNC_SYMBOL_STRATEGY_OBJC = 1 << 1,
    
    /**
     * Enable all available symbolication strategies.
     */
    OKCRASH_ASYNC_SYMBOL_STRATEGY_ALL = (OKCRASH_ASYNC_SYMBOL_STRATEGY_SYMBOL_TABLE|OKCRASH_ASYNC_SYMBOL_STRATEGY_OBJC)
} okcrash_async_symbol_strategy_t;

/**
 * @internal
 *
 * Context object that helps speed up repeated symbol lookups.
 *
 * @warning It is invalid to reuse this context for multiple Mach tasks.
 * @warning Any okcrash_async_macho_t pointers passed in must be valid across all
 * calls using this context.
 */
typedef struct okcrash_async_symbol_cache {
    /** Objective-C look-up cache. */
    okcrash_async_objc_cache_t objc_cache;
} okcrash_async_symbol_cache_t;

okcrash_error_t okcrash_async_symbol_cache_init (okcrash_async_symbol_cache_t *cache);
void okcrash_async_symbol_cache_free (okcrash_async_symbol_cache_t *cache);


/**
 * Prototype of a callback function used to execute user code with async-safely fetched symbol.
 *
 * @param address The symbol address.
 * @param name The symbol name. The callback is responsible for copying this value, as its backing storage is not gauranteed to exist
 * after the callback returns.
 * @param ctx The API client's supplied context value.
 */
typedef void (*okcrash_async_found_symbol_cb)(ok_vm_address_t address, const char *name, void *ctx);

okcrash_error_t okcrash_async_find_symbol(okcrash_async_macho_t *image,
                                          okcrash_async_symbol_strategy_t strategy,
                                          okcrash_async_symbol_cache_t *cache,
                                          ok_vm_address_t pc,
                                          okcrash_async_found_symbol_cb callback,
                                          void *ctx);
    
#ifdef __cplusplus
}
#endif

#endif /* OKCRASH_ASYNC_SYMBOLICATION_H */
