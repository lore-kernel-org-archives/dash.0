Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF041FC8
	for <dash@vger.kernel.org>; Mon,  8 Apr 2024 04:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712552093; cv=none; b=D1qYmwAA7imyGa5PH3nZbt0MaFzRW20h+xCAvDHcUsd4vovrL/Gs1fsGej4MXIBhXB4ckqFLcz6GPZ1XztforJcqfVD2ZCsF62eBqtHsaCFucSgC5TtZlNaiA5vTRWB+FYPN26F7VEsGnX84uqeDSTIw1qIBG2U1M0GfJljOY78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712552093; c=relaxed/simple;
	bh=XUzSY3Xyo2oQNUiTmLAx3dvzfsA+DueiDAQnz899YAc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=edH1T6SAiSkyVf1JxtIzyWFKs9LkbB7YXB+U297KzRl76j0bsYXKswBP1Zma/onaKSt9+FqSMVq5/jZfoIClITLoA0Q84dyctdUSXw/91nJVT9xYTjiT6gmUG1bBbuOsNExTzhU7dIOvXmy0DnxjrBmmNg/Ykf07SU1gHDZpQ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rth1p-00GSdy-S4; Mon, 08 Apr 2024 12:54:46 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 08 Apr 2024 12:55:03 +0800
Date: Mon, 8 Apr 2024 12:55:03 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Harald van Dijk <harald@gigawatt.nl>
Cc: dash@vger.kernel.org
Subject: [PATCH] alias: Fix out-of-bound access
Message-ID: <ZhN4p6axGxEpiUu+@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc839b61-a7d5-6a36-ed47-db8363989379@gigawatt.nl>
X-Newsgroups: apana.lists.os.linux.dash

Harald van Dijk <harald@gigawatt.nl> wrote:
>
> I had trusted that this "n+1: funny ksh stuff" logic which allows an 
> alias to start with = was because ksh allows this, but I tested this 
> now, it does not and I can find no evidence that it ever did. Maybe it 
> would be good to just remove this exception, or if dash wants to keep 
> it, document it as an ash extension rather than claim it as a ksh thing?

Thanks.  This patch should fix the overrun.

---8<---
Check for empty string before searching for equal sign starting at
n+1 in aliascmd.

Reported-by: Harald van Dijk <harald@gigawatt.nl>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/alias.c b/src/alias.c
index fcad43b..cee07e9 100644
--- a/src/alias.c
+++ b/src/alias.c
@@ -143,7 +143,8 @@ aliascmd(int argc, char **argv)
 		return (0);
 	}
 	while ((n = *++argv) != NULL) {
-		if ((v = strchr(n+1, '=')) == NULL) { /* n+1: funny ksh stuff */
+		/* n + 1: funny ksh stuff (from 44lite) */
+		if (!*n || !(v = strchr(n + 1, '='))) {
 			if ((ap = *__lookupalias(n)) == NULL) {
 				outfmt(out2, "%s: %s not found\n", "alias", n);
 				ret = 1;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
