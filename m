From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [BUG] Redirection bug in subshell's EXIT trap
Date: Thu, 19 Oct 2017 23:57:46 +0200
Message-ID: <8790d678-ee72-fdb5-750b-d2bb64cf2ec2@gigawatt.nl>
References: <20171019174410.GA22649@ghost.hq.kp4.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from home.gigawatt.nl ([83.163.3.213]:46358 "EHLO home.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753282AbdJSWG1 (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 19 Oct 2017 18:06:27 -0400
In-Reply-To: <20171019174410.GA22649@ghost.hq.kp4.ru>
Content-Language: en-US
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Vitaly Sinilin <vs@kp4.ru>, dash@vger.kernel.org

On 19/10/17 19:44, Vitaly Sinilin wrote:
> Hi,
> 
> I've recently written a quite unusual script and faced a strange dash
> behavior that seems not POSIX-ly correct to me.
> 
> Here is the script with a lot of debugging extra output.
> 
> (I am sorry about posting a pretty lengthy script, but I feel like a
> shorten version will look just insane without the context.)

A shortened version is easier to debug:

   dash -c 'f()(trap cat EXIT);f<&-'

This is supposed to print error messages. With dash, it doesn't.

> The problem here is that although getch is run in a subshell and it
> got FD#4 as stdin it somehow has parent's stdin in its EXIT trap.
> 
> POSIX says: "The environment in which the shell executes a trap on
> EXIT shall be identical to the environment immediately after the
> last command executed before the trap on EXIT was taken."

Yes, it is a bug. The problem is that dash, just before checking whether 
to execute the EXIT handler, has already reset everything to continue 
parsing and evaluating the next command. Which is not supposed to 
happen, never going to happen, and messes up the execution of the handler.

This resetting is done by the reset() function, and although the simple 
fix would be to move its call after exitshell(), the old ChangeLog shows 
that it was originally (about 15 years ago) the other way around and 
intentionally switched to how it is now, because some of what reset() 
does is necessary even here:

>  -- Herbert Xu <herbert@debian.org>  Sat, 26 Oct 2002 21:28:33 +1000
> 
> dash (0.4.2) unstable; urgency=low
> 
>   [...]
>   * Call reset() before exitshell() is called.  This fixes the bug where
>     returning an error from a function running under set -e caused the exit
>     trap to be taken with evalskip set.

Aside from the issue with redirections, the current order has other 
problems too:

   dash -c 'f()(local cmd="echo good";trap \$cmd EXIT);cmd="echo bad";f'

This is supposed to print "good". With dash, it prints "bad". With the 
call to reset() moved after exitshell(), it prints "good".

I suspect reset() needs to be split into two separate functions, but it 
may be a bit tricky to determine exactly what is supposed to go where.

Cheers,
Harald van Dijk
