Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85106C433DB
	for <linux-dash@archiver.kernel.org>; Wed,  6 Jan 2021 22:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52D302313B
	for <linux-dash@archiver.kernel.org>; Wed,  6 Jan 2021 22:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbhAFWlr (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 6 Jan 2021 17:41:47 -0500
Received: from scw01.stack.nl ([51.15.111.152]:40664 "EHLO mail02.stack.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726993AbhAFWlr (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 6 Jan 2021 17:41:47 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail02.stack.nl (Postfix) with ESMTP id 53C9F1E01A4;
        Wed,  6 Jan 2021 22:41:05 +0000 (UTC)
Received: from mail02.stack.nl ([127.0.0.1])
        by localhost (mail02.stack.nl [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WsrLJSPbXfFA; Wed,  6 Jan 2021 22:41:03 +0000 (UTC)
Received: from blade.stack.nl (blade.stack.nl [192.168.121.130])
        by mail02.stack.nl (Postfix) with ESMTP id 184181E019C;
        Wed,  6 Jan 2021 22:41:03 +0000 (UTC)
Received: by blade.stack.nl (Postfix, from userid 1677)
        id EC29923C9A2; Wed,  6 Jan 2021 23:41:02 +0100 (CET)
Date:   Wed, 6 Jan 2021 23:41:02 +0100
From:   Jilles Tjoelker <jilles@stack.nl>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>, steffen@sdaoden.eu,
        dash@vger.kernel.org, vda.linux@googlemail.com
Subject: Re: [PATCH] jobs: Block signals during tcsetpgrp
Message-ID: <20210106224102.GB23865@stack.nl>
References: <20210106044512.GA28191@gondor.apana.org.au>
 <cb36ab63-d039-c4ee-c4f3-28bafea56b3a@gigawatt.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb36ab63-d039-c4ee-c4f3-28bafea56b3a@gigawatt.nl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Wed, Jan 06, 2021 at 09:16:58PM +0000, Harald van Dijk wrote:
> On 06/01/2021 04:45, Herbert Xu wrote:
> > This patch implements the blocking of SIGTTOU (and everything else)
> > while we call tcsetpgrp.

> > Reported-by: Steffen Nurpmeso <steffen@sdaoden.eu>
> > Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

> > diff --git a/src/jobs.c b/src/jobs.c
> > index 516786f..809f37c 100644
> > --- a/src/jobs.c
> > +++ b/src/jobs.c
> > @@ -1512,7 +1512,13 @@ showpipe(struct job *jp, struct output *out)
> >   STATIC void
> >   xtcsetpgrp(int fd, pid_t pgrp)
> >   {
> > -	if (tcsetpgrp(fd, pgrp))
> > +	int err;
> > +
> > +	sigblockall(NULL);
> > +	err = tcsetpgrp(fd, pgrp);
> > +	sigclearmask();
> > +
> > +	if (err)
> >   		sh_error("Cannot set tty process group (%s)", strerror(errno));
> >   }
> >   #endif

> While this is a step in the right direction, Jilles has already replied with
> an explanation of why this is not enough: if the terminal is in TOSTOP mode,
> it's not just tcsetpgrp() that needs to be handled, it's any write as well
> that may occur while the shell is not in the foreground process group. While
> it may be working according to design for messages written when the shell is
> not supposed to be in the foreground process group, it is another story when
> the shell is both responsible for taking itself out of the foreground
> process group and for writing a message. This is made worse by the fact that
> there is no synchronisation with child processes on errors, so even forcibly
> restoring the foreground process group may not be enough: unfortunate
> scheduling may result in a child process immediately setting the foreground
> process group to the child process after the parent process attempted to
> restore it to itself. I have not yet seen a good solution for this.

Comparing this error situation to the normal case, I think the right
solution is to close any stray pipe ends we have, wait for the remaining
child processes and only then report the error (throwing an exception as
normal). The child processes will probably terminate soon because of a
broken pipe, but even if they stop, they will not change the tty
foreground process group any more. The code in jobs.c will then reset
it.

The same error handling applies to the situation where pipe() fails.
This is a bit easier to test reliably, using ulimit -n.

Adding synchronization with the child processes slows down the normal
case for a rare error case, and the synchronization objects such as
pipe, eventfd, SysV semaphore or MAP_SHARED mapping might cause
unexpected issues in strange use cases.

A related bug: if fork fails for a command substitution, the pipe
created for reading the command output remains open (two descriptors).
This one is also in dash as well as FreeBSD sh. Throwing exceptions from
forkshell() may not be the best idea.

-- 
Jilles Tjoelker
