From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: bug with <&- under ulimit -n
Date: Thu, 28 Oct 2010 00:50:49 +0200
Message-ID: <20101027225048.GC72761@stack.nl>
References: <4CC89AB5.3050207@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:61864 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751402Ab0J0Wuu (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 27 Oct 2010 18:50:50 -0400
Content-Disposition: inline
In-Reply-To: <4CC89AB5.3050207@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: dash@vger.kernel.org

On Wed, Oct 27, 2010 at 03:33:41PM -0600, Eric Blake wrote:
> Dash does not behave well when under artificial fd pressure due to
> ulimit -n.  It insists on copying a to-be-closed fd to another fd
> greater than 10, then complains when the dup fails, rather than just
> flat-out closing the fd in the first place.  Compare this with ksh93

> $ ksh -c 'ulimit -n 10; : <&-'; echo $?
> 0
> $ dash -c 'ulimit -n 11; : <&-'; echo $?
> 0
> $ dash -c 'ulimit -n 10; : <&-'; echo $?
> dash: 0: Invalid argument
> 2

> See this thread on the bug-tar list for more details:
> http://thread.gmane.org/gmane.comp.gnu.tar.bugs/4010/focus=4020

Summary: use 'exec' to close the file descriptors before setting ulimit
-n ridiculously low instead of relying on redirections to work in such a
restricted environment.

By the way, there is also a bug in some ash versions that fails when
closing an fd (via <&- or >&-) that is not open, except if the
redirection is for 'exec' or an external program.

However, some of the gory details are below.

fcntl(F_DUPFD) fails with [EINVAL] if arg (the minimum for the new file
descriptor) exceeds the ulimit. The FreeBSD kernel, at least, checks
this before checking if the existing file descriptor is open. Therefore
any redirection attempt that must allow for the possibility of restoring
the old open file requires a ulimit -n of at least 11.

That the ksh93 example works is due to ksh93 being very clever (too
clever for its own good, sometimes, if you ask me). It thinks that it
has no need to save the old open file if this is the last command and
there are no trap handlers.

So the following fail (on a FreeBSD 8 kernel):

$ ksh93 -c 'ulimit -n 10; : <&-; :'; echo $?
ksh93[1]: open file limit exceeded [Invalid argument]
1
$ ksh93 -c 'trap "echo hi" EXIT; ulimit -n 10; : <&-'; echo $?
ksh93[1]: open file limit exceeded [Invalid argument]
hi
1

Where the cleverness fails is when that last command sets a trap handler
itself:

$ ksh93 -c ':; trap "echo hi" EXIT >/dev/null'
$

The other shells I tried correctly print "hi".

A further difference between shells is that some shells perform
redirections for a simple command before looking at what kind of command
it is, therefore always saving the old open files, while others postpone
this until after looking what kind of command it is, not saving the old
open files for external programs because the open happens in the child
process (potentially also for 'exec').

The former behaviour is shown by most kinds of Korn shell and dash. The
latter behaviour is shown by the Bourne shell, most other ash
derivatives, bash and zsh.

A command like
  (ulimit -n 10; /bin/foo 3<&- 4<&-; :)
will only work in a shell that uses the latter behaviour.

I consider both behaviours valid and shell script that depends on either
of them broken. They both have historical basis and their own advantages
and disadvantages.

-- 
Jilles Tjoelker
