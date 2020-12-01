Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F92FC64E7B
	for <linux-dash@archiver.kernel.org>; Tue,  1 Dec 2020 13:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA5E72084C
	for <linux-dash@archiver.kernel.org>; Tue,  1 Dec 2020 13:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgLANFA (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 1 Dec 2020 08:05:00 -0500
Received: from dd44832.kasserver.com ([85.13.162.224]:35720 "EHLO
        dd44832.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728746AbgLANFA (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 1 Dec 2020 08:05:00 -0500
Received: from [192.168.179.70] (x4db4e882.dyn.telefonica.de [77.180.232.130])
        by dd44832.kasserver.com (Postfix) with ESMTPSA id 1221635C318D;
        Tue,  1 Dec 2020 14:04:17 +0100 (CET)
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Harald van Dijk <harald@gigawatt.nl>
Cc:     Andrej Shadura <andrew.shadura@collabora.co.uk>,
        dash@vger.kernel.org, 974705@bugs.debian.org
References: <0b1af921-f0dc-33e1-eae3-91192c2ec60a@collabora.co.uk>
 <20201201053837.GA26889@gondor.apana.org.au>
 <20201201054203.GA27074@gondor.apana.org.au>
 <20201201060618.GA27281@gondor.apana.org.au>
 <0e6bb3c5-96d9-18e1-e6bb-87cb34f85fab@gigawatt.nl>
 <20201201103448.GA28234@gondor.apana.org.au>
 <861e7a14-3dfc-83f7-8872-714b333d4246@gigawatt.nl>
 <20201201105328.GA28341@gondor.apana.org.au>
From:   Michael Biebl <biebl@debian.org>
Subject: Re: Changes to job handling cause hangs in wait
Message-ID: <de2922f5-1c3e-202e-09ff-6bcd633db46c@debian.org>
Date:   Tue, 1 Dec 2020 14:04:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201201105328.GA28341@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Am 01.12.20 um 11:53 schrieb Herbert Xu:
> On Tue, Dec 01, 2020 at 10:50:19AM +0000, Harald van Dijk wrote:
>>
>> This used to exit immediately, leaving the sleep process running in the
>> background without waiting for it. On the dash that's currently provided by
>> Ubuntu, based on 0.5.10.2, it still behaves that way. With current dash from
>> Git, it does not. This is clearly a change in behaviour in dash not in
>> response to any bug (real or not) in bash.
> 
> I'm not suggesting it's a bug in bash.  If anything it's a bug
> in the script.

Keep in mind, that the timedated script is not the only affected script, 
there is at least src:fence-agents as well and there might be other 
packages affected as well as local scripts which expect /bin/sh to 
behave POSIX compliant in that regard.

If this change in behaviour is kept, I would at least expect a big fat 
NEWS entry in the Debian dash package which is shown on upgrades and it 
should probably also update the package description which currently 
still says that it is a POSIX-compliant shell.

Regards,
Michael
