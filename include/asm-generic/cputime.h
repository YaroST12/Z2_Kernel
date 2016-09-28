#ifndef _ASM_GENERIC_CPUTIME_H
#define _ASM_GENERIC_CPUTIME_H

#include <linux/time.h>
#include <linux/jiffies.h>

#ifndef CONFIG_VIRT_CPU_ACCOUNTING
# include <asm-generic/cputime_jiffies.h>
#endif

#ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
# include <asm-generic/cputime_nsecs.h>
#endif

#define cputime64_add(__a, __b) ((__a) + (__b))
#define cputime64_sub(__a, __b) ((__a) - (__b))

#define cputime64_add(__a, __b) ((__a) + (__b))
#define cputime64_sub(__a, __b) ((__a) - (__b))

#endif
