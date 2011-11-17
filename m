From: Heiko Gerstung <heiko@am-anger-1.de>
Subject: Dashhh
Date: Thu, 17 Nov 2011 17:17:27 +0100
Message-ID: <4EC53397.2030005@am-anger-1.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060400010508030203070607"
Return-path: <dash-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:52451 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223Ab1KQQR3 (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 17 Nov 2011 11:17:29 -0500
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

This is a multi-part message in MIME format.
--------------060400010508030203070607
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi!

I am an enthusiastic user of dash since a couple of months and use it on an embedded system (appliance) that is operating
all around the globe in all kinds of networks. I made the switch from bash to dash as soon as I found out that dash covers
99% of what I do with bash while requiring 10% of the ressources.

In the course of porting ~200 shell scripts (small three liners and a few big guys) from bash to dash, I ran into a few
issues (surprise surprise):

1. The usual "[[" and "==" stuff (pretty easy to change, thank you sed)
2. shift returns with a critical error when no arguments are left (no really good solution found)
3. $[] arithmetic stuff not working (OK, worked around that with bc)
4. The bash FUNCNAME variable was very valuable for debugging purposes and is nonexistent in dash

Now, since I solved point 1 and 3 by changing my code, all I did is creating a very small patch to deal with point 2 and,
since it is also not too complicated, I added patches to deal with point 1 and 4 as well.

I call this the dashhh (dash: Heiko's Hack) and although I browsed the mailing list archives and found out that the shift
issue has not been accepted as a worthwhile change for dash and people are still discussing about "==", I decided that I at
least want to show you my patch.

If anyone wants to try this: Please remember that this of course is no longer dash (it is dashhh).

I can understand the reasoning behind the relucatance of the dash crew to apply any of those changes to the main codebase.
For me it is not so important that dash is fully POSIX compliant (I was using bash for years, that tells you how much I care
for POSIX compliance in my shell scripts), the killer feature of dash is its small footprint and the fast execution times.
Since my shell scripts are running inside a closed system where I control which binary is loaded when I enter #!/bin/dash in
the first line of a new shell script, I can easily make patches to dash and make use of the modifications on my system.

What this tiny patch does:
- shift does not return a critical error when no arguments are left, it simply does nothing
- "[[" works exactly as "["
- "==" works like "="
- the variable FUNCNAME contains the name of the currently running shell function or nothing (when not inside a function)

It is far from being perfect and I am not a very good C programmer (as you can probably tell from looking at the patch), so
please feel free to send me your suggestions for changes and any kind of feedback. And, if anyone feels the need for other
tiny tweaks that due to the strict POSIX compliance approach of dash would not make it into the main source tree, I would be
happy to look into that, maybe it is just another tiny patch.

Best Regards,
  Heiko



--------------060400010508030203070607
Content-Type: text/x-patch;
 name="dashhh-0.5.7.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dashhh-0.5.7.patch"

diff -Naur dash-0.5.7/src/bltin/test.c dash-0.5.7-shhh/src/bltin/test.c
--- dash-0.5.7/src/bltin/test.c	2011-03-15 07:18:06.000000000 +0000
+++ dash-0.5.7-shhh/src/bltin/test.c	2011-11-17 13:29:08.000000000 +0000
@@ -112,6 +112,7 @@
 	{"-G",	FILGID,	UNOP},
 	{"-L",	FILSYM,	UNOP},
 	{"-S",	FILSOCK,UNOP},
+	{"==",	STREQ,	BINOP},
 	{"=",	STREQ,	BINOP},
 	{"!=",	STRNE,	BINOP},
 	{"<",	STRLT,	BINOP},
diff -Naur dash-0.5.7/src/builtins.def.in dash-0.5.7-shhh/src/builtins.def.in
--- dash-0.5.7/src/builtins.def.in	2010-05-27 03:45:23.000000000 +0000
+++ dash-0.5.7-shhh/src/builtins.def.in	2011-11-17 13:27:20.000000000 +0000
@@ -90,5 +90,5 @@
 #ifdef HAVE_GETRLIMIT
 ulimitcmd	ulimit
 #endif
-testcmd		test [
+testcmd		test [ [[
 killcmd		-u kill
diff -Naur dash-0.5.7/src/eval.c dash-0.5.7-shhh/src/eval.c
--- dash-0.5.7/src/eval.c	2011-07-08 08:29:56.000000000 +0000
+++ dash-0.5.7-shhh/src/eval.c	2011-11-17 14:01:55.000000000 +0000
@@ -36,7 +36,7 @@
 #include <signal.h>
 #include <unistd.h>
 #include <sys/types.h>
-
+#include <stdio.h>
 /*
  * Evaluate a command.
  */
@@ -928,6 +928,7 @@
 	int e;
 	int savefuncline;
 
+	snprintf(fnnamevar, sizeof(fnnamevar), "FUNCNAME=%s", argv[0]);
 	saveparam = shellparam;
 	savefuncline = funcline;
 	savehandler = handler;
@@ -949,6 +950,7 @@
 	poplocalvars(0);
 funcdone:
 	INTOFF;
+	strcpy(fnnamevar, "FUNCNAME=");
 	funcline = savefuncline;
 	freefunc(func);
 	freeparam(&shellparam);
diff -Naur dash-0.5.7/src/options.c dash-0.5.7-shhh/src/options.c
--- dash-0.5.7/src/options.c	2008-07-13 14:24:56.000000000 +0000
+++ dash-0.5.7-shhh/src/options.c	2011-11-17 13:35:36.000000000 +0000
@@ -352,8 +352,10 @@
 	n = 1;
 	if (argc > 1)
 		n = number(argv[1]);
-	if (n > shellparam.nparam)
-		sh_error("can't shift that many");
+	if (n > shellparam.nparam) {
+                shellparam.nparam = 0;
+                return 0;
+        }
 	INTOFF;
 	shellparam.nparam -= n;
 	for (ap1 = shellparam.p ; --n >= 0 ; ap1++) {
diff -Naur dash-0.5.7/src/var.c dash-0.5.7-shhh/src/var.c
--- dash-0.5.7/src/var.c	2011-03-15 07:45:32.000000000 +0000
+++ dash-0.5.7-shhh/src/var.c	2011-11-17 14:01:27.000000000 +0000
@@ -83,6 +83,8 @@
 
 int lineno;
 char linenovar[sizeof("LINENO=")+sizeof(int)*CHAR_BIT/3+1] = "LINENO=";
+char fnnamevar[1024] = "FUNCNAME=";
+
 
 /* Some macros in var.h depend on the order, add new variables to the end. */
 struct var varinit[] = {
@@ -102,6 +104,7 @@
 	{ 0,	VSTRFIXED|VTEXTFIXED,		"PS4=+ ",	0 },
 	{ 0,	VSTRFIXED|VTEXTFIXED,		"OPTIND=1",	getoptsreset },
 	{ 0,	VSTRFIXED|VTEXTFIXED,		linenovar,	0 },
+	{ 0,	VSTRFIXED|VTEXTFIXED,		fnnamevar,	0 },
 #ifndef SMALL
 	{ 0,	VSTRFIXED|VTEXTFIXED|VUNSET,	"TERM\0",	0 },
 	{ 0,	VSTRFIXED|VTEXTFIXED|VUNSET,	"HISTSIZE\0",	sethistsize },
@@ -339,6 +342,7 @@
 			fmtstr(linenovar+7, sizeof(linenovar)-7, "%d", lineno);
 		}
 		return strchrnul(v->text, '=') + 1;
+
 	}
 	return NULL;
 }
diff -Naur dash-0.5.7/src/var.h dash-0.5.7-shhh/src/var.h
--- dash-0.5.7/src/var.h	2011-03-15 07:45:32.000000000 +0000
+++ dash-0.5.7-shhh/src/var.h	2011-11-17 13:53:11.000000000 +0000
@@ -89,8 +89,9 @@
 #define vps4 (&vps2)[1]
 #define voptind (&vps4)[1]
 #define vlineno (&voptind)[1]
+#define vfnname (&vlineno)[1]
 #ifndef SMALL
-#define vterm (&vlineno)[1]
+#define vterm (&vfnname)[1]
 #define vhistsize (&vterm)[1]
 #endif
 
@@ -105,6 +106,7 @@
 
 extern int lineno;
 extern char linenovar[];
+extern char fnnamevar[1024];
 
 /*
  * The following macros access the values of the above variables.

--------------060400010508030203070607--
