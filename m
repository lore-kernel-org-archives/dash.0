Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3524232B99B
	for <dash@vger.kernel.org>; Tue, 21 Oct 2025 13:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053381; cv=none; b=VZBwU+8BXUz+XULtcI2aC1BRRCwFYXVT8+pt5Y34VPlCbdrLyMr6dcarSoexWg2MARTNXEUhovlLFJGUL70iAaoX5UCz172CbRh1/GWsSW5gqjJ/p6mx6Vko+vBRWQ/3Q6zW5zGUK67mEnKmUYM/IBPbIwsiE8soEaMKLn/ISv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053381; c=relaxed/simple;
	bh=6i3eK3IxtyNGjhqJ2KiX24O1fluUBxz04rssUoTtnVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwFQAd8GtCf/UKlAIEO3iv7omsqgF6vCrBr4ts/ZA2wcI0qUj4bq+0jRFW2pBgescUABRenlKc+u+3Jb9mNZqulLT4xrSworL4sHXmBcJU7OOuHELtS3CWd2H2UtCJUUlnv2kKpbFDQaK9O4hiFztjRDu8RWk2/4KoRa/vFPh+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=BDEaWRvG; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="BDEaWRvG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=RTOgRl0OCFNY/NUlMjac6dlD0W+rIZpHpcvG/5NGLfM=; 
	b=BDEaWRvGddSKqBhRO209lDiMLGnK8rw3k1NU30FAPdDJy7bDMigQ8osRNWMDq75cn3wKg7v/xpu
	buyTn74mGHImP84GjsYlGgFVy3EhXcIO/oY/fSoRUiuCMwmqr2MelNP95SX1xtxDSQVbkfvDsskNd
	2MDJqbzZ9OZGYl4LSOFdzgV4x5v7wo0im+YbaF3l32Khp0q/Cv1GZUrKPwKnqDyoseDefEJMken4m
	M/1bZj7fzL0TRvJgW3hE2SUxObxb38rg/Z30D2oFRoLwGk0DvguY2j6fGHrU/6A76IHvcG3PwVJ9V
	H+fLbI5Z4WU+hFibM+P6Z5xYsqlwaJAo8cPg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vBCQe-00EM1X-0Z;
	Tue, 21 Oct 2025 21:29:33 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 21 Oct 2025 21:29:32 +0800
Date: Tue, 21 Oct 2025 21:29:32 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: j.daubert@posteo.de
Cc: Dash <dash@vger.kernel.org>
Subject: [PATCH] shell: Fix unsigned char promotion and truncation
Message-ID: <aPeKvExPB1HluHly@gondor.apana.org.au>
References: <df9d5e861c3fc9bf6754fecc113616c1@posteo.de>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df9d5e861c3fc9bf6754fecc113616c1@posteo.de>

On Mon, Oct 20, 2025 at 12:31:03PM +0000, j.daubert@posteo.de wrote:
> We are using dash 0.5.13.1 as /bin/sh and running into several build
> problems on ARM64,
> for example curl:

Thanks for the report!

I can reproduce this and it appears to be a couple of instances of
incorrect unsigned char (the default on arm64) promotion.

Please try this patch:

---8<---
When a char is promoted to an int, it needs to be signed as otherwise
comparisons on it may fail.  Alternatively, an integer needs to be
truncated to char before comparing it against another char.

Reported-by: Juergen Daubert <j.daubert@posteo.de> 
Fixes: e878137f63e6 ("expand: Do not call rmescapes in expari")
Fixes: c5bf9702ea11 ("expand: Add multi-byte support to pmatch")
Fixes: 8f01c3796f0f ("[PARSER] Add FAKEEOFMARK for expandstr")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/expand.c b/src/expand.c
index 912384d..8c8bf0e 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -1914,7 +1914,7 @@ static int pmatch(char *pattern, const char *string)
 			if (c == '?' || c == '[')
 				c = CTLESC;
 			for (;;) {
-				if (c != CTLESC) {
+				if (c != (char)CTLESC) {
 					/* Stop should be null-terminated
 					 * as it is passed as a string to
 					 * strpbrk(3).
@@ -1985,7 +1985,7 @@ static int pmatch(char *pattern, const char *string)
 					p++;
 					if (*p == (char)CTLESC)
 						p++;
-					else if (*p == CTLMBCHAR) {
+					else if (*p == (char)CTLMBCHAR) {
 						mbp = mbnext(p);
 						p += mbp & 0xff;
 						p += mbp >> 8;
diff --git a/src/parser.c b/src/parser.c
index eb402a7..5714958 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -1240,7 +1240,7 @@ checkend: {
 
 		markloc = out - (char *)stackblock();
 		for (p = eofmark; STPUTC(c, out), *p; p++) {
-			if (c != *p)
+			if (c != (signed char)*p)
 				goto more_heredoc;
 
 			c = pgetc();
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
