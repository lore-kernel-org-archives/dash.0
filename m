From: Guido Berhoerster <guido+kernel.org@berhoerster.name>
Subject: Re: [PATCH] Allow == as synonym for = in test
Date: Mon, 7 Mar 2011 18:18:27 +0100
Message-ID: <20110307171827.GB5987@wopr.local.invalid>
References: <E1PwMwp-0001iy-B5@fenris.runbox.com>
 <20110306234845.GC18385@elie>
 <E1PwOzt-0007C2-Qw@fenris.runbox.com>
 <20110307103457.GA5987@wopr.local.invalid>
 <E1Pwbqm-00056z-0V@garm.runbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from multivac.heapoverflow.de ([83.169.16.167]:44619 "EHLO
	multivac.heapoverflow.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab1CGRM0 (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 7 Mar 2011 12:12:26 -0500
Content-Disposition: inline
In-Reply-To: <E1Pwbqm-00056z-0V@garm.runbox.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: "David A. Wheeler" <dwheeler@dwheeler.com>
Cc: dash@vger.kernel.org, jrnieder@gmail.com

* David A. Wheeler <dwheeler@dwheeler.com> [2011-03-07 15:56]:
> Jonathan Nieder:
> > > > dash tends to support features that ash and older
> > > > versions of dash supported (to avoid breaking backward compatibility)
> 
> I said:
> > > Busybox's ash *already* supports "==", so I think that's *also*
> > > an argument for adding "==".
> > >  After all, adding "==" would improve compatibility between
> > > busybox ash and dash, and its effect on space and speed is miniscule.
> 
> Guido Berhoerster:
> > By that argument pretty much every (mis)feature of bash...
> 
> But is "==" a misfeature? I don't think so.

Mind the braces, also my argument was directed more generally
towards adding further non-SUS/POSIX extensions to dash.

> >  can be
> > included into dash because people keep writing scripts assuming
> > /bin/sh == bash which of course will not work on dash.
> 
> That's not the argument I made there; I wasn't talking about bash.
> Jonathan Nieder said that dash "tends to support features [of] ash".
> Busybox ash is *also* an ash, as shown in this family tree:
>   http://www.in-ulm.de/~mascheck/various/ash/
> Busybox ash is an *ash*, it's not *bash*, and dash is lacking a feature
> for compatibility with another *ash*.

There are many variants of ash and some of them are already
incompatible with each other (e.g. the -nt/-ot test operators
that I pointed out in my previous reply). Why should we care
about busybox ash anyway it seems to be the only ash descendant
to implement that, the FreeBSD/NetBSD ones don't.

> 
> > I consider dash's orientation towards POSIX/SUS compliance and
> > lack of support for many extensions a feature...
> > Hence I don't think it is a good idea to add this to
> > dash before it is being standardized.
> 
> Most comments about "==" in the POSIX/SUS group have been positive.  There was only one negative comment that I remember, and it primarily noted that == is not in dash and FreeBSD.  If the POSIX group will never add new capabilities until dash adds them, and dash will never add anything until POSIX adds them, we have a deadlock :-).

I don't think the discussions taking place under the umbrella at
the Austing group would give that much weight to dash as == is a
feature addition of ksh and later bash which are probably in more
widespread use than dash. Besides, if it really was to be part of
an upcoming standard it should of course be added as dash aims
to be a "POSIX-compliant implementation" of the shell.
Note that there are also at least two different "test" variants
used with ash, there is a combined test/expr builtin and
standalone version of the test command included in the ash
sources from 1989 and there are various versions derived from the
pdksh test command which was imported by NetBSD and has spread
from there to FreeBSD and the first the ash Linux port in 1993.

> 
> > and allows one to easily spot bashisms in /bin/sh scripts.
> 
> This is no longer a "bashism", as it's also in ksh and busybox ash at least, and probably others.

Sure, but so are many other features of the test builtins that
come with these shells.
I was generically referring to "bashisms" since the ignorance
in using such non-standard features and constructs while
requesting the /bin/sh interpreter seems to be a particularly
common bad habit among bash users coming from the linux camp
where it often is a symlink to bash (Debian and its derivatives
being the notable exception here). (I'm also not implying that
one should expect /bin/sh to be the POSIX shell.)

> 
> > it makes it easy
> > to extend with later POSIX features without breaking backwards
> > compatibility
> 
> Given how many shells already implement "==" as "=", it's highly improbable that it would ever have a different semantic.  It's hard to make the semantics clearer, in fact: "synonym for =".

In this case that might be correct, however...

> 
> > [I consider the] lack of support for many extensions a feature,
> 
> BusyBox doesn't want lots of options either, yet even their ash supports "==". The page <http://www.busybox.net/about.html> says:
> "BusyBox combines tiny versions of many common UNIX utilities into a single small executable... The utilities in BusyBox generally have fewer options [but] provide the expected functionality...  BusyBox has been written with size-optimization and limited resources in mind."
> 
> There's value in "lean and mean", but this is a few bytes we're talking about, for a feature that is already widely used.

... I was trying to make a more generic argument, in particular
where does one draw the line? What will be added next? There are
surely a lot of scripts that break because they use "[[", and
it's also widely implemented and useful since it doesn't do
pathname expansion and word splitting, that applies to the "<"
and ">" test operators as well etc. etc.

Currently, from what I can see the criteria for including
features in dash seems to have been compliance with POSIX/SUS
specification while simultaneously maintaining backwards
compatibility with custom extensions and I think that has worked
well.
-- 
Guido Berhoerster
