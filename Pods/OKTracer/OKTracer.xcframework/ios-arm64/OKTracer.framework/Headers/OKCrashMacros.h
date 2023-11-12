/*
 * Author: Landon Fuller <landonf@plausiblelabs.com>
 *
 * Copyright (c) 2013 Plausible Labs Cooperative, Inc.
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

#ifndef OKCRASH_CONSTANTS_H
#define OKCRASH_CONSTANTS_H

#include <assert.h>
#include <TargetConditionals.h>

#if defined(__cplusplus)
#   define OKCR_EXPORT extern "C"
#   define OKCR_C_BEGIN_DECLS extern "C" {
#   define OKCR_C_END_DECLS }
#else
#   define OKCR_EXPORT extern
#   define OKCR_C_BEGIN_DECLS
#   define OKCR_C_END_DECLS
#endif

#if defined(__cplusplus)
#  define NO_OTHER_MACRO_STARTS_WITH_THIS_NAME_
#  define IS_EMPTY_(name) defined(NO_OTHER_MACRO_STARTS_WITH_THIS_NAME_ ## name)
#  define IS_EMPTY(name) IS_EMPTY_(name)
#  if defined(OKCRASHREPORTER_PREFIX) && !IS_EMPTY(OKCRASHREPORTER_PREFIX)
     /** @internal Define the okcrash namespace, automatically inserting an inline namespace containing the configured OKCRASHREPORTER_PREFIX, if any. */
#    define OKCR_CPP_BEGIN_NS namespace okcrash { inline namespace OKCRASHREPORTER_PREFIX {

    /** @internal Close the definition of the `okcrash` namespace (and the OKCRASHREPORTER_PREFIX inline namespace, if any). */
#    define OKCR_CPP_END_NS }}
#  else
#   define OKCR_CPP_BEGIN_NS namespace okcrash {
#   define OKCR_CPP_END_NS }
#  endif
#endif

#ifdef __clang__
#  define OKCR_PRAGMA_CLANG(_p) _Pragma(_p)
#else
#  define OKCR_PRAGMA_CLANG(_p)
#endif

#ifdef __clang__
#  define OKCR_DEPRECATED __attribute__((deprecated))
#else
#  define OKCR_DEPRECATED
#endif

#if defined(__clang__) || defined(__GNUC__)
#  define OKCR_UNUSED __attribute__((unused))
#else
#  define OKCR_UNUSED
#endif

#ifdef OKCR_PRIVATE
/**
 * Marks a definition as deprecated only for for external clients, allowing
 * uses of it internal fo the framework.
 */
#  define OKCR_EXTERNAL_DEPRECATED

/**
 * @internal
 * A macro to put above a definition marked OKCR_EXTERNAL_DEPRECATED that will
 * silence warnings about there being a deprecation documentation marker but the
 * definition not being marked deprecated.
 */
#  define OKCR_EXTERNAL_DEPRECATED_NOWARN_PUSH() \
      OKCR_PRAGMA_CLANG("clang diagnostic push"); \
      OKCR_PRAGMA_CLANG("clang diagnostic ignored \"-Wdocumentation-deprecated-sync\"")

/**
 * @internal
 * A macro to put below a definition marked OKCR_EXTERNAL_DEPRECATED that will
 * silence warnings about there being a deprecation documentation marker but the
 * definition not being marked deprecated.
 */
#  define OKCR_EXTERNAL_DEPRECATED_NOWARN_POP() OKCR_PRAGMA_CLANG("clang diagnostic pop")

#else

#  define OKCR_EXTERNAL_DEPRECATED OKCR_DEPRECATED
#  define OKCR_EXTERNAL_DEPRECATED_NOWARN_PUSH()
#  define OKCR_EXTERNAL_DEPRECATED_NOWARN_PUSH()

#endif /* OKCR_PRIVATE */

#ifdef OKCR_PRIVATE
#  if defined(__clang__) && __has_feature(cxx_attributes) && __has_warning("-Wimplicit-fallthrough")
#    define OKCR_FALLTHROUGH [[clang::fallthrough]]
#  else
#    define OKCR_FALLTHROUGH do {} while (0)
#  endif
#endif

#ifdef OKCR_PRIVATE
/**
 * @internal
 * Static compile-time assertion.
 *
 * @param name The assertion name; must be valid for use within a C identifier.
 * @param cond Assertion condition
 */
#  define OKCR_ASSERT_STATIC(name, cond) OKCR_ASSERT_STATIC_(name, cond, __LINE__)
/*
 * C++11 and C11 both provide a static_assert().
 *
 * Otherwise, we have to use typedef-based static assertions.
 */
#  if (defined(__cplusplus) && __cplusplus >= 201103L) || (!defined(__cplusplus) && defined(__STDC_VERSION__) && __STDC_VERSION__ >= 201112L)
#    define OKCR_ASSERT_STATIC_(name, cond, line) OKCR_ASSERT_STATIC__(#name, cond)
#    define OKCR_ASSERT_STATIC__(name, cond) static_assert(cond, #name)
#  else
#    define OKCR_ASSERT_STATIC_(name, cond, line) OKCR_ASSERT_STATIC__(name, cond, line)
#    define OKCR_ASSERT_STATIC__(name, cond, line) typedef int okcf_static_assert_##name##_##line [(cond) ? 1 : -1] OKCR_UNUSED
#  endif
#endif /* OKCR_PRIVATE */

#endif /* OKCRASH_CONSTANTS_H */
