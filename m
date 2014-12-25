From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: Possibly wrong handling of $_?
Date: Thu, 25 Dec 2014 15:32:26 +0100
Message-ID: <20141225143226.GA27266@stack.nl>
References: <E1Y3Y2d-000276-SL@smtp.tt-solutions.com>
 <5499F8E5.205@gigawatt.nl>
 <E1Y3YxI-0004Qg-GA@smtp.tt-solutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:65191 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752034AbaLYOc3 (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 25 Dec 2014 09:32:29 -0500
Content-Disposition: inline
In-Reply-To: <E1Y3YxI-0004Qg-GA@smtp.tt-solutions.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Vadim Zeitlin <vz-dash@zeitlins.org>
Cc: dash@vger.kernel.org, Harald van Dijk <harald@gigawatt.nl>

On Wed, Dec 24, 2014 at 12:33:32AM +0100, Vadim Zeitlin wrote:
> On Wed, 24 Dec 2014 00:21:09 +0100 Harald van Dijk <harald@gigawatt.nl> wrote:

> HvD> On 23/12/2014 23:34, Vadim Zeitlin wrote:
> HvD> >   Hello,
> HvD> >
> HvD> >   I'm not exactly sure if this is a bug because I didn't find any
> HvD> > specification about how is this supposed to behave (to my surprise it
> HvD> > turned out that $_ was not in POSIX), but please consider this:
> HvD> >
> HvD> > 	% zsh -c 'echo -n foo && echo $_'
> HvD> > 	foofoo
> HvD> > 	% bash -c 'echo -n foo && echo $_'
> HvD> > 	foofoo
> HvD> > 	% dash -c 'echo -n foo && echo $_'
> HvD> > 	foo/usr/bin/dash
> HvD> 
> HvD> This does come across as somewhat confusing, but $_ is really not a 
> HvD> special variable at all in dash.

>  Ah, this does explain it, thanks!

Dash does implement $_, but only in interactive mode.

Your selection of shells makes it appear as if dash is the odd one out,
but in fact it is not. FreeBSD /bin/sh (also an Almquist shell
derivative), mksh and ksh93 also only implement $_ in interactive mode.
Details of how $_ differ as well, particularly in ksh93. It seems unwise
to use this feature in scripts.

> HvD> If dash did something special with $_, then I agree it would be nice if 
> HvD> it would be somewhat compatible with other shells. If dash simply does 
> HvD> not implement a feature, that feature is not required by any standard, 
> HvD> and that feature is not widely used, then I suspect there won't be a lot 
> HvD> of interest in implementing that feature.

>  Yes, I understand, somehow the idea that dash didn't implement it at all
> just didn't occur to me, but clearly adding a non-standard new feature is
> not nowhere near as important as fixing [what looked like] a bug. I'm not
> sure about the "not widely part", but I don't have any non-anecdotal
> evidence one way or the other.

> HvD> Don't be put off by that, though. You are free, of course, if you feel 
> HvD> so, to attempt to convince people $_ is an important feature that all 
> HvD> shells should implement. If you have compelling use cases, if it solves 
> HvD> real problems, and if many other shells already implement it, you might 
> HvD> even get it standardised. I have never seen a need for it, but that's 
> HvD> just me speaking from personal experience, others may feel differently.

>  FWIW my initial problem started with using

> 	builddir := $(shell mkdir -p some-long-make-expression && echo $_)

> in a makefile, which seemed like a nice way to assign the value to the
> variable only if the directory was successfully created. This can, of
> course, be done in a myriad of other ways, but this one just seemed like
> the most elegant to me. Whether this counts as a "need" or not is not for
> me to say.

>  Personally I'd say the main argument for adding support for "$_" to dash
> would be to avoid mysterious problems like the one I just had because dash
> silently (i.e. without giving any errors) behaves differently from the
> other shells, which in my case resulted in the makefile misbehaving only
> under Debian (where dash is used as /bin/sh) but not under systems.

Such a principle of least surprise is not a design goal for dash.

-- 
Jilles Tjoelker
