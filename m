From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: ':' noop results in ':: not found'
Date: Fri, 28 Oct 2016 13:22:20 +0200
Message-ID: <c5b4a25d-bdf6-eb44-2401-c9af897f9b23@gigawatt.nl>
References: <56849947.Cgj98o2q7x@blitz-lx>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from home.gigawatt.nl ([83.163.3.213]:42540 "EHLO home.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752752AbcJ1LW3 (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 28 Oct 2016 07:22:29 -0400
In-Reply-To: <56849947.Cgj98o2q7x@blitz-lx>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Tim Ruehsen <tim.ruehsen@gmx.de>, dash@vger.kernel.org

On 28/10/16 12:54, Tim Ruehsen wrote:
> Hi,
>
> maybe you can enlighten me :-)
>
> I try to use dash (0.5.8-2.3) on Debian unstable for executing ./configure
> scripts. Since Debian builds with --disable-lineno, all ./configure scripts
> silently fall back to bash (I created bug report #842242 to get this fixed).

As you found there, this is intentional, specifically to force configure 
scripts to continue to be run with bash, which is what happened with 
older dash versions. I asked at the time why they don't just call bash 
explicitly (bash configure instead of ./configure) if that's the goal, 
but didn't get a response.

> Next I rebuilt the package from the (Debian) sources without --disable-lineno
> and installed it. Now I see error messages from dash when it comes to the do
> nothing operator :.
>
> $ dash -c 'test -n "a" && :'
> dash: 1: :: not found
> $ echo $?
> 127
>
> $ bash -c 'test -n "a" && :'
> $ echo $?
> 0
>
> Since this : construct is wildly used and I know that dash on other systems
> work with it, I wonder what is wrong here.
>
> Is there a known bug, maybe fixed on recent dash versions ?
> Or has this some simple reason my stupidity doesn't see ?

This is likely to happen if you have the LC_ALL environment variable set 
when building dash, and I can reproduce your results with 0.5.8 by 
setting LC_ALL to en_GB.UTF-8. It was fixed in 0.5.9. (Specifically, 
where a fixed sort order was needed, 0.5.8 only forced LC_COLLATE=C, but 
that still allowed LC_ALL to override it.)

dash won't be the only program that has problems with this; if you're 
building software yourself, setting LANG should generally be okay, but 
LC_ALL is best avoided. Unless you're doing it specifically to find and 
report/fix bugs, anyway.

Cheers,
Harald van Dijk

> Regards, Tim
