/*
 * Author: Landon Fuller <landonf@plausiblelabs.com>
 *
 * Copyright (c) 2008-2009 Plausible Labs Cooperative, Inc.
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

#import <Foundation/Foundation.h>
#import <mach/mach.h>

#ifndef OKCRASH_REPORTER_H
#define OKCRASH_REPORTER_H

#if __has_include(<CrashReporter/OKCrashReporterConfig.h>)
#import <CrashReporter/OKCrashReporterConfig.h>
#import <CrashReporter/OKCrashMacros.h>
#else
#import "OKCrashReporterConfig.h"
#import "OKCrashMacros.h"
#endif

@class OKCrashMachExceptionServer;
@class OKCrashMachExceptionPortSet;

/**
 * @ingroup functions
 *
 * Prototype of a callback function used to execute additional user code with signal information as provided
 * by OKCrashReporter. Called upon completion of crash handling, after the crash report has been written to disk.
 *
 * @param info The signal info.
 * @param uap The crash's threads context.
 * @param context The API client's supplied context value.
 *
 * @sa The @ref async_safety documentation.
 * @sa OKCrashReporter::setPostCrashCallbacks:
 */
typedef void (*OKCrashReporterPostCrashSignalCallback)(siginfo_t *info, ucontext_t *uap, void *context);

/**
 * @ingroup types
 *
 * This structure contains callbacks supported by OKCrashReporter to allow the host application to perform
 * additional tasks prior to program termination after a crash has occurred.
 *
 * @sa The @ref async_safety documentation.
 */
typedef struct OKCrashReporterCallbacks {
    /** The version number of this structure. If not one of the defined version numbers for this type, the behavior
     * is undefined. The current version of this structure is 0. */
    uint16_t version;
    
    /** An arbitrary user-supplied context value. This value may be NULL. */
    void *context;

    /**
     * The callback used to report caught signal information. In version 0 of this structure, all crashes will be
     * reported via this function.
     *
     * @warning When using OKCrashReporterSignalHandlerTypeMach, the siginfo_t argument to this function will be derived
     * from the Mach exception data, and may be incorrect, or may otherwise not match the expected data as provided via
     * OKCrashReporterSignalHandlerTypeBSD. In addition, the provided ucontext_t value will be zero-initialized, and will
     * not provide valid thread state.
     *
     * This callback will be deprecated in favor of a Mach-compatible replacement in a future release; support is maintained
     * here to allow clients that rely on post-crash callbacks without thread state to make use of Mach exceptions.
     */
    OKCrashReporterPostCrashSignalCallback handleSignal;
} OKCrashReporterCallbacks;


typedef NS_ENUM(NSUInteger, OKCrashReporterLiveReportType) {
    OKCrashReporterLiveReportTypeAllThread = 0,
    OKCrashReporterLiveReportTypeWithoutThread = 1,
};

@interface OKCrashReporter : NSObject {
@private
    /** Reporter configuration */
    __strong OKCrashReporterConfig *_config;

    /** YES if the crash reporter has been enabled */
    BOOL _enabled;
    
#if OKCRASH_FEATURE_MACH_EXCEPTIONS
    /** The backing Mach exception server, if any. Nil if the reporter has not been enabled, or if
     * the configured signal handler type is not OKCrashReporterSignalHandlerTypeMach. */
    __strong OKCrashMachExceptionServer *_machServer;
    
    /** Previously registered Mach exception ports, if any. */
    __strong OKCrashMachExceptionPortSet *_previousMachPorts;
#endif /* OKCRASH_FEATURE_MACH_EXCEPTIONS */

    /** Application identifier */
    __strong NSString *_applicationIdentifier;

    /** Application version */
    __strong NSString *_applicationVersion;
    
    /** Application marketing version */
    __strong NSString *_applicationMarketingVersion;

    /** Path to the crash reporter internal data directory */
    __strong NSString *_crashReportDirectory;
}

+ (OKCrashReporter *) sharedReporter OKCR_DEPRECATED;

- (instancetype) initWithConfiguration: (OKCrashReporterConfig *) config;

- (BOOL) hasPendingCrashReport;

- (NSData *) loadPendingCrashReportData;
- (NSData *) loadPendingCrashReportDataAndReturnError: (NSError **) outError;

- (NSData *) generateLiveReportWithType:(OKCrashReporterLiveReportType)reportType;
- (NSData *) generateLiveReportReportType:(OKCrashReporterLiveReportType)reportType error: (NSError **) outError;

- (BOOL) purgePendingCrashReport;
- (BOOL) purgePendingCrashReportAndReturnError: (NSError **) outError;

- (BOOL) enableCrashReporter;
- (BOOL) enableCrashReporterAndReturnError: (NSError **) outError;

- (void) setCrashCallbacks: (OKCrashReporterCallbacks *) callbacks;

/**
 * Return the path to live crash report (which may not yet, or ever, exist).
 */
- (NSString *) crashReportPath;

/**
 * Custom data to save in the crash report.
 */
@property(nonatomic, strong) NSData *customData;

@end

#endif
