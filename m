From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: Dashhh
Date: Thu, 17 Nov 2011 18:21:57 +0100
Message-ID: <201111171821.58460.stefano.lattarini@gmail.com>
References: <4EC53397.2030005@am-anger-1.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51722 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753822Ab1KQRWJ (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 17 Nov 2011 12:22:09 -0500
Received: by wwe5 with SMTP id 5so3358037wwe.1
        for <dash@vger.kernel.org>; Thu, 17 Nov 2011 09:22:07 -0800 (PST)
In-Reply-To: <4EC53397.2030005@am-anger-1.de>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Heiko Gerstung <heiko@am-anger-1.de>
Cc: dash@vger.kernel.org

Hello everybody.  Hope it's OK if I chime in for a couple of tangential
issues... (I've no comments on the patch proper, as my knowledge of the
dash internals is zero).

On Thursday 17 November 2011, Heiko Gerstung wrote:
> Hi!
> 
> I am an enthusiastic user of dash since a couple of months and use it
> on an embedded system (appliance) that is operating all around the
> globe in all kinds of networks. I made the switch from bash to dash
> as soon as I found out that dash covers 99% of what I do with bash
> while requiring 10% of the ressources.
> 
> In the course of porting ~200 shell scripts (small three liners and
> a few big guys) from bash to dash, I ran into a few issues (surprise
> surprise):
> 
> 1. The usual "[[" and "==" stuff (pretty easy to change, thank
>    you sed)
> 2. shift returns with a critical error when no arguments are left
>    (no really good solution found)
> 3. $[] arithmetic stuff not working (OK, worked around that with bc)
>
You might instead use the shell built-in construct `$(( ))', which is
mandated by POSIX, and which dash supports as well:

  $ echo $((1 + 2 * 3))
  7

(In fact, I'm pretty sure the the use of `$[]' for arithmetic substitution
has been deprecated in bash for a looong time now).

> 4. The bash FUNCNAME variable was very valuable for debugging purposes
> and is nonexistent in dash
> 
> Now, since I solved point 1 and 3 by changing my code, all I did is creating
> a very small patch to deal with point 2 and, since it is also not too
> complicated, I added patches to deal with point 1 and 4 as well.
>
As for point (1), I'm quite opposed to "solving it", since the change
you are proposing would reduce the usefulness of dash as a testbed to
detect bashisms in shell scripts.

Also (and more importantly), if I'm not mistaken, `[[' as supported by
bash and the Korn shells is not a mere builtin, but rather a "syntactical
contruct", in that the shell parses and interpreters stuff enclosed into
`[[ ... ]]'  differently:

 ## Quoting rules are different ##

 $ a="x y"; [[ -n $a ]] && echo ok
 ok
 $ a="x y"; [ -n $a ] && echo ok
 bash: [: x: binary operator expected
 # Do this in an empty directory.
 $ touch foo
 $ a='*'; [ $a = foo ] && echo ok
 ok
 $ a='*'; [[ $a = "*" ]] && echo ok
 ok

 ## Operators and redirections: ">" is "greater than" in   ##
 ## `[[', but is the usual redirection operator inside `[' ##

 # Do this in an empty directory.
 $ [[ 1 > 2 ]]; echo status = $?; ls -l
 status = 1
 total 0
 $ [ 1 > 2 ]; echo $?; ls -l
 status = 0
 total 0
 -rw-r--r-- 1 stefano stefano 0 Nov 17 18:13 2

> I call this the dashhh (dash: Heiko's Hack) and although I browsed
> the mailing list archives and found out that the shift issue has not
> been accepted as a worthwhile change for dash and people are still
> discussing about "==", I decided that I at least want to show you my
> patch.
> 
> If anyone wants to try this: Please remember that this of course is no
> longer dash (it is dashhh).
> 
> I can understand the reasoning behind the relucatance of the dash crew
> to apply any of those changes to the main codebase.
> For me it is not so important that dash is fully POSIX compliant
>
But for many people, this is VERY important!

(Still, it seems to me that your proposed changes would leave dash
POSIX-compliant, so there's no need to venture into a discussion
of the merits of POSIX-compatibility).

> (I was using bash for years, that tells you how much I care for
> POSIX compliance in my shell scripts), the killer feature of dash
> is its small footprint and the fast execution times.
>
> [SNIP]
>
> Best Regards,
>   Heiko
> 

Regards,
  Stefano 
