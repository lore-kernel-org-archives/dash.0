From: Martijn Dekker <martijn@inlv.org>
Subject: Re: [PATCH] quote arguments in xtrace output
Date: Tue, 28 Feb 2017 04:39:43 +0100
Message-ID: <0cc5830e-4078-8d4b-55e7-8278f8811e13@inlv.org>
References: <e50519c3-4055-ab2a-b9f3-0776369e4106@inlv.org>
 <f9c5d0a5-69bc-c543-7de8-59e5e9cb105b@gigawatt.nl>
 <6e8434e8-87e3-db2a-9d80-147f064c4793@inlv.org>
 <9092df1b-e6b6-a879-1268-596932892a58@inlv.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------6EBD2C8BE7328911920B815F"
Return-path: <dash-owner@vger.kernel.org>
Received: from kahlil.inlv.org ([37.59.109.123]:49636 "EHLO kahlil.inlv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752059AbdB1LCj (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 28 Feb 2017 06:02:39 -0500
In-Reply-To: <9092df1b-e6b6-a879-1268-596932892a58@inlv.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org

This is a multi-part message in MIME format.
--------------6EBD2C8BE7328911920B815F
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Op 28-02-17 om 00:17 schreef Martijn Dekker:
> Op 27-02-17 om 21:08 schreef Martijn Dekker:
>> Shell reserved words (a.k.a. shell keywords) such as "if" are harder to
>> fix. The single_quote() routine, if told to quote conditionally, would
>> have to iterate through the internal list of shell reserved words and
>> quote the string if it matches one of those. I will see if I can make
>> that happen.
> 
> Here is a version that does that, and removes '=' and '!' from the list
> of shell-safe characters. This should fix all the issues you were
> reporting, hopefully making the xtrace output completely safe for shell
> re-entry. It introduces a new function is_kwd() that checks if a string
> is identical to a shell keyword/reserved word.
> 
> Attached are two patches: one incremental to my previous one, and one
> against pristine dash 0.5.9.1.

There's a bug in my code. Empties need to be quoted, or they'll
disappear. A simple check for the first character being null fixes it.

Once again, one incremental patch against v2, one against pristine dash
0.5.9.1.

- M.


--------------6EBD2C8BE7328911920B815F
Content-Type: text/x-patch;
 name="dash-shellquoted-xtrace-v3-incremental.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dash-shellquoted-xtrace-v3-incremental.patch"

diff -ur dash-0.5.9.1.orig/src/mystring.c dash-0.5.9.1/src/mystring.c
--- dash-0.5.9.1.orig/src/mystring.c	2017-02-28 04:37:45.000000000 +0100
+++ dash-0.5.9.1/src/mystring.c	2017-02-28 04:31:39.000000000 +0100
@@ -213,7 +213,7 @@
 single_quote(const char *s, int conditional) {
 	char *p;
 
-	if (conditional && s[strspn(s, SHELLSAFECHARS)] == '\0' && ! is_kwd(s))
+	if (conditional && *s != '\0' && s[strspn(s, SHELLSAFECHARS)] == '\0' && ! is_kwd(s))
 		return (char *)s;
 
 	STARTSTACKSTR(p);

--------------6EBD2C8BE7328911920B815F
Content-Type: text/x-patch;
 name="dash-shellquoted-xtrace-v3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dash-shellquoted-xtrace-v3.patch"

diff -ur dash-0.5.9.1.orig/src/alias.c dash-0.5.9.1/src/alias.c
--- dash-0.5.9.1.orig/src/alias.c	2014-09-28 10:19:32.000000000 +0200
+++ dash-0.5.9.1/src/alias.c	2017-02-28 04:28:31.000000000 +0100
@@ -197,7 +197,7 @@
 
 void
 printalias(const struct alias *ap) {
-	out1fmt("%s=%s\n", ap->name, single_quote(ap->val));
+	out1fmt("%s=%s\n", ap->name, single_quote(ap->val, 0));
 }
 
 STATIC struct alias **
diff -ur dash-0.5.9.1.orig/src/eval.c dash-0.5.9.1/src/eval.c
--- dash-0.5.9.1.orig/src/eval.c	2016-09-02 16:12:23.000000000 +0200
+++ dash-0.5.9.1/src/eval.c	2017-02-28 04:28:31.000000000 +0100
@@ -95,7 +95,8 @@
 STATIC int evalbltin(const struct builtincmd *, int, char **, int);
 STATIC int evalfun(struct funcnode *, int, char **, int);
 STATIC void prehash(union node *);
-STATIC int eprintlist(struct output *, struct strlist *, int);
+STATIC int eprintvarlist(struct output *, struct strlist *, int);
+STATIC void eprintarglist(struct output *, struct strlist *, int);
 STATIC int bltincmd(int, char **);
 
 
@@ -786,8 +787,8 @@
 		out = &preverrout;
 		outstr(expandstr(ps4val()), out);
 		sep = 0;
-		sep = eprintlist(out, varlist.list, sep);
-		eprintlist(out, arglist.list, sep);
+		sep = eprintvarlist(out, varlist.list, sep);
+		eprintarglist(out, arglist.list, sep);
 		outcslow('\n', out);
 #ifdef FLUSHERR
 		flushout(out);
@@ -1107,16 +1108,35 @@
 
 
 STATIC int
-eprintlist(struct output *out, struct strlist *sp, int sep)
+eprintvarlist(struct output *out, struct strlist *sp, int sep)
 {
 	while (sp) {
 		const char *p;
+		int i;
 
-		p = " %s" + (1 - sep);
+		if (sep)
+			outfmt(out, " ");
 		sep |= 1;
-		outfmt(out, p, sp->text);
+		i = 0;
+		while (sp->text[i] != '=' && sp->text[i] != '\0')
+			outfmt(out, "%c", sp->text[i++]);
+		if (sp->text[i] == '=')
+			outfmt(out, "=%s", single_quote(sp->text+i+1, 1));
 		sp = sp->next;
 	}
 
 	return sep;
 }
+
+STATIC void
+eprintarglist(struct output *out, struct strlist *sp, int sep)
+{
+	while (sp) {
+		const char *p;
+
+		p = " %s" + (1 - sep);
+		sep |= 1;
+		outfmt(out, p, single_quote(sp->text, 1));
+		sp = sp->next;
+	}
+}
diff -ur dash-0.5.9.1.orig/src/mystring.c dash-0.5.9.1/src/mystring.c
--- dash-0.5.9.1.orig/src/mystring.c	2014-09-28 10:19:32.000000000 +0200
+++ dash-0.5.9.1/src/mystring.c	2017-02-28 04:31:39.000000000 +0100
@@ -55,6 +55,7 @@
 #include "memalloc.h"
 #include "parser.h"
 #include "system.h"
+#include "token_vars.h"
 
 
 char nullstr[1];		/* zero length string */
@@ -181,16 +182,40 @@
 	return 1;
 }
 
+/*
+ * Check if a string is identical to a shell keyword (reserved word).
+ */
+
+int
+is_kwd(const char *s)
+{
+	int i = 0;
+
+	do {
+		if (strcmp(s, parsekwd[i++]) == 0)
+			return 1;
+	} while (*parsekwd[i-1] != '}');  /* assuming that "}" is last entry */
+	
+	return 0;
+}
+	
 
 /*
  * Produce a possibly single quoted string suitable as input to the shell.
- * The return string is allocated on the stack.
+ * If 'conditional' is nonzero, quoting is only done if the string contains
+ * non-shellsafe characters, or is identical to a shell keyword (reserved
+ * word); if it is zero, quoting is always done.
+ * If quoting was done, the return string is allocated on the stack,
+ * otherwise a pointer to the original string is returned.
  */
 
 char *
-single_quote(const char *s) {
+single_quote(const char *s, int conditional) {
 	char *p;
 
+	if (conditional && *s != '\0' && s[strspn(s, SHELLSAFECHARS)] == '\0' && ! is_kwd(s))
+		return (char *)s;
+
 	STARTSTACKSTR(p);
 
 	do {
diff -ur dash-0.5.9.1.orig/src/mystring.h dash-0.5.9.1/src/mystring.h
--- dash-0.5.9.1.orig/src/mystring.h	2014-09-28 10:19:32.000000000 +0200
+++ dash-0.5.9.1/src/mystring.h	2017-02-28 04:28:31.000000000 +0100
@@ -54,10 +54,13 @@
 intmax_t atomax10(const char *);
 int number(const char *);
 int is_number(const char *);
-char *single_quote(const char *);
+char *single_quote(const char *, int);
 char *sstrdup(const char *);
 int pstrcmp(const void *, const void *);
 const char *const *findstring(const char *, const char *const *, size_t);
 
 #define equal(s1, s2)	(strcmp(s1, s2) == 0)
 #define scopy(s1, s2)	((void)strcpy(s2, s1))
+
+/* Characters that don't need quoting before re-entry into the shell */
+#define SHELLSAFECHARS "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz%+,./:@_^-"
diff -ur dash-0.5.9.1.orig/src/trap.c dash-0.5.9.1/src/trap.c
--- dash-0.5.9.1.orig/src/trap.c	2016-09-02 16:12:23.000000000 +0200
+++ dash-0.5.9.1/src/trap.c	2017-02-28 04:28:31.000000000 +0100
@@ -107,7 +107,7 @@
 			if (trap[signo] != NULL) {
 				out1fmt(
 					"trap -- %s %s\n",
-					single_quote(trap[signo]),
+					single_quote(trap[signo], 0),
 					signal_names[signo]
 				);
 			}
diff -ur dash-0.5.9.1.orig/src/var.c dash-0.5.9.1/src/var.c
--- dash-0.5.9.1.orig/src/var.c	2014-10-07 16:30:35.000000000 +0200
+++ dash-0.5.9.1/src/var.c	2017-02-28 04:28:31.000000000 +0100
@@ -417,7 +417,7 @@
 		p = strchrnul(*ep, '=');
 		q = nullstr;
 		if (*p)
-			q = single_quote(++p);
+			q = single_quote(++p, 0);
 
 		out1fmt("%s%s%.*s%s\n", prefix, sep, (int)(p - *ep), *ep, q);
 	}

--------------6EBD2C8BE7328911920B815F--
