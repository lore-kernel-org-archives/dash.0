From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: (fwd) dash fix for job control off warning
Date: Fri, 2 Apr 2010 22:42:20 +0800
Message-ID: <20100402144220.GB31158@gondor.apana.org.au>
References: <20100402143220.GC6199@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:34186 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756469Ab0DBOmZ (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 2 Apr 2010 10:42:25 -0400
Content-Disposition: inline
In-Reply-To: <20100402143220.GC6199@stro.at>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: maximilian attems <max@stro.at>
Cc: dash@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, klibc@zytor.com

On Fri, Apr 02, 2010 at 04:32:20PM +0200, maximilian attems wrote:
>
> Pulled this; there seems to be a problem with the new version of dash
> with job control off.  I can't tell if it is just a warning or is a
> manifest bug.
> 
> The solution is simple:
> 
> --- a/usr/dash/jobs.h
> +++ b/usr/dash/jobs.h
> @@ -105,5 +105,5 @@ int waitforjob(struct job *);
>  int stoppedjobs(void);
> 
>  #if ! JOBS
> -#define setjobctl(on)  /* do nothing */
> +#define setjobctl(on) ((void)(on))     /* do nothing */
>  #endif
> 
> ... to keep the code syntactically valid even when setjobctl() is used
> as the body of an if statement.

So when exactly is this needed? Can you give an example?

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
