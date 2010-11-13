From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: dash "set -e" breaks "trap INT"
Date: Sat, 13 Nov 2010 22:05:54 +0100
Message-ID: <20101113210554.GA86425@stack.nl>
References: <AANLkTimrXpDb5z1d4PC3M=8hyN-Ob7sVb1ngF-JTem4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:56385 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753675Ab0KMVF5 (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 13 Nov 2010 16:05:57 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimrXpDb5z1d4PC3M=8hyN-Ob7sVb1ngF-JTem4g@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Dan Muresan <danmbox@gmail.com>
Cc: dash@vger.kernel.org

On Wed, Nov 10, 2010 at 03:49:19PM +0200, Dan Muresan wrote:
> I've submitted a bug regarding trap + "set -e" on Ubuntu Launchpad
> [1], but that's probably not the best place to talk about the issue.

> I'm using dash 0.5.5.1-3ubuntu2 from Ubuntu Lucid on an x86 machine.
> With "set -e", only the first command in an INT trap handler gets
> executed -- UNLESS that first command is a call to a function that
> returns 0. Here's an example of the problem:

> --- 8-x ---

> #!/bin/sh
> set -e
> 
> trap 'hnd' INT
> trap 'echo EXIT' EXIT
> 
> zero() {
>   return 0;
> }
> 
> hnd() {
>   #zero
>   echo "Ignored 1"; echo "Ignored 2"
>   sleep 1
>   echo Back
> }
> 
> for i in 3 2 1; do
>     echo "$i"
>     sleep 1 # || true
> done
> 
> echo OUT

> --- 8-x ---

> If we uncomment either the call to zero, or the || true check, the
> entire handler gets executed. A set +e inside the handler makes no
> difference.

> My workaround at the moment is to trap both INT and EXIT (I'm not
> going to rely on the "zero" bit of magic). I suppose this workaround
> will unfortunately have to stick around for a while -- even if this
> bug gets fixed, scripts can't assume they are running on the latest
> version of dash.

> [1] https://bugs.launchpad.net/ubuntu/+source/dash/+bug/673119

I can reproduce this with v0.5.5.1 but not with v0.5.6 or master, so
apparently it has been fixed.

The exit after the INT trap has been executed also occurs in all other
shells I tried (newer dash, FreeBSD sh, mksh, true Bourne shell), except
ksh93 which does not execute the INT trap at all, only the EXIT trap.
The cause is that sleep also gets the SIGINT and terminates on it, which
can be seen by removing  set -e  and adding  echo rc=$?  after sleep.

ksh93 has a sleep builtin, but this has no effect on above. Behaviour
remains the same with /bin/sleep.

-- 
Jilles Tjoelker
