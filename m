From: Guido Berhoerster <gber@opensuse.org>
Subject: Re: [PATCH] Allow == as synonym for = in test
Date: Tue, 8 Mar 2011 19:13:01 +0100
Message-ID: <20110308181301.GD3948@wopr.local.invalid>
References: <E1PwMwp-0001iy-B5@fenris.runbox.com>
 <20110306234845.GC18385@elie>
 <E1PwOzt-0007C2-Qw@fenris.runbox.com>
 <20110307103457.GA5987@wopr.local.invalid>
 <E1Pwbqm-00056z-0V@garm.runbox.com>
 <20110307220048.GE15732@elie>
 <E1PwjSv-0004ZG-3B@fenris.runbox.com>
 <20110308000557.GC5987@wopr.local.invalid>
 <AANLkTinea9rwpq9M70SazaDCJ-usb5HuLeh=+62onYe9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from multivac.heapoverflow.de ([83.169.16.167]:41399 "EHLO
	multivac.heapoverflow.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996Ab1CHSVI (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 8 Mar 2011 13:21:08 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTinea9rwpq9M70SazaDCJ-usb5HuLeh=+62onYe9@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Dan Muresan <danmbox@gmail.com>
Cc: "David A. Wheeler" <dwheeler@dwheeler.com>, dash@vger.kernel.org

* Dan Muresan <danmbox@gmail.com> [2011-03-08 08:17]:
> > The hard work of many Debian maintainers fixing broken shell
> > scripts and pushing these changes upstream is certainly not
> 
> The hardest (and entirely avoidable) work fell on the shoulders of the
> "community" who had scripts break mysteriously without so much as a
> warning from Debian/Ubuntu. People would all of a sudden receive
> errors from well established packages (such as vmware) with absolutely
> no clue as to what was wrong.
> 
> > wasted time but a great service to other platforms as well by
> 
> Wherever Linux goes, bash goes too... except for embedded busyboxy
> systems, where everything is customized by hand anyway.

Well you know, not the whole world revolves around Linux.
And while there are pecularities, writing shell scripts
using IEEE Std 1003.1-2001 as a baseline is a good starting point
for achieving portability since most modern Unix or Unix-like OS
come with a shell that claims to conform to it.

> 
> > improving portability. If you want bash or ksh scripts to work
> > why do you use dash?
> 
> No sane user cares about bash / ksh / *sh in *scripts* -- but once
> sh=bash became a de-facto standard, making a change swiftly and "under
> the radar" was irresponsible. We are not living in an ideal world, and
> I do not wish to debate worthy causes for that inexistent ideal world.

/bin/sh == bash might be common among Linux distros, however in
the real world it is neither a de-facto standard nor guaranteed
to even give you a POSIX-shell. While bash may be available on
most platforms it versions are likely to vary. And since bash
tends to make backwards-incompatible changes even with minor
releases it I don't find it to be the best option for writing
portable scripts.

> > That is a very weak argument as it applies to many such features,
> > the question is whether to create precendent here and where that'll
> 
> I actually tend to agree with this (though I still think it's a
> bikeshed issue). Now that we've paid the price to port scripts to
> dash, why lose the one benefit we ever had?
> 
> Still, I wish dash would spend more effort making sure that everything
> in SUSv3 works *at least as well* as it does in Bash, and less effort
> in debating == vs =. I have had to abandon certain POSIX idioms that
> work well in Bash because dash does not (or did not) support them.
> 
> Note that even when an upgraded dash fixes a bug, the impact on
> distributions lingers on for years: it takes a while for new distros
> to incorporate the new dash, and scripts can't know if they are
> running on "new" or "old" distros. So dash, the now-default /bin/sh,
> should be even more proactive about bugs than a normal package.

In the real world software tends to have bugs, other shells have
bugs, too. Given its resources dash is relatively well-
maintained, bugs reported on this list are getting addressed.

-- 
Guido Berhoerster
