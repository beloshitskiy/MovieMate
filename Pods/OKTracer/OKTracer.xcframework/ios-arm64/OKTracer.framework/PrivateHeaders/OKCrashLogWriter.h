/*
 * Author: Landon Fuller <landonf@plausiblelabs.com>
 *
 * Copyright (c) 2008-2013 Plausible Labs Cooperative, Inc.
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

#ifndef OKCRASH_LOG_WRITER_H
#define OKCRASH_LOG_WRITER_H

#ifdef __cplusplus
extern "C" {
#endif

#import <TargetConditionals.h>
#import <Foundation/Foundation.h>

#import "OKCrashAsync.h"
#import "OKCrashAsyncImageList.h"
#import "OKCrashFrameWalker.h"
    
#import "OKCrashAsyncSymbolication.h"
#import "OKCrashLogWriterEncoding.h"

#include <uuid/uuid.h>

/**
 * @internal
 * @defgroup okcrash_log_writer Crash Log Writer
 * @ingroup okcrash_internal
 *
 * Implements an async-safe, zero allocation crash log writer C API, intended
 * to be called from the crash log signal handler.
 *
 * @{
 */

/**
 * @internal
 *
 * Crash log writer context.
 */
typedef struct okcrash_log_writer {
    /** The strategy to use for symbolication */
    okcrash_async_symbol_strategy_t symbol_strategy;

    /** Report data */
    struct {
        /** If true, the report should be marked as a 'generated' user-requested report, rather than as a true crash
         * report */
        bool user_requested;

        /** Report UUID */
        uuid_t uuid_bytes;
    } report_info;

    /** System data */
    struct {
        /** The host OS version. */
        OKProtobufCBinaryData version;

        /** The host OS build number. This may be NULL. */
        OKProtobufCBinaryData build;
    } system_info;

    /* Machine data */
    struct {
        /** The host model (may be NULL). */
        OKProtobufCBinaryData model;

        /** The host CPU type. */
        uint64_t cpu_type;

        /** The host CPU subtype. */
        uint64_t cpu_subtype;
        
        /** The total number of physical cores */
        uint32_t processor_count;
        
        /** The total number of logical cores */
        uint32_t logical_processor_count;
    } machine_info;

    /** Application data */
    struct {
        /** Application identifier */
        OKProtobufCBinaryData app_identifier;

        /** Application version */
        OKProtobufCBinaryData app_version;
        
        /** Application marketing version (may be null) */
        OKProtobufCBinaryData app_marketing_version;
    } application_info;
    
    /** Process data */
    struct {
        /** Process name (may be null) */
        OKProtobufCBinaryData process_name;
        
        /** Process ID */
        pid_t process_id;
        
        /** Process path (may be null) */
        OKProtobufCBinaryData process_path;
        
        /** Process start time */
        time_t start_time;
        
        /** Parent process name (may be null) */
        OKProtobufCBinaryData parent_process_name;
        
        /** Parent process ID */
        pid_t parent_process_id;
        
        /** If false, the reporting process is being run under process emulation (such as Rosetta). */
        bool native;
    } process_info;

    /** Uncaught exception (if any) */
    struct {
        /** Flag specifying wether an uncaught exception is available. */
        bool has_exception;

        /** Exception name (may be null) */
        char *name;

        /** Exception reason (may be null) */
        char *reason;

        /** The original exception call stack (may be null) */
        void **callstack;
        
        /** Call stack frame count, or 0 if the call stack is unavailable */
        size_t callstack_count;
    } uncaught_exception;

    /** Custom user data */
    OKProtobufCBinaryData custom_data;

} okcrash_log_writer_t;

/**
 * @internal
 *
 * BSD/POSIX signal information.
 */
typedef struct okcrash_log_bsd_signal_info {
    /** The signal number. */
    int signo;
    
    /** The signal code. */
    int code;
    
    /** The signal address. */
    void *address;
} okcrash_log_bsd_signal_info_t;

/**
 * @internal
 *
 * Mach exception information.
 */
typedef struct okcrash_log_mach_signal_info {
    /** The exception type. */
    exception_type_t type;
    
    /** The exception code(s). */
    mach_exception_data_t code;
    
    /** The number of codes supplied. */
    mach_msg_type_number_t code_count;
} okcrash_log_mach_signal_info_t;

/**
 * @internal
 *
 * The signal and/or exception data from the crash.
 */
typedef struct okcrash_log_signal_info {
    /**
     * The BSD/POSIX signal information. This value is currently required by v1.0 crash
     * reports, and must not be NULL. The value may be derived from the Mach exception
     * data, and in such a case is not required to perfectly match the data that would
     * have been generated by the kernel for the given Mach exception.
     *
     * For more information, refer to the crash_report.proto documentation.
     */
    okcrash_log_bsd_signal_info_t *bsd_info;
    
    /**
     * The Mach exception information. Must be NULL if the signal was not processed via
     * Mach exception handling.
     */
    okcrash_log_mach_signal_info_t *mach_info;
} okcrash_log_signal_info_t;


okcrash_error_t okcrash_log_writer_init (okcrash_log_writer_t *writer,
                                         NSString *app_identifier,
                                         NSString *app_version,
                                         NSString *app_marketing_version,
                                         okcrash_async_symbol_strategy_t symbol_strategy,
                                         BOOL user_requested);
void okcrash_log_writer_set_exception (okcrash_log_writer_t *writer, NSException *exception);

void okcrash_log_writer_set_custom_data (okcrash_log_writer_t *writer, NSData *custom_data);

okcrash_error_t okcrash_log_writer_write (okcrash_log_writer_t *writer,
                                          thread_t crashed_thread,
                                          int reportType,
                                          okcrash_async_image_list_t *image_list,
                                          okcrash_async_file_t *file,
                                          okcrash_log_signal_info_t *siginfo,
                                          okcrash_async_thread_state_t *current_state);

okcrash_error_t okcrash_log_writer_close (okcrash_log_writer_t *writer);
void okcrash_log_writer_free (okcrash_log_writer_t *writer);

/*
 * @} okcrash_log_writer
 */
    
#ifdef __cplusplus
}
#endif

#endif /* OKCRASH_LOG_WRITER_H */
