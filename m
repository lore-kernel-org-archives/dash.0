Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DA5C433E0
	for <linux-dash@archiver.kernel.org>; Thu, 24 Dec 2020 15:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CF982246B
	for <linux-dash@archiver.kernel.org>; Thu, 24 Dec 2020 15:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgLXPaF (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 24 Dec 2020 10:30:05 -0500
Received: from scw01.stack.nl ([51.15.111.152]:43068 "EHLO mail02.stack.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728230AbgLXPaF (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 24 Dec 2020 10:30:05 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail02.stack.nl (Postfix) with ESMTP id 083A71E009B;
        Thu, 24 Dec 2020 15:29:23 +0000 (UTC)
Received: from mail02.stack.nl ([127.0.0.1])
        by localhost (mail02.stack.nl [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hGAwaATs7oCO; Thu, 24 Dec 2020 15:29:21 +0000 (UTC)
Received: from blade.stack.nl (blade.stack.nl [192.168.121.130])
        by mail02.stack.nl (Postfix) with ESMTP id 215FF1E0060;
        Thu, 24 Dec 2020 15:29:21 +0000 (UTC)
Received: by blade.stack.nl (Postfix, from userid 1677)
        id 19E18239240; Thu, 24 Dec 2020 16:29:21 +0100 (CET)
Date:   Thu, 24 Dec 2020 16:29:20 +0100
From:   Jilles Tjoelker <jilles@stack.nl>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     Steffen Nurpmeso <steffen@sdaoden.eu>,
        DASH shell mailing list <dash@vger.kernel.org>,
        Denys Vlasenko <vda.linux@googlemail.com>
Subject: Re: dash 0.5.11.2, busybox sh 1.32.0, FreeBSD 12.2 sh: spring TTOU
 but should not i think
Message-ID: <20201224152920.GA31281@stack.nl>
References: <20201219172838.1B-WB%steffen@sdaoden.eu>
 <20201219222122.p9UYT%steffen@sdaoden.eu>
 <9bb6fbb5-20e1-eae1-0144-67a4c7e20496@gigawatt.nl>
 <20201221162442.GA26001@stack.nl>
 <bf6e1634-e472-1e9f-056a-ae98be7ec9d1@gigawatt.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf6e1634-e472-1e9f-056a-ae98be7ec9d1@gigawatt.nl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Wed, Dec 23, 2020 at 08:18:24PM +0000, Harald van Dijk wrote:
> On 21/12/2020 16:24, Jilles Tjoelker wrote:
> > Also, simply entering the command
> >      trap "echo TTOU" TTOU
> > in an interactive shell makes it behave strangely. Created jobs
> > immediately stop, "fg" works once but after that the shell tends to get
> > stuck quickly.

> Good catch, there is some work to be done there too.

> > This seems a good approach, but certain writes to the terminal may need
> > the same treatment, for example the error message when fork fails for
> > the second and further elements of a pipeline. This also makes me wonder
> > why SIGTTOU is ignored at all by default.

> True. This is hard to create a reliable test case for, but there is only
> limited code that can get executed while a job-control-enabled shell may not
> be in the foreground process group.

An rlimit (ulimit -u) will cause fork to fail after a number of
processes, but will not work reliably if other code is executing
concurrently with the same UID.

> If fork fails halfway through a pipeline, it may also be a problem that some
> of the commands in the pipeline may still run.

This can be handled much like the case where an element in the pipeline
fails immediately such as because a utility cannot be found. I am not
sure how well this currently works.

> > In mksh, the issue is resolved slightly differently: setting a trap on
> > TTOU pretends to work but the signal disposition remains set to ignored.

> zsh also rejects traps on TTOU, but does so explicitly:

>   zsh: can't trap SIGTTOU in interactive shells

> Amusingly, it prints this in any shell where job control is enabled,
> regardless of whether the shell is interactive.

The rejection makes sense for any shell instance that has job control
and uses tcsetpgrp(), whether interactive or not.

I am not entirely happy with the rejection idea, though, since the check
can be bypassed by temporarily disabling job control:
    set +m; trap 'echo TTOU' TTOU; set -m
and running external utilities then fails with:
    zsh: can't set tty pgrp: interrupt

> > Tradition is for job control shells to be a process group leader, but I
> > don't really know why. Changing this will not fix the issue entirely
> > anyway since the shell must perform tcsetpgrp() from the background when
> > a foreground job has terminated.

> I've been thinking more about this, and I suspect it's a another conflation
> between interactive mode and job control. In an interactive shell that's not
> executing any external program, you want any Ctrl-C to only send SIGINT to
> that shell, not to any other process. In order for that to work, it needs to
> be its own process group.

> This should, in my opinion, *only* happen for interactive shells, not for
> job-control-enabled non-interactive shells. Consider

>   sh -c 'sh -mc "while :; do :; done"; echo bye'

> The behaviour I would want is that Ctrl-C kills the parent shell, so that
> this does not print "bye". Different shells behave differently.

I think the main effect of the -m option is that it places jobs in
separate process groups, which may also be useful in scripts. After
something like:

    set -m
    foo &
    foopid=$!
    set +m

it is possible to  kill -- "-$foopid"  .

Although non-portable kernel features such as cgroups (Linux) or reaper
(FreeBSD) might be more useful for tracking processes like this, the
work to define how to use them in a shell has not been done.

In FreeBSD sh, I extended the possibilities here by allowing job control
without an accessible tty in non-interactive mode. This applies both if
there is no controlling terminal at all and if the shell is in the
background.

In the example 
    sh -c 'sh -mc "while :; do :; done"; echo bye'
the -m flag seems to have no effect since that shell only runs builtins.

Changing it to
    sh -mc 'sh -c "while :; do :; done"; echo bye'
the desired Ctrl+C behaviour can still work because the outer shell
exits when it notices the inner shell has terminated because of SIGINT.

-- 
Jilles Tjoelker
