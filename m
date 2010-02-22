From: Guido Berhoerster <guido+kernel.org@berhoerster.name>
Subject: Re: test -nt/-ot behavior
Date: Mon, 22 Feb 2010 11:33:53 +0100
Message-ID: <20100222103353.GA9924@wopr.local.invalid>
References: <20100221122100.GA9005@wopr.local.invalid>
 <20100222065043.GA28401@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from multivac.heapoverflow.de ([83.169.16.167]:35919 "EHLO
	multivac.heapoverflow.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830Ab0BVKbX (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 22 Feb 2010 05:31:23 -0500
Content-Disposition: inline
In-Reply-To: <20100222065043.GA28401@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org

* Herbert Xu <herbert@gondor.apana.org.au> [2010-02-22 07:50]:
> Guido Berhoerster <guido+kernel.org@berhoerster.name> wrote:
> > 
> > It should be noted that pdksh contains many other subtle
> > differences and is not really compatible to either ksh88 or
> > ksh93, the behavior introduced by the test builtin of earlier
> > pdksh versions is likely due to a misunderstanding of ksh88's
> > specified behavior which was later fixed.  So IMHO the
> > consequence for ash should be to either merge the fix from pdksh
> > or to drop -nt, -ot, and -ef altogether, I would prefer that
> > latter since I think silently changing the behavior in an
> > incompatible way is bad practice and these features are not
> > specified in POSIX anyway.
> 
> Well, as you say the behaviour is not specified by POSIX so dash
> isn't doing anything wrong per se.  As this has been the documented
> behaviour within dash since forever I'm reluctant to change it or
> for that matter, removing the feature entirely.

It is not doing something "wrong", but my point (and that of the
original reporter of
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=558989) is that
it is diverging from established behavior in widely used shells
such a ksh88, ksh93, bash, pdksh, and GNU userland, as I said
this was even fixed in pdksh where it originally came from.  I
don't know how many /bin/dash scripts there are which rely on
this behavior from test -nt/-ot but it can't be that many and
dash has only been called das since 2002.  On the other hand dash
is being widely used as /bin/sh, e.g. in Ubuntu, Debian, and
hopefully soon openSUSE.

Changing the behavior as pdksh did after ten years is certainly
not a good practice but removing it will lead to an clear error
message rather than unexpected behavior which would be an
advantage when dealing with scripts expecting -nt/-ot but using
/bin/sh. For this reason alone I'm inclined to patch this out on
openSUSE.

If dash aims to be a POSIX compliant /bin/sh which is "as small
as possible", why does it need test -nt/-ot/-ef at all?  BTW, why
did you go with pdksh's test instead of the one coming with ash?

-- 
Guido Berhoerster
