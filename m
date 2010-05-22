From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: wait regression in 3800d4
Date: Sat, 22 May 2010 23:28:52 +0200
Message-ID: <20100522212852.GA36029@stack.nl>
References: <20100519190856.19606.qmail@ea7dd6dfa89c0a.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:61829 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758278Ab0EVV2z (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 22 May 2010 17:28:55 -0400
Received: from turtle.stack.nl (turtle.stack.nl [IPv6:2001:610:1108:5010::132])
	by mx1.stack.nl (Postfix) with ESMTP id 056991DD64F
	for <dash@vger.kernel.org>; Sat, 22 May 2010 23:28:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100519190856.19606.qmail@ea7dd6dfa89c0a.315fe32.mid.smarden.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

On Wed, May 19, 2010 at 07:08:56PM +0000, Gerrit Pape wrote:
> Hi, since commit 3800d49 the wait builtin shows some unexpected
> behavior, see http://bugs.debian.org/581425

> To reproduce:

>  $ dash -c '
>  for i in 1 2 3; do
>    (sleep $i; echo $i) &
>  done
>  wait
>  echo all done
>  sleep 2'
>  1
>  all done
>  2
>  3
>  $ 

> Expected output:
>  1
>  2
>  3
>  all done

> I don't completely understand commitdiff 3800d49, and didn't find time
> to fix the lack of understanding yet, but this patch seems to fix this
> specific issue.

> diff --git a/src/jobs.c b/src/jobs.c
> index a4fada0..57c0854 100644
> --- a/src/jobs.c
> +++ b/src/jobs.c
> @@ -1136,8 +1136,6 @@ waitproc(int block, int *status)
>                 if (err || !block)
>                         break;
>  
> -               block = 0;
> -
>                 sigfillset(&mask);
>                 sigprocmask(SIG_SETMASK, &mask, &oldmask);
>  

This patch is not correct as it makes dash busy-wait for the second and
further processes to terminate. Also, I think aborting the wait builtin
with 128+SIGCHLD is the correct behaviour if a trap on CHLD is active
(like any other trap). This requires a more sophisticated handling of
pendingsigs so that an untrapped SIGCHLD does not overwrite a trapped
signal.

I wonder why this hasn't been noticed before, as this is the most common
use of the wait builtin. I can even reproduce the regression with the
test script in 3800d49's commit message: sometimes I see a line *** 148
meaning that the wait builtin was aborted by SIGCHLD (even though no
CHLD trap has been set); however only on an SMP system. (This is on
FreeBSD; I hacked mksignames.c to compile and work, although realtime
signals are missing.)

-- 
Jilles Tjoelker
