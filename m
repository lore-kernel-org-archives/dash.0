From: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] echo: fix octal escaping with \1...\7
Date: Mon, 31 Oct 2011 07:12:43 -0600
Message-ID: <4EAE9ECB.4040607@redhat.com>
References: <20111031034146.GA19477@gondor.apana.org.au> <201110310023.45138.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:13705 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754661Ab1JaNMv (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 31 Oct 2011 09:12:51 -0400
In-Reply-To: <201110310023.45138.vapier@gentoo.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: Herbert Xu <herbert@gondor.hengli.com.au>, dash@vger.kernel.org, bug-libtool@gnu.org

[adding bug-libtool]

On 10/30/2011 10:23 PM, Mike Frysinger wrote:
> On Sunday 30 October 2011 23:41:58 Herbert Xu wrote:
>> Mike Frysinger wrote:
>>> POSIX states that octal escape sequences should take the form \0num
>>> when using echo.  dash however additionally treats \num as an octal
>>> sequence.  This breaks some packages (like libtool) who attempt to
>>> use strings with these escape sequences via variables to execute sed
>>> (since sed ends up getting passed a byte instead of a literal \1).

That's a bug in libtool for using "echo '\1'" and expecting sane 
behavior.  Can you provide more details on this libtool bug, so we can 
get it fixed in libtool?  Or perhaps it has already been fixed in modern 
libtool, and you are just encountering it in an older version?

>>
>> OK this is a bit of problem.  From our conversation I had the
>> impression that you were referring to the lack of support of
>> escape codes, rather than unwanted support.
>>
>> If it was the former I could easily add it if POSIX said so,
>> however, as this is an existing feature there may well be scripts
>> out there that depend on it.  So removing it is not an option
>> unless it is explicitly forbidden by POSIX.
>
> i'm not seeing how this jives with dash's goal.  if it intends to be a
> fast/small POSIX compliant shell while punting (almost) all the rest, then why
> carry additional functionality that POSIX doesn't even mention in passing ?
> this isn't "documented but optional extended functionality", but rather the
> realm of "anything goes".  otherwise we approach the same realm that dash was
> created to avoid -- carrying lots of cruft that slow things down because
> scripts use it rather than POSIX mandating it.
>
> as a comparison, bash/ksh/tcsh/zsh/busybox[ash] all behave the way my patch
> updates dash to operate ... i would test more shells, but these tend to be the
> standards that everyone compares against.  i can't see people writing scripts
> that only work under dash either.
>
>> In any case, scripts that rely on escape codes like this are
>> simply broken and should either be fixed to use printf or just
>> run with #!/bin/bash.
>
> they're relying on these escape codes not being interpreted as escape codes
> (which every other shell appears to do), not the other way around

Scripts that rely on a certain interpretation of "echo '\1'" are broken 
regardless of how dash behaves; but that said, since POSIX doesn't 
require dash's current behavior, and since the proposed patch makes dash 
both smaller and more like other shells in treating it as an extension 
that means a literal 1 rather than an octal escape, I would be in favor 
of making the change in dash.

-- 
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org
