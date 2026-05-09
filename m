Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C20379982
	for <dash@vger.kernel.org>; Sat,  9 May 2026 02:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778294843; cv=none; b=rpOh10xaO4+1+a0uizC9oyhz53BTyv1R/1k8ovOD++sp3nEbPENJDJOACKxjmuZtR1G41uwcdlzRHE2HRXVRlbGem4/Kbob/bgwe3UDB0ns57ES84oFIr2PXAzFoH+JeL+VnykMYnUmFiY4IYf1MWRCShSMmcUEYNpqvcWf4uF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778294843; c=relaxed/simple;
	bh=aPwQRpoNpT9B51/KsJZYXkWy/jNfZYkWah58XDrKl48=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SQqUXJYXTcRpwbTilQxicK6amBwqkVhMML0SwoFXS7YsEfo/4560VNTxetaNboLswt3HavWPyZAHzKo1cKhWXg7mbBqwGhX23V6BUkn6NXt6wh34ILJMABZp9EeWurbVhlps4EITvrznPX6xqY0Gfw/LN9f0ofOCzwowgz0erSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=fGs/xxxe; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="fGs/xxxe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=qBrYw0cJReABuloZv2u76t4eSpigmFyqMMPU10z607E=; b=fGs/xxxeNuIg+CbDcAkKgbMDUp
	nswmLcGTGPtOkRmhlMO+GHwYM8DxxeHjwQUgchuYHaY7PgGXJ/RG8OnOraeVi8pjjZfVZJpvY31He
	M83wzgKs7jh8kAR+gccuMa8Rup+Oxhj27Mwoy31zjR2fQVUVYo43/tS/SDRY7tJ8UahBu1FEDZua3
	9l0OW4PlTGC3kJwR5T1LpaVWMmYC6M1lBb4s1dLc72Q6I4OUbb895rp24jzif5E+Umm8oy5SU5IuD
	WzB6Zgms29znjgPVslke9Ivav6R5hKKSFyrL0Ob5w6BiP1YLJ91A/TWSHByRvvovfqyusXmMWcCpx
	fjBSZ4Zw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wLXif-00CaEX-2V;
	Sat, 09 May 2026 10:47:10 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 09 May 2026 10:47:09 +0800
Date: Sat, 9 May 2026 10:47:09 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: sebastien peterson boudreau <sebastien.peterson.boudreau@gmail.com>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH] Don't use groff(1) specific string syntax
Message-ID: <af6gLe2f_jlMCofg@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418185421.28841-1-sebastien.peterson.boudreau@gmail.com>
X-Newsgroups: apana.lists.os.linux.dash

sebastien peterson boudreau <sebastien.peterson.boudreau@gmail.com> wrote:
> It's standard for troff(1)s to recognize \*( for 2 character
> strings, but \*[] is a GNU extension. I don't see any reason to
> use it.
> 
> groff_mdoc(7) also gives ``preferred'' alternatives to these uses
> in the section _Predefined strings_, but I don't know if these
> are portable; for some, it lists characters that are unique(?) to
> groff (in groff_char(7), characters with widespread portability
> are marked by a `+', and some of the preferred alternatives listed
> in groff_mdoc(7) are not marked as such), but \*(Lt and \*(Gt have
> preferred alternatives of simply the ASCII < and > characters.
> ---
> src/dash.1 | 58 +++++++++++++++++++++++++++---------------------------
> 1 file changed, 29 insertions(+), 29 deletions(-)

Thanks for working on this!

I checked the NetBSD code and they replaced these with literals
instead.  Any reason why we can't do the same thing?

> diff --git a/src/dash.1 b/src/dash.1
> index dbc34c9..0fcb183 100644
> --- a/src/dash.1
> +++ b/src/dash.1
> @@ -197,7 +197,7 @@ operand and the positional parameters ($1, $2, etc.)
> set from the remaining argument operands.
> .It Fl C Em noclobber
> Don't overwrite existing files with
> -.Dq \*[Gt] .
> +.Dq \*(Gt .

NetBSD simply replaced "\*[Gt]" with ">".

https://github.com/NetBSD/src/commit/30b9dfc8813e15031a13fc2fc85094b81c71e2b7

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
