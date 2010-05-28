From: Kris Maglione <maglione.k@gmail.com>
Subject: Job control bug in revision 3800d4934391b,
Date: Thu, 27 May 2010 20:21:57 -0400
Message-ID: <20100527202157.08a1fa53@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-pz0-f176.google.com ([209.85.222.176]:52859 "EHLO
	mail-pz0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753662Ab0E1AWH (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 27 May 2010 20:22:07 -0400
Received: by pzk6 with SMTP id 6so394150pzk.1
        for <dash@vger.kernel.org>; Thu, 27 May 2010 17:22:06 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org


I'm not sure how to describe this bug, but it's affected one of my
scripts, and those of several of my users. Basically, we've had loops
dieing when backgrounded programs exit. This is the simplest test case
I can come up with:

#!/bin/dash
{
	echo foo
	sleep 1
	echo foo
	echo done>/dev/tty
} | while read p; do
	( echo good & ) &
done
echo done


In versions prior to 3800d4934391b, the output would
"good\ndone\ndone\ngood" (or some permutation thereof depending on
system load), but from 3800d4934391b on, it's "good\ndone".

The offending revision:

[JOBS] Fix dowait signal race
author	Herbert Xu <herbert@gondor.apana.org.au>	
	Sun, 22 Feb 2009 10:10:01 +0000 (18:10 +0800)
committer	Herbert Xu <herbert@gondor.apana.org.au>	
	Sun, 22 Feb 2009 10:10:01 +0000 (18:10 +0800)
commit	3800d4934391b144fd261a7957aea72ced7d47ea
tree	40c003ab3063ceab7f3615a623a09d3c610332a0
parent	6045fe25078345074f027312d106d3fc19df56e5
[JOBS] Fix dowait signal race

This test program by Alexey Gladkov can cause dash to enter an
infinite loop in waitcmd.

#!/bin/dash
trap "echo TRAP" USR1
stub() {
echo ">>> STUB $1" >&2
sleep $1
echo "<<< STUB $1" >&2
kill -USR1 $$
}
stub 3 &
stub 2 &
until { echo "###"; wait; } do
echo "*** $?"
done

The problem is that if we get a signal after the wait3 system
call has returned but before we get to INTON in dowait, then
we can jump back up to the top and lose the exit status.  So
if we then wait for the job that has just exited, then it'll
stay there forever.

I made the original change that caused this bug to fix pretty
much the same bug but in the opposite direction.  That is, if
we get a signal after we enter wait3 but before we hit the kernel
then it too can cause the wait to go on forever (assuming the
child doesn't exit).

In fact this is pretty much exactly the scenario that you'll
find in glibc's documentation on pause().  The solution is given
there too, in the form of sigsuspend, which is the only way to
do the check and wait atomically.

So this patch fixes Alexey's race without reintroducing the old
bug by converting the blocking wait3 to a sigsuspend.

In order to do this we need to set a signal handler for SIGCHLD,
so the code has been modified to always do that.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

-- 
Kris Maglione

If you want to go somewhere, goto is the best way to get there.
	--Ken Thompson

