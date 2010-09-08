From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: dash klibc DEBUG more compile trouble
Date: Wed, 8 Sep 2010 21:09:57 +0200
Message-ID: <20100908190957.GA13836@merkur.ravnborg.org>
References: <20100709144330.GA23188@stro.at> <20100710221518.GA9154@gondor.apana.org.au> <20100908162017.GB27278@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from pqueuea.post.tele.dk ([193.162.153.9]:47046 "EHLO
	pqueuea.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041Ab0IHTKR (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 8 Sep 2010 15:10:17 -0400
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
	by pqueuea.post.tele.dk (Postfix) with ESMTP id B9774DBB63
	for <dash@vger.kernel.org>; Wed,  8 Sep 2010 21:10:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100908162017.GB27278@stro.at>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: maximilian attems <max@stro.at>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org, klibc@zytor.com

On Wed, Sep 08, 2010 at 06:20:17PM +0200, maximilian attems wrote:
> On Sun, 11 Jul 2010, Herbert Xu wrote:
> 
> > maximilian attems <max@stro.at> wrote:
> > > once taken that stat/stat64 appart, histedit appears to be a minefield:
> > 
> > Unless you have libedit, you're supposed to define SMALL.
> 
> indeed we do define it, but it was due to my poor Kconfig foo
> that it gets undefined again on debug compile run.
> thanks Herbert for aboves comment, helped out.
> 
> so compiling klibc with
>  make   KLIBCKERNELSRC=`pwd`/../linux-2.6 EXTRA_KLIBCCFLAGS="-DDEBUG=1 " V=1
> 
> is either wrong or the klibc Kbuild is buggy as it undefines the Kbuild
> specific entries in the subdirs.

It is wrong...
When you specify an variable on the commandline like in this
case you do with EXTRA_KLIBCCFLAGS=... then make will use the value
you assign to the variable rather than the value that is assigned
in the makefile.

So you actually overwrite the variable EXTRA_KLIBCCFLAGS, where you
expected to append to it.

I took a quick look at the kbuild stuff in klibc - and
there does not seem to be any way to pass extra flags on the commandline.

Except that you can say:

make CC="gcc -DDEBUG=1"

But I did not test this.

	Sam
