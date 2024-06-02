Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7DAA930
	for <dash@vger.kernel.org>; Sun,  2 Jun 2024 01:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717292084; cv=none; b=hQ4XDYuLPGus9VFYn0qreWwbAkADZ9ouqhJzPOVrNmpusk1A4NmfdyGNUP9CwC04EVGJQYWk+waWtcudI9ddwtpkvpZ+6xdPDGmQ4PWsXn+lnf8wn33LAsfzZrnOsJQcs0YUMEOki1hwZ6p5RQclfq5NsbN7dnKC5niERDJXt+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717292084; c=relaxed/simple;
	bh=+HTJWLkGmSCjQr78DqBTkBqbATk6YDXzFNRqy4gQLnQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mp2Vg8xfnMkczXlHsoA2YehB3RpeHiKxO2XERFIKyghwLBcLrf+xwrSsT2xlVAbytqhK73SFh/Q54ZPbXn5RwmIzI+Qht8y1lkdySwnlMe5j4uBNmXuuzNIesBDhytZkJX2yT5plqGUJf7zXzZRhUci7wGwmjLYP3YsO6H0GgGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sDa7I-004id7-0P;
	Sun, 02 Jun 2024 09:34:37 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 02 Jun 2024 09:34:38 +0800
Date: Sun, 2 Jun 2024 09:34:38 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] expand: Check d_type in expmeta before recursing
Message-ID: <ZlvMLrrmMR92Bbvq@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

If the directory pointer is not a directory or symlink, do not
recurse into expmeta.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/expand.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/expand.c b/src/expand.c
index 345c498..527ce7c 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -1722,6 +1722,8 @@ static char *expmeta(char *name, unsigned name_len, size_t expdir_len)
 
 		if (*dname == '.' && !matchdot)
 			goto check_int;
+		if (c && dp->d_type != DT_DIR && dp->d_type != DT_LNK)
+			goto check_int;
 		len = strlen(dname) + 1;
 		p = dname;
 		if (!FNMATCH_IS_ENABLED) {
-- 
2.39.2

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
