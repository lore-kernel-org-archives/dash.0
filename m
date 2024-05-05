Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672CB6FC7
	for <dash@vger.kernel.org>; Sun,  5 May 2024 09:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714900488; cv=none; b=JnCkAEIvDA6HLuHQJ0bWKQS8Zqq5dIA3LIPRGtyGL4/ZOblANl3EsGVT9R1H8vd7RAJNidsyF39Vv/bzcIzqyhIsG5+JRPewXYGsuD/YaGPxgrZ3W8/y0Ev4ADfBd2LaRQlBpzZOXX2TDDYqofBclLKYpPb9Ky5HcLN4XPZciAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714900488; c=relaxed/simple;
	bh=mDQ9ZCbicr5SFLv6A+EEB8nvfMcv5Am7kAM0I2z4Evs=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=tof7iHO0ri7GJTBxmQidOE/YJn4A8MNImBrzZphs2PUUw6nSDC2arSSJDaARRJZjIFrLumPRzvdhCmHXNu7tTZg03gam9c4KAM7eSeuI/L52wtXwsMFnw8I8UhmC1zQrZO5SbcYI4ocCwj1Fh+oCxJxCOl0t8ehoJm5IVcPtvKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s3XxC-00AaWp-19;
	Sun, 05 May 2024 17:14:43 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 05 May 2024 17:14:42 +0800
Date: Sun, 05 May 2024 17:14:42 +0800
Message-Id: <91d6bef13f4cca0029d879ba44650dc2b15199d1.1714900377.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1714900377.git.herbert@gondor.apana.org.au>
References: <cover.1714900377.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v3 PATCH 08/13] input: Add pgetc_eoa
To: DASH Mailing List <dash@vger.kernel.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

This reintroduces PEOA in a limited way.  Instead of allowing pgetc
to return it, limit it to a new function pgetc_eoa so only specific
callers need to deal with PEOA.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/input.c | 8 +++++++-
 src/input.h | 3 ++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/input.c b/src/input.c
index e17e067..bedc581 100644
--- a/src/input.c
+++ b/src/input.c
@@ -157,7 +157,7 @@ static int __pgetc(void)
  * Nul characters in the input are silently discarded.
  */
 
-int pgetc(void)
+int __attribute__((noinline)) pgetc(void)
 {
 	struct strpush *sp = parsefile->spfree;
 
@@ -167,6 +167,12 @@ int pgetc(void)
 	return __pgetc();
 }
 
+int pgetc_eoa(void)
+{
+	return parsefile->strpush && parsefile->nleft == -1 &&
+	       parsefile->strpush->ap ? PEOA : pgetc();
+}
+
 static int stdin_clear_nonblock(void)
 {
 	int flags = fcntl(0, F_GETFL, 0);
diff --git a/src/input.h b/src/input.h
index 5b4a045..151b1c6 100644
--- a/src/input.h
+++ b/src/input.h
@@ -45,6 +45,7 @@
 #define PUNGETC_MAX (MB_LEN_MAX > 16 ? MB_LEN_MAX : 16)
 
 /* PEOF (the end of file marker) is defined in syntax.h */
+#define PEOA ((PEOF) - 1)
 
 enum {
 	INPUT_PUSH_FILE = 1,
@@ -102,7 +103,7 @@ extern struct parsefile *parsefile;
 #define plinno (parsefile->linno)
 
 int pgetc(void);
-int pgetc2(void);
+int pgetc_eoa(void);
 void pungetc(void);
 void pungetn(int);
 void pushstring(char *, void *);
-- 
2.39.2

