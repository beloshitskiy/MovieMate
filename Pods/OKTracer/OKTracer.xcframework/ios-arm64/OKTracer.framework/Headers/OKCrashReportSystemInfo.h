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

#if __has_include(<CrashReporter/OKCrashMacros.h>)
#import <CrashReporter/OKCrashMacros.h>
#else
#import "OKCrashMacros.h"
#endif

@class OKCrashReportProcessorInfo;

/**
 * @ingroup constants
 *
 * Indicates the Operating System under which a Crash Log was generated.
 *
 * @internal
 * These enum values match the protobuf values. Keep them synchronized.
 */
typedef enum {
    /** Mac OS X. */
    OKCrashReportOperatingSystemMacOSX = 0,
    
    /** iPhone OS */
    OKCrashReportOperatingSystemiPhoneOS = 1,
    
    /** iPhone Simulator (Mac OS X with additional simulator-specific runtime libraries) */
    OKCrashReportOperatingSystemiPhoneSimulator = 2,
    
    /** Unknown operating system */
    OKCrashReportOperatingSystemUnknown = 3,
  
    /** Apple tvOS */
    OKCrashReportOperatingSystemAppleTVOS = 4,
  
} OKCrashReportOperatingSystem;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation-deprecated-sync"
/**
 * @ingroup constants
 *
 * Indicates the architecture under which a Crash Log was generated.
 *
 * @note The architecture value has been deprecated in v1.1 and later crash reports. All new reports
 * will make use of the new OKCrashReportProcessorInfo CPU type encodings.
 *
 * @internal
 * These enum values match the protobuf values. Keep them synchronized.
 */
typedef enum {
    /** x86-32. */
    OKCrashReportArchitectureX86_32 = 0,
    
    /** x86-64 */
    OKCrashReportArchitectureX86_64 = 1,

    /** ARMv6 */
    OKCrashReportArchitectureARMv6 = 2,

    /**
     * ARMv6
     * @deprecated This value has been deprecated in favor of ARM subtype-specific
     * values.
     * @sa OKCrashReportArchitectureARMv6
     */
    OKCrashReportArchitectureARM OKCR_DEPRECATED = OKCrashReportArchitectureARMv6,

    /** PPC */
    OKCrashReportArchitecturePPC = 3,
    
    /** PPC64 */
    OKCrashReportArchitecturePPC64 = 4,
    
    /** ARMv7 */
    OKCrashReportArchitectureARMv7 = 5,
    
    /** Unknown */
    OKCrashReportArchitectureUnknown = 6
} OKCrashReportArchitecture;
#pragma clang diagnostic pop

extern OKCrashReportOperatingSystem OKCrashReportHostOperatingSystem;
OKCR_EXTERNAL_DEPRECATED_NOWARN_PUSH();
extern OKCrashReportArchitecture OKCrashReportHostArchitecture OKCR_EXTERNAL_DEPRECATED;
OKCR_EXTERNAL_DEPRECATED_NOWARN_PUSH();

@interface OKCrashReportSystemInfo : NSObject {
@private
    /** Operating system */
    OKCrashReportOperatingSystem _operatingSystem;
    
    /** Operating system version */
    __strong NSString *_osVersion;
    
    /** OS build. May be nil. */
    __strong NSString *_osBuild;
    
    /** Architecture */
    OKCrashReportArchitecture _architecture;
    
    /** Date crash report was generated. May be nil if the date is unknown. */
    __strong NSDate *_timestamp;

    /** Processor information. */
    __strong OKCrashReportProcessorInfo *_processorInfo;
}

- (id) initWithOperatingSystem: (OKCrashReportOperatingSystem) operatingSystem 
        operatingSystemVersion: (NSString *) operatingSystemVersion
                  architecture: (OKCrashReportArchitecture) architecture
                     timestamp: (NSDate *) timestamp OKCR_DEPRECATED;

- (id) initWithOperatingSystem: (OKCrashReportOperatingSystem) operatingSystem 
        operatingSystemVersion: (NSString *) operatingSystemVersion
          operatingSystemBuild: (NSString *) operatingSystemBuild
                  architecture: (OKCrashReportArchitecture) architecture
                     timestamp: (NSDate *) timestamp OKCR_DEPRECATED;

- (id) initWithOperatingSystem: (OKCrashReportOperatingSystem) operatingSystem
        operatingSystemVersion: (NSString *) operatingSystemVersion
          operatingSystemBuild: (NSString *) operatingSystemBuild
                  architecture: (OKCrashReportArchitecture) architecture
                 processorInfo: (OKCrashReportProcessorInfo *) processorInfo
                     timestamp: (NSDate *) timestamp;

/** The operating system. */
@property(nonatomic, readonly) OKCrashReportOperatingSystem operatingSystem;

/** The operating system's release version. */
@property(nonatomic, readonly, strong) NSString *operatingSystemVersion;

/** The operating system's build identifier (eg, 10J869). This may be unavailable, and this property will be nil. */
@property(nonatomic, readonly, strong) NSString *operatingSystemBuild;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation-deprecated-sync"
/** Architecture. @deprecated The architecture value has been deprecated in v1.1 and later crash reports. All new reports
 * include the CPU type as part of the crash report's machine info structure, using the OKCrashReportProcessorInfo
 * extensible encoding. */
@property(nonatomic, readonly) OKCrashReportArchitecture architecture OKCR_DEPRECATED;

/** Date and time that the crash report was generated. This may be unavailable, and this property will be nil. */
@property(nonatomic, readonly, strong) NSDate *timestamp;

/** The processor type. For v1.2 reports and later, this is an alias to the machine info's processorInfo.
  * For earlier reports, this will be synthesized from the deprecated architecture property.  */
@property(nonatomic, readonly, strong) OKCrashReportProcessorInfo *processorInfo;

@end
