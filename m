From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: Job control bug in revision 3800d4934391b,
Date: Sat, 29 May 2010 01:09:13 +0200
Message-ID: <20100528230913.GA55183@stack.nl>
References: <20100527202157.08a1fa53@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:50268 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751708Ab0E1XJP (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 28 May 2010 19:09:15 -0400
Content-Disposition: inline
In-Reply-To: <20100527202157.08a1fa53@gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Kris Maglione <maglione.k@gmail.com>
Cc: dash@vger.kernel.org

On Thu, May 27, 2010 at 08:21:57PM -0400, Kris Maglione wrote:
> I'm not sure how to describe this bug, but it's affected one of my
> scripts, and those of several of my users. Basically, we've had loops
> dieing when backgrounded programs exit. This is the simplest test case
> I can come up with:

> #!/bin/dash
> {
> 	echo foo
> 	sleep 1
> 	echo foo
> 	echo done>/dev/tty
> } | while read p; do
> 	( echo good & ) &
> done
> echo done

> In versions prior to 3800d4934391b, the output would
> "good\ndone\ndone\ngood" (or some permutation thereof depending on
> system load), but from 3800d4934391b on, it's "good\ndone".

> The offending revision:

> [JOBS] Fix dowait signal race

I can reproduce this here. It happens because the child process exit's
SIGCHLD causes an EINTR on the read, which then fails.

While the above testcase works with FreeBSD sh, a similar script with a
trap on CHLD fails in both (and likely also in older dash):

#!/bin/dash
{
	echo foo
	sleep 1
	echo foo
	echo done>/dev/tty
} | { trap : CHLD; while read p; do
	( echo good & ) &
done }
echo done

Most other shells do not seem to abort a read builtin for a trap. bash
and ksh93 execute the trap right away and then continue the read, while
mksh postpones it until the read is done. POSIX seems vague about it,
but a look at existing scripts suggests that traps should not abort a
read. Executing the trap right away is useful in case it does something
such as exiting, and should be safe given that traps are already invoked
from deeper levels of recursion of the interpreter. If the trap executes
a break, continue or return command outside its boundaries this should
abort the read.

-- 
Jilles Tjoelker
