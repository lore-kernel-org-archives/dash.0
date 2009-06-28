From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Debian Bug#429251: [PATCH] honor tab as IFS whitespace when
	splitting fields
Date: Sun, 28 Jun 2009 12:19:02 +0800
Message-ID: <20090628041902.GA27613@gondor.apana.org.au>
References: <200905302233.05407.stefan.potyra@informatik.uni-erlangen.de> <20090610054845.GA17111@gondor.apana.org.au> <200906100953.37597.stefan.potyra@informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:56988 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751015AbZF1ETE (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 28 Jun 2009 00:19:04 -0400
Content-Disposition: inline
In-Reply-To: <200906100953.37597.stefan.potyra@informatik.uni-erlangen.de>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Stefan Potyra <stefan.potyra@informatik.uni-erlangen.de>
Cc: dash@vger.kernel.org

On Wed, Jun 10, 2009 at 09:53:34AM +0200, Stefan Potyra wrote:
>
> Of course, here you are.

Awesome! The patch looks pretty good in general.  There are just
a few minor issues that we need to fix.

> +static void
> +readcmd_handle_line(char *line, char **ap)
> +{
> +	struct arglist arglist;
> +	struct strlist *sl;
> +	char *s, *backup;
> +
> +	/* ifsbreakup will fiddle stack region, need a copy */
> +	s = savestr(line);

savestr calls strdup so it cannot be used safely without disabling
SIGINT in dash.  sstrdup is the safe alternative.  In fact, if
you do a grabstackstr first then you only need to dup once.

> +	/* need yet another copy, so that delimiters aren't lost
> +	 * in case there are more fields than variables */
> +	backup = savestr(line);
> +
> +	arglist.lastp = &arglist.list;
> +	recordregion(0, strlen(line), 0);

You can avoid doing strlen if you save the stacknxt and use that
to compute the length.

> +	ifsbreakup(s, &arglist);
> +	*arglist.lastp = NULL;
> +	removerecordregions(0);
> +
> +	for (sl = arglist.list; sl != NULL; sl = sl->next) {
> +
> +		/* remaining fields present, but no variables left. */
> +		if ((*(ap + 1) == NULL) && (sl->next != NULL)) {
> +			size_t offset;
> +			const char *remainder;
> +
> +			/* FIXME little bit hacky, assuming that ifsbreakup 
> +			 * will not modify the length of the string */

Hacky but should be safe.

> +		/* preceeding backslash */
> +		if (backslash != 0) {
> +			backslash = 0;
> +			if (c != '\n') {
> +				STPUTC(c, p);

Need to output CTLESC for ifsbreakup and check for raw CTLESC
and escape those.  Also need to rmescapes after ifsbreakup for
each argument.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
