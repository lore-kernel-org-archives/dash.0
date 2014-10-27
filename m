From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 1/9] [BUILTIN] Handle embedded NULs correctly in printf
Date: Mon, 27 Oct 2014 16:26:56 +0800
Message-ID: <E1Xifdg-0001gq-1Z@gondolin.me.apana.org.au>
References: <20141027082546.GA6447@gondor.apana.org.au>
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:43240 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbaJ0I07 (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 27 Oct 2014 04:26:59 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6])
	by fornost.hengli.com.au with esmtp (Exim 4.80 #3 (Debian))
	id 1Xifdg-0006Ib-Ni
	for <dash@vger.kernel.org>; Mon, 27 Oct 2014 19:26:56 +1100
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=379227

On Sat, Jul 22, 2006 at 12:48:38PM +0200, A Mennucc wrote:
> Package: dash
> Version: 0.5.3-3
> Severity: normal
> 
> hi
> 
> here are the examples
> 
> $ bash -c 'echo -n -e "A\0102C\00D\0E" | hexdump -c'
> 0000000   A   B   C  \0   D  \0   E
> 0000007
> 
> $ /bin/echo -n -e "A\0102C\00D\0E" | hexdump -c
> 0000000   A   B   C  \0   D  \0   E
> 0000007
> 
> $ zsh -c 'echo -n -e "A\0102C\00D\0E" | hexdump -c'
> 0000000   A   B   C  \0   D  \0   E
> 0000007
> 
> $ dash -c 'echo -n  "A\0102C\00D\0E" | hexdump -c'
> 0000000   A   B   C
> 0000003
> 
> and also
> 
> $ dash -c 'echo -n  "ABC\0DEFGH" | hexdump -c'
> 0000000   A   B   C
> 0000003
> 
> As you see, dash 's builtin echo truncates the output at the first \0
> 
> a.
> 
> -- System Information:
> Debian Release: testing/unstable
>   APT prefers unstable
>   APT policy: (500, 'unstable'), (500, 'testing')
> Architecture: i386 (i686)
> Shell:  /bin/sh linked to /bin/bash
> Kernel: Linux 2.6.16-1-k7
> Locale: LANG=it_IT.UTF-8, LC_CTYPE=it_IT.UTF-8 (charmap=UTF-8)
> 
> Versions of packages dash depends on:
> ii  libc6                         2.3.6-15   GNU C Library: Shared libraries
> 
> dash recommends no packages.
> 
> -- debconf information:
> * dash/sh: false
> 
> -- 
> Andrea Mennucc
>  "E' un mondo difficile. Che vita intensa!" (Tonino Carotone)

This patch fixes handling of embedded NULs using an approach similar
to the one taken by NetBSD.  In particular, we first determine the
length of the output string, and then use a sequence of Xs of the
same length as input to the underlying C printf to determine the
amount of leading and trailing padding.  Finally we replace the
Xs with the actual string before writing it out.

In order to print out the temporary string containing Xs and padding,
a new helper xasprintf is added.  Unlike asprintf though, our
xasprintf prints to the ash stack rather than using straight malloc
memory.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 ChangeLog          |    1 
 src/bltin/printf.c |   80 ++++++++++++++++++++++++++++++++++++++++-----------
 src/output.c       |   82 ++++++++++++++++++++++++++++++++++-------------------
 src/output.h       |    3 +
 4 files changed, 119 insertions(+), 47 deletions(-)

diff --git a/ChangeLog b/ChangeLog
index 46ef4c2..379672f 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,6 +1,7 @@
 2014-10-27  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Add printf support for format string a, A, and F.
+	* Handle embedded NULs correctly in printf.
 
 2014-10-13  Eric Blake <eblake@redhat.com>
 
diff --git a/src/bltin/printf.c b/src/bltin/printf.c
index e0ef912..213025f 100644
--- a/src/bltin/printf.c
+++ b/src/bltin/printf.c
@@ -40,7 +40,7 @@
 #include <string.h>
 #include <unistd.h>
 
-static int	 conv_escape_str(char *);
+static int	 conv_escape_str(char *, char **);
 static char	*conv_escape(char *, int *);
 static int	 getchr(void);
 static double	 getdouble(void);
@@ -73,6 +73,53 @@ static char  **gargv;
 	} \
 }
 
