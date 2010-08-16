From: Guido Berhoerster <guido+kernel.org@berhoerster.name>
Subject: Re: trap bug in recent versions of dash
Date: Mon, 16 Aug 2010 13:52:56 +0200
Message-ID: <20100816115154.GB11790@wopr.local.invalid>
References: <20100811080616.GA18303@wopr.local.invalid>
 <20100815200551.GA19150@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from multivac.heapoverflow.de ([83.169.16.167]:41250 "EHLO
	multivac.heapoverflow.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab0HPLsX (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 16 Aug 2010 07:48:23 -0400
Content-Disposition: inline
In-Reply-To: <20100815200551.GA19150@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: dash@vger.kernel.org

* Jilles Tjoelker <jilles@stack.nl> [2010-08-15 22:05]:
> On Wed, Aug 11, 2010 at 10:06:16AM +0200, Guido Berhoerster wrote:
> > with the latest git version of dash trap actions are not
> > evaluated in the context of a function.
> 
> I think dotrap()'s return value should be removed or at least ignored.
> An "evalskip" (break/continue/return-function/return-file) should never
> lead to an immediate exit. I'm not supplying a patch because I am not
> entirely sure about the side effects this could have.

OK, I'm not familiar with the source but it'd be nice to have it
fixed before the next release since it is a regression breaking
scripts.

> > The following script demonstrates the bug:
> > ----8<----
> > read_timeout () {
> >     saved_traps="$(trap)"
> 
> This does not work in dash, it always returns an empty string because
> trap is evaluated in a subshell.
> 
> Some other ash variants do not evaluate most command substitutions
> containing only a single builtin in a subshell, but this was removed in
> NetBSD sh and dash because such commands can affect the shell in wrong
> ways (e.g. $(exit 1) causes FreeBSD sh to exit).

POSIX:2008 lists

save_traps=$(trap)
...
eval "$save_traps"

as an example in the specification of the trap special builtin,
although it somewhat contradicts the description. This goes back
to at lease the SUSv2 in 1997 and it currently works e.g. in bash
and ksh93.

> A recent or proposed POSIX interpretation has said that $(trap) should
> work, and that this may be done by treating a lone trap command
> specially or by having trap in a subshell output the parent's traps
> until a trap has been set in the subshell. To help the former case,
> stuff like TRAP=trap; y=$($TRAP) is not required to work.
> 
> A problem in the script is that it does not handle TERM set to the
> default action properly, as this is not included in trap's output.

Right, the following interpretation has been approved last year (see
http://austingroupbugs.net/view.php?id=53):
"When a subshell is entered, traps that are not being ignored shall
be set to the default actions, except in the case of a command
substitution containing only a single trap command, when the traps
need not be altered. Implementations may check for this case
using only lexical analysis; for example if `trap` and $( trap -- )
do not alter the traps in the subshell, cases such as assigning
var=trap and then using $($var) may still alter them."
and
"The trap command with no operands shall write to standard output
a list of commands associated with each condition. If the command
is executed in a subshell, the implementation does not perform
the optional check described above for a command substitution
containing only a single trap command, and no trap commands with
operands have been executed since entry to the subshell, the list
shall contain the commands that were associated with each
condition immediately before the subshell environment was entered.
Otherwise, the list shall contain the commands currently
associated with each condition."

So this IMHO this should be implemented as a special case in dash
as well.

> >     trap 'printf "timed out\n"; eval "${saved_traps}"; return' TERM
> >     ( sleep $1; kill -TERM $$ ) >/dev/null 2>&1 &
> 
> For portability, I recommend braces
>     { sleep $1; kill -TERM $$; } >/dev/null 2>&1 &
> 
> Some shells do not treat a background subshell specially and fork twice,
> which would cause the wrong process to be killed below.

Thanks for the hint.

> >     timer_pid=$!
> >     read $2
> >     kill $timer_pid 2>/dev/null
> 
> eval "${saved_traps}"  is missing here.

Yep, forgot that.

-- 
Guido Berhoerster
