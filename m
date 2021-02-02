Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C816C433E0
	for <linux-dash@archiver.kernel.org>; Tue,  2 Feb 2021 07:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D7A464EE9
	for <linux-dash@archiver.kernel.org>; Tue,  2 Feb 2021 07:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhBBH4D (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 2 Feb 2021 02:56:03 -0500
Received: from ns.simtreas.ru ([94.25.26.30]:54745 "EHLO ns.simtreas.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229466AbhBBH4D (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 2 Feb 2021 02:56:03 -0500
Received: from [94.25.26.27] (IDENT:1000@dzo.simtreas.ru [94.25.26.27])
        by ns.simtreas.ru (8.14.2/8.14.2) with ESMTP id 1127tIk7004595
        for <dash@vger.kernel.org>; Tue, 2 Feb 2021 11:55:18 +0400
To:     dash@vger.kernel.org
From:   "Vladimir N. Oleynik" <dzo@simtreas.ru>
Subject: ${#a#a} bug?
Organization: Ulyanovsk Treasury
Message-ID: <7d15a038-2dc1-ae08-3091-97e3d356fdc3@simtreas.ru>
Date:   Tue, 2 Feb 2021 11:55:19 +0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-4.0.1 (ns.simtreas.ru [10.68.0.1]); Tue, 02 Feb 2021 11:55:18 +0400 (SAMT)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hello.

$ a=abc
$ echo ${#a#a}

dash-0.5.11.3 produce:
3a
bash:
${#a#a}: bad substitution


Also, found incompatibility vs bash, may be is not bug:
for ${#*} bash eq $#, dash - s="$*" ${#s} :)


--w
vodz
