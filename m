Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F596C63777
	for <linux-dash@archiver.kernel.org>; Thu,  3 Dec 2020 12:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EB492222E
	for <linux-dash@archiver.kernel.org>; Thu,  3 Dec 2020 12:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbgLCM2e (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 3 Dec 2020 07:28:34 -0500
Received: from dd44832.kasserver.com ([85.13.162.224]:51700 "EHLO
        dd44832.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgLCM2e (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 3 Dec 2020 07:28:34 -0500
Received: from [192.168.179.70] (x4db8bbfe.dyn.telefonica.de [77.184.187.254])
        by dd44832.kasserver.com (Postfix) with ESMTPSA id 556C235C06F9;
        Thu,  3 Dec 2020 13:27:52 +0100 (CET)
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Andrej Shadura <andrew.shadura@collabora.co.uk>,
        dash@vger.kernel.org, 974705@bugs.debian.org
References: <0b1af921-f0dc-33e1-eae3-91192c2ec60a@collabora.co.uk>
 <20201201053837.GA26889@gondor.apana.org.au>
 <20201201054203.GA27074@gondor.apana.org.au>
 <20201201060618.GA27281@gondor.apana.org.au>
 <20201201065623.GA27646@gondor.apana.org.au>
 <86689c77-34c6-2dbe-32d2-95f826bfa634@debian.org>
 <20201201232606.GA32382@gondor.apana.org.au>
From:   Michael Biebl <biebl@debian.org>
Subject: Re: Changes to job handling cause hangs in wait
Message-ID: <8f71b2dc-bb40-ec95-51a9-2b60e730bc84@debian.org>
Date:   Thu, 3 Dec 2020 13:27:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201201232606.GA32382@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Am 02.12.20 um 00:26 schrieb Herbert Xu:
> On Wed, Dec 02, 2020 at 12:21:52AM +0100, Michael Biebl wrote:
>>
>> I'll update the timedated test accordingly.
>> Incidentally we already have
>> https://salsa.debian.org/systemd-team/systemd/-/merge_requests/110
> 
> Thanks.

Hm, so I applied this change and switched backed to dash, but now I get

autopkgtest systemd --test-name=timedated -s -- lxc -s autopkgtest-sid
...
disable NTP
enable NTP
Terminated
autopkgtest [13:21:42]: test timedated: -----------------------]
autopkgtest [13:21:42]: test timedated:  - - - - - - - - - - results - - 
- - - - - - - -
timedated            FAIL non-zero exit status 143


Running with sh -x
...
+ kill 825
+ wait 825
Terminated


Herbert, any idea what going wrong there?
(systemd 247.1-2 and dash 0.5.11+git20200708+dd9ef66-2)

Michael
