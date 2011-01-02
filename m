From: David Majnemer <david.majnemer@gmail.com>
Subject: [PATCH] Rid dash of most undefined behavior + one bug fix
Date: Sun, 2 Jan 2011 03:28:17 -0500
Message-ID: <AANLkTikBooagKbv1Nuk_Z_dzgFRCN_evadSJ8faEfwYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42636 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715Ab1ABI2S (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 2 Jan 2011 03:28:18 -0500
Received: by vws16 with SMTP id 16so5410325vws.19
        for <dash@vger.kernel.org>; Sun, 02 Jan 2011 00:28:17 -0800 (PST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi there,

First of all, I apologize if I am doing anything outside of any
established protocol, I could not find the modus operandi of this list

Second of all, the bug:

The test_st_mode function will truncate the geteuid() return value if
sizeof(int) < sizeof(uid_t) which is allowed by POSIX.
This could cause the following comparison: "st->st_uid == euid" to
fail where it should succeed.

diff --git a/src/bltin/test.c b/src/bltin/test.c
index 7888f38..b25362b 100644
--- a/src/bltin/test.c
+++ b/src/bltin/test.c
@@ -498,7 +498,7 @@ static int test_file_access(const char *path, int mode)
 static int
 test_st_mode(const struct stat64 *st, int mode)
 {
-	int euid = geteuid();
+	uid_t euid = geteuid();

 	if (euid == 0) {
 		/* Root can read or write any file. */

Additionally, the dash source base seems to rely on a small number of
GCC/undefined behaviors repeated in a few places.
One of them is performing pointer arithmetic on a pointer to void. The
behavior that the dash source base wants is easily achieved
with a cast to pointer to char.

Another is "Conditionals with Omitted Operands". This is an extension
that allows one to write:
name = arg0 ? arg0 : "sh";
as
name = arg0 ?: "sh";

Yet another extension that is unneeded is the "statement expression extension":
 #define CHECKSTRSPACE(n, p) \
	({ \
 		char *q = (p); \
 		size_t l = (n); \
 		size_t m = sstrend - q; \
 		if (l > m) \
 			(p) = makestrspace(l, q); \
		0; \
	})

It can be replaced with the completely standard:

 #define CHECKSTRSPACE(n, p) \
	do { \
 		char *q = (p); \
 		size_t l = (n); \
 		size_t m = sstrend - q; \
 		if (l > m) \
 			(p) = makestrspace(l, q); \
	} while(0)

Another extension is gcc's field initialization syntax (example is
from the manual):

struct point p = { y: yvalue, x: xvalue };

it can be replaced with:

struct point p = { .y = yvalue, .x = xvalue };

Note, the gcc specific syntax has been _obsolete_ since gcc 2.5!

The final extension: C99 requires that both branches of a ternary
operator require their types to be equivalent.

Oh, and there is one expression that should not be executable:
diff --git a/src/miscbltin.c b/src/miscbltin.c
index 653c92f..7f5ecd3 100644
--- a/src/miscbltin.c
+++ b/src/miscbltin.c
@@ -478,8 +478,6 @@ ulimitcmd(int argc, char **argv)
 			while ((c = *p++) >= '0' && c <= '9')
 			{
 				val = (val * 10) + (long)(c - '0');
-				if (val < (rlim_t) 0)
-					break;
 			}
 			if (c)
 				sh_error("bad number");
val is of type rlim_t, POSIX requires that rlim_t be unsigned.

I highly recommend that dash use -std=c99 (or perhaps -std=gnu99
however this should be avoidable with the below patches) simply
because it makes use of both designated initializers and of variable
length arrays (VLAs)


The following is a series of diffs that should correct the above
issues, feel free to apply what you want (my opinion is that none of
them hurt too much and all of them make the code more portable):

diff --git a/src/bltin/test.c b/src/bltin/test.c
index 7888f38..b25362b 100644
--- a/src/bltin/test.c
+++ b/src/bltin/test.c
@@ -498,7 +498,7 @@ static int test_file_access(const char *path, int mode)
 static int
 test_st_mode(const struct stat64 *st, int mode)
 {
-	int euid = geteuid();
+	uid_t euid = geteuid();

 	if (euid == 0) {
 		/* Root can read or write any file. */
diff --git a/src/cd.c b/src/cd.c
index 9a69b69..d831695 100644
--- a/src/cd.c
+++ b/src/cd.c
@@ -201,7 +201,7 @@ updatepwd(const char *dir)
 		new = stputs(curdir, new);
 	}
 	new = makestrspace(strlen(dir) + 2, new);
-	lim = stackblock() + 1;
+	lim = (char *)stackblock() + 1;
 	if (*dir != '/') {
 		if (new[-1] != '/')
 			USTPUTC('/', new);
diff --git a/src/error.c b/src/error.c
index f1a358d..ae6ab43 100644
--- a/src/error.c
+++ b/src/error.c
@@ -116,7 +116,7 @@ exvwarning2(const char *msg, va_list ap)
 	const char *fmt;

 	errs = out2;
-	name = arg0 ?: "sh";
+	name = arg0 ? arg0 : "sh";
 	fmt = "%s: ";
 	if (commandname) {
 		name = commandname;
diff --git a/src/error.h b/src/error.h
index f236d9f..183a1b9 100644
--- a/src/error.h
+++ b/src/error.h
@@ -79,38 +79,37 @@ extern int exception;
 extern int suppressint;
 extern volatile sig_atomic_t intpending;

-#define barrier() ({ __asm__ __volatile__ ("": : :"memory"); })
+#define barrier() \
+	do { \
+		__asm__ __volatile__ ("": : :"memory"); \
+	} while (0)
 #define INTOFF \
-	({ \
+	do { \
 		suppressint++; \
 		barrier(); \
-		0; \
-	})
+	} while (0)
 #ifdef REALLY_SMALL
 void __inton(void);
 #define INTON __inton()
 #else
 #define INTON \
-	({ \
+	do { \
 		barrier(); \
 		if (--suppressint == 0 && intpending) onint(); \
-		0; \
-	})
+	} while (0)
 #endif
 #define FORCEINTON \
-	({ \
+	do { \
 		barrier(); \
 		suppressint = 0; \
 		if (intpending) onint(); \
-		0; \
-	})
+	} while (0)
 #define SAVEINT(v) ((v) = suppressint)
 #define RESTOREINT(v) \
-	({ \
+	do { \
 		barrier(); \
 		if ((suppressint = (v)) == 0 && intpending) onint(); \
-		0; \
-	})
+	} while (0)
 #define CLEAR_PENDING_INT intpending = 0
 #define int_pending() intpending

diff --git a/src/eval.c b/src/eval.c
index 6e5c43e..11d0e18 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -104,8 +104,8 @@ STATIC int bltincmd(int, char **);


 STATIC const struct builtincmd bltin = {
-	name: nullstr,
-	builtin: bltincmd
+	.name = nullstr,
+	.builtin = bltincmd
 };


diff --git a/src/expand.c b/src/expand.c
index 1b77b7c..0e406a2 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -653,7 +653,7 @@ subevalvar(char *p, char *str, int strloc, int
subtype, int startloc, int varfla
 			       (flag & EXP_QUOTED ? EXP_QPAT : EXP_CASE) : 0));
 	STPUTC('\0', expdest);
 	argbackq = saveargbackq;
-	startp = stackblock() + startloc;
+	startp = (char *)stackblock() + startloc;

 	switch (subtype) {
 	case VSASSIGN:
@@ -674,16 +674,16 @@ subevalvar(char *p, char *str, int strloc, int
subtype, int startloc, int varfla
 #endif

 	rmesc = startp;
-	rmescend = stackblock() + strloc;
+	rmescend = (char *)stackblock() + strloc;
 	if (quotes) {
 		rmesc = _rmescapes(startp, RMESCAPE_ALLOC | RMESCAPE_GROW);
 		if (rmesc != startp) {
 			rmescend = expdest;
-			startp = stackblock() + startloc;
+			startp = (char *)stackblock() + startloc;
 		}
 	}
 	rmescend--;
-	str = stackblock() + strloc;
+	str = (char *)stackblock() + strloc;
 	preglob(str, 0);

 	/* zero = subtype == VSTRIMLEFT || subtype == VSTRIMLEFTMAX */
diff --git a/src/memalloc.c b/src/memalloc.c
index e75e609..d710da8 100644
--- a/src/memalloc.c
+++ b/src/memalloc.c
@@ -264,7 +264,7 @@ growstackstr(void)
 {
 	size_t len = stackblocksize();
 	growstackblock();
-	return stackblock() + len;
+	return (char *)stackblock() + len;
 }

 /*
@@ -286,7 +286,7 @@ makestrspace(size_t newlen, char *p)
 			break;
 		growstackblock();
 	}
-	return stackblock() + len;
+	return (char *)stackblock() + len;
 }

 char *
diff --git a/src/memalloc.h b/src/memalloc.h
index 4b5be46..500b177 100644
--- a/src/memalloc.h
+++ b/src/memalloc.h
@@ -79,14 +79,13 @@ static inline char *_STPUTC(int c, char *p) {
 #define STARTSTACKSTR(p) ((p) = stackblock())
 #define STPUTC(c, p) ((p) = _STPUTC((c), (p)))
 #define CHECKSTRSPACE(n, p) \
-	({ \
+	do { \
 		char *q = (p); \
 		size_t l = (n); \
 		size_t m = sstrend - q; \
 		if (l > m) \
 			(p) = makestrspace(l, q); \
-		0; \
-	})
+	} while(0)
 #define USTPUTC(c, p)	(*p++ = (c))
 #define STACKSTRNUL(p)	((p) == sstrend? (p = growstackstr(), *p =
'\0') : (*p = '\0'))
 #define STUNPUTC(p)	(--p)
diff --git a/src/miscbltin.c b/src/miscbltin.c
index 653c92f..7f5ecd3 100644
--- a/src/miscbltin.c
+++ b/src/miscbltin.c
@@ -478,8 +478,6 @@ ulimitcmd(int argc, char **argv)
 			while ((c = *p++) >= '0' && c <= '9')
 			{
 				val = (val * 10) + (long)(c - '0');
-				if (val < (rlim_t) 0)
-					break;
 			}
 			if (c)
 				sh_error("bad number");
diff --git a/src/options.c b/src/options.c
index 6f381e6..30dee40 100644
--- a/src/options.c
+++ b/src/options.c
@@ -394,7 +394,10 @@ void
 getoptsreset(value)
 	const char *value;
 {
-	shellparam.optind = number(value) ?: 1;
+	shellparam.optind = number(value);
+	if (!shellparam.optind) {
+		shellparam.optind = 1;
+	}
 	shellparam.optoff = -1;
 }

diff --git a/src/output.c b/src/output.c
index 2f9b5c4..b36ff72 100644
--- a/src/output.c
+++ b/src/output.c
@@ -71,27 +71,27 @@

 #ifdef USE_GLIBC_STDIO
 struct output output = {
-	stream: 0, nextc: 0, end: 0, buf: 0, bufsize: 0, fd: 1, flags: 0
+	.stream = 0, .nextc = 0, .end = 0, .buf = 0, .bufsize = 0, .fd = 1, .flags = 0
 };
 struct output errout = {
-	stream: 0, nextc: 0, end: 0, buf: 0, bufsize: 0, fd: 2, flags: 0
+	.stream = 0, .nextc = 0, .end = 0, .buf = 0, .bufsize = 0, .fd = 2, .flags = 0
 }
 #ifdef notyet
 struct output memout = {
-	stream: 0, nextc: 0, end: 0, buf: 0, bufsize: 0, fd: MEM_OUT, flags: 0
+	.stream = 0, .nextc = 0, .end = 0, .buf = 0, .bufsize = 0, .fd =
MEM_OUT, .flags = 0
 };
 #endif
 #else
 struct output output = {
-	nextc: 0, end: 0, buf: 0, bufsize: OUTBUFSIZ, fd: 1, flags: 0
+	.nextc = 0, .end = 0, .buf = 0, .bufsize = OUTBUFSIZ, .fd = 1, .flags = 0
 };
 struct output errout = {
-	nextc: 0, end: 0, buf: 0, bufsize: 0, fd: 2, flags: 0
+	.nextc = 0, .end = 0, .buf = 0, .bufsize = 0, .fd = 2, .flags = 0
 };
 struct output preverrout;
 #ifdef notyet
 struct output memout = {
-	nextc: 0, end: 0, buf: 0, bufsize: 0, fd: MEM_OUT, flags: 0
+	.nextc = 0, .end = 0, .buf = 0, .bufsize = 0, .fd = MEM_OUT, .flags = 0
 };
 #endif
 #endif
diff --git a/src/output.h b/src/output.h
index d123301..eecdbbd 100644
--- a/src/output.h
+++ b/src/output.h
@@ -100,7 +100,7 @@ freestdout()
 #define outc(c, o)	putc((c), (o)->stream)
 #define doformat(d, f, a)	vfprintf((d)->stream, (f), (a))
 #else
-#define outc(c, file)	((file)->nextc == (file)->end ? outcslow((c),
(file)) : (*(file)->nextc = (c), (file)->nextc++))
+#define outc(c, file)	((file)->nextc == (file)->end ? outcslow((c),
(file)) : (*(file)->nextc = (c), (void)(file)->nextc++))
 #endif
 #define out1c(c)	outc((c), out1)
 #define out2c(c)	outcslow((c), out2)
diff --git a/src/system.c b/src/system.c
index 5fd6062..7c35f46 100644
--- a/src/system.c
+++ b/src/system.c
@@ -64,7 +64,7 @@
 #ifndef HAVE_MEMPCPY
 void *mempcpy(void *dest, const void *src, size_t n)
 {
-	return memcpy(dest, src, n) + n;
+	return (char *)memcpy(dest, src, n) + n;
 }
 #endif

diff --git a/src/var.c b/src/var.c
index 25c2216..2957954 100644
--- a/src/var.c
+++ b/src/var.c
@@ -336,7 +336,11 @@ lookupvar(const char *name)

 intmax_t lookupvarint(const char *name)
 {
-	return atomax(lookupvar(name) ?: nullstr, 0);
+	char *s = lookupvar(name);
+	if (!s) {
+		s = nullstr;
+	}
+	return atomax(s, 0);
 }
