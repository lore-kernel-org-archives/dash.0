From: Nikola Vladov <v20-another_malloc@riemann.fmi.uni-sofia.bg>
Subject: another malloc + dash patch
Date: Sun, 28 Jun 2009 09:47:55 +0300
Message-ID: <20090628064755.3036.qmail@riemann.fmi.uni-sofia.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from riemann.fmi.uni-sofia.bg ([62.44.100.74]:1086 "HELO
	riemann.fmi.uni-sofia.bg" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751524AbZF1Gry (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 28 Jun 2009 02:47:54 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

I my previos patch (malloctest.c) I described how to test 
malloc implementation.  I my opinion the standart glibc malloc 
is not very good for dash.  It start with 128K.  From the other
side dash needs only 4K.  At each fork 128K are always copied.

Here I suggest to use another malloc implementation.
It's part of http://riemann.fmi.uni-sofia.bg/programs/diet/alloc.tar.gz
I included here only the file alloc.c.  Acttualy this patch changes
dash memalloc.c with two lines only:

 #include "system.h"
+#define MALLOC_USES_MMAP_FOR_BIG_BLOCKS
+#include "alloc.c"

I included also MINSIZE and XXXSIZE patches.  I tryed to keep
the definitions of the last macros simple.

After applying the patch dash work with less memory (glibc or dietlibc).
The memory does not grow after
	echo /usr/bin/*    # directory with many files.

Herbert, it remains to make for you a separate patch for
memalloc.c which does not change MINSIZE definifion.
Please comment my definintions of MINSIZE and XXXSIZE
and the patch is ready ;-)  If you want really such patch let me know!

Some words about the malloc included here!  See the link above for it.
You will see there that I offer 200 Euro security guarantee for it ;-)

Nikola


Binary files dash-0.5.5.1_orig/dash-0.5.5.1.tar.gz and dash-0.5.5.1/dash-0.5.5.1.tar.gz differ
diff -urN dash-0.5.5.1_orig/src/alloc.c dash-0.5.5.1/src/alloc.c
--- dash-0.5.5.1_orig/src/alloc.c	Thu Jan  1 02:00:00 1970
+++ dash-0.5.5.1/src/alloc.c	Sun Jun 28 00:35:26 2009
@@ -0,0 +1,288 @@
+/*
+ * malloc/free by O.Dreesen
+ *
+ * first TRY:
+ *   lists w/magics
+ * and now the second TRY
+ *   let the kernel map all the stuff (if there is something to do)
+ *
+ * modified by Nikola Vladov: 2009-04-05
+ *   free, calloc, realloc can be in a separate file.
+ */
+
+#include <unistd.h>
+#include <sys/mman.h>
+#if !defined(MREMAP_MAYMOVE) && defined(__linux__)
+#include <linux/mman.h>
+#endif
+// #include "dietfeatures.h" /* must be befoore errno.h */
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+
+#ifndef MEM_BLOCK_SIZE
+#include <sys/shm.h>
+#ifdef PAGE_SIZE
+#define MEM_BLOCK_SIZE PAGE_SIZE
+#endif
+#endif
+
+#ifndef MAP_FAILED
+#define MAP_FAILED ((void*)-1)
+#endif
+
+#ifndef MEM_BLOCK_SIZE
+#if defined(__alpha__) || defined(__sparc__)
+#define MEM_BLOCK_SIZE 8192UL
+#else
+#define MEM_BLOCK_SIZE 4096UL
+#endif
+#endif
+
+#if MEM_BLOCK_SIZE == (1<<17)
+#define PAGE_shift 17
+#elif MEM_BLOCK_SIZE == (1<<16)
+#define PAGE_shift 16
+#elif MEM_BLOCK_SIZE == (1<<15)
+#define PAGE_shift 15
+#elif MEM_BLOCK_SIZE == (1<<14)
+#define PAGE_shift 14
+#elif MEM_BLOCK_SIZE == (1<<13)
+#define PAGE_shift 13
+#elif MEM_BLOCK_SIZE == (1<<12)
+#define PAGE_shift 12
+#else
+#error unknown MEM_BLOCK_SIZE
+#endif
+
+#if !defined(__WORDSIZE) || (__WORDSIZE != 32 && __WORDSIZE != 64)
+#error unknown __WORDSIZE
+#endif
+
+
+#ifdef MALLOC_THREAD_SAFE
+#include "pthread_alloc.h"
+#else
+#define alloc_LOCK(X) X
+#define alloc_MUTEX()
+#endif
+
+typedef struct { void* next; size_t size; } __alloc_t;
+
+#define BLOCK_START(b)	(((void*)(b))-sizeof(__alloc_t))
+#define BLOCK_RET(b)	(((void*)(b))+sizeof(__alloc_t))
+#define BLOCK_size(b)	((__alloc_t*)(b))[-1].size
+#define PAGE_ALIGN(s)	(((s+(MEM_BLOCK_SIZE-1))>>PAGE_shift)<<PAGE_shift)
+#define return_ENOMEM	errno = ENOMEM; return 0
+
+#define __MIN_SMALL_SIZE	__WORDSIZE/2	/* 16/32 */
+#define __MAX_SMALL_SIZE	MEM_BLOCK_SIZE/2
+#define MAX_IDX			(PAGE_shift -3 -__WORDSIZE/32)
+#define __GET_SIZE(s)	__libc_alloc_page_size(s)
+#define __GET_INDEX(s)	__libc_alloc_page_index(s)
+
+#if defined(__i386__)
+#define REGPARM(x) __attribute__((regparm(x)))
+#else
+#define REGPARM(x)
+#endif
+
+#ifdef WANT_FREE_OVERWRITE
+#define ALLOC_FREE_OVERWRITE 0x55
+#else
+#define ALLOC_FREE_OVERWRITE 0
+#endif
+
+#ifndef WANT_GLOBAL_MALLOC_INIT_SPACE
+#define WANT_GLOBAL_MALLOC_INIT_SPACE static
+#endif
+
+extern __alloc_t** __libc_alloc_page_index(size_t size) REGPARM(1);
+extern size_t __libc_alloc_page_size(size_t size) REGPARM(1);
+extern void* __libc_malloc(size_t n);
+extern void  __libc_free(void *p);
+
+
+/* -- HELPER CODE ------------------------------------------------------ */
+
+#ifndef DIET_SKIP_ALLOC_HELPER
+alloc_MUTEX();
+
+WANT_GLOBAL_MALLOC_INIT_SPACE
+__alloc_t *__malloc_free_lists[MAX_IDX] = {0};
+
+__alloc_t** REGPARM(1) __libc_alloc_page_index(size_t size) {
+  size_t len=0;
+  for (; size > __MIN_SMALL_SIZE; size /= 2) ++len;
+  return (__malloc_free_lists+len);
+}
+
+size_t REGPARM(1) __libc_alloc_page_size(size_t size) {
+  register size_t len;
+
+  size+=sizeof(__alloc_t);
+  if (size<=sizeof(__alloc_t)) return 0;
+
+  if (size > __MAX_SMALL_SIZE)
+    len=PAGE_ALIGN(size);
+  else
+    for (len=__MIN_SMALL_SIZE; len < size; ) len *= 2;
+  return len;
+}
+#endif
+
+
+/* -- MALLOC CODE ------------------------------------------------------ */
+
+#ifndef WANT_SEPARATE_MALLOC
+WANT_GLOBAL_MALLOC_INIT_SPACE
+__alloc_t *__malloc_init_space=0;
+
+static void* REGPARM(1) __small_malloc(size_t size) {
+  __alloc_t *ptr, **idx, *prev=(void*)&__malloc_init_space;
+  size_t map_size;
+
+  if (!size) return 0;
+  if (size>__MAX_SMALL_SIZE) {
+    map_size=size;
+    goto do_mmap;
+  }
+  idx=__GET_INDEX(size);
+  ptr=*idx;
+
+  if (ptr) {	/* get a free block */
+    *idx=ptr->next;
+  } else {
+    /* see: Algorithm.txt */
+    for (ptr=__malloc_init_space; ptr; prev=ptr, ptr=ptr->next)
+      if (ptr->size >= size) break;
+
+    if (ptr==0) {
+      map_size=MEM_BLOCK_SIZE;
+    do_mmap:
+      ptr = mmap(0, map_size, PROT_READ|PROT_WRITE,
+		 MAP_ANONYMOUS|MAP_PRIVATE, -1, (size_t)0);
+      if (ptr==MAP_FAILED) return 0;
+      if (size>__MAX_SMALL_SIZE) return ptr;
+
+      prev->next = ptr;
+      ptr->size = map_size;
+    }
+
+    ptr->size -= size;
+    if (ptr->size==0) prev->next = ptr->next;
+    ptr = (((void*)ptr) + ptr->size);
+  }    
+
+  return ptr;
+}
+
+#ifdef WANT_MALLOC_ZERO
+static __alloc_t zeromem[2];
+#endif
+
+static void* _alloc_malloc(size_t size) {
+  __alloc_t* ptr;
+#ifdef WANT_MALLOC_ZERO
+  if (!size) return BLOCK_RET(zeromem);
+#endif
+
+  size=__GET_SIZE(size);
+  alloc_LOCK(ptr=__small_malloc(size));
+
+  if (!ptr) { return_ENOMEM; }
+
+  ptr->next=0;
+  ptr->size=size;
+  return BLOCK_RET(ptr);
+}
+void* __libc_malloc(size_t size) __attribute__((alias("_alloc_malloc")));
+void* malloc(size_t size) __attribute__((weak,alias("_alloc_malloc")));
+#endif
+
+/* -- FREE CODE ------------------------------------------------------ */
+
+#ifndef WANT_SEPARATE_FREE
+static void _alloc_free(void *_ptr) {
+  if (_ptr) {
+    __alloc_t *ptr=BLOCK_START(_ptr);
+    size_t size=ptr->size;
+    if (size) {
+      if (size<=__MAX_SMALL_SIZE) {
+	__alloc_t **idx=__GET_INDEX(size);
+	/* always zero out small mem */
+	memset(ptr,ALLOC_FREE_OVERWRITE,size);
+	alloc_LOCK(ptr->next=*idx; *idx=ptr);
+      } else
+	munmap(ptr,size);
+    }
+  }
+}
+void __libc_free(void *ptr) __attribute__((weak,alias("_alloc_free")));
+void free(void *ptr) __attribute__((weak,alias("_alloc_free")));
+void if_freenameindex(void* ptr) __attribute__((alias("free")));
+#endif
+
+/* -- CALLOC CODE ------------------------------------------------------ */
+
+#ifndef WANT_SEPARATE_CALLOC
+static void* _alloc_calloc(size_t nmemb, size_t _size) {
+  void *x;
+  register size_t size=_size*nmemb;
+  if (nmemb && size/nmemb!=_size) { return_ENOMEM; }
+
+  x = malloc(size);
+#ifdef WANT_FREE_OVERWRITE
+  if (x && size<=__MAX_SMALL_SIZE-sizeof(__alloc_t))
+    memset(x,0,size);
+#endif
+  return x;
+}
+void* __libc_calloc(size_t nmemb, size_t _size) __attribute__((weak,alias("_alloc_calloc")));
+void* calloc(size_t nmemb, size_t _size) __attribute__((weak,alias("_alloc_calloc")));
+#endif
+
+/* -- REALLOC CODE ------------------------------------------------------ */
+
+#ifndef WANT_SEPARATE_REALLOC
+static void* _alloc_realloc(void* ptr, size_t _size) {
+  void *orig=ptr;
+  if (!_size) {
+    if (ptr) {
+      ptr=0;
+      goto do_free;
+    }
+  } else { /* size > 0 */
+    size_t old_size=0, size;
+    if (!ptr) goto do_malloc;
+
+    old_size=BLOCK_size(ptr);
+    size=__GET_SIZE(_size);
+    if (size==0) { return_ENOMEM; }
+
+    if (old_size!=size) {
+#ifdef MREMAP_MAYMOVE
+      if (old_size >= MEM_BLOCK_SIZE && size >= MEM_BLOCK_SIZE) {
+	__alloc_t *t=mremap(BLOCK_START(ptr),old_size,size,MREMAP_MAYMOVE);
+	if (t != MAP_FAILED) {
+	  t->size=size;
+	  return BLOCK_RET(t);
+	}
+      }
+#endif
+    do_malloc:
+      ptr=__libc_malloc(_size);
+      if (ptr && old_size) {
+	size=BLOCK_size(ptr);
+	if (size > old_size) size = old_size;
+	memcpy(ptr,orig,size-sizeof(__alloc_t));
+      do_free:
+	__libc_free(orig);
+      }
+    }
+  }
+  return ptr;
+}
+void* __libc_realloc(void* ptr, size_t size) __attribute__((weak,alias("_alloc_realloc")));
+void* realloc(void* ptr, size_t size) __attribute__((weak,alias("_alloc_realloc")));
+#endif
diff -urN dash-0.5.5.1_orig/src/memalloc.c dash-0.5.5.1/src/memalloc.c
--- dash-0.5.5.1_orig/src/memalloc.c	Wed Jan 14 01:37:13 2009
+++ dash-0.5.5.1/src/memalloc.c	Sun Jun 28 08:40:31 2009
@@ -42,6 +42,8 @@
 #include "machdep.h"
 #include "mystring.h"
 #include "system.h"
+#define MALLOC_USES_MMAP_FOR_BIG_BLOCKS
+#include "alloc.c"
 
 /*
  * Like malloc, but returns an error when out of space.
@@ -97,18 +99,25 @@
  */
 
 /* minimum size of a block */
-#define MINSIZE SHELL_ALIGN(504)
+/* #define MINSIZE SHELL_ALIGN(504) */
+#define MINSIZE (512  -SHELL_ALIGN(sizeof(void*) *3))
+
+#if defined(__dietlibc__) || defined(MALLOC_USES_MMAP_FOR_BIG_BLOCKS)
+#if !defined(MEM_BLOCK_SIZE) && defined(PAGE_SIZE)
+#define MEM_BLOCK_SIZE PAGE_SIZE
+#endif
+#define XXXSIZE (MEM_BLOCK_SIZE -SHELL_ALIGN(sizeof(void*) * 3))
+#endif
 
 struct stack_block {
 	struct stack_block *prev;
-	char space[MINSIZE];
+	char space[4];
 };
 
-struct stack_block stackbase;
-struct stack_block *stackp = &stackbase;
-char *stacknxt = stackbase.space;
-size_t stacknleft = MINSIZE;
-char *sstrend = stackbase.space + MINSIZE;
+static struct stack_block *stackp = 0;
+char *stacknxt = 0;
+char *sstrend = 0;
+size_t stacknleft = 0;
 
 pointer
 stalloc(size_t nbytes)
@@ -123,9 +132,13 @@
 		struct stack_block *sp;
 
 		blocksize = aligned;
+#ifdef XXXSIZE
+		if (stackp && blocksize < XXXSIZE)
+			blocksize = XXXSIZE;
+#endif
 		if (blocksize < MINSIZE)
 			blocksize = MINSIZE;
-		len = sizeof(struct stack_block) - MINSIZE + blocksize;
+		len = sizeof(void *) + blocksize;
 		if (len < blocksize)
 			sh_error("Out of space");
 		INTOFF;
@@ -169,7 +182,7 @@
 
 void setstackmark(struct stackmark *mark)
 {
-	pushstackmark(mark, stacknxt == stackp->space && stackp != &stackbase);
+	pushstackmark(mark, stacknxt == stackp->space);
 }
 
 
@@ -212,19 +225,13 @@
 	if (newlen < 128)
 		newlen += 128;
 
-	if (stacknxt == stackp->space && stackp != &stackbase) {
-		struct stack_block *oldstackp;
+	if (stacknxt == stackp->space) {
 		struct stack_block *sp;
-		struct stack_block *prevstackp;
 		size_t grosslen;
 
 		INTOFF;
-		oldstackp = stackp;
-		sp = stackp;
-		prevstackp = sp->prev;
-		grosslen = newlen + sizeof(struct stack_block) - MINSIZE;
-		sp = ckrealloc((pointer)sp, grosslen);
-		sp->prev = prevstackp;
+ 		grosslen = newlen + sizeof(void *);
+		sp = ckrealloc((pointer)stackp, grosslen);
 		stackp = sp;
 		stacknxt = sp->space;
 		stacknleft = newlen;


