From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: trap bug in recent versions of dash
Date: Sun, 15 Aug 2010 22:05:51 +0200
Message-ID: <20100815200551.GA19150@stack.nl>
References: <20100811080616.GA18303@wopr.local.invalid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:60463 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751484Ab0HOUFz (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 15 Aug 2010 16:05:55 -0400
Received: from turtle.stack.nl (turtle.stack.nl [IPv6:2001:610:1108:5010::132])
	by mx1.stack.nl (Postfix) with ESMTP id 492D71DD631
	for <dash@vger.kernel.org>; Sun, 15 Aug 2010 22:05:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100811080616.GA18303@wopr.local.invalid>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

On Wed, Aug 11, 2010 at 10:06:16AM +0200, Guido Berhoerster wrote:
> with the latest git version of dash trap actions are not
> evaluated in the context of a function.

I think dotrap()'s return value should be removed or at least ignored.
An "evalskip" (break/continue/return-function/return-file) should never
lead to an immediate exit. I'm not supplying a patch because I am not
entirely sure about the side effects this could have.

Related, there may be a bug with SKIPFILE. This constant is never tested
against, and this makes 'break' inside a dot script behave strangely.
Example (this must be saved to a file, as it sources itself):

if [ "$1" != nested ]; then
        while :; do
                set -- nested
                . "$0"
                echo bad2
                exit 2
        done
        exit 0
fi
break
echo bad1
exit 1

> The following script demonstrates the bug:
> ----8<----
> read_timeout () {
>     saved_traps="$(trap)"

This does not work in dash, it always returns an empty string because
trap is evaluated in a subshell.

Some other ash variants do not evaluate most command substitutions
containing only a single builtin in a subshell, but this was removed in
NetBSD sh and dash because such commands can affect the shell in wrong
ways (e.g. $(exit 1) causes FreeBSD sh to exit).

A recent or proposed POSIX interpretation has said that $(trap) should
work, and that this may be done by treating a lone trap command
specially or by having trap in a subshell output the parent's traps
until a trap has been set in the subshell. To help the former case,
stuff like TRAP=trap; y=$($TRAP) is not required to work.

A problem in the script is that it does not handle TERM set to the
default action properly, as this is not included in trap's output.

>     trap 'printf "timed out\n"; eval "${saved_traps}"; return' TERM
>     ( sleep $1; kill -TERM $$ ) >/dev/null 2>&1 &

For portability, I recommend braces
    { sleep $1; kill -TERM $$; } >/dev/null 2>&1 &

Some shells do not treat a background subshell specially and fork twice,
which would cause the wrong process to be killed below.

>     timer_pid=$!
>     read $2
>     kill $timer_pid 2>/dev/null

eval "${saved_traps}"  is missing here.

> }

> read_timeout 5 value
> printf "read \"%s\"\n" "${value:=default}"

> ---->8----
> The return statement in the trap inside the read_timeout function
> does not return from the function but rather exits the script.

> With dash 0.5.5.1 it works as expected.

-- 
Jilles Tjoelker
