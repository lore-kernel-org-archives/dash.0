Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1F7C433F5
	for <linux-dash@archiver.kernel.org>; Wed, 15 Sep 2021 20:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 878FF6105A
	for <linux-dash@archiver.kernel.org>; Wed, 15 Sep 2021 20:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhIOUKF (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 15 Sep 2021 16:10:05 -0400
Received: from mail.gigawatt.nl ([51.68.198.76]:54958 "EHLO mail.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231535AbhIOUKE (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 15 Sep 2021 16:10:04 -0400
X-Greylist: delayed 583 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Sep 2021 16:10:04 EDT
Received: from [IPV6:2a02:8010:68a1:0:e69:c5c8:93ab:b95] (unknown [IPv6:2a02:8010:68a1:0:e69:c5c8:93ab:b95])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id 177B5D45;
        Wed, 15 Sep 2021 20:59:01 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 177B5D45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1631735941;
        bh=rFAJUct/0VHqONUIeO5wGaTG2RFu8/DNiQOjIRX2qI0=; l=817;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IJNQ2FFbsKauCyDV4g+ojPphGhYjJ8bmPxlRsctTabujpjFdm8ok11PhElDbFgLd4
         0A/mUp5XRsY9yZfWVHHKz8SdORPsLfIizxsLMkUzRdMXW5uhiLBQAAZ6v+N4nzLr+F
         pYFUuKDhx+khhDdGQhSojnRxf0wJNP8PcVtn69MA=
Message-ID: <4dfc717b-93dc-7e63-3ede-f8a8cd977413@gigawatt.nl>
Date:   Wed, 15 Sep 2021 20:59:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: shell script error management in busybox ash
Content-Language: en-GB
To:     Denys Vlasenko <vda.linux@googlemail.com>,
        "Roberto A. Foglietta" <roberto.foglietta@gmail.com>
Cc:     DASH shell mailing list <dash@vger.kernel.org>
References: <CAJGKYO4i85vGboyucxhJ948xZYxrBjoj5PtAO0eB3TEWW8QpzA@mail.gmail.com>
 <CAK1hOcOVuR4i0FgEOF1AdTA-EbdJyOTLNbViGxT0zwHceZGt-g@mail.gmail.com>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <CAK1hOcOVuR4i0FgEOF1AdTA-EbdJyOTLNbViGxT0zwHceZGt-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 15/09/2021 20:47, Denys Vlasenko wrote:
> On Wed, Sep 15, 2021 at 7:48 PM Roberto A. Foglietta
> <roberto.foglietta@gmail.com> wrote:
>> Moreover,
>> the code that these exceptions trigger (everywhere the setjmp()
>> returns true) restores some values and frees some memory but the traps
>> need the information before the restore, not the restored values.
> 
> Yes, _this_ is the problem we are having.
> 
> E.g. $FUNCNAME in EXIT trap needs to be current function's name.

Important to also mention that although FUNCNAME is not part of POSIX, 
and there is no spec to compare to, in bash and ksh it does not behave 
that way, so you're talking about implementing FUNCNAME in a way that is 
incompatible with existing shells. Which is fine if that is what you 
want to do.

Cheers,
Harald van Dijk
