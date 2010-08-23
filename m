From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [Partial patch] IFS and read builtin
Date: Mon, 23 Aug 2010 02:03:01 +0200
Message-ID: <4C71BAB5.1030504@gigawatt.nl>
References: <4C71A29C.1080609@gigawatt.nl> <20100822230003.GB49760@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from cp1107341-a.dbsch1.nb.home.nl ([84.31.115.1]:45681 "EHLO
	boostbox.lionra.local" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751031Ab0HWABP (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 22 Aug 2010 20:01:15 -0400
In-Reply-To: <20100822230003.GB49760@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

On 23/08/10 01:00, Jilles Tjoelker wrote:
> On Mon, Aug 23, 2010 at 12:20:12AM +0200, Harald van Dijk wrote:
>>[...]
>>   echo a:b | { IFS=: read a b; echo $a; }
>>[...]
> 
> This has already been fixed in a totally different way in master. See
> git commits near 95a60b2936e8835963bfb08eadc0edf9dddf0498.

Interesting, thank you for the reference. That commit (from May) does a lot more than fix the read problem, and does not specifically address the read problem at all, which is probably why it has not made it into 0.5.6.1 (from June), and why I had not found it.

The IFS problem was breaking the build of glibc, and reportedly also causing an unbootable system for someone because of a bad build of libusb, so it was important to fix it somehow for Gentoo. Would you prefer I continue to use a version of the patch I posted, or use the more invasive commits from master?

>>    $ src/dash -c 'printf "a\t\tb\n" | { IFS=$(printf "\t") read a b c; echo "|$a|$b|$c|"; }'
>>    |a||b|
>>    $ src/dash -c 'printf "a\t\tb\n" | { IFS="$(printf "\t")" read a b c; echo "|$a|$b|$c|"; }'
>>    |a|b||
>>[...]
> Ick. Your change will probably work, but it remains sneaky action at a
> distance. To reduce complexity, it would be good to implement read's
> splitting without using expand.c.

read used to have its own splitting code, but it was changed to use expand.c some time between 0.5.5 and 0.5.6.1. The old splitting code had bugs that expand.c did not have.

> I estimate the extra lines of code
> from importing FreeBSD's code at less than 50. It will also fix an edge
> case with the splitting. The last two lines of FreeBSD's
> builtins/read1.0 test are:
> 
> echo " 1 ,2 3,"         | { IFS=', ' read a b c; echo "x${a}x${b}x${c}x"; }
> echo " 1 ,2 3,,"        | { IFS=', ' read a b c; echo "x${a}x${b}x${c}x"; }
> 
> These should result in:
> 
> x1x2x3x
> x1x2x3,,x
> 
> bash and ksh93 agree on this. However, dash master prints:
> 
> x1x2x3,x
> x1x2x3,,x

This is also what zsh prints. Could you explain why bash and ksh are correct? By my reading, when IFS=', ', then splitting " 1 ,2 3," results in "1", "2", "3", and "". Leading and trailing IFS white space gets ignored, but the trailing , is not white space, so makes the total field count 4. Since there are four fields, a is assigned "1", b is assigned "2", c is assigned "3," which is "3", the separator ",", and the final field "". But I'll be the first to admit I'm far from an expert, and I trust bash to get these things right, I'm just curious why bash is right.

That said, zsh is consistent here, and dash is not. zsh also makes
  x=" 1 ,2 3,"
  IFS=", "
  set $x
  echo $#
print out 4, while dash prints 3 in this case. So either way, something is wrong.
