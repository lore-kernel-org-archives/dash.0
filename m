From: Martijn Dekker <martijn@inlv.org>
Subject: Re: AW: Bizarre interaction bug involving bash w/ lastpipe + Almquist
 'wait'
Date: Fri, 7 Feb 2020 14:33:46 +0000
Message-ID: <967b5a41-31b7-0ec1-fb04-62af1617a86b@inlv.org>
References: <10e3756b-5e8f-ba00-df0d-b36c93fa2281@inlv.org>
 <f8b210f5-dd59-2c7f-05d4-be0a89316d3d@gigawatt.nl>
 <cbe5644f6db94eb89e4088141c426f8a@bfs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from kahlil.inlv.org ([37.59.109.123]:58198 "EHLO kahlil.inlv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbgBGOeQ (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 7 Feb 2020 09:34:16 -0500
In-Reply-To: <cbe5644f6db94eb89e4088141c426f8a@bfs.de>
Content-Language: en-GB
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Walter Harms <wharms@bfs.de>, Harald van Dijk <harald@gigawatt.nl>, DASH shell mailing list <dash@vger.kernel.org>, busybox <busybox@busybox.net>, Bug reports for the GNU Bourne Again SHell <bug-bash@gnu.org>, Robert Elz <kre@munnari.OZ.AU>, Jilles Tjoelker <jilles@stack.nl>

Op 07-02-20 om 12:19 schreef Walter Harms:
> IMHO is the bug on bash side. ash can assume to get an "healthy"
> environment from the caller. You can simply not fix everything that
> can possible go wrong.

That is a rather fallacious argument. Of course you cannot fix 
*everything* that could possibly go wrong. You can certainly fix *this* 
thing, though. I know, because every non-Almquist shell does it.

These days, no program can realistically assume a "healthy" environment. 
Computers have become unimaginably complex machines, built on thousands 
of interdependent abstraction layers, each as fallible as the humans 
that designed and implemented them. So "unhealthy" environments happen 
all the time, due to all sorts of unforeseen causes.

It's well past time to accept that the 1980s are behind us. In 2020, 
systems have to be programmed robustly and defensively.

> Obviously it should not segfault but so far i understand it is bsd as
> that does, not busybox ash.

True. But instead, it simply gets stuck forever, with no message or 
other indicator of what went wrong. How is that better?

(Going slightly off-topic below...)

Segfaulting is actually a good thing: it's one form of failing reliably. 
And failing reliably is vastly better than what often happens instead, 
especially in shell scripts: subtle breakage, which can take a lot of 
detective work to trace, and in some cases can cause serious damage due 
to the program functioning inconsistently and incorrectly (instead of 
not at all).

Failing reliably is something the shell is ATROCIOUSLY bad at, and it's 
one of the first things modernish aims to fix.

- Martijn

-- 
modernish -- harness the shell
https://github.com/modernish/modernish
