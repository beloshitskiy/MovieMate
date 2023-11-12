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

#ifndef OKCRASH_ASYNC_THREAD_X86_H
#define OKCRASH_ASYNC_THREAD_X86_H

#ifdef __cplusplus
extern "C" {
#endif

#if defined(__i386__) || defined(__x86_64__)

// Large enough for 64-bit or 32-bit
typedef uint64_t okcrash_pdef_greg_t;
typedef uint64_t okcrash_pdef_fpreg_t;

#endif /* __i386__ */

/**
 * @internal
 * x86 registers, as defined by the System V ABI, IA32 Supplement.
 */
typedef enum {
    /*
     * General
     */
    
    /** Instruction pointer */
    OKCRASH_X86_EIP = OKCRASH_REG_IP,
    
    /** Stack frame pointer */
    OKCRASH_X86_EBP = OKCRASH_REG_FP,

    /** Stack pointer */
    OKCRASH_X86_ESP = OKCRASH_REG_SP,

    /** Return value */
    OKCRASH_X86_EAX ,
    
    /** Dividend register */
    OKCRASH_X86_EDX,
    
    /** Count register */
    OKCRASH_X86_ECX,
    
    /** Local register variable */
    OKCRASH_X86_EBX,
    
    /** Local register variable */
    OKCRASH_X86_ESI,
    
    /** Local register variable */
    OKCRASH_X86_EDI,    
    
    /** Flags */
    OKCRASH_X86_EFLAGS,
    
    /* Scratcn */
    OKCRASH_X86_TRAPNO,
    
    
    /*
     * Segment Registers
     */
    /** Segment register */
    OKCRASH_X86_CS,
    
    /** Segment register */
    OKCRASH_X86_DS,
    
    /** Segment register */
    OKCRASH_X86_ES,
    
    /** Segment register */
    OKCRASH_X86_FS,
    
    /** Segment register */
    OKCRASH_X86_GS,
    
    /** Last register */
    OKCRASH_X86_LAST_REG = OKCRASH_X86_GS
} okcrash_x86_regnum_t;

/**
 * @internal
 * x86-64 Registers
 */
typedef enum {
    /*
     * General
     */
    
    /** Instruction pointer */
    OKCRASH_X86_64_RIP = OKCRASH_REG_IP,
    
    /** Optional stack frame pointer. */
    OKCRASH_X86_64_RBP = OKCRASH_REG_FP,

    /** Stack pointer. */
    OKCRASH_X86_64_RSP = OKCRASH_REG_SP,

    /** First return register. */
    OKCRASH_X86_64_RAX,
    
    /** Local register variable. */
    OKCRASH_X86_64_RBX,
    
    /** Fourth integer function argument. */
    OKCRASH_X86_64_RCX,
    
    /** Third function argument. Second return register. */
    OKCRASH_X86_64_RDX,
    
    /** First function argument. */
    OKCRASH_X86_64_RDI,
    
    /** Second function argument. */
    OKCRASH_X86_64_RSI,
    
    /** Temporary register. */
    OKCRASH_X86_64_R8,
    
    /** Temporary register. */
    OKCRASH_X86_64_R9,
    
    /** Temporary register. */
    OKCRASH_X86_64_R10,
    
    /** Callee-saved register. */
    OKCRASH_X86_64_R11,
    
    /** Callee-saved register. */
    OKCRASH_X86_64_R12,
    
    /** Callee-saved register. */
    OKCRASH_X86_64_R13,
    
    /** Callee-saved register. */
    OKCRASH_X86_64_R14,
    
    /** Callee-saved register. */
    OKCRASH_X86_64_R15,
    
    /** Flags */
    OKCRASH_X86_64_RFLAGS,
    
    /*
     * Segment Registers
     */
    
    /** Segment register */
    OKCRASH_X86_64_CS,
    
    /** Segment register */
    OKCRASH_X86_64_FS,
    
    /** Segment register */
    OKCRASH_X86_64_GS,
    
    /** Last register */
    OKCRASH_X86_64_LAST_REG = OKCRASH_X86_64_GS
} okcrash_x86_64_regnum_t;
    
#ifdef __cplusplus
}
#endif

#endif /* OKCRASH_ASYNC_THREAD_X86_H */
