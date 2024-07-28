Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670C78494
	for <dash@vger.kernel.org>; Sun, 28 Jul 2024 03:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722136015; cv=none; b=clyNQ1VmUHTkgH/8o7JmsKFB3foZZdm0vDldz3hqILrn+83s91DX27SsIp9b5AXA70GusXsic8+bOuuYxPTMr25LRA1En7EuoTfpWykgHrE160EINRxOI0gklPoaV0YHFIlrU3diftI/06SwlRRgKDaWAYhlF3G6O8vqGBFMpRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722136015; c=relaxed/simple;
	bh=brU/FftXo+vsunXX011NC0h/DPp1MAnzqfGfQmWUhA0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cykLaPqdcy8Vye8tMxxRCRW00Hqi3hRQeoOX60aRjyuh5Yk5PpFQcrH09YSWqI4hl9MEJtaYD0H3qQBmUEMyC3bW75kA6w80L0LHTic2uO/BgiPWjwhhnDiaTYdBJXPejiWS8S5XUjSWNTR4NpYHPvAOv7Wl4qZ2YBkXCFMrmYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sXu6k-000e1s-1T;
	Sun, 28 Jul 2024 11:06:48 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 28 Jul 2024 11:06:47 +0800
Date: Sun, 28 Jul 2024 11:06:47 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH] bltin/test: = and != are strcmp, not strcoll
Message-ID: <ZqW1xyfvsoI5F4IQ@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <t3tjfncwhu5shadny7kikk5ulsycsqk6in3ieuof3ibivekd5c@tarta.nabijaczleweli.xyz>
X-Newsgroups: apana.lists.os.linux.dash

наб <nabijaczleweli@nabijaczleweli.xyz> wrote:
> [-- text/plain, encoding quoted-printable, charset: us-ascii, 38 lines --]
> 
> 117067  s1 = s2  True if the strings s1 and s2 are identical; otherwise, false.
> 117068  s1 != s2 True if the strings s1 and s2 are not identical; otherwise, false.
> 117069  s1 > s2  True if s1 collates after s2 in the current locale; otherwise, false.
> 117070  s1 < s2  True if s1 collates before s2 in the current locale; otherwise, false.
> 
> "identical" does not mean "collate equally";
> this is the difference between sort | uniq and sort -u
> ---
> This bug violates every POSIX issue i can find.
> 
> The manual is already correct.
> 
> src/bltin/test.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
