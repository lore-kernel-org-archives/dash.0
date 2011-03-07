From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: [PATCH] Allow == as synonym for = in test
Date: Mon, 07 Mar 2011 09:55:55 -0500 (EST)
Message-ID: <E1Pwbqm-00056z-0V@garm.runbox.com>
References: <E1PwMwp-0001iy-B5@fenris.runbox.com>
 <20110306234845.GC18385@elie> <E1PwOzt-0007C2-Qw@fenris.runbox.com>
 <20110307103457.GA5987@wopr.local.invalid>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <dash-owner@vger.kernel.org>
Received: from aibo.runbox.com ([87.238.52.70]:34815 "EHLO aibo.runbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814Ab1CGOz7 convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Mon, 7 Mar 2011 09:55:59 -0500
Content-Disposition: inline
In-Reply-To: <20110307103457.GA5987@wopr.local.invalid>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: jrnieder@gmail.com, guido+kernel.org@berhoerster.name

Jonathan Nieder:
> > > dash tends to support features that ash and older
> > > versions of dash supported (to avoid breaking backward compatibility)

I said:
> > Busybox's ash *already* supports "==", so I think that's *also*
> > an argument for adding "==".
> >  After all, adding "==" would improve compatibility between
> > busybox ash and dash, and its effect on space and speed is miniscule.

Guido Berhoerster:
> By that argument pretty much every (mis)feature of bash...

But is "==" a misfeature? I don't think so.

>  can be
> included into dash because people keep writing scripts assuming
> /bin/sh == bash which of course will not work on dash.

That's not the argument I made there; I wasn't talking about bash.
Jonathan Nieder said that dash "tends to support features [of] ash".
Busybox ash is *also* an ash, as shown in this family tree:
  http://www.in-ulm.de/~mascheck/various/ash/
Busybox ash is an *ash*, it's not *bash*, and dash is lacking a feature
for compatibility with another *ash*.

> I consider dash's orientation towards POSIX/SUS compliance and
> lack of support for many extensions a feature...
> Hence I don't think it is a good idea to add this to
> dash before it is being standardized.

Most comments about "==" in the POSIX/SUS group have been positive.  There was only one negative comment that I remember, and it primarily noted that == is not in dash and FreeBSD.  If the POSIX group will never add new capabilities until dash adds them, and dash will never add anything until POSIX adds them, we have a deadlock :-).

> and allows one to easily spot bashisms in /bin/sh scripts.

This is no longer a "bashism", as it's also in ksh and busybox ash at least, and probably others.

> it makes it easy
> to extend with later POSIX features without breaking backwards
> compatibility

Given how many shells already implement "==" as "=", it's highly improbable that it would ever have a different semantic.  It's hard to make the semantics clearer, in fact: "synonym for =".

> [I consider the] lack of support for many extensions a feature,

BusyBox doesn't want lots of options either, yet even their ash supports "==". The page <http://www.busybox.net/about.html> says:
"BusyBox combines tiny versions of many common UNIX utilities into a single small executable... The utilities in BusyBox generally have fewer options [but] provide the expected functionality...  BusyBox has been written with size-optimization and limited resources in mind."

There's value in "lean and mean", but this is a few bytes we're talking about, for a feature that is already widely used.

--- David A. Wheeler
