Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C92C54EBE
	for <linux-dash@archiver.kernel.org>; Tue, 10 Jan 2023 21:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjAJV2z (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 10 Jan 2023 16:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbjAJV2u (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 10 Jan 2023 16:28:50 -0500
Received: from mail02.stack.nl (scw01.stack.nl [51.15.111.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D689B5585F
        for <dash@vger.kernel.org>; Tue, 10 Jan 2023 13:28:47 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail02.stack.nl (Postfix) with ESMTP id DB2801E00B9;
        Tue, 10 Jan 2023 21:28:45 +0000 (UTC)
Received: from mail02.stack.nl ([127.0.0.1])
        by localhost (mail02.stack.nl [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Jm2gaA8umOfy; Tue, 10 Jan 2023 21:28:42 +0000 (UTC)
Received: from blade.stack.nl (blade.stack.nl [192.168.121.130])
        by mail02.stack.nl (Postfix) with ESMTP id 290E81E0096;
        Tue, 10 Jan 2023 21:28:42 +0000 (UTC)
Received: by blade.stack.nl (Postfix, from userid 1677)
        id 124AB238B7F; Tue, 10 Jan 2023 22:28:42 +0100 (CET)
Date:   Tue, 10 Jan 2023 22:28:42 +0100
From:   Jilles Tjoelker <jilles@stack.nl>
To:     Ganael Laplanche <ganael.laplanche@martymac.org>
Cc:     dash@vger.kernel.org
Subject: Re: Monitor mode handling (bug ?)
Message-ID: <20230110212842.GA2103@stack.nl>
References: <7091680.J8PY2HnTC3@home.martymac.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7091680.J8PY2HnTC3@home.martymac.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Mon, Jan 09, 2023 at 04:18:02PM +0100, Ganael Laplanche wrote:
> Digging into a problem with a project of mine [1], I found dash (0.5.12) 
> behaves differently from other POSIX-compliant shells when dealing with 
> monitor mode when running in the background.

> In the following example, dash immediately sends a SIGTTIN signal that stops 
> the process group:

> $ cat test.sh
> set -m
> $ dash test.sh &
> [1]  + suspended (tty input)  dash test.sh

> while other shells do not:

> $ bash test.sh &
> [1]  + done       bash test.sh
> $ sh test.sh & # (/bin/sh from FreeBSD 13.1-RELEASE)
> [1]  + done       sh test.sh
> $ ksh93 test.sh &
> [1]  + done       ksh93 test.sh

> Is that an intended behaviour ?

The loop with SIGTTIN is the right thing for an interactive job control
shell. It ensures that two job control shells do not interfere. The idea
is that the user can later 'fg' from the outer job control shell.

The loop also helps with suspending a job control shell, for example via
the funcs/suspend function from the ash source (containing 'local -',
'set +m' and 'kill -TSTP 0'): when trying to resume the inner shell via
'bg' in the outer shell, it is this loop that makes the inner shell stop
itself.

However, for a non-interactive shell, monitor mode is most useful for
its effect of placing jobs in their own process groups. This does not
necessarily imply any tty manipulation.

To make this possible, feature was added to FreeBSD sh in
https://cgit.freebsd.org/src/commit/?id=cd60e2c67d52e1f957841af19128c7227880743a

This commit allows using job control without a tty in non-interactive
mode. Where an interactive shell disables job control with the message
  can't access tty; job control turned off
or stops itself because it is not in the foreground, a non-interactive
shell instead leaves a limited form of job control enabled that only
sets process group IDs on new processes and does not alter the
terminal's foreground process group ID.

> Also, the following test leads to dash looping indefinitely and eating 100% 
> CPU:

> $ cat test2.sh
> trap '' 21
> set -m
> $ dash test2.sh &

> It remains stuck within the following loop:

> https://git.kernel.org/pub/scm/utils/dash/dash.git/tree/src/jobs.c?
> h=v0.5.12#n208

> Weird... Is that a dash bug or am I missing something?

Manipulating the disposition of TTIN/TTOU/TSTP with job control enabled
might be a question of "if it hurts, don't do that".

-- 
Jilles Tjoelker
