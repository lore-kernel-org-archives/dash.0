Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14A4C433DB
	for <linux-dash@archiver.kernel.org>; Fri, 29 Jan 2021 19:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 941D864E0E
	for <linux-dash@archiver.kernel.org>; Fri, 29 Jan 2021 19:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhA2TuP (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 29 Jan 2021 14:50:15 -0500
Received: from ns.simtreas.ru ([94.25.26.30]:50882 "EHLO ns.simtreas.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232816AbhA2TuF (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 29 Jan 2021 14:50:05 -0500
Received: from dzo.ulttk.ru (IDENT:1000@dzo-home-tun.ufk68.roskazna.local [192.168.68.4])
        by ns.simtreas.ru (8.14.2/8.14.2) with ESMTP id 10TJnHAd019592
        for <dash@vger.kernel.org>; Fri, 29 Jan 2021 23:49:18 +0400
To:     dash@vger.kernel.org
From:   "Vladimir N. Oleynik" <dzo@simtreas.ru>
Subject: [PATCH]: allow $(())
Organization: Ulyanovsk Treasury
Message-ID: <08178d03-1912-76e7-0733-75e8f1d691af@simtreas.ru>
Date:   Fri, 29 Jan 2021 23:49:20 +0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (ns.simtreas.ru [94.25.26.30]); Fri, 29 Jan 2021 23:49:18 +0400 (SAMT)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hello.

My micro patch for allow $(( )) as 0

--- arith_yacc.orig.c   2020-12-23 11:58:12.000000000 +0400
+++ arith_yacc.c        2021-01-29 23:47:01.854997852 +0400
@@ -292,10 +292,17 @@
  intmax_t arith(const char *s)
  {
         intmax_t result;
+       int l0;

         arith_buf = arith_startbuf = s;

-       result = assignment(yylex(), 0);
+       l0 = yylex();
+       if (l0 == 0) {
+               /* $(( )) */
+               yylval.val = 0;
+               l0 = ARITH_NUM;
+       }
+       result = assignment(l0, 0);

         if (last_token)
                 yyerror("expecting EOF");


--w
vodz
