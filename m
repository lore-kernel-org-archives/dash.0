From: Cristian Ionescu-Idbohrn <cristian.ionescu-idbohrn@axis.com>
Subject: Re: Parameter expansion fails when assigning a local variable
Date: Mon, 29 Jun 2009 19:10:29 +0200
Message-ID: <0906291823520.16266@somehost>
References: <A612847CFE53224C91B23E3A5B48BAC73AEC8A9FE8@xmail3.se.axis.com> <20090622085729.GA22431@gondor.apana.org.au> <0906282220250.1491@somehost> <20090629004750.GA2019@gondor.apana.org.au>
Reply-To: Cristian Ionescu-Idbohrn <cristian.ionescu-idbohrn@axis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <dash-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:41152 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751999AbZF2RKk (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 29 Jun 2009 13:10:40 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MLKNO-0005RY-TD
	for dash@vger.kernel.org; Mon, 29 Jun 2009 17:10:42 +0000
Received: from h59ec1d3e.selucle.dyn.perspektivbredband.net ([89.236.29.62])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Mon, 29 Jun 2009 17:10:42 +0000
Received: from cristian.ionescu-idbohrn by h59ec1d3e.selucle.dyn.perspektivbredband.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Mon, 29 Jun 2009 17:10:42 +0000
In-Reply-To: <20090629004750.GA2019@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
Cc: Jesper Bengtsson <jesper.bengtsson@axis.com>, dash@vger.kernel.org

On Mon, 29 Jun 2009, Herbert Xu wrote:

> On Sun, Jun 28, 2009 at 11:39:16PM +0200, Cristian Ionescu-Idbohrn wrote:
> >
> > But wait a second.  Shouldn't quotes '"' around $@ protect the whole
> > $@? It does so in different other context.  Why not here?
>
> The whole point of $@ is to retain field splitting within double
> quotes:

Sure.  Quoted, like "$@".  I've no problem with that.

> > There's some parallel unnatural behaviour I noticed:
> >
> > 	local var=$(some forked thing here)
> >
> > $(...)
> > ^^   ^ doesn't seem to protect the resulting string. There seems to
> > be a difference between:
> >
> > 	local h=$(grep --help)
> >
> > and:
> >
> > 	local h="$(grep --help)"
> >
> > Can anything motivate that?  Is that POSIX too?
>
> As I said local is identical to any other utility in this respect,
> including shell functions.

Ok.  You're telling us how it's implemented in dash.  Other shells do it
different.  Are you implying dash is the only shell which does that thing
right?  Even though it is unnatural?

Let's try something else.  busybox ash and bash are doing the right thing.
dash and zsh got it wrong.  What do people think?

Please consider this example script:

---8<---
#!/bin/dash

set -e
#set -x

func() {
	local i=0 v xx="$@"

	for v; do
		i=$(($i + 1))
		echo "func arg. $i: '$v'"
	done
	echo "inside func: NOONE_SHOULD_TOUCH_THIS=$NOONE_SHOULD_TOUCH_THIS"
}

NOONE_SHOULD_TOUCH_THIS=protected
echo "main, bef. func: NOONE_SHOULD_TOUCH_THIS=$NOONE_SHOULD_TOUCH_THIS"
func "$@"
echo "main, aft. func: NOONE_SHOULD_TOUCH_THIS=$NOONE_SHOULD_TOUCH_THIS"

exit 0
---8<---

and run the script like this:

	$ <script path> abc NOONE_SHOULD_TOUCH_THIS=overwritten

Is it the intended behaviour?  Should one be able to overwrite script
function variables from command line?


Cheers,

-- 
Cristian

