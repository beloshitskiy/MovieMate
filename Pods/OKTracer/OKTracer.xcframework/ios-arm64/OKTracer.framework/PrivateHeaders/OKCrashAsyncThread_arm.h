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

#ifndef OKCRASH_ASYNC_THREAD_ARM_H
#define OKCRASH_ASYNC_THREAD_ARM_H

#ifdef __cplusplus
extern "C" {
#endif

/**
 * Bitmask to strip pointer authentication (PAC).
 */
#define ARM64_PTR_MASK 0x0000000FFFFFFFFF

#if defined(__arm__) || defined(__arm64__)

// Large enough for 64-bit or 32-bit
typedef uint64_t okcrash_pdef_greg_t;
typedef uint64_t okcrash_pdef_fpreg_t;

#endif /* __arm__ */

/**
 * @internal
 * Arm registers
 */
typedef enum {
    /*
     * General
     */
    
    /** Program counter (r15) */
    OKCRASH_ARM_PC = OKCRASH_REG_IP,
    
    /** Frame pointer */
    OKCRASH_ARM_R7 = OKCRASH_REG_FP,
    
    /* stack pointer (r13) */
    OKCRASH_ARM_SP = OKCRASH_REG_SP,

    OKCRASH_ARM_R0,
    OKCRASH_ARM_R1,
    OKCRASH_ARM_R2,
    OKCRASH_ARM_R3,
    OKCRASH_ARM_R4,
    OKCRASH_ARM_R5,
    OKCRASH_ARM_R6,
    // R7 is defined above
    OKCRASH_ARM_R8,
    OKCRASH_ARM_R9,
    OKCRASH_ARM_R10,
    OKCRASH_ARM_R11,
    OKCRASH_ARM_R12,
    
    /* link register (r14) */
    OKCRASH_ARM_LR,
    
    /** Current program status register */
    OKCRASH_ARM_CPSR,
    
    /** Last register */
    OKCRASH_ARM_LAST_REG = OKCRASH_ARM_CPSR
} okcrash_arm_regnum_t;
    
/**
 * @internal
 * ARM64 registers
 */
typedef enum {
    /*
     * General
     */
    
    /** Program counter */
    OKCRASH_ARM64_PC = OKCRASH_REG_IP,
    
    /** Frame pointer (x29) */
    OKCRASH_ARM64_FP = OKCRASH_REG_FP,
    
    /* stack pointer (x31) */
    OKCRASH_ARM64_SP = OKCRASH_REG_SP,
    
    OKCRASH_ARM64_X0,
    OKCRASH_ARM64_X1,
    OKCRASH_ARM64_X2,
    OKCRASH_ARM64_X3,
    OKCRASH_ARM64_X4,
    OKCRASH_ARM64_X5,
    OKCRASH_ARM64_X6,
    OKCRASH_ARM64_X7,
    OKCRASH_ARM64_X8,
    OKCRASH_ARM64_X9,
    OKCRASH_ARM64_X10,
    OKCRASH_ARM64_X11,
    OKCRASH_ARM64_X12,
    OKCRASH_ARM64_X13,
    OKCRASH_ARM64_X14,
    OKCRASH_ARM64_X15,
    OKCRASH_ARM64_X16,
    OKCRASH_ARM64_X17,
    OKCRASH_ARM64_X18,
    OKCRASH_ARM64_X19,
    OKCRASH_ARM64_X20,
    OKCRASH_ARM64_X21,
    OKCRASH_ARM64_X22,
    OKCRASH_ARM64_X23,
    OKCRASH_ARM64_X24,
    OKCRASH_ARM64_X25,
    OKCRASH_ARM64_X26,
    OKCRASH_ARM64_X27,
    OKCRASH_ARM64_X28,

    /* link register (x30) */
    OKCRASH_ARM64_LR,
    
    /** Current program status register */
    OKCRASH_ARM64_CPSR,
    
    /** Last register */
    OKCRASH_ARM64_LAST_REG = OKCRASH_ARM64_CPSR
} okcrash_arm64_regnum_t;

#ifdef __cplusplus
}
#endif

#endif /* OKCRASH_ASYNC_THREAD_ARM_H */
