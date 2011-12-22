From: Thorsten Glaser <tg+ml-SdpXnpOQhD8dnm+yROfE0A@public.gmane.org>
Subject: Re: '>;' redirection operator
Date: Thu, 22 Dec 2011 23:34:23 +0000 (UTC)
Message-ID: <Pine.BSM.4.64L.1112222327530.2211@herc.mirbsd.org>
References: <201112221539.pBMFdlaj011933@penguin.research.att.com>
 <4EF39B1E.80709@redhat.com> <4EF3AA9A.9070009@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <austin-group-l-request-7882/jkIBncuagvECLh61g@public.gmane.org>
In-Reply-To: <4EF3AA9A.9070009-mXXj517/zsQ@public.gmane.org>
Resent-Message-ID: <"CuPPLB.A.xLC.O778OB"@Phoebe.vpn.opengroup.org>
Resent-To: austin-group-l-7882/jkIBncuagvECLh61g@public.gmane.org
To: Eric Blake <eblake-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Bruce Korb <bkorb-mXXj517/zsQ@public.gmane.org>
Cc: David Korn <dgk-7WuBAv+fczCkVZkbZjKZZw@public.gmane.org>, austin-group-l-7882/jkIBncuagvECLh61g@public.gmane.org, Bash - Bug <bug-bash-mXXj517/zsQ@public.gmane.org>, zsh-workers-SwHCXuVDQaU@public.gmane.org, dash <dash-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, miros-discuss-SdpXnpOQhD8dnm+yROfE0A@public.gmane.org
List-Id: dash@vger.kernel.org

Eric Blake dixit:

>powerful approach.  Can we get buy-in from other shell developers to
>support '>;' as an atomic temp-file replacement-on-success idiom, if

Urgh, PLEASE NOT!

People complain about the readability of code enough already, and as
practice shows, things like [[ have been around and nobody uses them
anyway (often using just POSIX, but not even knowing – myself included
– that POSIX sh has $((…))⁺; or even using less-than-POSIX, e.g. in
autoconf, which means that anything we were to introduce now would not
be used in the places where it counts anyway, for compatibility).

⁺) Reminds me to write to the list about that. Buried in dayjob work
   atm though. Expect something about that next year.


Bruce Korb dixit:

> slide on slippery slopes.  Shells can always add some useful builtins:
>
>   sh_move_if_changed
>   sh_save_on_success
>   sh_save_on_failure

In mksh, practice is to keep such things out of the core code and
optionally put it into ~/.mkshrc instead. The pushd/popd/dirs code
is a prime example of it. Also, this way, the shell is extended in
shell instead of in C. (I’ve seen the C201x draft this week. This
drives home _that_ point even better. That’s bloat, not C any more.)

Many languages have standard libraries written in that language
itself, for better portability and easier maintenance, so I’d say
do it like that. Heck, https://evolvis.org/projects/shellsnippets/
(disclaimer: a pet project of a coworker and me) is waiting for
more contributions. (Hosted at my current employer, that’s why I
untypically-for-me chose git so nobody needs to fear they could
take it down.)


Oh, and: sed. has. no. -i. option. either. Please. There’s a
perfectly fine ed, man! man ed! for that.

bye,
//mirabilos
-- 
FWIW, I'm quite impressed with mksh interactively. I thought it was much
*much* more bare bones. But it turns out it beats the living hell out of
ksh93 in that respect. I'd even consider it for my daily use if I hadn't
wasted half my life on my zsh setup. :-) -- Frank Terbeck in #!/bin/mksh
