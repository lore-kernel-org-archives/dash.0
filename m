Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BA6296BC1
	for <dash@vger.kernel.org>; Sat,  9 May 2026 02:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778295210; cv=none; b=Nbl2hb9lj6Ka3KCc5VQ0zbYSoAFbtT688S2RKSoz9aka1vNVTa4QxNCsVygLX0WGCSYIM0Jia2gBLJ+39DaJGWl+x9tRyPuO0HFQ3Tom6ZYkmBdZf3oC4jLU8G50/KhetEjxLmDNfRrf+WHmbeBmhMBRS2GTAIn9E2a2ywDnAfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778295210; c=relaxed/simple;
	bh=ACOZ5oTOE2p8fEdvb9SsOZb4ULgFqGHT5p+bDiO2sz0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MrrlAmcZAIOAD7M34rPnVj/njf9VquPHyTzJK96H5W/qmHoST1asF9mgi789WuWs/tzBq+jxxAnsPoM8DgUiPukw6MOuceYSo7bO+ZiOPM8T5f4BaCIgQl3Wo8JKSjVCEZLsM4fch5jL+h6zeH0CglkiqKIf1nYTvEV/RTShsYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=jHfFY0DM; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="jHfFY0DM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=oFJpUwwNZbKfvr7VzEsC+29z0/2027oMjzW9zjx0Nxs=; b=jHfFY0DM7e1nR01CTICfwkryy+
	7vCPT+YDdl2sIwDvWaAkBDvVGSZ/DRMwrCv6V/DlDGYg1WmSFOm9H8YOU2UsEDYYrzvMgbqbop6PG
	uzLPQsuNFggimYRA5OeHhinPa0E2EhhCHaox3NaHjHVuNrALY+LonZmjjPDNX6FQg0vB2w0ZvK8xl
	Gkw4YtFd5YGSHKSgmaTGQ6EhEq20mHvVbWcH5urcyY8YMYTs/UVbthSOwwWGdEDOCPkf91g4yHxMn
	+bAajd8910Vx0Tg4oooyp/9On+xZHCx7nAiK460mpvwBQYYlXGs7B+zxf30pftDdRqL0/SgPWSPyG
	NuDLLRpg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wLXoi-00CaH1-0u;
	Sat, 09 May 2026 10:53:25 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 09 May 2026 10:53:24 +0800
Date: Sat, 9 May 2026 10:53:24 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: sebastien peterson boudreau <sebastien.peterson.boudreau@gmail.com>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH] Use proper grave accent character
Message-ID: <af6hpLV8IFrTd3G6@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418185528.29367-1-sebastien.peterson.boudreau@gmail.com>
X-Newsgroups: apana.lists.os.linux.dash

sebastien peterson boudreau <sebastien.peterson.boudreau@gmail.com> wrote:
> ---
> src/dash.1 | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/src/dash.1 b/src/dash.1
> index dbc34c9..f651a03 100644
> --- a/src/dash.1
> +++ b/src/dash.1
> @@ -293,12 +293,12 @@ Enclosing characters within double quotes preserves the literal
> meaning of all characters except dollarsign
> .Pq $ ,
> backquote
> -.Pq ` ,
> +.Pq \(ga ,

Sorry could you please explain why this makes any difference because
they look identical to my untrained eye.

This explanation should also go into the patch description.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
