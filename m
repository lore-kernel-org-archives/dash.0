From: Martijn Dekker <martijn@inlv.org>
Subject: [PATCH] quote arguments in xtrace output
Date: Mon, 27 Feb 2017 07:22:13 +0100
Message-ID: <e50519c3-4055-ab2a-b9f3-0776369e4106@inlv.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------575F76EA48A7C7B9A53C9EC3"
Return-path: <dash-owner@vger.kernel.org>
Received: from kahlil.inlv.org ([37.59.109.123]:57590 "EHLO kahlil.inlv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751484AbdB0GlQ (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 27 Feb 2017 01:41:16 -0500
Received: from breedzicht.local (inlv.demon.nl [212.238.240.159])
        (authenticated bits=0)
        by kahlil.inlv.org (8.14.9/8.14.4) with ESMTP id v1R6MDQ0005866
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
        for <dash@vger.kernel.org>; Mon, 27 Feb 2017 07:22:14 +0100
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash <dash@vger.kernel.org>

This is a multi-part message in MIME format.
--------------575F76EA48A7C7B9A53C9EC3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

The xtrace (set -x) output in dash is a bit of a pain, because arguments
containing whitespace aren't quoted. This can it impossible to tell
which bit belongs to which argument:

$ dash -c 'set -x; printf "%s\n" one "two three" four'
+ printf %s\n one two three four
one
two three
four

Another disadvantage is you cannot simply copy and paste the commands
from this xtrace output to repeat them for debugging purposes.

I wrote the attached patch which fixes this. I've been testing it for
about a week and had no issues.

The patch changes the following:

- Since we don't want every command name and argument quoted but only
those containing non-shell-safe characters, single_quote() has acquired
an extra argument indicating whether quoting should be conditional upon
the string containing non-shell-safe characters (1) or unconditional
(0). Shell-safe characters are defined as this set:
0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz%+,./:=@_^!-

- Quoting of variable assignments preceding commands needs to be handled
specially; in order for the output to be suitable for re-entry into the
shell, only the part after the "=" must be quoted. For this purpose, I
changed eprintlist() into two functions, eprintvarlist() to print the
variable assignments and eprintarglist() to print the rest.

Hope this is useful,

- Martijn

--------------575F76EA48A7C7B9A53C9EC3
Content-Type: text/x-patch;
 name="dash-shellquoted-xtrace.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dash-shellquoted-xtrace.patch"

diff -ur dash-0.5.9.1.orig/src/alias.c dash-0.5.9.1/src/alias.c
--- dash-0.5.9.1.orig/src/alias.c	2014-09-28 10:19:32.000000000 +0200
+++ dash-0.5.9.1/src/alias.c	2017-02-23 03:01:57.000000000 +0100
@@ -197,7 +197,7 @@
 
 void
 printalias(const struct alias *ap) {
-	out1fmt("%s=%s\n", ap->name, single_quote(ap->val));
+	out1fmt("%s=%s\n", ap->name, single_quote(ap->val, 0));
 }
 
 STATIC struct alias **
diff -ur dash-0.5.9.1.orig/src/eval.c dash-0.5.9.1/src/eval.c
--- dash-0.5.9.1.orig/src/eval.c	2016-09-02 16:12:23.000000000 +0200
+++ dash-0.5.9.1/src/eval.c	2017-02-23 03:14:56.000000000 +0100
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
+++ dash-0.5.9.1/src/mystring.c	2017-02-23 03:10:48.000000000 +0100
@@ -184,13 +184,19 @@
 
 /*
  * Produce a possibly single quoted string suitable as input to the shell.
- * The return string is allocated on the stack.
+ * If 'conditional' is nonzero, quoting is only done if the string contains
+ * non-shellsafe characters; if it is zero, quoting is always done.
+ * If quoting was done, the return string is allocated on the stack,
+ * otherwise a pointer to the original string is returned.
  */
 
 char *
-single_quote(const char *s) {
+single_quote(const char *s, int conditional) {
 	char *p;
 
+	if (conditional && s[strspn(s, SHELLSAFECHARS)] == '\0')
+		return (char *)s;
+
 	STARTSTACKSTR(p);
 
 	do {
diff -ur dash-0.5.9.1.orig/src/mystring.h dash-0.5.9.1/src/mystring.h
--- dash-0.5.9.1.orig/src/mystring.h	2014-09-28 10:19:32.000000000 +0200
+++ dash-0.5.9.1/src/mystring.h	2017-02-23 03:01:57.000000000 +0100
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
+#define SHELLSAFECHARS "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz%+,./:=@_^!-"
diff -ur dash-0.5.9.1.orig/src/trap.c dash-0.5.9.1/src/trap.c
--- dash-0.5.9.1.orig/src/trap.c	2016-09-02 16:12:23.000000000 +0200
+++ dash-0.5.9.1/src/trap.c	2017-02-23 03:01:57.000000000 +0100
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
+++ dash-0.5.9.1/src/var.c	2017-02-23 03:01:57.000000000 +0100
@@ -417,7 +417,7 @@
 		p = strchrnul(*ep, '=');
 		q = nullstr;
 		if (*p)
-			q = single_quote(++p);
+			q = single_quote(++p, 0);
 
 		out1fmt("%s%s%.*s%s\n", prefix, sep, (int)(p - *ep), *ep, q);
 	}

--------------575F76EA48A7C7B9A53C9EC3--
