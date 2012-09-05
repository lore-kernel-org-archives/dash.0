From: Roy Tam <roytam@gmail.com>
Subject: [HACK] making dash works in MSYS environment
Date: Wed, 5 Sep 2012 16:06:13 +0800
Message-ID: <CAA=zYJaFsQd5ynPRsdqi3ajSHfUFgkUqW9jRaFmvF25S270_HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:41679 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765Ab2IEIGe (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 5 Sep 2012 04:06:34 -0400
Received: by weyx8 with SMTP id x8so200433wey.19
        for <dash@vger.kernel.org>; Wed, 05 Sep 2012 01:06:33 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Dear all,

There is a hack for making dash working in MSYS environment.
briefly in points:
- there is no fnmatch.h in MSYS
- ungetc()ing 0x0D is need in MSYS as some MinGW utilities (for
example GCC) will return in CRLF line ending
- strtoll()/strtoull() is missing in MSYS, inlining
http://cygwin.com/ml/cygwin-apps/2011-07/txt00006.txt to mystring.c as
a big hack

Regards,
Roy

diff --git a/src/expand.c b/src/expand.c
index ce60fe9..01662e7 100644
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
@@ -557,7 +557,7 @@ read:

 	/* Eat all trailing newlines */
 	dest = expdest;
-	for (; dest > (char *)stackblock() && dest[-1] == '\n';)
+	for (; dest > (char *)stackblock() && (dest[-1] == '\n'||dest[-1] == '\r');)
 		STUNPUTC(dest);
 	expdest = dest;

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
