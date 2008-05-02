From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: dash regression against klibc
Date: Fri, 2 May 2008 17:53:40 +0800
Message-ID: <20080502095340.GA17407@gondor.apana.org.au>
References: <449c10960805011025v675414cco36cb2d6400cc6217@mail.gmail.com> <20080502052530.GA15890@gondor.apana.org.au> <20080502062303.GA16356@gondor.apana.org.au> <20080502075010.GA19721@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:46280 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752482AbYEBJxp (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 2 May 2008 05:53:45 -0400
Content-Disposition: inline
In-Reply-To: <20080502075010.GA19721@uranus.ravnborg.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Dan McGee <dan@archlinux.org>, dash@vger.kernel.org

On Fri, May 02, 2008 at 09:50:10AM +0200, Sam Ravnborg wrote:
>
> > @@ -251,8 +249,13 @@ inline
> >  STATIC char *
> >  getpwd()
> >  {
> > +#ifdef _GNU_SOURCE
> >  	char *dir = getcwd(0, 0);
> >  	return dir ? dir : nullstr;
> > +#else
> > +	char buf[PATH_MAX];
> > +	return getcwd(buf, sizeof(buf)) ? savestr(buf) : nullstr;
> > +#endif
> >  }
> If this patch is correct then we leak memory in the glic extension case.
> According to man 3 getcwd the memory is allocated and thus should be freed.

If we leaked memory in the glibc case then we'd also leak in the
other one because savestr is dash's version of strdup.  But we
don't because the caller is responsible for freeing it.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
