Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54876C433E0
	for <linux-dash@archiver.kernel.org>; Mon, 21 Dec 2020 16:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20C9922C9C
	for <linux-dash@archiver.kernel.org>; Mon, 21 Dec 2020 16:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgLUQeu (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 21 Dec 2020 11:34:50 -0500
Received: from scw01.stack.nl ([51.15.111.152]:42344 "EHLO mail02.stack.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgLUQeu (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 21 Dec 2020 11:34:50 -0500
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Dec 2020 11:34:49 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail02.stack.nl (Postfix) with ESMTP id A30B41E008B;
        Mon, 21 Dec 2020 16:24:44 +0000 (UTC)
Received: from mail02.stack.nl ([127.0.0.1])
        by localhost (mail02.stack.nl [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pOOUHWRVXJjj; Mon, 21 Dec 2020 16:24:42 +0000 (UTC)
Received: from blade.stack.nl (blade.stack.nl [192.168.121.130])
        by mail02.stack.nl (Postfix) with ESMTP id A7F801E0060;
        Mon, 21 Dec 2020 16:24:42 +0000 (UTC)
Received: by blade.stack.nl (Postfix, from userid 1677)
        id 89EB2239240; Mon, 21 Dec 2020 17:24:42 +0100 (CET)
Date:   Mon, 21 Dec 2020 17:24:42 +0100
From:   Jilles Tjoelker <jilles@stack.nl>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     Steffen Nurpmeso <steffen@sdaoden.eu>,
        DASH shell mailing list <dash@vger.kernel.org>,
        Denys Vlasenko <vda.linux@googlemail.com>
Subject: Re: dash 0.5.11.2, busybox sh 1.32.0, FreeBSD 12.2 sh: spring TTOU
 but should not i think
Message-ID: <20201221162442.GA26001@stack.nl>
References: <20201219172838.1B-WB%steffen@sdaoden.eu>
 <20201219222122.p9UYT%steffen@sdaoden.eu>
 <9bb6fbb5-20e1-eae1-0144-67a4c7e20496@gigawatt.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9bb6fbb5-20e1-eae1-0144-67a4c7e20496@gigawatt.nl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Sat, Dec 19, 2020 at 11:52:31PM +0000, Harald van Dijk wrote:
> On 19/12/2020 22:21, Steffen Nurpmeso wrote:
> > Steffen Nurpmeso wrote in
> >   <20201219172838.1B-WB%steffen@sdaoden.eu>:
> >   |Long story short, after falsely accusing BSD make of not working

> > After dinner i shortened it a bit more, and attach it again, ok?
> > It is terrible, but now less redundant than before.
> > Sorry for being so terse, that problem crosses my head for about
> > a week, and i was totally mislead and if you bang your head
> > against the wall so many hours bugs or misbehaviours in a handful
> > of other programs is not the expected outcome.

> I think a minimal test case is simply

> all:
>         $(SHELL) -c 'trap "echo TTOU" TTOU; set -m; echo all good'

> unless I accidentally oversimplified.

Yes, and it can be simplified a bit more to remove make from the
picture:
    (SHELL -c 'trap "echo TTOU" TTOU; set -m; echo all good'; :)

The idea is to start the shell without being a process group leader, set
a trap for SIGTTOU and enable job control.

Also, simply entering the command
    trap "echo TTOU" TTOU
in an interactive shell makes it behave strangely. Created jobs
immediately stop, "fg" works once but after that the shell tends to get
stuck quickly.

> The SIGTTOU is caused by setjobctl's xtcsetpgrp(fd, pgrp) call to make its
> newly started process group the foreground process group when job control is
> enabled, where xtcsetpgrp is a wrapper for tcsetpgrp. (That's in dash, the
> other variants may have some small differences.) tcsetpgrp has this little
> bit in its specification:

>        Attempts to use tcsetpgrp() from a process which is a member of
>        a background process group on a fildes associated with its con‐
>        trolling  terminal  shall  cause the process group to be sent a
>        SIGTTOU signal. If the calling thread is blocking SIGTTOU  sig‐
>        nals  or  the  process is ignoring SIGTTOU signals, the process
>        shall be allowed to perform the operation,  and  no  signal  is
>        sent.

> Ordinarily, when job control is enabled, SIGTTOU is ignored. However, when a
> trap action is specified for SIGTTOU, the signal is not ignored, and there
> is no blocking in place either, so the tcsetpgrp() call is not allowed.

Right.

> The lowest impact change to make here, the one that otherwise preserves the
> existing shell behaviour, is to block signals before calling tcsetpgrp and
> unblocking them afterwards. This ensures SIGTTOU does not get raised here,
> but also ensures that if SIGTTOU is sent to the shell for another reason,
> there is no window where it gets silently ignored.

This seems a good approach, but certain writes to the terminal may need
the same treatment, for example the error message when fork fails for
the second and further elements of a pipeline. This also makes me wonder
why SIGTTOU is ignored at all by default.

In mksh, the issue is resolved slightly differently: setting a trap on
TTOU pretends to work but the signal disposition remains set to ignored.

> Another way to fix this is by not trying to make the shell start a new
> process group, or at least not make it the foreground process group. Most
> other shells appear to not try to do this.

Tradition is for job control shells to be a process group leader, but I
don't really know why. Changing this will not fix the issue entirely
anyway since the shell must perform tcsetpgrp() from the background when
a foreground job has terminated.

What is definitely required, though, is that the shell not read input or
alter terminal settings if it is started in the background (possibly
unless the script explicitly ignored SIGTTOU). This is what the loop
with tcgetpgrp() does.

-- 
Jilles Tjoelker
