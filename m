From: Robert Elz <kre@munnari.OZ.AU>
Subject: Re: Bizarre interaction bug involving bash w/ lastpipe + Almquist
 'wait'
Date: Fri, 07 Feb 2020 09:41:27 +0700
Message-ID: <5461.1581043287@jinx.noi.kre.to>
References: <10e3756b-5e8f-ba00-df0d-b36c93fa2281@inlv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <bug-bash-bounces+gnu-bug-bash-3=m.gmane-mx.org@gnu.org>
In-Reply-To: <10e3756b-5e8f-ba00-df0d-b36c93fa2281@inlv.org>
List-Unsubscribe: <https://lists.gnu.org/mailman/options/bug-bash>,
 <mailto:bug-bash-request@gnu.org?subject=unsubscribe>
List-Archive: <https://lists.gnu.org/archive/html/bug-bash>
List-Post: <mailto:bug-bash@gnu.org>
List-Help: <mailto:bug-bash-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/bug-bash>,
 <mailto:bug-bash-request@gnu.org?subject=subscribe>
Errors-To: bug-bash-bounces+gnu-bug-bash-3=m.gmane-mx.org@gnu.org
Sender: "bug-bash" <bug-bash-bounces+gnu-bug-bash-3=m.gmane-mx.org@gnu.org>
To: Martijn Dekker <martijn@inlv.org>
Cc: busybox <busybox@busybox.net>, Harald van Dijk <harald@gigawatt.nl>, DASH shell mailing list <dash@vger.kernel.org>, Jilles Tjoelker <jilles@stack.nl>, Bug reports for the GNU Bourne Again SHell <bug-bash@gnu.org>
List-Id: dash@vger.kernel.org

    Date:        Thu, 6 Feb 2020 16:12:06 +0000
    From:        Martijn Dekker <martijn@inlv.org>
    Message-ID:  <10e3756b-5e8f-ba00-df0d-b36c93fa2281@inlv.org>

  | NetBSD sh behaves differently. NetBSD 8.1 sh (as installed on sdf.org 
  | and sdf-eu.org) seem to act completely normally, but NetBSD 9.0rc2 sh 
  | (on my VirtualBox test VM) segfaults. Output on NetBSD 9.0rc2:

I have updated my opinion on that, I think it is "don't have the bug",
though it is possible a blocked SIGCHLD acts differently on NetBSD than
on other systems.   On NetBSD it seems to affect nothing (the shell does
not rely upon receiving SIGCHLD so not getting it is irrelevant) and
the wait code when given an arg (as your script did) would always wait
until that process exited, and return as soon as it did.

None of that is changed in -9 ... but the wait command now has -n, which
also works with a list of pids, and while waiting for any process in its
list to exit, gets told each time a process is reaped (from lower level
code) which job that process was from (new code of mine) so it can see if
the process that completed finished one of the jobs for which it is waiting.\
I wasn't expecting to see exiting children that are not the shell's children,
which is what happens here - the
	: | return
creates a child (of bash) to run the ':' command, then the function
returns without waiting for that one.  You then exec the NetBSD shell,
which inherits that child (a child of the same process) but is unaware of
it.   If that one happens to exit while the ash script running on the
NetBSD sh is doing the wait command, core would dump.   (Fix for that is
now in the tree).   If the bash invoked ':' command exited some other time
and was noticed (eg: between commands) as having finished, it would simply
have been ignored.   I saw both happen.

kre
