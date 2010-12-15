From: Cristian Ionescu-Idbohrn <cristian.ionescu-idbohrn@axis.com>
Subject: Re: read() builtin doesnt read integer value /proc files (but bashs
 does)
Date: Wed, 15 Dec 2010 20:12:35 +0100 (CET)
Message-ID: <1012152002160.15865@somehost>
References: <AANLkTinTd+29=8EkiTKptoE8nnVphcQ_TW=ezS99LmWw@mail.gmail.com> <AANLkTi=ZcNYJKCO_FM0RpJndwAgtzTU_C8J=9BsfmdAk@mail.gmail.com> <20100903212504.GA86276@stack.nl> <AANLkTi=d_13RCDhJHE_23BXN5Tf2RY_2e3rED7JwtFOK@mail.gmail.com> <20100904193504.GA3357@stack.nl>
 <20101128084219.GC8818@gondor.apana.org.au> <1012151034250.15865@somehost> <20101215185551.GA22905@burratino>
Reply-To: Cristian Ionescu-Idbohrn <cristian.ionescu-idbohrn@axis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <dash-owner@vger.kernel.org>
Received: from ra.se.axis.com ([195.60.68.13]:48739 "EHLO ra.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754851Ab0LOTMh (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 15 Dec 2010 14:12:37 -0500
In-Reply-To: <20101215185551.GA22905@burratino>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: 595063@bugs.debian.org

Jonathan,

On Wed, 15 Dec 2010, Jonathan Nieder wrote:
> Cristian Ionescu-Idbohrn wrote:
> > On Sun, 28 Nov 2010, Herbert Xu wrote:
> >>
> >> I'm with Jilles on this.  I also don't particularly feel like
> >> bloating dash just because of the borked /proc interface when
> >> there is a perfectly adequate work-around in "cat".
> >>
> >> 	value=$(cat /proc/file)
> >
> > I wouldn't call that "a perfectly adequate work-around", but a painful
> > and unadequate work-around.
>
> This works in /proc because files in /proc are seekable.
>
> That said, I don't think borked /proc is a great reason to do this
> (it's a better reason to fix /proc).  Speeding up the read builtin
> might be a good reason.

Right.  So, there are 2 options here.  One is to to make dash work like
bash on a proc filesystem, the other to "fix" the kernel.

How many linux distributions depend on a "working" dash?
Which alternative is the more realistic one?
What are the ETAs odds?
How do we proceed?


Cheers,

-- 
Cristian
