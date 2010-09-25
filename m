From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: exit-ing in a trap handler uses the wrong exit code
Date: Sat, 25 Sep 2010 22:34:04 +0200
Message-ID: <20100925203404.GA93010@stack.nl>
References: <20100925115900.GA9732@bee.dooz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:55321 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754513Ab0IYUeH (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 25 Sep 2010 16:34:07 -0400
Content-Disposition: inline
In-Reply-To: <20100925115900.GA9732@bee.dooz.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: =?iso-8859-1?Q?Lo=EFc?= Minier <lool@dooz.org>
Cc: dash@vger.kernel.org

On Sat, Sep 25, 2010 at 01:59:00PM +0200, Lo=EFc Minier wrote:
>  qemu's configure uses a trap handler which calls exit; configure wou=
ld
>  call exit 1, but with the trap handler in place the configure script
>  would return with exit 0.

>  dash -c 'trap "sh -c \"exit 4\"; exit" 0 1 2 3 9 11 13 15;exit 3'; e=
cho $?
>  4

>  Blue Swirl on the qemu-devel list points out that according to POSIX
>  this should be 3:
>  http://www.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.h=
tml#tag_18_21

>  bash and zsh get this right:
>  bash -c 'trap "sh -c \"exit 4\"; exit" 0 1 2 3 9 11 13 15;exit 3'; e=
cho $?
>  3

>  I've logged https://bugs.launchpad.net/ubuntu/+source/dash/+bug/6474=
50
>  to track this as I'm seeing this with the Ubuntu version of dash.

You are certainly right that POSIX requires this to be handled
differently, but there are various other shells that are non-compliant
in the same way as dash and it is easy to avoid the behaviour, so I
would not recommend depending on it.

Other shells where 'exit' is equivalent to 'exit $?' even in traps:
NetBSD /bin/sh, FreeBSD /bin/sh (both of these are related to dash),
pdksh, mksh, the original Bourne shell (from the Heirloom toolchest).
Of course this is no guarantee that these shells will not be changed to
be compliant later on, but many deployed systems use a /bin/sh that is
not compliant in this regard.

To avoid the behaviour, only use the exit special builtin in a trap
action for EXIT if you want to override the exit status. If you do not
use exit, all shells preserve the exit status.

=46or signals, the trap action should typically terminate the process,
either via exit with an explicit non-zero status, or (more properly) by
resetting the trap to its default action and resending the signal. Usin=
g
exit without parameters in a signal trap action appears to return statu=
s
0 in bash and zsh, which seems less than useful. Only in ksh93 does thi=
s
do something useful: it resets the signal to its default action and
resends it; however, if the signal is one that is ignored by default
ksh93 hangs forever.

POSIX says that the same applies to the return special builtin (even
though POSIX only specifies returning from functions or dot scripts, no=
t
from shell instances). This does not appear to make much sense to me,
and bash does not implement it (it does not allow returning from shell
instances either, while dash and ksh93 do).

=46urther remarks:
* Trying to trap SIGKILL produces undefined results, don't do it.
* Trapping SIGSEGV may cause unexpected results unless the signal was
sent via kill(), sigqueue() or similar. Ash variants return from the
signal handler after setting a flag, which usually causes an infinite
loop as the problematic instruction is retried over and over again. The=
y
do not use a signal stack (sigaltstack()), so a stack overflow will
terminate the process immediately. In any case, if the shell itself get=
s
an actual SIGSEGV, its state is probably too messed up to continue
executing a script.

--=20
Jilles Tjoelker
