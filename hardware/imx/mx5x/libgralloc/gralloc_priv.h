/*
 * Copyright (C) 2008 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/* Copyright 2009-2012 Freescale Semiconductor, Inc. */

#ifndef GRALLOC_PRIV_H_
#define GRALLOC_PRIV_H_

#include <stdint.h>
#include <limits.h>
#include <sys/cdefs.h>
#include <hardware/gralloc.h>
#include <pthread.h>
#include <errno.h>
#include <unistd.h>

#include <cutils/native_handle.h>

#include <linux/fb.h>

#define  ALIGN_PIXEL(x)  ((x+ 31) & ~31)
#define  ALIGN_PIXEL_64(x)  ((x+ 63) & ~63)
/** z430 core need 4k aligned memory, since xres has been 32 aligned, make yres
    to 128 aligned will meet this request for all pixel format (RGB565,RGB888,etc.) */
#define  ALIGN_PIXEL_128(x)  ((x+ 127) & ~127)
/** z430 core needs 4k aligned memory for all YUV pixel
 *  formats */
#define  ALIGN_PIXEL_4096(x)  ((x+ 4095) & ~4095)

/*****************************************************************************/

struct private_module_t;
struct private_handle_t;

struct private_module_t {
    gralloc_module_t base;

    private_handle_t* framebuffer;
    uint32_t flags;
    uint32_t numBuffers;
    uint32_t bufferMask;
    pthread_mutex_t lock;
    buffer_handle_t currentBuffer;
    int ion_master;
    unsigned long master_phys;

    struct fb_var_screeninfo info;
    struct fb_fix_screeninfo finfo;
    float xdpi;
    float ydpi;
    float fps;
    
    enum {
        // flag to indicate we'll post this buffer
        PRIV_USAGE_LOCKED_FOR_POST = 0x80000000
    };
};

/*****************************************************************************/

#ifdef __cplusplus
struct private_handle_t : public native_handle {
#else
struct private_handle_t {
    struct native_handle nativeHandle;
#endif
    
    enum {
        PRIV_FLAGS_FRAMEBUFFER = 0x00000001,
        PRIV_FLAGS_USES_PMEM   = 0x00000002,
        PRIV_FLAGS_USES_ION    = 0x00000004,
        PRIV_FLAGS_NEEDS_FLUSH    = 0x00000008,
    };

    enum {
        LOCK_STATE_WRITE     =   1<<31,
        LOCK_STATE_MAPPED    =   1<<30,
        LOCK_STATE_READ_MASK =   0x3FFFFFFF
    };

    // file-descriptors
    int     fd;
    // ints
    int     magic;
    int     flags;
    int     size;
    int     offset;
    int     gpu_fd;

    // FIXME: the attributes below should be out-of-line
    int     base;
    int     lockState;
    int     writeOwner;
    int     phys; // The physical address of that chunk of memory. If using ashmem, set to 0 They don't care
    int     pid;
    int	    usage;
    int	    format;
    int     width;
    int     height;
    void*   handle;
    
#ifdef __cplusplus
    static const int sNumInts = 14;
    static const int sNumFds = 1;
    static const int sMagic = 'igpu';

    private_handle_t(int fd, int size, int flags) :
        fd(fd), magic(sMagic), flags(flags), size(size), offset(0),gpu_fd(-1),
        base(0), lockState(0), writeOwner(0), phys(0),pid(getpid()),usage(0),
        format(0), width(0), height(0)
    {
        version = sizeof(native_handle);
        numInts = sNumInts;
        numFds = sNumFds;
    }
    ~private_handle_t() {
        magic = 0;
    }

    bool usesPhysicallyContiguousMemory() {
        return (flags & PRIV_FLAGS_USES_ION) != 0;
    }

    static int validate(const native_handle* h) {
        const private_handle_t* hnd = (const private_handle_t*)h;
        if (!h || h->version != sizeof(native_handle) ||
                h->numInts != sNumInts || h->numFds != sNumFds ||
                hnd->magic != sMagic) 
        {
            ALOGE("invalid gralloc handle (at %p)", h);
            return -EINVAL;
        }
        return 0;
    }

    static private_handle_t* dynamicCast(const native_handle* in) {
        if (validate(in) == 0) {
            return (private_handle_t*) in;
        }
        return NULL;
    }
#endif
};

#endif /* GRALLOC_PRIV_H_ */
