Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5E5C433DB
	for <linux-dash@archiver.kernel.org>; Wed,  6 Jan 2021 21:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7C5323333
	for <linux-dash@archiver.kernel.org>; Wed,  6 Jan 2021 21:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbhAFVRq (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 6 Jan 2021 16:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbhAFVRq (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 6 Jan 2021 16:17:46 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTP id B6436C061799
        for <dash@vger.kernel.org>; Wed,  6 Jan 2021 13:17:05 -0800 (PST)
Received: from [192.168.1.5] (92.40.195.43.threembb.co.uk [92.40.195.43])
        by mail.gigawatt.nl (Postfix) with UTF8SMTPSA id 69C54744;
        Wed,  6 Jan 2021 22:17:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 69C54744
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1609967823;
        bh=zf266aYZdzDuDinvn+PegYiVz9Fp7y8VhthKAPOJgVo=; l=1739;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AeWFrynCxryBLVjwmJIeB5CfqhDV7ZLd8/x7s9N/FqECJ1XIGQnrRBv8bGQcn21sE
         rpmIx3waLdhlGQgEIVp7ajRcNkbmmF6tPzjriTB0k0HMv2nNEIjWgPq3w2LNJAsbvH
         +RhiRKWgZqcCMnCgef+hV5aSM+ypzM7ogschksbg=
Subject: Re: [PATCH] jobs: Block signals during tcsetpgrp
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     steffen@sdaoden.eu, dash@vger.kernel.org, vda.linux@googlemail.com,
        jilles@stack.nl
References: <20210106044512.GA28191@gondor.apana.org.au>
From:   Harald van Dijk <harald@gigawatt.nl>
Message-ID: <cb36ab63-d039-c4ee-c4f3-28bafea56b3a@gigawatt.nl>
Date:   Wed, 6 Jan 2021 21:16:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <20210106044512.GA28191@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 06/01/2021 04:45, Herbert Xu wrote:
> This patch implements the blocking of SIGTTOU (and everything else)
> while we call tcsetpgrp.
> 
> Reported-by: Steffen Nurpmeso <steffen@sdaoden.eu>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> diff --git a/src/jobs.c b/src/jobs.c
> index 516786f..809f37c 100644
> --- a/src/jobs.c
> +++ b/src/jobs.c
> @@ -1512,7 +1512,13 @@ showpipe(struct job *jp, struct output *out)
>   STATIC void
>   xtcsetpgrp(int fd, pid_t pgrp)
>   {
> -	if (tcsetpgrp(fd, pgrp))
> +	int err;
> +
> +	sigblockall(NULL);
> +	err = tcsetpgrp(fd, pgrp);
> +	sigclearmask();
> +
> +	if (err)
>   		sh_error("Cannot set tty process group (%s)", strerror(errno));
>   }
>   #endif

While this is a step in the right direction, Jilles has already replied 
with an explanation of why this is not enough: if the terminal is in 
TOSTOP mode, it's not just tcsetpgrp() that needs to be handled, it's 
any write as well that may occur while the shell is not in the 
foreground process group. While it may be working according to design 
for messages written when the shell is not supposed to be in the 
foreground process group, it is another story when the shell is both 
responsible for taking itself out of the foreground process group and 
for writing a message. This is made worse by the fact that there is no 
synchronisation with child processes on errors, so even forcibly 
restoring the foreground process group may not be enough: unfortunate 
scheduling may result in a child process immediately setting the 
foreground process group to the child process after the parent process 
attempted to restore it to itself. I have not yet seen a good solution 
for this.

Cheers,
Harald van Dijk
