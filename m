From: Nikola Vladov <v20-two_dash_patches@riemann.fmi.uni-sofia.bg>
Subject: memalloc.c patch
Date: Wed, 10 Jun 2009 09:33:35 +0300
Message-ID: <20090610063335.20442.qmail@riemann.fmi.uni-sofia.bg>
References: <20090522195011.9388.qmail@riemann.fmi.uni-sofia.bg> <20090610050456.GA16563@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from riemann.fmi.uni-sofia.bg ([62.44.100.74]:2154 "HELO
	riemann.fmi.uni-sofia.bg" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752488AbZFJGkP (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 10 Jun 2009 02:40:15 -0400
Content-Disposition: inline
In-Reply-To: <20090610050456.GA16563@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org

On Wed, Jun 10, 2009 at 03:04:56PM +1000, Herbert Xu wrote:
> Can you separate these two changes into two patches? It's much
> easier to track down problems if each patch does a single thing.

Bellow are the patches.  In the first we can change space[4] also
to space[1].  The second is good for systems which uses malloc
based on mmap and after
   void *x = malloc(4000);
   free(x);
the region is _unmapped_.  One can check this with a simple program
and strace.

diff -urN dash-0.5.5.1_orig/src/memalloc.c dash-0.5.5.1/src/memalloc.c
--- dash-0.5.5.1_orig/src/memalloc.c	Wed Jan 14 01:37:13 2009
+++ dash-0.5.5.1/src/memalloc.c	Wed Jun 10 09:09:23 2009
@@ -97,18 +97,19 @@
  */
 
 /* minimum size of a block */
-#define MINSIZE SHELL_ALIGN(504)
+/* #define MINSIZE SHELL_ALIGN(504) */
+typedef struct { void *next; size_t size; } __alloc_t;
+#define MINSIZE (512  -SHELL_ALIGN(sizeof(void*) + sizeof(__alloc_t)))
 
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
@@ -125,7 +126,7 @@
 		blocksize = aligned;
 		if (blocksize < MINSIZE)
 			blocksize = MINSIZE;
-		len = sizeof(struct stack_block) - MINSIZE + blocksize;
+		len = sizeof(void *) + blocksize;
 		if (len < blocksize)
 			sh_error("Out of space");
 		INTOFF;
@@ -169,7 +170,7 @@
 
 void setstackmark(struct stackmark *mark)
 {
-	pushstackmark(mark, stacknxt == stackp->space && stackp != &stackbase);
+	pushstackmark(mark, stacknxt == stackp->space);
 }
 
 
@@ -212,19 +213,13 @@
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


===================================================================


diff -urN dash-0.5.5.1_orig/src/memalloc.c dash-0.5.5.1/src/memalloc.c
--- dash-0.5.5.1_orig/src/memalloc.c	Wed Jan 14 01:37:13 2009
+++ dash-0.5.5.1/src/memalloc.c	Wed Jun 10 09:21:21 2009
@@ -99,6 +99,12 @@
 /* minimum size of a block */
 #define MINSIZE SHELL_ALIGN(504)
 
+#if defined(__dietlibc__) || defined(MALLOC_USES_MMAP_FOR_BIG_BLOCKS)
+typedef struct { void *next; size_t size; } __alloc_t;
+#include <sys/shm.h>	/* PAGE_SIZE */
+#define XXXSIZE (PAGE_SIZE -SHELL_ALIGN(sizeof(void*) + sizeof(__alloc_t)))
+#endif
+
 struct stack_block {
 	struct stack_block *prev;
 	char space[MINSIZE];
@@ -123,6 +129,10 @@
 		struct stack_block *sp;
 
 		blocksize = aligned;
+#ifdef XXXSIZE
+		if (stackp && blocksize < XXXSIZE)
+			blocksize = XXXSIZE;
+#endif
 		if (blocksize < MINSIZE)
 			blocksize = MINSIZE;
 		len = sizeof(struct stack_block) - MINSIZE + blocksize;


