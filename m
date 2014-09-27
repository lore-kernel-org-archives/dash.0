From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: "command -p" does not correctly limit search to a safe PATH
Date: Sat, 27 Sep 2014 23:57:06 +0200
Message-ID: <20140927215706.GA25474@stack.nl>
References: <CAL=-wemDL=2-7Rco761LTgGrFeAA_-zvz0ECpk4xZE7QJsGUEg@mail.gmail.com>
 <51E30212.3030901@gigawatt.nl>
 <51E9B46B.10401@gigawatt.nl>
 <20140926091942.GB14940@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:51284 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753171AbaI0WHI (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 27 Sep 2014 18:07:08 -0400
Content-Disposition: inline
In-Reply-To: <20140926091942.GB14940@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Harald van Dijk <harald@gigawatt.nl>, Craig Loomis <cploomis@gmail.com>, dash <dash@vger.kernel.org>

On Fri, Sep 26, 2014 at 05:19:42PM +0800, Herbert Xu wrote:
> On Fri, Jul 19, 2013 at 09:49:31PM +0000, Harald van Dijk wrote:
> >
> > So, how about this, to be applied on top of my previous patch? It
> > defaults to using confstr() if available and reporting a hard error at
> > run time if that fails, but it can be configured to not use confstr(),
> > and/or fall back to a path specified at configuration time:

> Thanks for the patch.  But until someone who needs this complexity
> steps up, I'm going to stick with the simpler version below:

> [snip]
> diff --git a/src/var.h b/src/var.h
> index 79ee71a..872e2db 100644
> --- a/src/var.h
> +++ b/src/var.h
> @@ -107,7 +107,7 @@ extern const char defifsvar[];
>  extern const char defifs[];
>  #endif
>  extern const char defpathvar[];
> -#define defpath (defpathvar + 5)
> +#define defpath (defpathvar + 36)
>  
>  extern int lineno;
>  extern char linenovar[];

This needs a comment at the definition of defpathvar in var.c;
otherwise, someone changing the default path will subtly break command
-p without knowing. The number 36 is rather magic too, but it can be
found back through git history.

Alternatively, you could rely on the linker combining common string
constant endings: put in some #define for
"/usr/sbin:/usr/bin:/sbin:/bin" and make defpathvar a #define instead of
a const array.

-- 
Jilles Tjoelker