+#define ASPF(sp, f, func) ({ \
+	int ret; \
+	switch ((char *)param - (char *)array) { \
+	default: \
+		ret = xasprintf(sp, f, array[0], array[1], func); \
+		break; \
+	case sizeof(*param): \
+		ret = xasprintf(sp, f, array[0], func); \
+		break; \
+	case 0: \
+		ret = xasprintf(sp, f, func); \
+		break; \
+	} \
+	ret; \
+})
+
+
+static int print_escape_str(const char *f, int *param, int *array, char *s)
+{
+	struct stackmark smark;
+	char *p, *q;
+	int done;
+	int len;
+	int total;
+
+	setstackmark(&smark);
+	done = conv_escape_str(s, &p);
+	q = stackblock();
+	len = p - q;
+
+	p = makestrspace(len, p);
+	memset(p, 'X', len - 1);
+	p[len - 1] = 0;
+
+	q = stackblock();
+	total = ASPF(&p, f, p);
+
+	len = strchrnul(p, 'X') - p;
+	memcpy(p + len, q, strchrnul(p + len, ' ') - (p + len));
+
+	out1mem(p, total);
+
+	popstackmark(&smark);
+	return done;
+}
+
+
 int printfcmd(int argc, char *argv[])
 {
 	char *fmt;
@@ -154,17 +201,14 @@ pc:
 			fmt[1] = 0;
 			switch (ch) {
 
-			case 'b': {
-				int done = conv_escape_str(getstr());
-				char *p = stackblock();
+			case 'b':
 				*fmt = 's';
-				PF(start, p);
 				/* escape if a \c was encountered */
-				if (done)
+				if (print_escape_str(start, param, array,
+						     getstr()))
 					goto out;
 				*fmt = 'b';
 				break;
-			}
 			case 'c': {
 				int p = getchr();
 				PF(start, p);
@@ -223,8 +267,9 @@ err:
  *	Halts processing string if a \c escape is encountered.
  */
 static int
-conv_escape_str(char *str)
+conv_escape_str(char *str, char **sp)
 {
+	int c;
 	int ch;
 	char *cp;
 
@@ -232,16 +277,14 @@ conv_escape_str(char *str)
 	STARTSTACKSTR(cp);
 
 	do {
-		int c;
-
-		ch = *str++;
+		c = ch = *str++;
 		if (ch != '\\')
 			continue;
 
 		ch = *str++;
 		if (ch == 'c') {
 			/* \c as in SYSV echo - abort all processing.... */
-			ch = 0x100;
+			c = ch = 0x100;
 			continue;
 		}
 
@@ -253,14 +296,14 @@ conv_escape_str(char *str)
 		if (ch == '0') {
 			unsigned char i;
 			i = 3;
-			ch = 0;
+			c = 0;
 			do {
 				unsigned k = octtobin(*str);
 				if (k > 7)
 					break;
 				str++;
-				ch <<= 3;
-				ch += k;
+				c <<= 3;
+				c += k;
 			} while (--i);
 			continue;
 		}
@@ -268,7 +311,9 @@ conv_escape_str(char *str)
 		/* Finally test for sequences valid in the format string */
 		str = conv_escape(str - 1, &c);
 		ch = c;
-	} while (STPUTC(ch, cp), (char)ch);
+	} while (STPUTC(c, cp), (char)ch);
+
+	*sp = cp;
 
 	return ch;
 }
@@ -456,8 +501,7 @@ echocmd(int argc, char **argv)
 	do {
 		int c;
 
-		nonl += conv_escape_str(*argv);
-		outstr(stackblock(), outs);
+		nonl += print_escape_str("%s", NULL, NULL, *argv);
 		if (nonl > 0)
 			break;
 
diff --git a/src/output.c b/src/output.c
index f62e7ea..1b20850 100644
--- a/src/output.c
+++ b/src/output.c
@@ -99,9 +99,6 @@ struct output *out1 = &output;
 struct output *out2 = &errout;
 
 
-#ifndef USE_GLIBC_STDIO
-static void __outstr(const char *, size_t, struct output *);
-#endif
 static int xvsnprintf(char *, size_t, const char *, va_list);
 
 
@@ -134,10 +131,14 @@ RESET {
 #endif
 
 
-#ifndef USE_GLIBC_STDIO
-static void
-__outstr(const char *p, size_t len, struct output *dest)
+void
+outmem(const char *p, size_t len, struct output *dest)
 {
+#ifdef USE_GLIBC_STDIO
+	INTOFF;
+	fwrite(p, 1, len, dest->stream);
+	INTON;
+#else
 	size_t bufsize;
 	size_t offset;
 	size_t nleft;
@@ -186,8 +187,8 @@ alloc:
 err:
 		dest->flags |= OUTPUT_ERR;
 	}
-}
 #endif
+}
 
 
 void
@@ -201,7 +202,7 @@ outstr(const char *p, struct output *file)
 	size_t len;
 
 	len = strlen(p);
-	__outstr(p, len, file);
+	outmem(p, len, file);
 #endif
 }
 
@@ -213,7 +214,7 @@ void
 outcslow(int c, struct output *dest)
 {
 	char buf = c;
-	__outstr(&buf, 1, dest);
+	outmem(&buf, 1, dest);
 }
 #endif
 
@@ -283,35 +284,58 @@ fmtstr(char *outbuf, size_t length, const char *fmt, ...)
 }
 
 
