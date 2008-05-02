From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: dash regression against klibc
Date: Fri, 2 May 2008 09:50:10 +0200
Message-ID: <20080502075010.GA19721@uranus.ravnborg.org>
References: <449c10960805011025v675414cco36cb2d6400cc6217@mail.gmail.com> <20080502052530.GA15890@gondor.apana.org.au> <20080502062303.GA16356@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from pasmtpb.tele.dk ([80.160.77.98]:50256 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750910AbYEBHth (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 2 May 2008 03:49:37 -0400
Content-Disposition: inline
In-Reply-To: <20080502062303.GA16356@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Dan McGee <dan@archlinux.org>, dash@vger.kernel.org

On Fri, May 02, 2008 at 02:23:03PM +0800, Herbert Xu wrote:
> On Fri, May 02, 2008 at 01:25:30PM +0800, Herbert Xu wrote:
> >
> > I suspect the problem is klibc's getcwd implementation but this
> > should confirm it for us.
> 
> Actually klibc's getcwd is just fine as it is.  It's dash that's
> relying on glibc extensions of getcwd.
> 
> This patch sould make it work again.
> 
> Cheers,
> -- 
> Visit Openswan at http://www.openswan.org/
> Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
> --
> commit b306b8c58d10c3fa1a34edc22042e4d9b6185f87
> Author: Herbert Xu <herbert@gondor.apana.org.au>
> Date:   Fri May 2 14:20:44 2008 +0800
> 
>     [CD] Restored non-glibc getcwd support
>     
>     These days dash is expected to build with libraries other than
>     glibc so we need to support the old way of calling getcwd again.
>     
>     Thanks to Dan McGee for reporting this bug when dash is built with
>     klibc.
>     
>     Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> diff --git a/ChangeLog b/ChangeLog
> index f5e0dbc..5216521 100644
> --- a/ChangeLog
> +++ b/ChangeLog
> @@ -1,3 +1,7 @@
> +2008-05-02  Herbert Xu <herbert@gondor.apana.org.au>
> +
> +	* Restored non-glibc getcwd support.
> +
>  2008-03-07  Larry Doolittle <ldoolitt@recycle.lbl.gov>
>  
>  	* Fix cmdtxt crash on if statements.
> diff --git a/src/cd.c b/src/cd.c
> index 1849c69..0c2f1ee 100644
> --- a/src/cd.c
> +++ b/src/cd.c
> @@ -241,8 +241,6 @@ updatepwd(const char *dir)
>  }
>  
>  
> -#define MAXPWD 256
> -
>  /*
>   * Find out what the current directory is. If we already know the current
>   * directory, this routine returns immediately.
> @@ -251,8 +249,13 @@ inline
>  STATIC char *
>  getpwd()
>  {
> +#ifdef _GNU_SOURCE
>  	char *dir = getcwd(0, 0);
>  	return dir ? dir : nullstr;
> +#else
> +	char buf[PATH_MAX];
> +	return getcwd(buf, sizeof(buf)) ? savestr(buf) : nullstr;
> +#endif
>  }
If this patch is correct then we leak memory in the glic extension case.
According to man 3 getcwd the memory is allocated and thus should be freed.

Is there a specific reason why you did not use PATH_MAX always
and dropped the use of the extension?

	Sam
