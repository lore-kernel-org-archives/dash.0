From: Roy Tam <roytam@gmail.com>
Subject: Re: [HACK v2] making dash works in MSYS environment
Date: Thu, 6 Sep 2012 08:05:31 +0800
Message-ID: <CAA=zYJbdssJaOMiN26bELCkjbhTMD2-X8BAT9ea+YvGSCMMJZg@mail.gmail.com>
References: <CAA=zYJaFsQd5ynPRsdqi3ajSHfUFgkUqW9jRaFmvF25S270_HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37703 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755205Ab2IFAFx (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 5 Sep 2012 20:05:53 -0400
Received: by wicr5 with SMTP id r5so6048569wic.1
        for <dash@vger.kernel.org>; Wed, 05 Sep 2012 17:05:52 -0700 (PDT)
In-Reply-To: <CAA=zYJaFsQd5ynPRsdqi3ajSHfUFgkUqW9jRaFmvF25S270_HQ@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

2012/9/5 Roy Tam <roytam@gmail.com>:
> Dear all,
>
> There is a hack for making dash working in MSYS environment.
> briefly in points:
> - there is no fnmatch.h in MSYS
> - ungetc()ing 0x0D is need in MSYS as some MinGW utilities (for
> example GCC) will return in CRLF line ending
> - strtoll()/strtoull() is missing in MSYS, inlining
> http://cygwin.com/ml/cygwin-apps/2011-07/txt00006.txt to mystring.c as
> a big hack
>
> Regards,
> Roy
>

This patch really processes CRLF only, standalone CR can be kept.

diff --git a/src/expand.c b/src/expand.c
index ce60fe9..c758414 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -45,7 +45,7 @@
 #include <inttypes.h>
 #include <limits.h>
 #include <string.h>
-#include <fnmatch.h>
+//#include <fnmatch.h>
 #ifdef HAVE_GLOB
 #include <glob.h>
 #endif
@@ -516,6 +516,7 @@ expbackq(union node *cmd, int flag)
 {
 	struct backcmd in;
 	int i;
+	int pc = 0;
 	char buf[128];
 	char *p;
 	char *dest;
@@ -557,8 +558,8 @@ read:

 	/* Eat all trailing newlines */
 	dest = expdest;
-	for (; dest > (char *)stackblock() && dest[-1] == '\n';)
-		STUNPUTC(dest);
+	for (; dest > (char *)stackblock() && (dest[-1] == '\n'||(dest[-1]
== '\r' && pc == '\n'));)
+		pc = dest[-1], STUNPUTC(dest);
 	expdest = dest;

 	if (!(flag & EXP_QUOTED))
diff --git a/src/mystring.c b/src/mystring.c
index 0106bd2..7b70baa 100644
--- a/src/mystring.c
+++ b/src/mystring.c
@@ -56,6 +56,140 @@
 #include "parser.h"
 #include "system.h"

+// msys hack
+#ifdef __MSYS__
+/* implementation adapted from google android bionic libc's
+ * strntoumax and strntoimax (removing the dependency on 'n')
+ */
+
+/*-
+ * Copyright (c) 1992 The Regents of the University of California.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of the University nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ */
+
+#include <sys/types.h>
+#include <stddef.h>
+#include <stdlib.h>
+#include <string.h>
+#include <ctype.h>
+#include <errno.h>
+#include <limits.h>
+
+static inline int digitval(int ch)
+{
+  unsigned  d;
+
+  d = (unsigned)(ch - '0');
+  if (d < 10) return (int)d;
+
+  d = (unsigned)(ch - 'a');
+  if (d < 6) return (int)(d+10);
+
+  d = (unsigned)(ch - 'A');
+  if (d < 6) return (int)(d+10);
+
+  return -1;
+}
+
+/*
+ * Convert a string to an unsigned long long.
+ *
+ * Ignores `locale' stuff.  Assumes that the upper and lower case
+ * alphabets and digits are each contiguous.
+ */
+unsigned long long
+strtoull(const char *nptr, char **endptr, int base)
+{
+  const unsigned char*  p   = nptr;
+  const unsigned char*  end;
+  int                   minus = 0;
+  unsigned long long    v = 0;
+  int                   d;
+  end = p + strlen(nptr);
+
+  /* skip leading space */
+  while (p < end && isspace(*p))
+    p++;
+
+  /* Single optional + or - */
+  if (p < end)
+    {
+      char c = p[0];
+      if ( c == '-' || c == '+' )
+        {
+          minus = (c == '-');
+          p++;
+        }
+    }
+
+  if ( base == 0 )
+    {
+      if ( p+2 < end && p[0] == '0' && (p[1] == 'x' || p[1] == 'X') )
+        {
+          p += 2;
+          base = 16;
+        }
+      else if ( p+1 < end && p[0] == '0' )
+        {
+          p   += 1;
+          base = 8;
+        }
+      else
+        {
+          base = 10;
+        }
+    }
+  else if ( base == 16 )
+    {
+      if ( p+2 < end && p[0] == '0' && (p[1] == 'x' || p[1] == 'X') )
+        {
+          p += 2;
+        }
+    }
+
+  while ( p < end && (d = digitval(*p)) >= 0 && d < base )
+    {
+      v = v*base + d;
+      p += 1;
+    }
+
+  if ( endptr )
+    *endptr = (char *)p;
+
+  return minus ? -v : v;
+}
+
+long long
+strtoll(const char *nptr, char **endptr, int base)
+{
+  return (long long) strtoull(nptr, endptr, base);
+}
+#endif
+// msys hack

 char nullstr[1];		/* zero length string */
 const char spcstr[] = " ";
diff --git a/src/show.c b/src/show.c
index 4a049e9..f313c39 100644
--- a/src/show.c
+++ b/src/show.c
@@ -398,7 +398,7 @@ opentrace(void)
 	if ((flags = fcntl(fileno(tracefile), F_GETFL, 0)) >= 0)
 		fcntl(fileno(tracefile), F_SETFL, flags | O_APPEND);
 #endif
-#ifndef __KLIBC__
+#if !defined(__KLIBC__) && !defined(__MSYS__)
 	setlinebuf(tracefile);
 #endif /* __KLIBC__ */
 	fputs("\nTracing started.\n", tracefile);
