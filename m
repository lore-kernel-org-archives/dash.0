Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C97C433E6
	for <linux-dash@archiver.kernel.org>; Wed,  3 Feb 2021 12:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF42764E30
	for <linux-dash@archiver.kernel.org>; Wed,  3 Feb 2021 12:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhBCM5Z (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 3 Feb 2021 07:57:25 -0500
Received: from ns.simtreas.ru ([94.25.26.30]:51095 "EHLO ns.simtreas.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231404AbhBCMzO (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 3 Feb 2021 07:55:14 -0500
Received: from [94.25.26.27] (IDENT:1000@dzo.simtreas.ru [94.25.26.27])
        by ns.simtreas.ru (8.14.2/8.14.2) with ESMTP id 113CsNd9020109
        for <dash@vger.kernel.org>; Wed, 3 Feb 2021 16:54:23 +0400
To:     dash@vger.kernel.org
From:   "Vladimir N. Oleynik" <dzo@simtreas.ru>
Subject: [PATH] forgoten set $PPID readonly
Organization: Ulyanovsk Treasury
Message-ID: <be7ceb79-c721-740a-7f5a-b65b15d4da24@simtreas.ru>
Date:   Wed, 3 Feb 2021 16:54:24 +0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.5.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------A076C833FDC4BD99D813BCD7"
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-4.0.1 (ns.simtreas.ru [10.68.0.1]); Wed, 03 Feb 2021 16:54:23 +0400 (SAMT)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

This is a multi-part message in MIME format.
--------------A076C833FDC4BD99D813BCD7
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

You probably forgot to specify the readonly flag for $PPID.
Micro patch attached.


--w
vodz

--------------A076C833FDC4BD99D813BCD7
Content-Type: text/x-patch;
 name="var_ppid.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="var_ppid.diff"

--- var.c~	2021-01-31 12:30:38.000000000 +0400
+++ var.c	2021-02-03 16:46:34.657412861 +0400
@@ -139,7 +139,7 @@
 	setvareq(defoptindvar, VTEXTFIXED);
 
 	fmtstr(ppid + 5, sizeof(ppid) - 5, "%ld", (long) getppid());
-	setvareq(ppid, VTEXTFIXED);
+	setvareq(ppid, VTEXTFIXED|VREADONLY);
 
 	p = lookupvar("PWD");
 	if (p)

--------------A076C833FDC4BD99D813BCD7--
