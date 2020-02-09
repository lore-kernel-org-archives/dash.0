From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: Bizarre interaction bug involving bash w/ lastpipe + Almquist
 'wait'
Date: Sun, 9 Feb 2020 20:03:22 +0100
Message-ID: <20200209190322.GA28226@stack.nl>
References: <10e3756b-5e8f-ba00-df0d-b36c93fa2281@inlv.org>
 <5461.1581043287@jinx.noi.kre.to>
 <2b436500-671b-b143-a4bb-2230f157e1b7@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <bug-bash-bounces+gnu-bug-bash-3=m.gmane-mx.org@gnu.org>
Content-Disposition: inline
In-Reply-To: <2b436500-671b-b143-a4bb-2230f157e1b7@gigawatt.nl>
List-Unsubscribe: <https://lists.gnu.org/mailman/options/bug-bash>,
 <mailto:bug-bash-request@gnu.org?subject=unsubscribe>
List-Archive: <https://lists.gnu.org/archive/html/bug-bash>
List-Post: <mailto:bug-bash@gnu.org>
List-Help: <mailto:bug-bash-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/bug-bash>,
 <mailto:bug-bash-request@gnu.org?subject=subscribe>
Errors-To: bug-bash-bounces+gnu-bug-bash-3=m.gmane-mx.org@gnu.org
Sender: "bug-bash" <bug-bash-bounces+gnu-bug-bash-3=m.gmane-mx.org@gnu.org>
To: Harald van Dijk <harald@gigawatt.nl>
Cc: busybox <busybox@busybox.net>, Martijn Dekker <martijn@inlv.org>, DASH shell mailing list <dash@vger.kernel.org>, Robert Elz <kre@munnari.OZ.AU>, Bug reports for the GNU Bourne Again SHell <bug-bash@gnu.org>
List-Id: dash@vger.kernel.org

On Sat, Feb 08, 2020 at 06:39:38PM +0000, Harald van Dijk wrote:
> On 07/02/2020 02:41, Robert Elz wrote:
> >      Date:        Thu, 6 Feb 2020 16:12:06 +0000
> >      From:        Martijn Dekker <martijn@inlv.org>
> >      Message-ID:  <10e3756b-5e8f-ba00-df0d-b36c93fa2281@inlv.org>

> >    | NetBSD sh behaves differently. NetBSD 8.1 sh (as installed on sdf.org
> >    | and sdf-eu.org) seem to act completely normally, but NetBSD 9.0rc2 sh
> >    | (on my VirtualBox test VM) segfaults. Output on NetBSD 9.0rc2:

> > I have updated my opinion on that, I think it is "don't have the bug",
> > though it is possible a blocked SIGCHLD acts differently on NetBSD than
> > on other systems.   On NetBSD it seems to affect nothing (the shell does
> > not rely upon receiving SIGCHLD so not getting it is irrelevant) and
> > the wait code when given an arg (as your script did) would always wait
> > until that process exited, and return as soon as it did.

> I think you're right that this isn't SIGCHLD behaving differently on NetBSD,
> it's that NetBSD sh does not have the same problem the other ash-based
> shells do. The problem is with sigsuspend, which in dash looks like:

> > 		sigblockall(&oldmask);
> > 
> > 		while (!gotsigchld && !pending_sig)
> > 			sigsuspend(&oldmask);
> > 
> > 		sigclearmask();

> <https://git.kernel.org/pub/scm/utils/dash/dash.git/tree/src/jobs.c?id=f30bd155ccbc3f084bbf03d56f9cc43f4b02af2a#n1170>

> This clearly cannot work when oldmask blocks SIGCHLD.

> NetBSD sh does not use sigsuspend here, so avoids that problem.

> I changed gwsh to call sigclearmask() on shell startup, but plan to check
> whether this loop is really necessary at some later time. It was added to
> dash to fix a race condition, where that race condition was apparently
> introduced by a fix for another race condition. If NetBSD sh manages to
> avoid this pattern, and assuming NetBSD sh is not still susceptible to one
> of those race conditions, the fix for it in the other shells would seem to
> be more complicated than necessary, and simplifying things would be good.

I have not tested whether the bug actually happens in NetBSD sh but I
think the complexity is necessary. The problem is that the wait builtin
must wait for either process termination or a signal, and relying on an
[EINTR] error return to abort a blocking waitpid() or similar leaves a
window where a signal could come in after which the program goes asleep.

In a script this could look like

trap 'echo cleaning up; exit' TERM
slow_process_1 &
slow_process_2 &
wait

and if a TERM signal comes in just before the wait system call is
invoked, the signal handler sets a flag but the trap is not taken until
a process terminates or another signal comes in.

FreeBSD sh also has a -T flag that causes traps to be taken immediately
while waiting for a process to terminate. This has the same issue with
waiting for process termination or a signal.

There are various solutions here:

* Make sure SIGCHLD is caught, reducing the problem to waiting for
  signals only. This can then be done using sigsuspend() or sigwait().

  Most ash variants that have closed this race window have chosen this
  option.

  The SIGCHLD handler could be installed globally or only for the
  duration of the wait builtin.

* Call longjmp() from the signal handler. The blocking wait will have to
  be changed to waitid() with WNOWAIT so no exit statuses are lost when
  a signal comes in just after waitid() returns.

  Note that ash variants already call longjmp() from a SIGINT signal
  handler in certain situations in interactive mode, so it is not a
  really strange thing to do.

* Use musl's solution for [EINTR] in the context of pthread
  cancellation, checking the saved program counter when a signal
  arrives. Although theoretically portable, it requires writing
  architecture-specific code in practice.

* Use FreeBSD libthr's solution for [EINTR] in the context of pthread
  cancellation, asking the kernel to abort the next blocking system call
  with [EINTR] immediately from the signal handler. This is not portable
  to other kernels.

-- 
Jilles Tjoelker
