From: Martijn Dekker <martijn@inlv.org>
Subject: Bizarre interaction bug involving bash w/ lastpipe + Almquist 'wait'
Date: Thu, 6 Feb 2020 16:12:06 +0000
Message-ID: <10e3756b-5e8f-ba00-df0d-b36c93fa2281@inlv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <bug-bash-bounces+gnu-bug-bash-3=m.gmane-mx.org@gnu.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.gnu.org/mailman/options/bug-bash>,
 <mailto:bug-bash-request@gnu.org?subject=unsubscribe>
List-Archive: <https://lists.gnu.org/archive/html/bug-bash>
List-Post: <mailto:bug-bash@gnu.org>
List-Help: <mailto:bug-bash-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/bug-bash>,
 <mailto:bug-bash-request@gnu.org?subject=subscribe>
Errors-To: bug-bash-bounces+gnu-bug-bash-3=m.gmane-mx.org@gnu.org
Sender: "bug-bash" <bug-bash-bounces+gnu-bug-bash-3=m.gmane-mx.org@gnu.org>
To: DASH shell mailing list <dash@vger.kernel.org>, busybox <busybox@busybox.net>, Bug reports for the GNU Bourne Again SHell <bug-bash@gnu.org>, Robert Elz <kre@munnari.OZ.AU>, Jilles Tjoelker <jilles@stack.nl>, Harald van Dijk <harald@gigawatt.nl>
List-Id: dash@vger.kernel.org

This is probably the strangest bug (or maybe pair of bugs) I've run into 
in nearly five years of breaking shells by developing modernish.

I've traced it to an interaction between bash >= 4.2 (i.e.: bash with 
shopt -s lastpipe) and variants of the Almquist shell, at least: dash, 
gwsh, Busybox ash, FreeBSD sh, and NetBSD 9.0rc2 sh.

Symptom: if 'return' is invoked on bash in the last element of a pipe 
executed in the main shell environment, then if you subsequently 'exec' 
an Almquist shell variant so that it has the same PID, its 'wait' 
builtin breaks.

I can consistently reproduce this on Linux, macOS, FreeBSD, NetBSD 
9.0rc2, OpenBSD, and Solaris.

To reproduce this, you need bash >= 4.2, some Almquist shell variant, 
and these two test scripts:

---begin test.bash---
fn() {
	: | return
}
shopt -s lastpipe || exit
fn
exec "${1:-dash}" test.ash
---end test.bash---

---begin test.ash---
echo '*ash-begin'
: &
echo '*ash-middle'
wait "$!"
echo '*ash-end'
---end test.ash---

When executing test.bash with dash, gwsh, Busybox ash, or FreeBSD sh, 
then test.ash simply waits forever on executing 'wait "$!"'.

$ bash test.bash <some-almquist-shell>
*ash-begin
*ash-middle
(nothing until ^C)

NetBSD sh behaves differently. NetBSD 8.1 sh (as installed on sdf.org 
and sdf-eu.org) seem to act completely normally, but NetBSD 9.0rc2 sh 
(on my VirtualBox test VM) segfaults. Output on NetBSD 9.0rc2:

$ bash test.bash /bin/sh
*ash-begin
*ash-middle
[1]   Segmentation fault       bash test.bash sh

I don't know if the different NetBSD sh behaviour is because the older 
NetBSD sh doesn't have the bug, or because some factor on the sdf*.org 
systems causes it to not be triggered.

To me, this smells like the use of some uninitialised value on various 
Almquist shells. Tracing that is beyond my expertise though.

Whether this also represents a bug in bash or not, I can't say. But no 
other shells trigger this that I've found, not even ksh93 and zsh which 
also execute the last element of a pipe in the main shell environment.

- Martijn

-- 
modernish -- harness the shell
https://github.com/modernish/modernish
