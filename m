Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6436CC64E7A
	for <linux-dash@archiver.kernel.org>; Thu,  3 Dec 2020 12:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A39222206
	for <linux-dash@archiver.kernel.org>; Thu,  3 Dec 2020 12:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbgLCMu2 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 3 Dec 2020 07:50:28 -0500
Received: from dd44832.kasserver.com ([85.13.162.224]:55188 "EHLO
        dd44832.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728727AbgLCMu1 (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 3 Dec 2020 07:50:27 -0500
Received: from [192.168.179.70] (x4db8bbfe.dyn.telefonica.de [77.184.187.254])
        by dd44832.kasserver.com (Postfix) with ESMTPSA id 3BA0D35C06F9;
        Thu,  3 Dec 2020 13:49:45 +0100 (CET)
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
Message-ID: <e95df4e6-b7d7-946c-e328-bbed6215a7df@debian.org>
Date:   Thu, 3 Dec 2020 13:49:44 +0100
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

I applied this change, but now the script terminates with 143 [1]

I'm happy for any suggestions to make the script more correct/robust and 
make it pass successfully.

Michael


[1] 
https://ci.debian.net/data/autopkgtest/testing/amd64/s/systemd/8600208/log.gz

