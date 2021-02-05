Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,SUBJ_ALL_CAPS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C676C433E0
	for <linux-dash@archiver.kernel.org>; Fri,  5 Feb 2021 08:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBB5664F45
	for <linux-dash@archiver.kernel.org>; Fri,  5 Feb 2021 08:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhBEIuD (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 5 Feb 2021 03:50:03 -0500
Received: from ns.simtreas.ru ([94.25.26.30]:52708 "EHLO ns.simtreas.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229496AbhBEIuB (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 5 Feb 2021 03:50:01 -0500
Received: from [94.25.26.27] (IDENT:1000@dzo.simtreas.ru [94.25.26.27])
        by ns.simtreas.ru (8.14.2/8.14.2) with ESMTP id 1158nBCY017903
        for <dash@vger.kernel.org>; Fri, 5 Feb 2021 12:49:12 +0400
To:     dash@vger.kernel.org
From:   "Vladimir N. Oleynik" <dzo@simtreas.ru>
Subject: [PATCH] [BUG] ${#10}
Organization: Ulyanovsk Treasury
Message-ID: <b91eab68-0a8a-36f0-a947-344cf2c168f5@simtreas.ru>
Date:   Fri, 5 Feb 2021 12:49:15 +0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.5.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------D3630746AB5A0355F682AF51"
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-4.0.1 (ns.simtreas.ru [10.68.0.1]); Fri, 05 Feb 2021 12:49:12 +0400 (SAMT)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

This is a multi-part message in MIME format.
--------------D3630746AB5A0355F682AF51
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

dash have bug for ${#10} and etc: ignores 0... in name (without errors :)

$ foo() { echo "length 10-th arg '${10}' is ${#10}"; }
$ foo a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11
length 10-th arg 'a10' is 2

But need:
length 10-th arg 'a10' is 3


Micro patch attached


--w
vodz

--------------D3630746AB5A0355F682AF51
Content-Type: text/plain; charset=UTF-8;
 name="lenght-na_bug.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="lenght-na_bug.diff.txt"

--- parser.c~	2021-02-04 00:51:34.000000000 +0400
+++ parser.c	2021-02-05 12:42:43.616635640 +0400
@@ -1274,7 +1274,7 @@
 			do {
 				STPUTC(c, out);
 				c = pgetc_eatbnl();
-			} while (!subtype && is_digit(c));
+			} while ((!subtype || subtype == VSLENGTH) && is_digit(c));
 		} else if (c != '}') {
 			int cc = c;
 

--------------D3630746AB5A0355F682AF51--
