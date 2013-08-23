From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: Fwd: bug? Spawned childs always remain in zombie state
Date: Fri, 23 Aug 2013 14:20:20 +0200
Message-ID: <20130823122020.GA31555@stack.nl>
References: <CAMqPLXWsMhPBjYa3JnCmuO=M6m2F=hSdiEfRx390VKdgC5qxZg@mail.gmail.com>
 <CAMqPLXX4GtCXcfrOnBkhPw+PEFRXh0x9X54H9paqm6b7vDnzNA@mail.gmail.com>
 <20130823104444.GE10632@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:55336 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753475Ab3HWMUY (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 23 Aug 2013 08:20:24 -0400
Content-Disposition: inline
In-Reply-To: <20130823104444.GE10632@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Sjon Hortensius <Sjon@hortensius.net>, dash@vger.kernel.org

On Fri, Aug 23, 2013 at 08:44:44PM +1000, Herbert Xu wrote:
> On Sun, Jan 20, 2013 at 12:04:04PM +0000, Sjon Hortensius wrote:
> > Hi. I'm trying to create a script which monitors a directory using
> > inotify and spawns a background process for all events. However I
> > found that all childs will remain in zombie state until the script
> > quits and I am unable to find a proper fix.

> > A minimal testcase:

> > #!/bin/dash
> > while true
> > do
> >     sleep 1 &
> > #    jobs >/dev/null
> > done

> > If you open a second terminal you'll see that all the 'sleep'
> > processes end up being defunct. I have tried playing with `set -ma`
> > but the only workaround I found is the commented 'jobs' line.
> > Uncommenting that line will result in expected behavior where childs
> > are properly reaped. Is this a bug, or is there an alternative
> > solution I'm missing?

> You need to wait on them as otherwise dash has to keep them around
> in case you call wait(1) later on.

The shell need not remember the processes indefinitely. Per POSIX (XCU
2.9.3.1 Asynchronous Lists), the application must reference $! before
starting another asynchronous list if it wants to use the wait builtin
for that particular process later on. (Note that this means that jobs -p
is not good enough even when the job consists of a single process, and
that printing $! can add memory leaks to a script.)

POSIX also restricts an operandless wait builtin to "known process IDs".
This seems inappropriate: there are many scripts that start multiple
asynchronous lists without referencing $! and expect operandless wait to
wait for all of them. Therefore, all jobs must be remembered while they
are running. However, if $! was not referenced for them and they are not
the most recent asynchronous list, they can be discarded when they
terminate. I implemented this in FreeBSD sh and it appears to work well.

An additional issue occurs when multiple asynchronous lists are started
without a foreground process, here-document that requires a fork,
operandless jobs builtin or wait builtin in between. In that case, dash
never calls wait3() and zombies accumulate. Although the example could
be considered a fork bomb and relies on the child processes getting CPU
time often enough, this may legitimately happen if the loop contains a
read builtin. In FreeBSD sh, I added a check for zombies before forking
the first process of a background job. Some other shells call waitpid()
or similar from a SIGCHLD handler; this reaps zombies faster at the cost
of more complex code (signal handler performing non-trivial work).

-- 
Jilles Tjoelker
