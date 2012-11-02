From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: [PATCH] sleep builtin
Date: Fri, 2 Nov 2012 17:32:07 +0100
Message-ID: <20121102163207.GA72967@stack.nl>
References: <201211011948.48456.geissert@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:59878 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752751Ab2KBQlw (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 2 Nov 2012 12:41:52 -0400
Content-Disposition: inline
In-Reply-To: <201211011948.48456.geissert@debian.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org, geissert@debian.org

On Thu, Nov 01, 2012 at 07:48:47PM -0600, Raphael Geissert wrote:
> A while ago I wrote a sleep builtin mainly to test its impact in the boot 
> process. The non-scientific results were not very impressive: around 1 
> second.

Anything statistically significant can be impressive, taking into
account how many other things also happen and are unaffected by the
change.

If it is not statistically significant it can just be noise.

> So, I was cleaning up some directories and found the builtin. Instead
> of just nuking it, I'm forwarding it in case anyone wants to play with
> it or even merge it. If merged it will annoy those who are used to
> GNU's sleep(1) which supports the s/m/h/d suffixes, but not those
> using fractions as I added support for them.

> Back then, I also payed attention to the resulting size of the binary,
> which obviously increased by a few KBs. However, I do remember that
> when switching from gcc 4.4 to 4.6 the resulting binary with the sleep
> builtin was smaller than the binary built with 4.4 and without sleep.

> (interestingly, Debian's 0.5.7-3 dash is bigger than in 0.5.5.1-7)

> [patch snipped]

POSIX says any utility may be provided as a builtin as long as this is
not detectable apart from performance (and {ARG_MAX} I guess).

Some ksh variants (ksh93 and mksh) have a sleep builtin, so it is likely
fairly safe to do this.

However, it will need better handling of [EINTR]. The included patch
simply exits with status 2 when it happens, which differs from what an
instance of /bin/sleep would do (assuming the signal is sent to parent
and child). If the signal is one that is ignored by default such as
SIGCHLD, /bin/sleep ignores it and the shell only takes the trap when
sleep is done. If the signal is one that causes termination by default,
/bin/sleep terminates on it and the shell returns exit status 128 plus
the signal number after which it takes the trap. Unfortunately,
determining the default action of a non-standard signal is annoying in a
portable program.

It is probably acceptable that an interactive sleep command cannot be
^Z'ed.

-- 
Jilles Tjoelker
