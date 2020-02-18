From: Robert Elz <kre@munnari.OZ.AU>
Subject: Re: Bizarre interaction bug involving bash w/ lastpipe + Almquist
 'wait'
Date: Wed, 19 Feb 2020 01:17:02 +0700
Message-ID: <17729.1582049822@jinx.noi.kre.to>
References: <CAK1hOcO_S_T=5SWJ0jpZWxDYwdUFqJisw_nC+JysnQvZ6XUuKw@mail.gmail.com>
 <10e3756b-5e8f-ba00-df0d-b36c93fa2281@inlv.org>
 <5461.1581043287@jinx.noi.kre.to>
 <2b436500-671b-b143-a4bb-2230f157e1b7@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <bug-bash-bounces+gnu-bug-bash-3=m.gmane-mx.org@gnu.org>
In-Reply-To: <CAK1hOcO_S_T=5SWJ0jpZWxDYwdUFqJisw_nC+JysnQvZ6XUuKw@mail.gmail.com>
List-Unsubscribe: <https://lists.gnu.org/mailman/options/bug-bash>,
 <mailto:bug-bash-request@gnu.org?subject=unsubscribe>
List-Archive: <https://lists.gnu.org/archive/html/bug-bash>
List-Post: <mailto:bug-bash@gnu.org>
List-Help: <mailto:bug-bash-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/bug-bash>,
 <mailto:bug-bash-request@gnu.org?subject=subscribe>
Errors-To: bug-bash-bounces+gnu-bug-bash-3=m.gmane-mx.org@gnu.org
Sender: "bug-bash" <bug-bash-bounces+gnu-bug-bash-3=m.gmane-mx.org@gnu.org>
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: Jilles Tjoelker <jilles@stack.nl>, busybox <busybox@busybox.net>, DASH shell mailing list <dash@vger.kernel.org>, Harald van Dijk <harald@gigawatt.nl>, Bug reports for the GNU Bourne Again SHell <bug-bash@gnu.org>, Martijn Dekker <martijn@inlv.org>
List-Id: dash@vger.kernel.org

    Date:        Tue, 18 Feb 2020 17:46:23 +0100
    From:        Denys Vlasenko <vda.linux@googlemail.com>
    Message-ID:  <CAK1hOcO_S_T=5SWJ0jpZWxDYwdUFqJisw_nC+JysnQvZ6XUuKw@mail.gmail.com>

  | > If NetBSD sh
  | > manages to avoid this pattern, and assuming NetBSD sh is not still
  | > susceptible to one of those race conditions
  |
  | Please let us know what you discovered.

It is very likley that it is racy as described, though no-one has ever
filed a bug report on it (ie: it hasn't happened to anyone in a way that
they'd complain about it).

I suspect it also isn't a conformance problem - POSIX says very
little about when traps are executed ... really only that they don't
interrupt waiting for a foreground command to complete, and that if a
trap occurs while waiting in the wait command, then that command ends
with an exit status indicating the signal.

What that means is that using traps for anything much more than cleanup
activities isn't really safe (or perhaps, s/safe/sane/) as there's no
guarantee when the trap will actually run.

Given that, losing the race in the situation cited (ie: getting the
signal just before running the waitpid() (or whichever) sys call when
implementing the wait command - and then going ahead and doing the
sys call, hanging until some process terminates (perhaps until a particular
process terminates) seems fully conformant to me (the signal doesn't
arrive while waiting, so no error return from wait is required).

It isn't nice, and ideally wouldn't happen (and in real life, seems
not to ... the window is quite small after all) but nothing should really
break badly because of it - or at least nothing portable should.

We do now unilaterally reset SIGCHLD to SIG_DFL/unblocked at startup
(SIGCHLD is the one signal we're not required to pass on to exec'd
processes in the same state we received it, so that's OK) so we could
adopt the block, catch SIGCHLD, and sigsuspend() approach if that ever
seemed like a necessary thing to do.

kre

ps: the observed core dump problem is also fixed, that was a related,
but quite different, issue - not connected to SIGCHLD in any way at all.
