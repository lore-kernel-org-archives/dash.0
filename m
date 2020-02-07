From: Walter Harms <wharms@bfs.de>
Subject: AW: Bizarre interaction bug involving bash w/ lastpipe + Almquist
 'wait'
Date: Fri, 7 Feb 2020 11:19:28 +0000
Message-ID: <cbe5644f6db94eb89e4088141c426f8a@bfs.de>
References: <10e3756b-5e8f-ba00-df0d-b36c93fa2281@inlv.org>,
 <f8b210f5-dd59-2c7f-05d4-be0a89316d3d@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <bug-bash-bounces+gnu-bug-bash-3=m.gmane-mx.org@gnu.org>
In-Reply-To: <f8b210f5-dd59-2c7f-05d4-be0a89316d3d@gigawatt.nl>
Content-Language: de-DE
List-Unsubscribe: <https://lists.gnu.org/mailman/options/bug-bash>,
 <mailto:bug-bash-request@gnu.org?subject=unsubscribe>
List-Archive: <https://lists.gnu.org/archive/html/bug-bash>
List-Post: <mailto:bug-bash@gnu.org>
List-Help: <mailto:bug-bash-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/bug-bash>,
 <mailto:bug-bash-request@gnu.org?subject=subscribe>
Errors-To: bug-bash-bounces+gnu-bug-bash-3=m.gmane-mx.org@gnu.org
Sender: "bug-bash" <bug-bash-bounces+gnu-bug-bash-3=m.gmane-mx.org@gnu.org>
To: Harald van Dijk <harald@gigawatt.nl>, Martijn Dekker <martijn@inlv.org>, DASH shell mailing list <dash@vger.kernel.org>, busybox <busybox@busybox.net>, Bug reports for the GNU Bourne Again SHell <bug-bash@gnu.org>, Robert Elz <kre@munnari.OZ.AU>, Jilles Tjoelker <jilles@stack.nl>
List-Id: dash@vger.kernel.org

IMHO is the bug on bash side. ash can assume to get an "healthy" environmen=
t from the caller. You can simply not fix everything that can possible go w=
rong.

Obviously it should not segfault but so far i understand it is bsd as that =
does, not busybox ash.

re,
 wh
________________________________________
Von: busybox <busybox-bounces@busybox.net> im Auftrag von Harald van Dijk <=
harald@gigawatt.nl>
Gesendet: Donnerstag, 6. Februar 2020 20:29
An: Martijn Dekker; DASH shell mailing list; busybox; Bug reports for the G=
NU Bourne Again SHell; Robert Elz; Jilles Tjoelker
Betreff: Re: Bizarre interaction bug involving bash w/ lastpipe + Almquist =
'wait'

On 06/02/2020 16:12, Martijn Dekker wrote:
> This is probably the strangest bug (or maybe pair of bugs) I've run into
> in nearly five years of breaking shells by developing modernish.
>
> I've traced it to an interaction between bash >=3D 4.2 (i.e.: bash with
> shopt -s lastpipe) and variants of the Almquist shell, at least: dash,
> gwsh, Busybox ash, FreeBSD sh, and NetBSD 9.0rc2 sh.
>
> Symptom: if 'return' is invoked on bash in the last element of a pipe
> executed in the main shell environment, then if you subsequently 'exec'
> an Almquist shell variant so that it has the same PID, its 'wait'
> builtin breaks.
>
> I can consistently reproduce this on Linux, macOS, FreeBSD, NetBSD
> 9.0rc2, OpenBSD, and Solaris.
>
> To reproduce this, you need bash >=3D 4.2, some Almquist shell variant,
> and these two test scripts:
>
> ---begin test.bash---
> fn() {
>      : | return
> }
> shopt -s lastpipe || exit
> fn
> exec "${1:-dash}" test.ash
> ---end test.bash---
>
> ---begin test.ash---
> echo '*ash-begin'
> : &
> echo '*ash-middle'
> wait "$!"
> echo '*ash-end'
> ---end test.ash---
>
> When executing test.bash with dash, gwsh, Busybox ash, or FreeBSD sh,
> then test.ash simply waits forever on executing 'wait "$!"'.

Nice test. bash leaves the process in a state where SIGCHLD is blocked,
and the various ash-based shells do not unblock it. Because of that,
they do not pick up on the fact that the child process has terminated. I
would consider this a bug both in bash and in the ash-based shells.

Cheers,
Harald van Dijk
