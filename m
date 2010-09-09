From: maximilian attems <max@stro.at>
Subject: Re: dash klibc DEBUG more compile trouble
Date: Thu, 9 Sep 2010 09:45:13 +0200
Message-ID: <20100909074512.GB19138@baikonur.stro.at>
References: <20100709144330.GA23188@stro.at> <20100710221518.GA9154@gondor.apana.org.au> <20100908162017.GB27278@stro.at> <20100908190957.GA13836@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:45217 "EHLO
	baikonur.stro.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311Ab0IIHzH (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 9 Sep 2010 03:55:07 -0400
Content-Disposition: inline
In-Reply-To: <20100908190957.GA13836@merkur.ravnborg.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org, klibc@zytor.com

hello Sam,


On Wed, Sep 08, 2010 at 09:09:57PM +0200, Sam Ravnborg wrote:
> On Wed, Sep 08, 2010 at 06:20:17PM +0200, maximilian attems wrote:
<snipp>
> > 
> > so compiling klibc with
> >  make   KLIBCKERNELSRC=`pwd`/../linux-2.6 EXTRA_KLIBCCFLAGS="-DDEBUG=1 " V=1
> > 
> > is either wrong or the klibc Kbuild is buggy as it undefines the Kbuild
> > specific entries in the subdirs.
> 
> It is wrong...
> When you specify an variable on the commandline like in this
> case you do with EXTRA_KLIBCCFLAGS=... then make will use the value
> you assign to the variable rather than the value that is assigned
> in the makefile.
> 
> So you actually overwrite the variable EXTRA_KLIBCCFLAGS, where you
> expected to append to it.

indeed thanks for the explanations.
 
> I took a quick look at the kbuild stuff in klibc - and
> there does not seem to be any way to pass extra flags on the commandline.
> 
> Except that you can say:
> 
> make CC="gcc -DDEBUG=1"
> 
> But I did not test this.

this works indeed, thanks for the hint. :)

-- 
maks

