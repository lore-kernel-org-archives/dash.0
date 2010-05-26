From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: [PATCH 1/4] [VAR] Add localvars nesting
Date: Wed, 26 May 2010 23:55:33 +0200
Message-ID: <20100526215533.GA5679@stack.nl>
References: <20100526105948.GA26352@gondor.apana.org.au>
 <E1OHELf-0006sP-9S@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:56445 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752952Ab0EZVzf (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 26 May 2010 17:55:35 -0400
Content-Disposition: inline
In-Reply-To: <E1OHELf-0006sP-9S@gondolin.me.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org, pape@smarden.org

On Wed, May 26, 2010 at 09:00:31PM +1000, Herbert Xu wrote:
> [VAR] Add localvars nesting

> This patch adds localvars nesting infrastructure so we can reuse
> the localvars mechanism for command evaluation.

localvars could already nest, it's just that this change makes the
nesting explicit instead of on the C stack.

Further comments inline.

> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> ---

>  ChangeLog  |    4 ++++
>  src/eval.c |    7 ++-----
>  src/var.c  |   50 ++++++++++++++++++++++++++++++++++++++++++++------
>  src/var.h  |    1 +
>  4 files changed, 51 insertions(+), 11 deletions(-)

> diff --git a/ChangeLog b/ChangeLog
> index ee78154..7285a23 100644
> --- a/ChangeLog
> +++ b/ChangeLog
> @@ -1,3 +1,7 @@
> +2010-05-24  Herbert Xu <herbert@gondor.apana.org.au>
> +
> +	* Add localvars nesting.
> +
>  2010-05-03  Gerrit Pape <pape@smarden.org>
>  
>  	* Fix command -- crash.
> diff --git a/src/eval.c b/src/eval.c
> index 62d9d5d..8d2767c 100644
> --- a/src/eval.c
> +++ b/src/eval.c
> @@ -928,20 +928,17 @@ STATIC int
>  evalfun(struct funcnode *func, int argc, char **argv, int flags)
>  {
>  	volatile struct shparam saveparam;
> -	struct localvar *volatile savelocalvars;
>  	struct jmploc *volatile savehandler;
>  	struct jmploc jmploc;
>  	int e;
>  
>  	saveparam = shellparam;
> -	savelocalvars = localvars;
>  	if ((e = setjmp(jmploc.loc))) {
>  		goto funcdone;
>  	}
>  	INTOFF;
>  	savehandler = handler;
>  	handler = &jmploc;
> -	localvars = NULL;
>  	shellparam.malloc = 0;
>  	func->count++;
>  	funcnest++;
> @@ -950,13 +947,13 @@ evalfun(struct funcnode *func, int argc, char **argv, int flags)
>  	shellparam.p = argv + 1;
>  	shellparam.optind = 1;
>  	shellparam.optoff = -1;
> +	pushlocalvars();
>  	evaltree(&func->n, flags & EV_TESTED);
> +	poplocalvars();
>  funcdone:
>  	INTOFF;
>  	funcnest--;
>  	freefunc(func);
> -	poplocalvars();
> -	localvars = savelocalvars;
>  	freeparam(&shellparam);
>  	shellparam = saveparam;
>  	handler = savehandler;

This change does not do poplocalvars() if the function was exited with
an error. While this is normally not a problem because the shell exits
or executes the RESET actions, 'command eval', 'command .' and 'fc' will
"catch" any errors and continue normally.

Example (with the below "disallow local outside a function" change):
  dash -c 'f() { unset xyz; ${xyz?}; }; command eval f; local i'

> diff --git a/src/var.c b/src/var.c
> index 2737fb1..de1a5f5 100644
> [...]
> @@ -446,6 +456,9 @@ localcmd(int argc, char **argv)
>  {
>  	char *name;
>  
> +	if (!localvar_stack)
> +		sh_error("not in a function");
> +
>  	argv = argptr;
>  	while ((name = *argv++) != NULL) {
>  		mklocal(name);

This change (failing local outside functions), while a good idea, should
be mentioned in the commit message/changelog, as it might break certain
scripts.

(Note that in mksh local is an alias for typeset, which will work
outside functions.)

-- 
Jilles Tjoelker
