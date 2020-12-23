Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C875DC433E0
	for <linux-dash@archiver.kernel.org>; Wed, 23 Dec 2020 20:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F7432151B
	for <linux-dash@archiver.kernel.org>; Wed, 23 Dec 2020 20:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgLWUTI (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 23 Dec 2020 15:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbgLWUTI (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 23 Dec 2020 15:19:08 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9EE3C061794
        for <dash@vger.kernel.org>; Wed, 23 Dec 2020 12:18:27 -0800 (PST)
Received: from [10.47.192.29] (92.40.195.40.threembb.co.uk [92.40.195.40])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id 7F1A34AE;
        Wed, 23 Dec 2020 21:18:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 7F1A34AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1608754705;
        bh=gPy9XylEa1NPt1ZudHFQyzbwC/Fxe03kNBGjKM9jDCU=; l=2509;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gcE291wBMjU0tOojzBN4t/natzh2UdvsiXnoUZR8XE8is6dzHvgD09TZ/D/KpMDzL
         t+Y9lSIQniX8FiBxtsaq0/f0BiXSr2Q6oYT4wQ08bH1zFn6u1dnG5I7UENRUkUp9tu
         DC0G9hTu9+rplAC4K7eWbxwx8GQ4WrL06EOfJKk8=
Subject: Re: dash 0.5.11.2, busybox sh 1.32.0, FreeBSD 12.2 sh: spring TTOU
 but should not i think
To:     Jilles Tjoelker <jilles@stack.nl>
Cc:     Steffen Nurpmeso <steffen@sdaoden.eu>,
        DASH shell mailing list <dash@vger.kernel.org>,
        Denys Vlasenko <vda.linux@googlemail.com>
References: <20201219172838.1B-WB%steffen@sdaoden.eu>
 <20201219222122.p9UYT%steffen@sdaoden.eu>
 <9bb6fbb5-20e1-eae1-0144-67a4c7e20496@gigawatt.nl>
 <20201221162442.GA26001@stack.nl>
From:   Harald van Dijk <harald@gigawatt.nl>
Message-ID: <bf6e1634-e472-1e9f-056a-ae98be7ec9d1@gigawatt.nl>
Date:   Wed, 23 Dec 2020 20:18:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201221162442.GA26001@stack.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 21/12/2020 16:24, Jilles Tjoelker wrote:
> Also, simply entering the command
>      trap "echo TTOU" TTOU
> in an interactive shell makes it behave strangely. Created jobs
> immediately stop, "fg" works once but after that the shell tends to get
> stuck quickly.

Good catch, there is some work to be done there too.

> This seems a good approach, but certain writes to the terminal may need
> the same treatment, for example the error message when fork fails for
> the second and further elements of a pipeline. This also makes me wonder
> why SIGTTOU is ignored at all by default.

True. This is hard to create a reliable test case for, but there is only 
limited code that can get executed while a job-control-enabled shell may 
not be in the foreground process group.

If fork fails halfway through a pipeline, it may also be a problem that 
some of the commands in the pipeline may still run.

> In mksh, the issue is resolved slightly differently: setting a trap on
> TTOU pretends to work but the signal disposition remains set to ignored.

zsh also rejects traps on TTOU, but does so explicitly:

   zsh: can't trap SIGTTOU in interactive shells

Amusingly, it prints this in any shell where job control is enabled, 
regardless of whether the shell is interactive.

> Tradition is for job control shells to be a process group leader, but I
> don't really know why. Changing this will not fix the issue entirely
> anyway since the shell must perform tcsetpgrp() from the background when
> a foreground job has terminated.

I've been thinking more about this, and I suspect it's a another 
conflation between interactive mode and job control. In an interactive 
shell that's not executing any external program, you want any Ctrl-C to 
only send SIGINT to that shell, not to any other process. In order for 
that to work, it needs to be its own process group.

This should, in my opinion, *only* happen for interactive shells, not 
for job-control-enabled non-interactive shells. Consider

   sh -c 'sh -mc "while :; do :; done"; echo bye'

The behaviour I would want is that Ctrl-C kills the parent shell, so 
that this does not print "bye". Different shells behave differently.

> What is definitely required, though, is that the shell not read input or
> alter terminal settings if it is started in the background (possibly
> unless the script explicitly ignored SIGTTOU). This is what the loop
> with tcgetpgrp() does.

Definitely.

Cheers,
Harald van Dijk
