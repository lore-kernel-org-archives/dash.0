From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: trap bug in recent versions of dash
Date: Mon, 23 Aug 2010 22:11:07 +0200
Message-ID: <20100823201107.GB67671@stack.nl>
References: <20100811080616.GA18303@wopr.local.invalid>
 <20100815200551.GA19150@stack.nl>
 <20100816115154.GB11790@wopr.local.invalid>
 <20100822223227.GA49760@stack.nl>
 <20100823103617.GA9302@wopr.local.invalid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:51269 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751107Ab0HWULI (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 23 Aug 2010 16:11:08 -0400
Received: from turtle.stack.nl (turtle.stack.nl [IPv6:2001:610:1108:5010::132])
	by mx1.stack.nl (Postfix) with ESMTP id 742991DD659
	for <dash@vger.kernel.org>; Mon, 23 Aug 2010 22:11:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100823103617.GA9302@wopr.local.invalid>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

On Mon, Aug 23, 2010 at 12:40:48PM +0200, Guido Berhoerster wrote:
> * Jilles Tjoelker <jilles@stack.nl> [2010-08-23 00:32]:
> > If you want to try something, here is a patch. I have verified that the
> > only change to the results of FreeBSD sh's testsuite is that the test
> > builtins/break2.0 starts working (there are still 51 other broken
> > tests). There is no change in output from the posh testsuite (run with
> >   -C sh,posix,no-typeset,no-arrays,no-coprocs,no-herestrings,no-history
> > ).

> > diff --git a/src/eval.c b/src/eval.c
> > index d5e5c95..e484bec 100644
> > --- a/src/eval.c
> > +++ b/src/eval.c
> > @@ -307,9 +307,9 @@ setstatus:
> >  		break;
> >  	}
> >  out:
> > -	if ((checkexit & exitstatus) ||
> > -	    (pendingsigs && dotrap()) ||
> > -	    (flags & EV_EXIT))
> > +	if (pendingsigs)
> > +		dotrap();
> > +	if ((flags & EV_EXIT) || (checkexit & exitstatus))
> >  		exraise(EXEXIT);
> >  }

> Unfortunately this seems to corrupt variables.
> See the attached test script, after the TERM signal $value
> is not empty anymore but contains garbage.

I think this is the same strange bug as Harald van Dijk reported. The
below gives incorrect output, and quoting the command substitution works
around the issue:

dash -c 'printf "a\t\tb\n" | { IFS=$(printf "\t") read a b c; echo "|$a|$b|$c|"; }'

In your script, if I write  read "$2"  instead of  read $2  it works.

> Where can I find FreeBSD's sh tests?

You need the tools/regression/bin/sh directory from the head (cvs: HEAD)
branch of the FreeBSD src repository. See
http://www.freebsd.org/developers/cvs.html for access methods. There are
also unofficial git, hg and other mirrors if you prefer that.

The tests are designed to run under perl's prove(1) tool.

The tests test the first instance of "sh" in the PATH. To test other
shells, create a symlink named sh in a new directory and add that
directory in front of your PATH. This is a little clumsy but also
ensures bash and zsh enable their compatibility modes.

-- 
Jilles Tjoelker
