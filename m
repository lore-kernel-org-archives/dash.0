From: Cristian Ionescu-Idbohrn <cristian.ionescu-idbohrn@axis.com>
Subject: Re: Parameter expansion fails when assigning a local variable
Date: Sun, 28 Jun 2009 23:39:16 +0200 (CEST)
Message-ID: <0906282220250.1491@somehost>
References: <A612847CFE53224C91B23E3A5B48BAC73AEC8A9FE8@xmail3.se.axis.com> <20090622085729.GA22431@gondor.apana.org.au>
Reply-To: Cristian Ionescu-Idbohrn <cristian.ionescu-idbohrn@axis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <dash-owner@vger.kernel.org>
Received: from miranda.se.axis.com ([193.13.178.8]:55510 "EHLO
	miranda.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992AbZF1WCO (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 28 Jun 2009 18:02:14 -0400
In-Reply-To: <20090622085729.GA22431@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jesper Bengtsson <jesper.bengtsson@axis.com>, dash@vger.kernel.org

On Mon, 22 Jun 2009, Herbert Xu wrote:

> Jesper Bengtsson <jesper.bengtsson@axis.com> wrote:
> >
> > I've found a problem with expanding $@.
> > If I declare a local variable and assigns the expanded positional
> > parameters:
> >        local v="$@"
> > It fails with something like:
> >        local: 20: \/: bad variable name
>
> This is expected behaviour.

Hmm...  Why is it so?  Because it's the only "natural" expectation?

> local is just like any other utility

Utility?  Not built-in?  Documentation refers to it as command.  Same
thing?

> in how it handled parameters.  So "$@" will have been split before
> it reaches local.  To get what you want, you should use "$*".

But wait a second.  Shouldn't quotes '"' around $@ protect the whole $@?
It does so in different other context.  Why not here?

> > I've tried this on dash 0.5.5.1 and 0.5.3 and both fail in the same way.
> > I've also tried on bash and ash (Busybox) and both handles declaration
> > and assignment on one line.
>
> Bash and older versions of dash (like the one in Busybox) has a hack

Hack.  Is that a hack?  It is not expected behaviour.  It's a hack?
Even newer/recent/latest versions of (busybox) ash have that "hack".
And dash claims to be the only POSIX "true" implementation?

> that disables field splitting for local and certain other
> commands.  This is not guaranteed by POSIX.

Sure.  That's what it looks like.  POSIX doesn't even mention it, does it?
Still.  Quotes around $@ should protect it, shouldn't it?

	local v="$@"

should expand to:

	v="'arg1' 'arg2' ..."

shouldn't it?

There's som parallel unnatural behaviour I noticed:

	local var=$(some forked thing here)

$(...)
^^   ^ doesn't seem to protect the resulting string. There seems to be a
difference between:

	local h=$(grep --help)

and:

	local h="$(grep --help)"

Can anything motivate that?  Is that POSIX too?


Cheers,

-- 
Cristian
