#pragma once

#include <sys/cdefs.h>
#include <linux/poll.h>
#include <signal.h> /* For sigset_t. */
#include <time.h> /* For timespec. */
__BEGIN_DECLS

typedef unsigned int nfds_t;
int poll(struct pollfd* _Nullable __fds, nfds_t __count, int __timeout_ms);

#if __ANDROID_API__ >= 21
int ppoll(struct pollfd* _Nullable __fds, nfds_t __count, 
const struct timespec* _Nullable __timeout, 
const sigset_t* _Nullable __mask) __INTRODUCED_IN(21);
#endif /* __ANDROID_API__ >= 21 */

#if __ANDROID_API__ >= 28
int ppoll64(struct pollfd* _Nullable  __fds, nfds_t __count, 
const struct timespec* _Nullable __timeout, 
const sigset64_t* _Nullable __mask) __INTRODUCED_IN(28);

#endif /* __ANDROID_API__ >= 28 */
#if defined(__BIONIC_INCLUDE_FORTIFY_HEADERS)
#define _POLL_H_
#include <bits/fortify/poll.h>
#undef _POLL_H_
#endif

__END_DECLS
