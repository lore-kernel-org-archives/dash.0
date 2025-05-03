Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBF21C683
	for <dash@vger.kernel.org>; Sat,  3 May 2025 07:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746256978; cv=none; b=nWsLZWAtFqTp9b+s60JUB0n9iB9wvjpXjpsN5Hpdi7Z9f7vwtEkw30LSKBOB1MchdJWTZfGLtyYcsl3tFOpvUHBzFjmBXpdH7NiG2kWp2EXgJD1W0/v4kUh+xp1zgb3c0ewAUYvynpjeILYAJr1WvTOsBQQeOe5Ki734j1sRj3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746256978; c=relaxed/simple;
	bh=zMyYENbkZXsEM0EbzPQLlTBp02vLCdmnMzN6CTx+lkY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VsrEcRvN257k/zc2sYnnrz/pihcEWO4tIj+6kj3+H0M4CMGM9KZJDDogcK9SPEuWishVNnEB5M/awIJp2hzfZtgrj2x1mPEli1OtHI5Kzf35A4bUR98Ok4PabTumPuvQ6yuMTASxaPbJpKLB9yY/MNVIKT/kPjUFPtoDXY+4QT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=o+LGBz2P; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="o+LGBz2P"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:
	Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=XcdE128wjT15lQY485kQIw/QewnvLG0LGFUMmKqoGAk=; b=o+LGBz2PT0vQs2mQRw39yAeIJB
	M57bK5mh2NAnDdI8NVkUvAjMlQ3uggW3kMPolv4mZbAmR+oECXkagzrXeSm24xrnqZUGRK6WOk2bB
	AA53udhIw4PzwRqHJRXO6QvgJ7MkxrxWwDK0frqtnFBlZHmkhrmL79DpVZe0G2CYS2ibR3bdy8/28
	BR5ozUR399UdLMktK3es9kakWr9cUU6g9wWOQjhYU8WB6RMH/imWsgO+2lVzpMQMAHeOG+DPnbFyj
	7Q3wxcHEDDzKxrgn8tjAWM98SD0GFfy7DMG06HpD0hnzQx7+lnv0PO2/M1ZvKOVEx/M8zK4Wus4Gb
	9tKVHKHQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uB7Cu-0031dP-39;
	Sat, 03 May 2025 15:22:46 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 03 May 2025 15:22:44 +0800
Date: Sat, 3 May 2025 15:22:44 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: dash@vger.kernel.org
Subject: [PATCH] expand: Move stop array closer to strpbrk call
Message-ID: <aBXERPJG0ewfvmTV@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Move the stop array closer to the strpbrk(3) call in pmatch.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/expand.c b/src/expand.c
index 1b9572d..25df03c 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -1886,9 +1886,6 @@ static __attribute__((noinline)) int ccmatch(char *p, const char *mbc, int ml,
 
 static int pmatch(char *pattern, const char *string)
 {
-    /* stop should be null-terminated as it passed as a string to
-     * strpbrk. */
-	char stop[] = { 0, CTLESC, CTLMBCHAR, '\0' };
 	const char *q;
 	unsigned mb;
 	char *p;
@@ -1918,11 +1915,17 @@ static int pmatch(char *pattern, const char *string)
 				c = *++p;
 			if (!c)
 				return 1;
-			stop[0] = CTLESC;
-			if (c != '?' && c != '[')
-				stop[0] = c;
+			if (c == '?' || c != '[')
+				c = CTLESC;
 			for (;;) {
-				if (stop[0] != (char)CTLESC) {
+				if (c != CTLESC) {
+					/* Stop should be null-terminated
+					 * as it is passed as a string to
+					 * strpbrk(3).
+					 */
+					const char stop[] = {
+						c, CTLESC, CTLMBCHAR, 0,
+					};
 					q = strpbrk(q, stop);
 					if (!q)
 						return 0;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
