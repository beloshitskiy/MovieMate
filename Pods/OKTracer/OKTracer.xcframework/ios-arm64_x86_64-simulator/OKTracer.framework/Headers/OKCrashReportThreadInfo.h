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

#ifndef OKCRASH_REPORT_THREAD_INFO_H
#define OKCRASH_REPORT_THREAD_INFO_H

#if __has_include(<CrashReporter/OKCrashReportStackFrameInfo.h>)
#import <CrashReporter/OKCrashReportStackFrameInfo.h>
#import <CrashReporter/OKCrashReportRegisterInfo.h>
#else
#import "OKCrashReportStackFrameInfo.h"
#import "OKCrashReportRegisterInfo.h"
#endif


@interface OKCrashReportThreadInfo : NSObject {
@private
    /** The thread number. Should be unique within a given crash log. */
    NSInteger _threadNumber;

    /** The thread identifier. Should be unique within a given crash log. */
    NSInteger _threadId;

    /** The thread name.  */
    NSString *_threadName;

    /** Ordered list of OKCrashReportStackFrame instances */
    __strong NSArray *_stackFrames;

    /** YES if this thread crashed. */
    BOOL _crashed;

    /** List of OKCrashReportRegister instances. Will be empty if _crashed is NO. */
    __strong NSArray *_registers;
}

- (id) initWithThreadNumber: (NSInteger) threadNumber
                   threadId: (NSInteger) threadId
                 threadName: (NSString *) threadName
                stackFrames: (NSArray *) stackFrames
                    crashed: (BOOL) crashed
                  registers: (NSArray *) registers;

/**
 * Application thread number.
 */
@property(nonatomic, readonly) NSInteger threadNumber;

/**
 * Application thread identifier.
 */
@property(nonatomic, readonly) NSInteger threadId;

/**
 * Application thread name.
 */
@property(nonatomic, readonly) NSString *threadName;

/**
 * Thread backtrace. Provides an array of OKCrashReportStackFrameInfo instances.
 * The array is ordered, last callee to first.
 */
@property(nonatomic, readonly, strong) NSArray *stackFrames;

/**
 * If this thread crashed, set to YES.
 */
@property(nonatomic, readonly) BOOL crashed;

/**
 * State of the general purpose and related registers, as a list of
 * OKCrashReportRegister instances. If this thead did not crash (crashed returns NO),
 * this list will be empty.
 */
@property(nonatomic, readonly, strong) NSArray *registers;

@end

#endif
