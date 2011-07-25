From: Harald van Dijk <harald@gigawatt.nl>
Subject: [PATCH] Avoid imaxdiv when only one of the results is wanted
Date: Tue, 26 Jul 2011 01:09:36 +0200
Message-ID: <1311635376.10727.8.camel@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from hosting12.csv-networks.nl ([84.244.151.141]:57984 "EHLO
	hosting12.csv-networks.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635Ab1GYXhv (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 25 Jul 2011 19:37:51 -0400
Received: from 541f32bc.cm-5-8a.dynamic.ziggo.nl ([84.31.50.188] helo=[10.0.1.100])
	by hosting12.csv-networks.nl with esmtpa (Exim 4.68)
	(envelope-from <harald@gigawatt.nl>)
	id 1QlUEF-0000DR-Ma
	for dash@vger.kernel.org; Tue, 26 Jul 2011 01:06:28 +0200
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

dash rather pointlessly calls imaxdiv, only to discard one of its
results. The call was already made conditional a while back because some
systems don't have imaxdiv, but the generated code for the version with
imaxdiv and the one with / and % is identical (with GCC 4.6.1 or ICC
12.0.2, with -O0, -O2 or -Os), so it could just as well go entirely to
clean up the code a little bit.

Signed-off-by: Harald van Dijk <harald@gigawatt.nl>

diff --git a/ChangeLog b/ChangeLog
index b96e5b2..02bfda0 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2011-07-26  Harald van Dijk <harald@gigawatt.nl>
+
+	* Avoid imaxdiv when only one of the results is wanted.
+
 2010-07-09  maximilian attems <max@stro.at>
 
 	* Fix klibc DEBUG compilation.
diff --git a/configure.ac b/configure.ac
index 7eae954..5cd6e95 100644
--- a/configure.ac
+++ b/configure.ac
@@ -85,7 +85,7 @@ AC_CHECK_DECL([PRIdMAX],,
 ])
 
 dnl Checks for library functions.
-AC_CHECK_FUNCS(bsearch faccessat getpwnam getrlimit imaxdiv isalpha
killpg \
+AC_CHECK_FUNCS(bsearch faccessat getpwnam getrlimit isalpha killpg \
 	       mempcpy \
 	       sigsetmask stpcpy strchrnul strsignal strtod strtoimax \
 	       strtoumax sysconf)
diff --git a/src/arith_yacc.c b/src/arith_yacc.c
index bf21830..1a087c3 100644
--- a/src/arith_yacc.c
+++ b/src/arith_yacc.c
@@ -94,22 +94,13 @@ static inline int higher_prec(int op1, int op2)
 
 static intmax_t do_binop(int op, intmax_t a, intmax_t b)
 {
-#ifdef HAVE_IMAXDIV
-	imaxdiv_t div;
-#endif
