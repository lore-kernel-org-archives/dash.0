Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98D842055
	for <dash@vger.kernel.org>; Sat, 27 Apr 2024 09:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714209058; cv=none; b=fMCM3oTTYKpT6SIZ0rsthcULUuQGf0XDorMoYKOuDIMM/6vkyIdJTtNUNnmstNX7TFrdIZhEJK1+SlahTk/60thSHmOeZYX1bAD1HOABEcCvISH3MAJCXQAM8KtzOPmcncxiyadRGi3xGLhKiHgQrleUgR1AgaiLGA6dsYtkhfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714209058; c=relaxed/simple;
	bh=XhrDu1lT+26NCceqvcWjAu6fPevago8OWioh0tZNXI8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Xsf2LkrQYFStdDbOu7Ikzin4R/Bab73JI5g243cRSJ1Gj4yhh+I1vagedU3mJ0xI45CzixmUMmeQnehVvrcTHIim+VCZPx7TOHeUFzHrYhA6+JUy3ANOmZL4rl7o4wmjPo8Avma6vjq0oLXsEPaMCIrjozQHTCzDHQUN7s07rjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s0e4y-00785h-2s;
	Sat, 27 Apr 2024 17:10:45 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 27 Apr 2024 17:11:02 +0800
Date: Sat, 27 Apr 2024 17:11:02 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: dash@vger.kernel.org
Subject: [PATCH] input: Fix history line reading regression
Message-ID: <ZizBJhvmuy/8Fx5r@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When a newline is encountered with history support, terminate
the loop immediately.

Fixes: 44ae22beedf8 ("input: Disable lleft in SMALL mode")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/input.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/input.c b/src/input.c
index 38969a7..fb9858f 100644
--- a/src/input.c
+++ b/src/input.c
@@ -301,7 +301,7 @@ again:
 		switch (c) {
 		case '\n':
 			parsefile->nleft = q - parsefile->nextc - 1;
-			goto check;
+			goto done;
 
 		default:
 			something = 1;
@@ -320,6 +320,7 @@ check:
 			break;
 		}
 	}
+done:
 	input_set_lleft(parsefile, more);
 
 	if (!IS_DEFINED_SMALL)
-- 
2.39.2

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
