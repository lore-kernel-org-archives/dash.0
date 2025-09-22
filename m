Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830C433993
	for <dash@vger.kernel.org>; Mon, 22 Sep 2025 03:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758512603; cv=none; b=nupe6P8ZbMxkDqwZEgSeQeEo3Wg/MZUtoBAicWpuGcu0qea8Rm59L6GF8hfEbWoe6A7E7iuxrY//2I3MR9Weo4yIQKUuhORcWiwvYIYJSMT/9kFCFO7kNisowKvNL4sTCwO0qtQJEsAV+Ou6zDK0kmfQzLIsAM3EwdrQi+skdLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758512603; c=relaxed/simple;
	bh=CA6T8dXX1lUmKErhfo5ocZdKwSzoUlYHNGU69LFv/3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIJCzUH6GvlckXlodo51qK8MphDgoCG47NY9DclabPCNenr8Mo/j0l5MLu7VSoTUixY1nXkXjDtbx6OUVfOwYoGGw6O60gJJ4NCr1OYfebq6Ix3H/zHEao3C1j1M8KMlgiEOlsugLMT6SLOaN0urh4X5I4jy+bGqm2WOYh7qJ/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=pwGxnvQ4; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="pwGxnvQ4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:cc:to:subject:message-id:date:from:reply-to;
	bh=qYQjenroizE00cSu47doH8fRp7r82VfplUiAo50Ba4M=; b=pwGxnvQ47C8MroEffoxvV4Pzha
	rqOpBa1MSO3PaQwPfCoMjTR4yx//eoQQtyXRw+u38IdGYlrKvQitvvPImHHsV9j0wxq8KP6ZWmzvR
	4HQQ2QgSiwYmliYSrWT/mK5UAhRxa+2l1YoYdJrC4TKi0Br/wxchy8rPd2AeIlKujQph1GhcQncdG
	+3aesnyCVC7gYiqFfRVgM+wL/zZDfhrocdrtIJOV7CLqXJr5l8SjzswcvQdtGbgTrJgok1UajHwZU
	y8qTlmvfgSn+Lce5mB/89xIGSjoSWpoIJGjMtCEgZEA4ICe2pmJ2ybygF2WmdW3LNNUUf4bfCnZmA
	JqafTudg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1v0XSN-007ILr-22;
	Mon, 22 Sep 2025 11:43:16 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 22 Sep 2025 11:43:15 +0800
Date: Mon, 22 Sep 2025 11:43:15 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: 3bd <3bd3bdr@gmail.com>
Cc: DASH Mailing List <dash@vger.kernel.org>
Subject: Re: [PATCH] histedit: fix dash exiting when receiving a signal
 interactively
Message-ID: <aNDF0z3nwN_V6-Ft@gondor.apana.org.au>
References: <20250918003435.11162-2-3bd3bdr@gmail.com>
 <aMt6eQAAwBluVjGP@gondor.apana.org.au>
 <DCW6NI4KVK3I.1ALXRKL5V6UCM@gmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCW6NI4KVK3I.1ALXRKL5V6UCM@gmail.com>

On Thu, Sep 18, 2025 at 10:45:38PM +0300, 3bd wrote:
>
> EditLine has no "restore the current line to XYZ".
> No el_restore_line() or something similar.
> 
> We could avoid this if we set the SA_RESTART flag in sa_flags,
> then EditLine's internal call to read(2) won't fail.
> But I'm not sure about this. This could play with dash's internal
> handling of signals.

I think that's a defiency in libedit and should be addressed there.

> >> -       if (signo == SIGCHLD)
> >> +       if (
> >> +               signo == SIGCHLD
> >> +#if defined(WINCH) && !defined(SMALL)
> >> +               || signo == WINCH
> >> +#endif
> >
> > Please use SIGWINCH consistently.
> 
> Oh, sorry, I just noticed the mistake.

I'm happy to take the SIGWINCH change though.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
