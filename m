Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14568C64E7A
	for <linux-dash@archiver.kernel.org>; Tue,  1 Dec 2020 23:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9E922222A
	for <linux-dash@archiver.kernel.org>; Tue,  1 Dec 2020 23:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgLAXWf (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 1 Dec 2020 18:22:35 -0500
Received: from dd44832.kasserver.com ([85.13.162.224]:57262 "EHLO
        dd44832.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgLAXWf (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 1 Dec 2020 18:22:35 -0500
Received: from [192.168.179.70] (x4db4e882.dyn.telefonica.de [77.180.232.130])
        by dd44832.kasserver.com (Postfix) with ESMTPSA id 228C235C07B3;
        Wed,  2 Dec 2020 00:21:53 +0100 (CET)
Subject: Re: Changes to job handling cause hangs in wait
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Andrej Shadura <andrew.shadura@collabora.co.uk>
Cc:     dash@vger.kernel.org, 974705@bugs.debian.org
References: <0b1af921-f0dc-33e1-eae3-91192c2ec60a@collabora.co.uk>
 <20201201053837.GA26889@gondor.apana.org.au>
 <20201201054203.GA27074@gondor.apana.org.au>
 <20201201060618.GA27281@gondor.apana.org.au>
 <20201201065623.GA27646@gondor.apana.org.au>
From:   Michael Biebl <biebl@debian.org>
Message-ID: <86689c77-34c6-2dbe-32d2-95f826bfa634@debian.org>
Date:   Wed, 2 Dec 2020 00:21:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201201065623.GA27646@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Am 01.12.20 um 07:56 schrieb Herbert Xu:
> On Tue, Dec 01, 2020 at 05:06:18PM +1100, Herbert Xu wrote:
>>
>> For some reason this is causing the final two tee's to be created
>> as children of debian/tests/timedated rather than the bash shell.
> 
> An alternative to changing the parent is of course to do
> 
> 	wait $MONPID
> 
> instead of
> 
> 	wait
> 
> I think this makes more sense anyway as otherwise someone could
> easily introduce a hang if they unwittingly add a backgrounded
> job to this script.

I'll update the timedated test accordingly.
Incidentally we already have
https://salsa.debian.org/systemd-team/systemd/-/merge_requests/110
