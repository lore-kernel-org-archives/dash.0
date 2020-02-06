From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: Bizarre interaction bug involving bash w/ lastpipe + Almquist
 'wait'
Date: Thu, 6 Feb 2020 19:29:41 +0000
Message-ID: <f8b210f5-dd59-2c7f-05d4-be0a89316d3d@gigawatt.nl>
References: <10e3756b-5e8f-ba00-df0d-b36c93fa2281@inlv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.gigawatt.nl ([51.68.198.76]:60104 "EHLO mail.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgBFTbO (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 6 Feb 2020 14:31:14 -0500
In-Reply-To: <10e3756b-5e8f-ba00-df0d-b36c93fa2281@inlv.org>
Content-Language: en-US
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Martijn Dekker <martijn@inlv.org>, DASH shell mailing list <dash@vger.kernel.org>, busybox <busybox@busybox.net>, Bug reports for the GNU Bourne Again SHell <bug-bash@gnu.org>, Robert Elz <kre@munnari.OZ.AU>, Jilles Tjoelker <jilles@stack.nl>

On 06/02/2020 16:12, Martijn Dekker wrote:
> This is probably the strangest bug (or maybe pair of bugs) I've run into 
> in nearly five years of breaking shells by developing modernish.
> 
> I've traced it to an interaction between bash >= 4.2 (i.e.: bash with 
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
> To reproduce this, you need bash >= 4.2, some Almquist shell variant, 
> and these two test scripts:
> 
> ---begin test.bash---
> fn() {
>      : | return
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
