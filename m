From: Cristian Ionescu-Idbohrn <cristian.ionescu-idbohrn@axis.com>
Subject: Re: read() builtin doesnt read integer value /proc files (but bashs
 does)
Date: Wed, 15 Dec 2010 10:49:30 +0100 (CET)
Message-ID: <1012151034250.15865@somehost>
References: <AANLkTinTd+29=8EkiTKptoE8nnVphcQ_TW=ezS99LmWw@mail.gmail.com> <AANLkTi=ZcNYJKCO_FM0RpJndwAgtzTU_C8J=9BsfmdAk@mail.gmail.com> <20100903212504.GA86276@stack.nl> <AANLkTi=d_13RCDhJHE_23BXN5Tf2RY_2e3rED7JwtFOK@mail.gmail.com> <20100904193504.GA3357@stack.nl>
 <20101128084219.GC8818@gondor.apana.org.au>
Reply-To: Cristian Ionescu-Idbohrn <cristian.ionescu-idbohrn@axis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <dash-owner@vger.kernel.org>
Received: from anubis.se.axis.com ([195.60.68.12]:49959 "EHLO
	anubis.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289Ab0LOJtd (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 15 Dec 2010 04:49:33 -0500
In-Reply-To: <20101128084219.GC8818@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org, 595063@bugs.debian.org

On Sun, 28 Nov 2010, Herbert Xu wrote:
> On Sat, Sep 04, 2010 at 07:35:04PM +0000, Jilles Tjoelker wrote:
> >
> > > I attached an updated patch that corrects this pb by discarding the
> > > buffer when opening a new file.
> >
> > This discarding is still bad as it throws away valid data if the open
> > file description is shared. This happens if stdin is redirected inside a
>
> I'm with Jilles on this.  I also don't particularly feel like
> bloating dash just because of the borked /proc interface when
> there is a perfectly adequate work-around in "cat".
>
> 	value=$(cat /proc/file)

I wouldn't call that "a perfectly adequate work-around", but a painful and
unadequate work-around.  And this example will hopefully show why:

$ dash -c 'loops=10000; while [ $loops -gt 0 ];do read MAX
</proc/sys/kernel/pid_max; loops=$(($loops - 1)); done; times'
0m0.180000s 0m0.100000s
0m0.000000s 0m0.000000s

total: 0.28s

$ dash -c 'loops=10000; while [ $loops -gt 0 ];do MAX=$(cat
/proc/sys/kernel/pid_max); loops=$(($loops - 1)); done; times'
0m0.280000s 0m1.330000s
0m3.840000s 0m1.560000s

total: 7.01s

That is, the first example is 24x more efficient than the second.  And
that realy _matters_, I would say.


Cheers,

-- 
Cristian
