Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912E2224D6
	for <dash@vger.kernel.org>; Sun,  7 Jun 2026 13:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780838202; cv=none; b=F6PEkjiH50qi9UqYK6S/OTNEZ3JRzPvTo4PLHpJJaYPCYO9SbfrGt68b925hcJEgDoNJIOvU45tLdywo45C2E7zSg63JwiJebwP6U80mDkcvDfZQmdlMzgQYzMRvgB05Jr4azDb+aa6ChO7BG9QEfSL6zelhZuaGrQ8Ni/mpGKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780838202; c=relaxed/simple;
	bh=IVtlI8HNwXpn2KUHQ9fX1XPs4zmI57EyXU8gfDAm0hg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KZsiYs0a1rlyl8h0Fshuez+ZtVzl916PwytaQb/2FfiXOTkYLPJxaabFS+nx+Kj7lv8Xw5d/7Kfkp5Ho38VztPr4mcGIRcXZy9lrrak2ngLXqZoEJ236sYeqvEABEFs/s23xtwxmtYxoF1MvsIFbuxYnVNv5f7FgEzvs2M3caYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=Av5NrIz3; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="Av5NrIz3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=Content-Type:MIME-Version:Message-ID:Subject:
	To:From:Date:cc:to:subject:message-id:date:from:content-type:in-reply-to:
	references:reply-to; bh=sM7Ihs1DCDZzVPmsWR/nIZ69icsCS4qSuE4BxNKquQ0=; b=Av5Nr
	Iz30wtXrdNN4TTp7nzOKRVmCgKLIAawHq7ocgwZ+N9y8EsUsQH3GBz6myj5UBqOE/aoEeTMigmimZ
	hkXgrYeF+V4ZemMZFht8t3hITfito04mA84K7oRFcDNiuL5Oat4QxJajEahr+wzj13Lwq0xNGQz/I
	d4mGSZI+mt9pPyPxbB50DSEknZquc73efSmZTh2EVLBCfhSEInOwd26ciEGQVDYTuBpFXzp1odrnY
	tWqcoCQ4klPUqcraWjoMDLmhuq++DF+1hDeVoHqivA77T9EYPJe3utFpcMmKmtTGGcqqlequL/LZS
	z0UPYq3KN1e0+phzM/iasPWBFxa6g==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wWDMj-003GNt-0b;
	Sun, 07 Jun 2026 21:16:38 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 07 Jun 2026 21:16:37 +0800
Date: Sun, 7 Jun 2026 21:16:37 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] parser: Use USTPUTC in parsebackq
Message-ID: <aiVvNcErvYd7JkSW@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Move the CHECKSTRSPACE call out and replace STPUTC with USTPUTC
in parsebackq.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/parser.c b/src/parser.c
index 412e876..c69e0fb 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -1539,6 +1539,7 @@ parsebackq: {
                 int pc;
 
 		while (!done) {
+			CHECKSTRSPACE(MB_LEN_MAX + 1, pout);
 			if (needprompt) {
 				setprompt(2);
 			}
@@ -1551,8 +1552,7 @@ parsebackq: {
                                 pc = pgetc();
                                 if (pc != '\\' && pc != '`' && pc != '$'
                                     && (!synstack->dblquote || pc != '"'))
-                                        STPUTC('\\', pout);
-				CHECKSTRSPACE(MB_LEN_MAX, pout);
+                                        USTPUTC('\\', pout);
 				ml = getmbc(pc, pout, 2);
 				pout += ml;
 				if (ml)
@@ -1569,7 +1569,7 @@ parsebackq: {
 			default:
 				break;
 			}
-			STPUTC(pc, pout);
+			USTPUTC(pc, pout);
                 }
 		if (chkeofmark) {
 			out = pout;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