+static int xvasprintf(char **sp, size_t size, const char *f, va_list ap)
+{
+	char *s;
+	int len;
+	va_list ap2;
+
+	va_copy(ap2, ap);
+	len = xvsnprintf(*sp, size, f, ap2);
+	va_end(ap2);
+	if (len < 0)
+		sh_error("xvsnprintf failed");
+	if (len < size)
+		return len;
+
+	s = stalloc((len >= stackblocksize() ? len : stackblocksize()) + 1);
+	*sp = s;
+	len = xvsnprintf(s, len + 1, f, ap);
+	return len;
+}
+
+
+int xasprintf(char **sp, const char *f, ...)
+{
+	va_list ap;
+	int ret;
+
+	va_start(ap, f);
+	ret = xvasprintf(sp, 0, f, ap);
+	va_end(ap);
+	return ret;
+}
+
+
 #ifndef USE_GLIBC_STDIO
 void
 doformat(struct output *dest, const char *f, va_list ap)
 {
 	struct stackmark smark;
 	char *s;
-	int len, ret;
-	size_t size;
-	va_list ap2;
+	int len;
+	int olen;
 
-	va_copy(ap2, ap);
-	size = dest->end - dest->nextc;
-	len = xvsnprintf(dest->nextc, size, f, ap2);
-	va_end(ap2);
-	if (len < 0) {
-		dest->flags |= OUTPUT_ERR;
-		return;
-	}
-	if (len < size) {
+	setstackmark(&smark);
+	s = dest->nextc;
+	olen = dest->end - dest->nextc;
+	len = xvasprintf(&s, olen, f, ap);
+	if (likely(olen > len)) {
 		dest->nextc += len;
-		return;
+		goto out;
 	}
-	setstackmark(&smark);
-	s = stalloc((len >= stackblocksize() ? len : stackblocksize()) + 1);
-	ret = xvsnprintf(s, len + 1, f, ap);
-	if (ret == len)
-		__outstr(s, len, dest);
-	else
-		dest->flags |= OUTPUT_ERR;
+	outmem(s, len, dest);
+out:
 	popstackmark(&smark);
 }
 #endif
diff --git a/src/output.h b/src/output.h
index f853e9d..c43d493 100644
--- a/src/output.h
+++ b/src/output.h
@@ -63,6 +63,7 @@ extern struct output memout;
 extern struct output *out1;
 extern struct output *out2;
 
+void outmem(const char *, size_t, struct output *);
 void outstr(const char *, struct output *);
 #ifndef USE_GLIBC_STDIO
 void outcslow(int, struct output *);
@@ -75,6 +76,7 @@ void out1fmt(const char *, ...)
     __attribute__((__format__(__printf__,1,2)));
 int fmtstr(char *, size_t, const char *, ...)
     __attribute__((__format__(__printf__,3,4)));
+int xasprintf(char **, const char *, ...);
 #ifndef USE_GLIBC_STDIO
 void doformat(struct output *, const char *, va_list);
 #endif
@@ -115,6 +117,7 @@ static inline void outc(int ch, struct output *file)
 #endif
 #define out1c(c)	outc((c), out1)
 #define out2c(c)	outcslow((c), out2)
+#define out1mem(s, l)	outmem((s), (l), out1)
 #define out1str(s)	outstr((s), out1)
 #define out2str(s)	outstr((s), out2)
 #define outerr(f)	(f)->flags
