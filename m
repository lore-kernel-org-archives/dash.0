Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1EDC46467
	for <linux-dash@archiver.kernel.org>; Wed,  4 Jan 2023 11:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbjADLZr (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 4 Jan 2023 06:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjADLZq (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 4 Jan 2023 06:25:46 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 645FD1ADBB
        for <dash@vger.kernel.org>; Wed,  4 Jan 2023 03:25:45 -0800 (PST)
Received: from [IPV6:2a02:8010:68a1:0:f140:f5fb:7038:8e8a] (unknown [IPv6:2a02:8010:68a1:0:f140:f5fb:7038:8e8a])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id E303E477;
        Wed,  4 Jan 2023 11:25:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl E303E477
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1672831544;
        bh=tubGJbYnRpmg7dfw2PXjewETma8y5cZHkXihMX3Rf2g=; l=2255;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SSUGX2t4ebaA7dcM2uOINAuMdjDuai/iiA+fm/mnrD6jejwcFj4UKYkCfA2KTROFl
         /vOicJsg41Mz2oJVJNBwrAnfQlylMOnVdBnHSnEJTr1ZLPYnvWXhk+54Hg5DWjU6aY
         QtVFGwjjv9iWKII0rkOtME3cv6hLxvpGdvucZfg4=
Message-ID: <8ddcc8a3-9588-435a-9d5f-1edbcd121012@gigawatt.nl>
Date:   Wed, 4 Jan 2023 11:25:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101
 Thunderbird/109.0
Subject: Re: [PATCH v2 2/3] parser: synerror: explicitly consume the entire
 invalid line
Content-Language: en-US
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
        dash@vger.kernel.org
References: <Y7OKk/jM53zRE4xg@gondor.apana.org.au>
 <bb422d70-0ba5-e29b-3ec8-8fc1c4630233@gigawatt.nl>
 <Y7VMJGPXXziUrBio@gondor.apana.org.au>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <Y7VMJGPXXziUrBio@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 04/01/2023 09:51, Herbert Xu wrote:
> On Tue, Jan 03, 2023 at 11:47:05AM +0000, Harald van Dijk wrote:
>>
>> In order for this to be a problem, we need something where the newline
>> itself triggers a syntax error. For synexpect(TDO), is that possible? In all
>> cases where synexpect(TDO) is called, a newline is permitted, and it is the
>> token after the newline that the error will be reported on, no? In that
>> situation, reading the rest of the line is correct.
> 
> You're right, it isn't possible with TDO.
> 
>> I'm not going to rule out that there is a potential for problems, but if
>> there is, it's not the situation you say.
> 
> However, the synexpect in parsefname would seem to qualify:
> 
> cat <<- <newline>

You're right, that does show the problem, thanks.

Since the only case where special care is needed is when the problematic 
token was newline, it can be handled as simply as

   if (lasttoken != TNL)
     skipline();

I will do some testing to see if I am overlooking something, and follow 
up if I am.

>> Handling it in the input layer after the error has already been reported
>> means we get inconsistent error handling when running with dash -isv. The
>> error may, depending on whether the rest of the line was in the buffer
>> already, be reported either in the middle of the input line, or on the next
>> line.
>>
>> Just try changing sh -i to sh -iv in the reproducer and seeing what what
>> happens with your patch.
> 
> I don't think this is such a big deal.  You get the same effect
> if you simply do input line buffering but only up to a certain
> length.  I tried one million instead of ten thousand with the
> reproducer and ksh93 prints out the error after only 65536
> characters.
> 
> In any case, we could actually fix this by buffering stderr and
> then making sh -v bypass the buffer and write directly to 2.
> 
> I tried it and it actually seems to work.  But all the extra flush
> calls bloat up the code a bit so it needs a bit more work before
> I'm happy to run with it.

Interesting approach. Error messages are known to always fit in the 
buffer, so you can probably be sure it won't be forced to be emitted 
early. It could work.

Cheers,
Harald van Dijk
