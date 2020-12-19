Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4971CC4361B
	for <linux-dash@archiver.kernel.org>; Sat, 19 Dec 2020 23:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16C2C20E65
	for <linux-dash@archiver.kernel.org>; Sat, 19 Dec 2020 23:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgLSXxR (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 19 Dec 2020 18:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgLSXxR (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 19 Dec 2020 18:53:17 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35772C0613CF
        for <dash@vger.kernel.org>; Sat, 19 Dec 2020 15:52:36 -0800 (PST)
Received: from [10.153.18.14] (92.40.195.41.threembb.co.uk [92.40.195.41])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id C89E1477;
        Sun, 20 Dec 2020 00:52:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl C89E1477
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1608421954;
        bh=jtqr1kX1EKZS9whttcr7n/cq/YTWUHkMEIsRfHOPsFc=; l=2260;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=OtdqDzKHPyK5OHa7wDre9i3hnPcd7j92PTl+4+0gm6HLaBei0pYWgGY/VcSAKrRkO
         fSeOyZ89VxhZmKtQhBEurEEoApPvEoTNa0uvLDVvqjUfEco3MXvomhl1je3e3x3g1K
         xa90Zqpn7jusrwFzs3/MuEtWI1kxS5mFLdwosFJc=
Subject: Re: dash 0.5.11.2, busybox sh 1.32.0, FreeBSD 12.2 sh: spring TTOU
 but should not i think
To:     Steffen Nurpmeso <steffen@sdaoden.eu>,
        DASH shell mailing list <dash@vger.kernel.org>,
        Denys Vlasenko <vda.linux@googlemail.com>,
        Jilles Tjoelker <jilles@stack.nl>
References: <20201219172838.1B-WB%steffen@sdaoden.eu>
 <20201219222122.p9UYT%steffen@sdaoden.eu>
From:   Harald van Dijk <harald@gigawatt.nl>
Message-ID: <9bb6fbb5-20e1-eae1-0144-67a4c7e20496@gigawatt.nl>
Date:   Sat, 19 Dec 2020 23:52:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201219222122.p9UYT%steffen@sdaoden.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 19/12/2020 22:21, Steffen Nurpmeso wrote:
> Steffen Nurpmeso wrote in
>   <20201219172838.1B-WB%steffen@sdaoden.eu>:
>   |Long story short, after falsely accusing BSD make of not working
> 
> After dinner i shortened it a bit more, and attach it again, ok?
> It is terrible, but now less redundant than before.
> Sorry for being so terse, that problem crosses my head for about
> a week, and i was totally mislead and if you bang your head
> against the wall so many hours bugs or misbehaviours in a handful
> of other programs is not the expected outcome.

I think a minimal test case is simply

all:
         $(SHELL) -c 'trap "echo TTOU" TTOU; set -m; echo all good'

unless I accidentally oversimplified.

The SIGTTOU is caused by setjobctl's xtcsetpgrp(fd, pgrp) call to make 
its newly started process group the foreground process group when job 
control is enabled, where xtcsetpgrp is a wrapper for tcsetpgrp. (That's 
in dash, the other variants may have some small differences.) tcsetpgrp 
has this little bit in its specification:

        Attempts to use tcsetpgrp() from a process which is a member of
        a background process group on a fildes associated with its con‐
        trolling  terminal  shall  cause the process group to be sent a
        SIGTTOU signal. If the calling thread is blocking SIGTTOU  sig‐
        nals  or  the  process is ignoring SIGTTOU signals, the process
        shall be allowed to perform the operation,  and  no  signal  is
        sent.

Ordinarily, when job control is enabled, SIGTTOU is ignored. However, 
when a trap action is specified for SIGTTOU, the signal is not ignored, 
and there is no blocking in place either, so the tcsetpgrp() call is not 
allowed.

The lowest impact change to make here, the one that otherwise preserves 
the existing shell behaviour, is to block signals before calling 
tcsetpgrp and unblocking them afterwards. This ensures SIGTTOU does not 
get raised here, but also ensures that if SIGTTOU is sent to the shell 
for another reason, there is no window where it gets silently ignored.

Another way to fix this is by not trying to make the shell start a new 
process group, or at least not make it the foreground process group. 
Most other shells appear to not try to do this.

Cheers,
Harald van Dijk
