Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83421C4332F
	for <linux-dash@archiver.kernel.org>; Tue, 13 Dec 2022 22:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236545AbiLMWht (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 13 Dec 2022 17:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbiLMWhr (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 13 Dec 2022 17:37:47 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08DA721269
        for <dash@vger.kernel.org>; Tue, 13 Dec 2022 14:37:44 -0800 (PST)
Received: from [IPV6:2a02:8010:68a1:0:26d4:234:5292:8b5e] (unknown [IPv6:2a02:8010:68a1:0:26d4:234:5292:8b5e])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id 094A8177;
        Tue, 13 Dec 2022 22:37:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 094A8177
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1670971063;
        bh=Oj7jbRUTSsoeLSIyVHpNe2CtCqWphQdCyKquamr7iOc=; l=2256;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=o5WW9+Oi+m0jhDgUIqFiXPVJh9bI91X60c4AD5RUv8cOPEE0OaltQW8JxBuzlX+mg
         cwWPiVWpeYPp4Q65bnk9MOw49ZK+B8YSgDYInig9LL4GNSzuS9YZZy4uQYvkVBAxuy
         Q3wGYvpUZFw1U0T4L9wovoo2RjLsrfoazvngG9Oo=
Message-ID: <877c8c0d-c7a3-6c56-0564-55080837f0a1@gigawatt.nl>
Date:   Tue, 13 Dec 2022 22:37:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101
 Thunderbird/108.0
Subject: Re: [PATCH] input: preadfd: read standard input byte-wise
To:     =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
        dash@vger.kernel.org
References: <20221213221732.6mvv22u7ktdozrbx@tarta.nabijaczleweli.xyz>
Content-Language: en-US
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <20221213221732.6mvv22u7ktdozrbx@tarta.nabijaczleweli.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 13/12/2022 22:17, наб wrote:
> Reading the standard input byte-by-byte is the obvious solution to this
> issue, Just Works, and is how all other shells do it (we could,
> theoretically, read regular files block-wise, then seek within them after
> parsing, but the complexity out-weighs the rarity of running
> sh < program; we could also do whole-line reads on teletypes in
> icanon mode, but, again, the gain here is miniscule for an interactive
> session, and the teletype mode can change at any time, so...).
> Naturally, we keep reading block-wise for non-standard-input.

There are a few things to consider here:

- Not all shells do it this way. bash does do the block-wise read,
   followed by a seek, when stdin is seekable. While I agree that it is
   not necessary and not worth it, you specifically say that other shells
   do not do this. That's simply not true.
- This will have no effect when running 'dash /dev/stdin'. I personally
   consider this acceptable, this doesn't work in other shells either.
- This patch breaks internal assumptions in dash that the buffer will
   contain a full line, affecting error recovery. See below.

> With this patch, we observe the correct
>    uid=1000(nabijaczleweli) gid=100(users) groups=100(users)
>    good!
> and
>    + id
>    uid=1000(nabijaczleweli) gid=100(users) groups=100(users)
>    + read Q
>    + echo Qgood!
>    Qgood!
> 
> Fixes: https://bugs.debian.org/862907
> ---
>   src/input.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/input.c b/src/input.c
> index ec075f5..6b6113e 100644
> --- a/src/input.c
> +++ b/src/input.c
> @@ -195,7 +195,7 @@ retry:
>   
>   	} else
>   #endif
> -		nr = read(parsefile->fd, buf, IBUFSIZ - 1);
> +		nr = read(parsefile->fd, buf, parsefile->fd == 0 ? 1 : IBUFSIZ - 1);
>   
>   
>   	if (nr < 0) {

With dash 0.5.12:

   $ | echo bug
   src/dash: 1: Syntax error: "|" unexpected
   $

With dash 0.5.12 + your patch:

   $ | echo bug
   src/dash: 1: Syntax error: "|" unexpected
   $ bug
   $

I had implemented the same change in my fork, see 
<https://github.com/hvdijk/gwsh/commit/d279523041c1c380d64b6dec7760feba20bbf6b5> 
for the additional changes I needed to get everything working.

Cheers,
Harald van Dijk
