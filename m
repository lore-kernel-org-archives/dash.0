From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: [Partial patch] IFS and read builtin
Date: Mon, 23 Aug 2010 21:35:10 +0200
Message-ID: <20100823193510.GA67671@stack.nl>
References: <4C71A29C.1080609@gigawatt.nl>
 <20100822230003.GB49760@stack.nl>
 <4C71BAB5.1030504@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:62364 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753026Ab0HWTfL (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 23 Aug 2010 15:35:11 -0400
Content-Disposition: inline
In-Reply-To: <4C71BAB5.1030504@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: dash@vger.kernel.org

On Mon, Aug 23, 2010 at 02:03:01AM +0200, Harald van Dijk wrote:
> On 23/08/10 01:00, Jilles Tjoelker wrote:
> > On Mon, Aug 23, 2010 at 12:20:12AM +0200, Harald van Dijk wrote:
> >>[...]
> >>   echo a:b | { IFS=: read a b; echo $a; }
> >>[...]
> > 
> > This has already been fixed in a totally different way in master. See
> > git commits near 95a60b2936e8835963bfb08eadc0edf9dddf0498.

> Interesting, thank you for the reference. That commit (from May) does
> a lot more than fix the read problem, and does not specifically
> address the read problem at all, which is probably why it has not made
> it into 0.5.6.1 (from June), and why I had not found it.

> The IFS problem was breaking the build of glibc, and reportedly also
> causing an unbootable system for someone because of a bad build of
> libusb, so it was important to fix it somehow for Gentoo. Would you
> prefer I continue to use a version of the patch I posted, or use the
> more invasive commits from master?

I think you should do what you think is best for the stability of your
product. Because dash releases are not extensively tested, I'd recommend
a trial build of at least a minimal base system with the new version you
choose. A particular feature to be wary of is LINENO support, as it will
cause most configure scripts to accept dash as a usable shell.

> >>    $ src/dash -c 'printf "a\t\tb\n" | { IFS=$(printf "\t") read a b c; echo "|$a|$b|$c|"; }'
> >>    |a||b|
> >>    $ src/dash -c 'printf "a\t\tb\n" | { IFS="$(printf "\t")" read a b c; echo "|$a|$b|$c|"; }'
> >>    |a|b||
> >>[...]
> > Ick. Your change will probably work, but it remains sneaky action at a
> > distance. To reduce complexity, it would be good to implement read's
> > splitting without using expand.c.

> read used to have its own splitting code, but it was changed to use
> expand.c some time between 0.5.5 and 0.5.6.1. The old splitting code
> had bugs that expand.c did not have.

Right, but it seems better to fix the bugs rather than entangle things
with expand.c and still leave bugs.

> > I estimate the extra lines of code
> > from importing FreeBSD's code at less than 50. It will also fix an edge
> > case with the splitting. The last two lines of FreeBSD's
> > builtins/read1.0 test are:

> > echo " 1 ,2 3,"         | { IFS=', ' read a b c; echo "x${a}x${b}x${c}x"; }
> > echo " 1 ,2 3,,"        | { IFS=', ' read a b c; echo "x${a}x${b}x${c}x"; }

> > These should result in:

> > x1x2x3x
> > x1x2x3,,x

> > bash and ksh93 agree on this. However, dash master prints:

> > x1x2x3,x
> > x1x2x3,,x

> This is also what zsh prints. Could you explain why bash and ksh are
> correct? By my reading, when IFS=', ', then splitting " 1 ,2 3,"
> results in "1", "2", "3", and "". Leading and trailing IFS white space
> gets ignored, but the trailing , is not white space, so makes the
> total field count 4. Since there are four fields, a is assigned "1", b
> is assigned "2", c is assigned "3," which is "3", the separator ",",
> and the final field "". But I'll be the first to admit I'm far from an
> expert, and I trust bash to get these things right, I'm just curious
> why bash is right.

> That said, zsh is consistent here, and dash is not. zsh also makes
>   x=" 1 ,2 3,"
>   IFS=", "
>   set $x
>   echo $#
> print out 4, while dash prints 3 in this case. So either way,
> something is wrong.

I think the important thing is that IFS characters are supposed to be
field terminators (see POSIX XCU 2.6.5 Field Splitting).

Therefore, in the example " 1 ,2 3," there are three fields, each
containing one digit, and each variable is assigned one of them.

In the example " 1 ,2 3,," there are four fields, the last being empty.
Then c is assigned the third field plus the delimiter character and the
remaining fields and their delimiters except trailing whitespace that is
in IFS. Hence, both commas end up in c.

Likewise, in your example with normal field splitting, dash is right and
zsh is wrong.

-- 
Jilles Tjoelker
