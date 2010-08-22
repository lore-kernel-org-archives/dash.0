From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: [Partial patch] IFS and read builtin
Date: Mon, 23 Aug 2010 01:00:03 +0200
Message-ID: <20100822230003.GB49760@stack.nl>
References: <4C71A29C.1080609@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:53659 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751324Ab0HVXAE (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 22 Aug 2010 19:00:04 -0400
Content-Disposition: inline
In-Reply-To: <4C71A29C.1080609@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: dash@vger.kernel.org

On Mon, Aug 23, 2010 at 12:20:12AM +0200, Harald van Dijk wrote:
> Hi, as has been reported already dash currently has a bug where the
> read builtin ignores the read environment's IFS setting. As a result,

>   echo a:b | { IFS=: read a b; echo $a; }

> will write out a:b. I tried to see what changed between 0.5.5.1 and
> 0.5.6, and found that the old code used bltinlookup("IFS"). So, I made
> the new code also use that. The above example works properly with the
> attached patch.

This has already been fixed in a totally different way in master. See
git commits near 95a60b2936e8835963bfb08eadc0edf9dddf0498.

> However, testing further, I found that there is bad interaction (even
> without my patch, where the IFS assignment below should just be
> ignored) between the code that handles variable assignments, and read.
> Try this:

>    $ src/dash -c 'printf "a\t\tb\n" | { IFS=$(printf "\t") read a b c; echo "|$a|$b|$c|"; }'
>    |a||b|
>    $ src/dash -c 'printf "a\t\tb\n" | { IFS="$(printf "\t")" read a b c; echo "|$a|$b|$c|"; }'
>    |a|b||

> This happens because expbackq is correctly called without EXP_QUOTED,
> which makes it call recordregion, which isn't cleared by the time read
> calls ifsbreakup. I'm not sure how that should be solved, and if there
> are more cases where it would fail. The simplest way to solve this for
> read is to call removerecordregions(0) before recordregion(0, len - 1,
> 0). I have tested that locally, and it works. I am not familiar enough
> with the code to judge whether the same situation can also happen in
> other cases that would also need fixing, which is why I have not
> included that part in the attached patch.

Ick. Your change will probably work, but it remains sneaky action at a
distance. To reduce complexity, it would be good to implement read's
splitting without using expand.c. I estimate the extra lines of code
from importing FreeBSD's code at less than 50. It will also fix an edge
case with the splitting. The last two lines of FreeBSD's
builtins/read1.0 test are:

echo " 1 ,2 3,"         | { IFS=', ' read a b c; echo "x${a}x${b}x${c}x"; }
echo " 1 ,2 3,,"        | { IFS=', ' read a b c; echo "x${a}x${b}x${c}x"; }

These should result in:

x1x2x3x
x1x2x3,,x

bash and ksh93 agree on this. However, dash master prints:

x1x2x3,x
x1x2x3,,x

-- 
Jilles Tjoelker
