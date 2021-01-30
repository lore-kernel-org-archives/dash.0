Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3448BC433E0
	for <linux-dash@archiver.kernel.org>; Sat, 30 Jan 2021 09:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B60364E28
	for <linux-dash@archiver.kernel.org>; Sat, 30 Jan 2021 09:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhA3JHn (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 30 Jan 2021 04:07:43 -0500
Received: from ns.simtreas.ru ([94.25.26.30]:32829 "EHLO ns.simtreas.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230484AbhA3JHZ (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 30 Jan 2021 04:07:25 -0500
Received: from dzo.ulttk.ru (IDENT:1000@dzo-home-tun.ufk68.roskazna.local [192.168.68.4])
        by ns.simtreas.ru (8.14.2/8.14.2) with ESMTP id 10U7altm024574
        for <dash@vger.kernel.org>; Sat, 30 Jan 2021 11:36:47 +0400
From:   "Vladimir N. Oleynik" <dzo@simtreas.ru>
Subject: Re: getopts appears to not be shifting $@ when consuming options
To:     dash@vger.kernel.org
References: <YBRTFXGM6pLwR5hg@teapot> <20210129203650.GA21262@stack.nl>
 <YBSLRXjBSbNmOHP2@teapot>
Organization: Ulyanovsk Treasury
Message-ID: <4273c178-60fe-ec37-3c7c-6576591ab12f@simtreas.ru>
Date:   Sat, 30 Jan 2021 11:36:48 +0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.5.1
MIME-Version: 1.0
In-Reply-To: <YBSLRXjBSbNmOHP2@teapot>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (ns.simtreas.ru [94.25.26.30]); Sat, 30 Jan 2021 11:36:48 +0400 (SAMT)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hello,

>> set -- -a foo -a bar # for testing
>> while getopts :a: arg; do
>> ...

You can use typical array cryptic emulation with dash for this :)

But i can not send this cryptic script to maillist, his parser crashing:
"for recipient address <dash@vger.kernel.org> the policy analysis reported:
zpostgrey: Read timed out !!!" :))

See ftp://simtreas.ru/pub/my/dash/arg2array.sh


--v
vodz
