From: Nikola Vladov <v20-dash_patch@riemann.fmi.uni-sofia.bg>
Subject: memalloc.c patch
Date: Sun, 24 May 2009 10:59:03 +0300
Message-ID: <20090524075903.830.qmail@riemann.fmi.uni-sofia.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from riemann.fmi.uni-sofia.bg ([62.44.100.74]:2543 "HELO
	riemann.fmi.uni-sofia.bg" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751384AbZEXIFq (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 24 May 2009 04:05:46 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi!  I find some never used code and removed it!

XXXSIZE is for systems which have malloc that uses
mmap/munmap for big blocks.  The patch forces
stalloc to malloc XXXSIZE block after first call of stalloc.
Az a result first stalloc starts with MINSIZE and next
with XXXSIZE.  On my system dash malloc 512 bytes first time.

If some command is too big it grows the stck many times with
4096 bytes by need.  After the command finish it munmap all
unneeded pages.

Nikola


diff -urN dash-0.5.5.1/src/memalloc.c dash-0.5.5.1_nv/src/memalloc.c
--- dash-0.5.5.1/src/memalloc.c	Wed Jan 14 01:37:13 2009
+++ dash-0.5.5.1_nv/src/memalloc.c	Sun May 24 10:32:15 2009
@@ -97,18 +97,24 @@
  */
 
 /* minimum size of a block */
-#define MINSIZE SHELL_ALIGN(504)
+/* #define MINSIZE SHELL_ALIGN(504) */
+typedef struct { void *next; size_t size; } __alloc_t;
+#define MINSIZE (512  -SHELL_ALIGN(sizeof(void*) + sizeof(__alloc_t)))
+
+#if defined(__dietlibc__) || defined(MALLOC_USES_MMAP_FOR_BIG_BLOCKS)
+#include <sys/shm.h>	/* PAGE_SIZE */
+#define XXXSIZE (PAGE_SIZE -SHELL_ALIGN(sizeof(void*) + sizeof(__alloc_t)))
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
@@ -123,9 +129,13 @@
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
@@ -169,7 +179,7 @@
 
 void setstackmark(struct stackmark *mark)
 {
-	pushstackmark(mark, stacknxt == stackp->space && stackp != &stackbase);
+	pushstackmark(mark, stacknxt == stackp->space);
 }
 
 
@@ -212,19 +222,13 @@
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

