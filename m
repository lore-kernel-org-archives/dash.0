Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA83C433E0
	for <linux-dash@archiver.kernel.org>; Sun, 31 Jan 2021 09:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51C4D64E11
	for <linux-dash@archiver.kernel.org>; Sun, 31 Jan 2021 09:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhAaJcw (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 31 Jan 2021 04:32:52 -0500
Received: from ns.simtreas.ru ([94.25.26.30]:34906 "EHLO ns.simtreas.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbhAaJa0 (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 31 Jan 2021 04:30:26 -0500
Received: from dzo.ulttk.ru (IDENT:1000@dzo-home-tun.ufk68.roskazna.local [192.168.68.4])
        by ns.simtreas.ru (8.14.2/8.14.2) with ESMTP id 10V9TWK8001663;
        Sun, 31 Jan 2021 13:29:33 +0400
Subject: [PATCH]: allow recursive variable inderection in arith
From:   "Vladimir N. Oleynik" <dzo@simtreas.ru>
To:     dash@vger.kernel.org
References: <08178d03-1912-76e7-0733-75e8f1d691af@simtreas.ru>
Cc:     "Vladimir N. Oleynik" <dzo@simtreas.ru>
Organization: Ulyanovsk Treasury
Message-ID: <ecf90382-e5b9-9b0c-c73b-c564a660ee20@simtreas.ru>
Date:   Sun, 31 Jan 2021 13:29:36 +0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.5.1
MIME-Version: 1.0
In-Reply-To: <08178d03-1912-76e7-0733-75e8f1d691af@simtreas.ru>
Content-Type: multipart/mixed;
 boundary="------------693E1DBEBF28AB9647C1A68D"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (ns.simtreas.ru [94.25.26.30]); Sun, 31 Jan 2021 13:29:33 +0400 (SAMT)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

This is a multi-part message in MIME format.
--------------693E1DBEBF28AB9647C1A68D
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Hello.


My patch for allow recursive variable inderection in arith
and simplify allow $(( )). Originaly from my arith in busybox

Before patch:
$ a=b b=2; echo $((a))
dash: 1: Illegal number: b

After patch:
$ a=b b=2; echo $((a))
2
a=b b="a*2"; echo $((a))
./dash: 4: arithmetic expression: expression recursion loop detected: "a"


--w
vodz

--------------693E1DBEBF28AB9647C1A68D
Content-Type: text/plain; charset=UTF-8;
 name="arith_diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="arith_diff.txt"

--- arith_yacc.c.orig   2020-12-23 11:58:12.000000000 +0400
+++ arith_yacc.c        2021-01-31 13:19:00.790119536 +0400
@@ -34,6 +34,7 @@

 #include <inttypes.h>
 #include <stdlib.h>
+#include <string.h>
 #include "arith_yacc.h"
 #include "expand.h"
 #include "shell.h"
@@ -134,6 +135,50 @@

 static intmax_t assignment(int var, int noeval);

+typedef struct CHK_VAR_RECURSIVE_LOOPED {
+       const char *name;
+       struct CHK_VAR_RECURSIVE_LOOPED *next;
+} chk_var_recursive_looped_t;
+
+static chk_var_recursive_looped_t *prev_chk_var_recursive;
+
+static intmax_t arith_lookup_val(const char *name)
+{
+       const char * p = lookupvar(name);
+
+       if(p) {
+           intmax_t ret;
+
+           /* recursive try as expression */
+           chk_var_recursive_looped_t *cur;
+           chk_var_recursive_looped_t cur_save;
+           const char *arith_buf_s;
+           int lt;
+
+           for(cur = prev_chk_var_recursive; cur; cur = cur->next) {
+               if(!strcmp(cur->name, name))
+                   yyerror("expression recursion loop detected");
+           }
+           /* save current lookuped var name */
+           cur = prev_chk_var_recursive;
+           cur_save.name = name;
+           cur_save.next = cur;
+           prev_chk_var_recursive = &cur_save;
+
+           arith_buf_s = arith_buf;
+           lt = last_token;
+           ret = arith (p, 1);
+           /* restore previous after recursiving */
+           prev_chk_var_recursive = cur;
+           arith_buf = arith_buf_s;
+           last_token = lt;
+           return ret;
+       } else {
+           /* allow undefined var as 0 */
+           return 0;
+       }
+}
+
 static intmax_t primary(int token, union yystype *val, int op, int noeval)
 {
	intmax_t result;
@@ -151,7 +196,7 @@
		return val->val;
	case ARITH_VAR:
		last_token = op;
-               return noeval ? val->val : lookupvarint(val->name);
+               return noeval ? val->val : arith_lookup_val(val->name);
	case ARITH_ADD:
		token = op;
		*val = yylval;
@@ -286,16 +331,27 @@

	return setvarint(val.name,
			 op == ARITH_ASS ? result :
-                        do_binop(op - 11, lookupvarint(val.name), result), 0);
+                        do_binop(op - 11, arith_lookup_val(val.name), result), 0);
 }

-intmax_t arith(const char *s)
+intmax_t arith(const char *s, int r)
 {
	intmax_t result;
+       int l0;

-       arith_buf = arith_startbuf = s;
+       arith_buf = s;
+       last_token = 0;

-       result = assignment(yylex(), 0);
+       if(!r) {
+               prev_chk_var_recursive = (chk_var_recursive_looped_t *)0;
+               arith_startbuf = s;
+       }
+       l0 = yylex();
+       if (l0 == 0) {
+               /* $(( )) */
+               return 0;
+       }
+       result = assignment(l0, 0);

	if (last_token)
		yyerror("expecting EOF");
--- expand.c.orig       2020-12-23 11:58:12.000000000 +0400
+++ expand.c    2021-01-31 12:39:07.083194412 +0400
@@ -460,7 +460,7 @@
		rmescapes(start);

	pushstackmark(&sm, endoff);
-       result = arith(start);
+       result = arith(start, 0);
	popstackmark(&sm);

	len = cvtnum(result, flag);
--- expand.h.orig       2020-12-23 11:58:12.000000000 +0400
+++ expand.h    2021-01-31 12:39:09.435194338 +0400
@@ -73,7 +73,7 @@
 void ifsfree(void);

 /* From arith.y */
-intmax_t arith(const char *);
+intmax_t arith(const char *, int r);
 int expcmd(int , char **);
 #ifdef USE_LEX
 void arith_lex_reset(void);
--- var.c.orig  2020-12-23 11:58:12.000000000 +0400
+++ var.c       2021-01-31 12:30:38.894210308 +0400
@@ -322,12 +322,6 @@
	return NULL;
 }

-intmax_t lookupvarint(const char *name)
-{
-       return atomax(lookupvar(name) ?: nullstr, 0);
-}
-
-

 /*
--- var.h.orig  2020-12-23 11:58:12.000000000 +0400
+++ var.h       2021-01-31 12:30:45.150210113 +0400
@@ -140,7 +140,6 @@
 struct var *setvareq(char *s, int flags);
 struct strlist;
 char *lookupvar(const char *);
-intmax_t lookupvarint(const char *);
 char **listvars(int, int, char ***);
 #define environment() listvars(VEXPORT, VUNSET, 0)
 int showvars(const char *, int, int);

--------------693E1DBEBF28AB9647C1A68D--
