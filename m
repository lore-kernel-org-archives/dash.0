From: Cristian Ionescu-Idbohrn <cristian.ionescu-idbohrn@axis.com>
Subject: Re: Parameter expansion fails when assigning a local variable
Date: Tue, 30 Jun 2009 18:17:50 +0200 (CEST)
Message-ID: <0906301817190.14361@somehost>
References: <A612847CFE53224C91B23E3A5B48BAC73AEC8A9FE8@xmail3.se.axis.com> <20090622085729.GA22431@gondor.apana.org.au> <0906282220250.1491@somehost> <20090629004750.GA2019@gondor.apana.org.au> <0906291823520.16266@somehost>
 <20090630013807.GA13339@gondor.apana.org.au>
Reply-To: Cristian Ionescu-Idbohrn <cristian.ionescu-idbohrn@axis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <dash-owner@vger.kernel.org>
Received: from [193.13.178.8] ([193.13.178.8]:39273 "EHLO miranda.se.axis.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754824AbZF3QSY (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 30 Jun 2009 12:18:24 -0400
In-Reply-To: <20090630013807.GA13339@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jesper Bengtsson <jesper.bengtsson@axis.com>, dash@vger.kernel.org

On Tue, 30 Jun 2009, Herbert Xu wrote:

> On Mon, Jun 29, 2009 at 07:10:29PM +0200, Cristian Ionescu-Idbohrn wrote:
> >
> > Please consider this example script:
> >
> > ---8<---
> > #!/bin/dash
> >
> > set -e
> > #set -x
> >
> > func() {
> > 	local i=0 v xx="$@"
> >
> > 	for v; do
> > 		i=$(($i + 1))
> > 		echo "func arg. $i: '$v'"
> > 	done
> > 	echo "inside func: NOONE_SHOULD_TOUCH_THIS=$NOONE_SHOULD_TOUCH_THIS"
> > }
> >
> > NOONE_SHOULD_TOUCH_THIS=protected
> > echo "main, bef. func: NOONE_SHOULD_TOUCH_THIS=$NOONE_SHOULD_TOUCH_THIS"
> > func "$@"
> > echo "main, aft. func: NOONE_SHOULD_TOUCH_THIS=$NOONE_SHOULD_TOUCH_THIS"
> >
> > exit 0
> > ---8<---
> >
> > and run the script like this:
> >
> > 	$ <script path> abc NOONE_SHOULD_TOUCH_THIS=overwritten
> >
> > Is it the intended behaviour?  Should one be able to overwrite script
> > function variables from command line?
>
> As I said, you should be using "$*" instead of "$@" which is
> designed exactly for this purpose and is completely portable.

Sure I will.  But that won't make the misfeature go away :(

And, by the way, I think the bug should probably be classified as a design
flaw and a security bug.  Reason is it has undesired side effects which
may lead to overwriting unrelated local variables and may have other
serious implications.


Cheers,

-- 
Cristian
