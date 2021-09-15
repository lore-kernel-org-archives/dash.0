Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AF6C433EF
	for <linux-dash@archiver.kernel.org>; Wed, 15 Sep 2021 20:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4016D601FA
	for <linux-dash@archiver.kernel.org>; Wed, 15 Sep 2021 20:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhIOUR2 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 15 Sep 2021 16:17:28 -0400
Received: from mail.gigawatt.nl ([51.68.198.76]:54976 "EHLO mail.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231559AbhIOUR2 (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 15 Sep 2021 16:17:28 -0400
Received: from [IPV6:2a02:8010:68a1:0:e69:c5c8:93ab:b95] (unknown [IPv6:2a02:8010:68a1:0:e69:c5c8:93ab:b95])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id 31CFA739;
        Wed, 15 Sep 2021 21:16:08 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 31CFA739
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1631736968;
        bh=MM0R5Ruu36pEsyGZqRrVcTwAemOLmaxAt+mPKR4F47Y=; l=1783;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SEEuYaFJIHrZbS0mlpK/beMf16bQ/vbsoN5etG8w+5HkOCtZbtbYXVQDikNabVtA+
         kPk+DKn8V7wdtGDNdh4y6R5v3nurPfoimvskBZl0JBKhAT2Pz62IhrY9rBjUD9yt+0
         fL2XuPlzxmL9nxUPwuRcFtVGpR4qtI1vTJy9Sw2g=
Message-ID: <6f4b5c87-a7ef-a80b-2230-de4c7d540318@gigawatt.nl>
Date:   Wed, 15 Sep 2021 21:16:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: shell script error management in busybox ash
Content-Language: en-GB
To:     Denys Vlasenko <vda.linux@googlemail.com>
Cc:     "Roberto A. Foglietta" <roberto.foglietta@gmail.com>,
        DASH shell mailing list <dash@vger.kernel.org>
References: <CAJGKYO4i85vGboyucxhJ948xZYxrBjoj5PtAO0eB3TEWW8QpzA@mail.gmail.com>
 <CAK1hOcOVuR4i0FgEOF1AdTA-EbdJyOTLNbViGxT0zwHceZGt-g@mail.gmail.com>
 <4dfc717b-93dc-7e63-3ede-f8a8cd977413@gigawatt.nl>
 <CAK1hOcMNcgRVm7aqYay22dKAkVMOmWJiDrp2MTmYw+k+ez=GoA@mail.gmail.com>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <CAK1hOcMNcgRVm7aqYay22dKAkVMOmWJiDrp2MTmYw+k+ez=GoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 15/09/2021 21:07, Denys Vlasenko wrote:
> On Wed, Sep 15, 2021 at 9:59 PM Harald van Dijk <harald@gigawatt.nl> wrote:
>> On 15/09/2021 20:47, Denys Vlasenko wrote:
>>> On Wed, Sep 15, 2021 at 7:48 PM Roberto A. Foglietta
>>> <roberto.foglietta@gmail.com> wrote:
>>>> Moreover,
>>>> the code that these exceptions trigger (everywhere the setjmp()
>>>> returns true) restores some values and frees some memory but the traps
>>>> need the information before the restore, not the restored values.
>>>
>>> Yes, _this_ is the problem we are having.
>>>
>>> E.g. $FUNCNAME in EXIT trap needs to be current function's name.
>>
>> Important to also mention that although FUNCNAME is not part of POSIX,
>> and there is no spec to compare to, in bash and ksh it does not behave
>> that way
> 
> In my testing, it does.
> 
>> so you're talking about implementing FUNCNAME in a way that is
>> incompatible with existing shells.
> 
> Try this in bash:
> 
>    trap 'echo trap:$FUNCNAME' EXIT
>    f() { exit; }
>    f
> 
> I'm getting:
>    trap:f

For bash, it depends on how the shell is invoked. When bash reads 
commands from stdin, it prints trap:f. When bash is called with that 
exact same script passed as -c, it prints trap:. There may be a more 
specific option that can control this.

$ bash --version
GNU bash, version 5.1.4(1)-release (x86_64-pc-linux-gnu)
Copyright (C) 2020 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later 
<http://gnu.org/licenses/gpl.html>

This is free software; you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

For ksh, as far as I can tell it always prints trap:.

$ ksh --version
   version         sh (AT&T Research) 93u+ 2012-08-01

Cheers,
Harald van Dijk
