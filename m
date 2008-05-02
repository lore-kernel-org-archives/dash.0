From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: dash regression against klibc
Date: Fri, 2 May 2008 12:30:49 +0200
Message-ID: <20080502103049.GA20741@uranus.ravnborg.org>
References: <449c10960805011025v675414cco36cb2d6400cc6217@mail.gmail.com> <20080502052530.GA15890@gondor.apana.org.au> <20080502062303.GA16356@gondor.apana.org.au> <20080502075010.GA19721@uranus.ravnborg.org> <20080502095340.GA17407@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from pasmtpa.tele.dk ([80.160.77.114]:52068 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758053AbYEBKaQ (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 2 May 2008 06:30:16 -0400
Content-Disposition: inline
In-Reply-To: <20080502095340.GA17407@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Dan McGee <dan@archlinux.org>, dash@vger.kernel.org

On Fri, May 02, 2008 at 05:53:40PM +0800, Herbert Xu wrote:
> On Fri, May 02, 2008 at 09:50:10AM +0200, Sam Ravnborg wrote:
> >
> > > @@ -251,8 +249,13 @@ inline
> > >  STATIC char *
> > >  getpwd()
> > >  {
> > > +#ifdef _GNU_SOURCE
> > >  	char *dir = getcwd(0, 0);
> > >  	return dir ? dir : nullstr;
> > > +#else
> > > +	char buf[PATH_MAX];
> > > +	return getcwd(buf, sizeof(buf)) ? savestr(buf) : nullstr;
> > > +#endif
> > >  }
> > If this patch is correct then we leak memory in the glic extension case.
> > According to man 3 getcwd the memory is allocated and thus should be freed.
> 
> If we leaked memory in the glibc case then we'd also leak in the
> other one because savestr is dash's version of strdup.  But we
> don't because the caller is responsible for freeing it.

OK, thanks for the explanation!

	Sam
