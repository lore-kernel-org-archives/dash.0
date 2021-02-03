Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A78CC433E0
	for <linux-dash@archiver.kernel.org>; Wed,  3 Feb 2021 21:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28CF864F6D
	for <linux-dash@archiver.kernel.org>; Wed,  3 Feb 2021 21:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhBCVpR (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 3 Feb 2021 16:45:17 -0500
Received: from ns.simtreas.ru ([94.25.26.30]:35917 "EHLO ns.simtreas.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232106AbhBCVpJ (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 3 Feb 2021 16:45:09 -0500
Received: from dzo.ulttk.ru (IDENT:1000@dzo-home-tun.ufk68.roskazna.local [192.168.68.4])
        by ns.simtreas.ru (8.14.2/8.14.2) with ESMTP id 113LiRC3024372
        for <dash@vger.kernel.org>; Thu, 4 Feb 2021 01:44:27 +0400
Subject: Re: [PATCH] trivial add ;& ;;& case break types
From:   "Vladimir N. Oleynik" <dzo@simtreas.ru>
To:     dash@vger.kernel.org
References: <41b9469e-f042-3ef3-ca30-2181f3d4ae8e@simtreas.ru>
Organization: Ulyanovsk Treasury
Message-ID: <5250f7bb-5f4d-9848-34a9-49b7f01f0d16@simtreas.ru>
Date:   Thu, 4 Feb 2021 01:44:27 +0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.5.1
MIME-Version: 1.0
In-Reply-To: <41b9469e-f042-3ef3-ca30-2181f3d4ae8e@simtreas.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (ns.simtreas.ru [94.25.26.30]); Thu, 04 Feb 2021 01:44:27 +0400 (SAMT)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Vladimir N. Oleynik wrote:

> The trivial patch for add ';&' and ';;&' case break types in attach


OOPS, I forgot this lines of patch to parser.c:

@@ -818,8 +822,16 @@
                         pungetc();
                         RETURN(TPIPE);
                 case ';':
-                       if (pgetc_eatbnl() == ';')
+                       c = pgetc_eatbnl();
+                       if (c == '&')
+                               RETURN(TENDCSCONT);
+                       if (c == ';') {
+                               c = pgetc_eatbnl();
+                               if (c == '&')
+                                       RETURN(TENDCSNPAT);
+                               pungetc();
                                 RETURN(TENDCASE);
+                       }
                         pungetc();
                         RETURN(TSEMI);

--w
vodz
