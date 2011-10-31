From: Paul Gilmartin <PaulGBoulder@aim.com>
Subject: Re: [PATCH] echo: fix octal escaping with \1...\7
Date: Mon, 31 Oct 2011 07:35:59 -0600
Message-ID: <ACAAFE20-00AB-46BC-BEE4-3BFAA1F0141A@aim.com>
References: <20111031034146.GA19477@gondor.apana.org.au> <201110310023.45138.vapier@gentoo.org> <4EAE9ECB.4040607@redhat.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <dash-owner@vger.kernel.org>
Received: from imr-da01.mx.aol.com ([205.188.105.143]:49193 "EHLO
	imr-da01.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932687Ab1JaNmB convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Mon, 31 Oct 2011 09:42:01 -0400
In-Reply-To: <4EAE9ECB.4040607@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: dash@vger.kernel.org

On Oct 31, 2011, at 07:12, Eric Blake wrote:

> [adding bug-libtool]
>  
[removing, because I'm not registered.]

> On 10/30/2011 10:23 PM, Mike Frysinger wrote:
>> On Sunday 30 October 2011 23:41:58 Herbert Xu wrote:
>>> Mike Frysinger wrote:
>>>> POSIX states that octal escape sequences should take the form \0num
>>>> when using echo.  dash however additionally treats \num as an octal
>>>> sequence.  This breaks some packages (like libtool) who attempt to
>>>> use strings with these escape sequences via variables to execute sed
>>>> (since sed ends up getting passed a byte instead of a literal \1).
>  
> That's a bug in libtool for using "echo '\1'" and expecting sane behavior.  Can you provide more details on this libtool bug, so we can get it fixed in libtool?  Or perhaps it has already been fixed in modern libtool, and you are just encountering it in an older version?
>  
Yes, there's value in coding defensively.  However:

I used to know a statement in POSIX that builtins should behave
identically to the executables in /bin (or perhaps /usr/bin)
except for performance.  So, testing with dash on Ubuntu:

\! $ echo "\1"

\! $ /bin/echo "\1"
\1
\! $ 

I recognize that following this precept would make the behavior
of the builtin "echo" platform-dependent.  But that could be
managed in autoconf.

-- gil

