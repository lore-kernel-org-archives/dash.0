Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41063F9FB
	for <dash@vger.kernel.org>; Thu, 18 Sep 2025 03:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758165633; cv=none; b=nR7EW79mziYXEI7SVXuJ1MFZM4FmsVsnMLN647njO5AGlEOawZqDReYw78+uIWWBnUHcxfODpBZlp+j08NOUy8WXlsXKvmhZgpdiUxe8qh4p87t4yW/USH7Kqx60J/WtmKIwPRYayMzddOvmXfOn2GXlIRhfoD+7jcclZ+M4gCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758165633; c=relaxed/simple;
	bh=sBAa5ImrbCb7OhGIcHKdaL7z+g+MwHNMwVxei1Yydbk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ncWplbHWwkvbR3Ada+2JjDnhEYyTiHIhUy8Zn7ZxAaaA+NoU+VJnA6CNYUqqPPr019OTBsXHntmcUq/Wjh8Mjv67bvrEnZW8khTHDLnCFZI7ip73sJ8/jJVOpWjNvSavT8ABL+glHL5GKv+QRFmJk09L0T2xJAkqeL9FLZNUVSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=rNA9+ox3; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="rNA9+ox3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lHxlIGu4REwk/9hkcrGqgH5y4RcyexXYlK0P0YkovkI=; b=rNA9+ox363dIg2aPh1rLk01NoU
	umLRChRk6yPSxtWkzHnCmlJfjpkPhyR6zKREqWyEhs9idFGuT5EarDNWcLnuzHG5N4QfLRQd70tJt
	G2qIz/+0y0Kc6kMU0vTHDIDmt++h2uFs1CTcKY1ZcVqi1ZPhKknwEZoCnwWbPvZ1h3jEOJ2FzzCF7
	WqjxOdIVteHrQOjIsSH/jTkL/6gyBOx1/5efcuYvfrG+yuyp3PKWhUWJ51OcIlnL6N7l6LHAOxIG0
	WQOVmR4dhkL+JX/X9id9T5z/DuLan4YsX63BqPGZ8xa7iKiqB58opK/TZtq8s87/y4LtUpc7LNrOt
	3fraK94A==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uz4wf-006LkU-00;
	Thu, 18 Sep 2025 11:20:26 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 18 Sep 2025 11:20:25 +0800
Date: Thu, 18 Sep 2025 11:20:25 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Abdullah <3bd3bdr@gmail.com>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH] histedit: fix dash exiting when receiving a signal
 interactively
Message-ID: <aMt6eQAAwBluVjGP@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918003435.11162-2-3bd3bdr@gmail.com>
X-Newsgroups: apana.lists.os.linux.dash

Abdullah <3bd3bdr@gmail.com> wrote:
>
> +               /* Got a signal while reading. */
> +               if (el_len < 0 && errno == EINTR && pending_sig) {
> +                       out2c('\r');
> +                       liw = el_wline(el);
> +                       /* Don't lose the current line.
> +                        * el_wpush() takes a L'\0' terminated string.
> +                        * el_wline() gives us a string with N elements.
> +                        * Simple solution: el_wpush() it wchar-by-wchar.
> +                        */
> +                       wbuf[1] = L'\0';
> +                       wc = liw->buffer;
> +                       while (wc < liw->lastchar) {
> +                               wbuf[0] = *wc++;
> +                               el_wpush(el, wbuf);
> +                       }
> +                       dotrap();
> +                       goto retry;
> +               }
> +               return 0;

Can you please explain why this is necessary and why el_gets can't
handle it?
 
> -       if (signo == SIGCHLD)
> +       if (
> +               signo == SIGCHLD
> +#if defined(WINCH) && !defined(SMALL)
> +               || signo == WINCH
> +#endif

Please use SIGWINCH consistently.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
