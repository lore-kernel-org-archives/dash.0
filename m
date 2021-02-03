Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54A9C433DB
	for <linux-dash@archiver.kernel.org>; Wed,  3 Feb 2021 21:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 743CD64F6D
	for <linux-dash@archiver.kernel.org>; Wed,  3 Feb 2021 21:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhBCVaM (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 3 Feb 2021 16:30:12 -0500
Received: from ns.simtreas.ru ([94.25.26.30]:45556 "EHLO ns.simtreas.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229783AbhBCVaM (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 3 Feb 2021 16:30:12 -0500
Received: from dzo.ulttk.ru (IDENT:1000@dzo-home-tun.ufk68.roskazna.local [192.168.68.4])
        by ns.simtreas.ru (8.14.2/8.14.2) with ESMTP id 113LTPsN024211
        for <dash@vger.kernel.org>; Thu, 4 Feb 2021 01:29:26 +0400
To:     dash@vger.kernel.org
From:   "Vladimir N. Oleynik" <dzo@simtreas.ru>
Subject: [PATCH] trivial add ;& ;;& case break types
Organization: Ulyanovsk Treasury
Message-ID: <41b9469e-f042-3ef3-ca30-2181f3d4ae8e@simtreas.ru>
Date:   Thu, 4 Feb 2021 01:29:25 +0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.5.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------E3B585A39179DDD752A932EB"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (ns.simtreas.ru [94.25.26.30]); Thu, 04 Feb 2021 01:29:26 +0400 (SAMT)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

This is a multi-part message in MIME format.
--------------E3B585A39179DDD752A932EB
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

The trivial patch for add ';&' and ';;&' case break types in attach

test code:

foo() {
  case "$1" in
  a)   echo "case (a)" ;&
  a*)  echo "case (a*)" ;;&
  ab*) echo "case (ab*)" ;;
  *)   echo "default"
  esac
}

$ foo
default

$ foo b
default

$ foo a
case (a)
case (a*)
default

$ foo ab
case (a*)
case (ab*)

$ foo ad
case (a*)
default

$ foo abc
case (a*)
case (ab*)


--w
vodz

--------------E3B585A39179DDD752A932EB
Content-Type: text/plain; charset=UTF-8;
 name="case-brk_type.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="case-brk_type.diff.txt"

--- eval.c.orig 2021-02-04 00:38:55.261769233 +0400
+++ eval.c      2021-02-04 00:45:51.555756211 +0400
@@ -440,6 +440,7 @@
	union node *patp;
	struct arglist arglist;
	int status = 0;
+       int skipmatch = 0;

	errlinno = lineno = n->ncase.linno;
	if (funcline)
@@ -449,7 +450,7 @@
	expandarg(n->ncase.expr, &arglist, EXP_TILDE);
	for (cp = n->ncase.cases ; cp && evalskip == 0 ; cp = cp->nclist.next) {
		for (patp = cp->nclist.pattern ; patp ; patp = patp->narg.next) {
-                       if (casematch(patp, arglist.list->text)) {
+                       if (skipmatch || casematch(patp, arglist.list->text)) {
				/* Ensure body is non-empty as otherwise
				 * EV_EXIT may prevent us from setting the
				 * exit status.
@@ -458,7 +459,15 @@
					status = evaltree(cp->nclist.body,
							  flags);
				}
-                               goto out;
+                               switch (cp->nclist.brk_type) {
+                               case 0:
+                                       goto out;
+                               case 1:
+                                       skipmatch = 1;
+                                       break;
+                               default:
+                                       skipmatch = 0;
+                               }
			}
		}
	}
--- mktokens.orig       2021-02-04 00:26:31.252792506 +0400
+++ mktokens    2021-02-04 00:29:26.483787025 +0400
@@ -50,6 +50,8 @@
 TLP    0       "("
 TRP    1       ")"
 TENDCASE 1     ";;"
+TENDCSCONT 1   ";&"
+TENDCSNPAT 1   ";;&"
 TENDBQUOTE 1   "`"
 TREDIR 0       redirection
 TWORD  0       word
--- parser.c.orig       2021-02-04 00:31:56.372782336 +0400
+++ parser.c    2021-02-04 00:51:34.876964135 +0400
@@ -449,10 +449,14 @@

			checkkwd = CHKNL | CHKKWD;
			if ((t = readtoken()) != TESAC) {
-                               if (t != TENDCASE)
+                               if (t != TENDCASE &&
+                                   t != TENDCSCONT &&
+                                   t != TENDCSNPAT) {
					synexpect(TENDCASE);
-                               else
+                               } else {
+                                       cp->nclist.brk_type = t - TENDCASE;
					goto next_case;
+                               }
			}
		}
		*cpp = NULL;
--- nodetypes.orig	2021-02-04 00:29:46.284786405 +0400
+++ nodetypes	2021-02-04 00:31:25.715783295 +0400
@@ -102,6 +102,7 @@
 
 NCLIST nclist			# a case
 	type	  int
+	brk_type  int			# 0 - ;;  1 - ;&  2 - ;;&
 	next	  nodeptr		# the next case in list
 	pattern	  nodeptr		# list of patterns for this case
 	body	  nodeptr		# code to execute for this case

--------------E3B585A39179DDD752A932EB--
