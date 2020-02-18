From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: Re: Bizarre interaction bug involving bash w/ lastpipe + Almquist 'wait'
Date: Tue, 18 Feb 2020 17:46:23 +0100
Message-ID: <CAK1hOcO_S_T=5SWJ0jpZWxDYwdUFqJisw_nC+JysnQvZ6XUuKw@mail.gmail.com>
References: <10e3756b-5e8f-ba00-df0d-b36c93fa2281@inlv.org>
 <5461.1581043287@jinx.noi.kre.to> <2b436500-671b-b143-a4bb-2230f157e1b7@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33076 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbgBRQqg (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 18 Feb 2020 11:46:36 -0500
Received: by mail-ed1-f67.google.com with SMTP id r21so25597322edq.0
        for <dash@vger.kernel.org>; Tue, 18 Feb 2020 08:46:35 -0800 (PST)
In-Reply-To: <2b436500-671b-b143-a4bb-2230f157e1b7@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: Robert Elz <kre@munnari.oz.au>, Martijn Dekker <martijn@inlv.org>, busybox <busybox@busybox.net>, DASH shell mailing list <dash@vger.kernel.org>, Jilles Tjoelker <jilles@stack.nl>, Bug reports for the GNU Bourne Again SHell <bug-bash@gnu.org>

On Sat, Feb 8, 2020 at 7:41 PM Harald van Dijk <harald@gigawatt.nl> wrote:
> I changed gwsh to call sigclearmask() on shell startup, but plan to
> check whether this loop is really necessary at some later time. It was
> added to dash to fix a race condition, where that race condition was
> apparently introduced by a fix for another race condition.

sigsuspend() is needed to make "wait" builtin interruptible by signals.

Attempts to use EINTR error return of waitpid() a-la:

               if (got_sigs) { handle signals }
               got_sigs = 0;
               pid = waitpid(...);  /* without WNOHANG */
               if (pid < 0 && errno == EINTR) { handle signals }

are racy, since signals can be delivered not only while waitpid() syscall
is in kernel, but also when we are only about to enter the kernel
- and in this case, the shell's sighandler will set the flag variable,
but then we enter the kernel and sleep.

Masking signals doesn't help, since you need to unmask them just before
waitpid() if you want to get EINTR on a signal, hence there is still
a window for the race.

> If NetBSD sh
> manages to avoid this pattern, and assuming NetBSD sh is not still
> susceptible to one of those race conditions

Please let us know what you discovered.
