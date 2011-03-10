From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] Improved LINENO support
Date: Thu, 10 Mar 2011 16:10:27 +0800
Message-ID: <20110310081027.GA10360@gondor.apana.org.au>
References: <4CD85E90.6000308@gigawatt.nl> <20101110220008.GC17871@stack.nl> <4CDD8481.1060306@gigawatt.nl> <4CDD8908.9010206@redhat.com> <4CDD9095.5070106@gigawatt.nl> <20101112212932.GB57806@stack.nl> <4CF1380D.8000509@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:47033 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810Ab1CJIKc (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 10 Mar 2011 03:10:32 -0500
Content-Disposition: inline
In-Reply-To: <4CF1380D.8000509@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: dash@vger.kernel.org, Jilles Tjoelker <jilles@stack.nl>

On Sat, Nov 27, 2010 at 04:56:17PM +0000, Harald van Dijk wrote:
>
> Again, comments are welcome.

Thanks for working on this! Just a few minor problems to correct.
Oh and please add a changelog + sign-off.

> diff --git a/src/eval.c b/src/eval.c
> index b966749..d85f66f 100644
> --- a/src/eval.c
> +++ b/src/eval.c
> @@ -73,7 +73,7 @@
>  int evalskip;			/* set if we are skipping commands */
>  STATIC int skipcount;		/* number of levels to skip */
>  MKINIT int loopnest;		/* current loop nesting level */
> -static int funcnest;		/* depth of function calls */
> +STATIC int funcline;		/* starting line number of current function, or 0 if not in a function */

Please don't add any new uses of STATIC.  I'm fine with leaving
existing ones in place though.

> @@ -730,7 +749,7 @@ evalcommand(union node *cmd, int flags)
>  	*nargv = NULL;
>  
>  	lastarg = NULL;
> -	if (iflag && funcnest == 0 && argc > 0)
> +	if (iflag && funcline == 0 && argc > 0)
>  		lastarg = nargv[-1];

I like this bit :)

> diff --git a/src/exec.c b/src/exec.c
> index 42299ea..959b9f4 100644
> --- a/src/exec.c
> +++ b/src/exec.c
> @@ -688,14 +688,14 @@ addcmdentry(char *name, struct cmdentry *entry)
>   */
>  
>  void
> -defun(char *name, union node *func)
> +defun(union node *func)
>  {
>  	struct cmdentry entry;
>  
>  	INTOFF;
>  	entry.cmdtype = CMDFUNCTION;
>  	entry.u.func = copyfunc(func);
> -	addcmdentry(name, &entry);
> +	addcmdentry(func->ndefun.text, &entry);
>  	INTON;
>  }

Please separate out unrelated changes like this into distinct
patches.

> @@ -329,6 +333,9 @@ lookupvar(const char *name)
>  	struct var *v;
>  
>  	if ((v = *findvar(hashvar(name), name)) && !(v->flags & VUNSET)) {
> +		if (v == &vlineno && v->text == linenovar) {
> +			sprintf(linenoval(), "%d", lineno);
> +		}

Please use fmtstr instead of sprintf for consistency.

Cheers,
--
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
