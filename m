Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5FC18659
	for <dash@vger.kernel.org>; Fri,  5 Apr 2024 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712313962; cv=none; b=p4eNAvdJN/ndWbuwZIWgaKB7orM82JvQF6E75OxfsmnrXsOk45jPH1HpPd2epg4MFIJtMz2FG7ObHeat6b1Q1obWmJiZsRt5+XZNmViY5OseKnBrGfSPzjwFYrhaUKhPah1p6bunVrRmv1DSsugmoWBoe5qjU0mVIJsAv9HmcbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712313962; c=relaxed/simple;
	bh=CqnWJy/3sCu0Nphj1wkPoUI6ayDs/aJHF9FeCs3c6KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fk9RDXIvoHKtVnGXP+hPsrpT9tCpPGQndlgt8HS/vvOolxGCKEzkUXkGdbtqxrx7bakRDr0mfBdrOqKwOW+5LWER3wZYeoGMgEVu7S4zh7D9x++IT70c7nh4FiFnhUVPvlOzUyOLvNQzSef5FvEwWy8X7isVwTVHz9Xn9VnziNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rsh50-00FY2p-ND; Fri, 05 Apr 2024 18:45:55 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Apr 2024 18:46:11 +0800
Date: Fri, 5 Apr 2024 18:46:11 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Ron Yorston <rmy@frippery.org>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH] var: move hashvar() calls into findvar()
Message-ID: <Zg/Wcyg4MRwD1EMS@gondor.apana.org.au>
References: <627a1f77.3CLq0J9mI6V6UePB%rmy@frippery.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <627a1f77.3CLq0J9mI6V6UePB%rmy@frippery.org>

On Tue, May 10, 2022 at 09:16:55AM +0100, Ron Yorston wrote:
> The first argument to findvar() is always obtained by a call to
> hashvar(), the return value of which is otherwise unused.
> 
> Signed-off-by: Ron Yorston <rmy@frippery.org>
> ---
>  src/var.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)

Nice work!

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
