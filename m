From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: Bizarre interaction bug involving bash w/ lastpipe + Almquist
 'wait'
Date: Sat, 8 Feb 2020 18:39:38 +0000
Message-ID: <2b436500-671b-b143-a4bb-2230f157e1b7@gigawatt.nl>
References: <10e3756b-5e8f-ba00-df0d-b36c93fa2281@inlv.org>
 <5461.1581043287@jinx.noi.kre.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.gigawatt.nl ([51.68.198.76]:39314 "EHLO mail.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727471AbgBHSlO (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 8 Feb 2020 13:41:14 -0500
In-Reply-To: <5461.1581043287@jinx.noi.kre.to>
Content-Language: en-US
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Robert Elz <kre@munnari.OZ.AU>, Martijn Dekker <martijn@inlv.org>
Cc: DASH shell mailing list <dash@vger.kernel.org>, busybox <busybox@busybox.net>, Bug reports for the GNU Bourne Again SHell <bug-bash@gnu.org>, Jilles Tjoelker <jilles@stack.nl>

On 07/02/2020 02:41, Robert Elz wrote:
>      Date:        Thu, 6 Feb 2020 16:12:06 +0000
>      From:        Martijn Dekker <martijn@inlv.org>
>      Message-ID:  <10e3756b-5e8f-ba00-df0d-b36c93fa2281@inlv.org>
> 
>    | NetBSD sh behaves differently. NetBSD 8.1 sh (as installed on sdf.org
>    | and sdf-eu.org) seem to act completely normally, but NetBSD 9.0rc2 sh
>    | (on my VirtualBox test VM) segfaults. Output on NetBSD 9.0rc2:
> 
> I have updated my opinion on that, I think it is "don't have the bug",
> though it is possible a blocked SIGCHLD acts differently on NetBSD than
> on other systems.   On NetBSD it seems to affect nothing (the shell does
> not rely upon receiving SIGCHLD so not getting it is irrelevant) and
> the wait code when given an arg (as your script did) would always wait
> until that process exited, and return as soon as it did.

I think you're right that this isn't SIGCHLD behaving differently on 
NetBSD, it's that NetBSD sh does not have the same problem the other 
ash-based shells do. The problem is with sigsuspend, which in dash looks 
like:

> 		sigblockall(&oldmask);
> 
> 		while (!gotsigchld && !pending_sig)
> 			sigsuspend(&oldmask);
> 
> 		sigclearmask();

<https://git.kernel.org/pub/scm/utils/dash/dash.git/tree/src/jobs.c?id=f30bd155ccbc3f084bbf03d56f9cc43f4b02af2a#n1170>

This clearly cannot work when oldmask blocks SIGCHLD.

NetBSD sh does not use sigsuspend here, so avoids that problem.

I changed gwsh to call sigclearmask() on shell startup, but plan to 
check whether this loop is really necessary at some later time. It was 
added to dash to fix a race condition, where that race condition was 
apparently introduced by a fix for another race condition. If NetBSD sh 
manages to avoid this pattern, and assuming NetBSD sh is not still 
susceptible to one of those race conditions, the fix for it in the other 
shells would seem to be more complicated than necessary, and simplifying 
things would be good.

Cheers,
Harald van Dijk
