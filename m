Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9435619D89E
	for <dash@vger.kernel.org>; Sat, 25 Apr 2026 02:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777085331; cv=none; b=YcROJKJz5QMn9VxqhrGiazMXf95ZzQ/p6CWIGJcCSXGunm4x5Jt59FZyB2ZEUM6tkizz1CIgOpiRB3Fq8heKPKPa5tF8YHGYu6xKqEHPDmX/EvSc/Ou4DSNwCrDZ/urVFf1gcszOjGR6ur+e73HwBrJKOWsvD7kBlJ4pxiS657o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777085331; c=relaxed/simple;
	bh=aFPqAYgp8JR3qyPvuLdtSosNSPqhAXqdxaKe4feGN4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcNQItA26PmB0DVU2ydEup3y56BpfC39JdU5eesIkTxFm0y9Ycqtj2bxhfGpAObtyuB4ZR2AnXrXqeRKRJvUtOsM/Mfktg/OgFTprlEcaZzVbvvZsi8KqSudGKDbdqMMkkyuUOTHMGJoCSSEPmg0Rv7/G9G6vxljZ1uY84+BmoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=NhlZD7pZ; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="NhlZD7pZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=UffQPzWIE0sStjnH32BESvetckBMBuVZ9Ww8VqDlIYQ=; 
	b=NhlZD7pZVKg2RFxRpG0ttGOwYbtdZAysSaXHLItFiuO0Z75YC1b6JsDgvdPt7kbIeedNPNaVAoE
	TE4eL855LzRKiaqEjPXJk5UzG3rvamjBjP2kxSLff950oD9KZZkw3M/J9oSN1W9NfnzM+d+xmEwyn
	rzz/9SHI4+gnJFXXfpGY73O9/YZ+FtkIhJLhtPepFm0esISlidAa4pAH6vlETB2dcnnb+ov0kouEc
	AS2Wk/h2eFeVtKtm+rfLTZ9OYE9aoAGS5jsZfJUj0Vhh6z9G1VC0zktnNgI5blqCOvPtvpJKpz6ER
	YA/38X/fVp9Qwe5vxT6cx+aOt7qRgxHd90gw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wGT4Q-008f9V-06;
	Sat, 25 Apr 2026 10:48:39 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 25 Apr 2026 10:48:38 +0800
Date: Sat, 25 Apr 2026 10:48:38 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: =?iso-8859-1?Q?Gr=E9gory?= Pakosz <gregory.pakosz@gmail.com>
Cc: dash@vger.kernel.org
Subject: [PATCH] Drop multi-byte character in argstr when discard is on
Message-ID: <aewrhm9X6eadjQ86@gondor.apana.org.au>
References: <CAC_01E1y9zYecy6ugvmwCzNm2tb2ipWqPKG6f6QUpOKU5AsK6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC_01E1y9zYecy6ugvmwCzNm2tb2ipWqPKG6f6QUpOKU5AsK6g@mail.gmail.com>

On Thu, Apr 23, 2026 at 02:22:15PM +0000, Grégory Pakosz wrote:
> 
> It seems that Dash regressed (but I don't know when).
> 
> $ dash -c 'x=X; printf "before: %s (%d)\n" "$x" "${#x}"; x=${x:-↗};
> printf "after: %s (%d)\n" "$x" "${#x}"'
> before: ↗ (1)
> after: X↗ (2)
> 
> I'm using Dash 0.5.13.2 on macOS, installed via Homebrew.
> The bug seems to be locale irrelevant.

Thank you.  Please try this patch:

---8<---
The multi-byte character should not be copied to the destination
in argstr if the discard flag is enabled.  Fix it.

Reported-by: Grégory Pakosz <gregory.pakosz@gmail.com>
Fixes: 6c44f4ee0c2b ("parser: Add support for multi-byte characters")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/expand.c b/src/expand.c
index bbf8454..76e67ce 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -379,7 +379,8 @@ addquote:
 			if (c == CTLESC)
 				startloc += ml;
 			p += mb & 0xff;
-			expdest = stnputs(p, ml, expdest);
+			if (!(flag & EXP_DISCARD))
+				expdest = stnputs(p, ml, expdest);
 			p += mb >> 8;
 			break;
 		case CTLESC:
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
