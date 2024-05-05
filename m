Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9AB567F
	for <dash@vger.kernel.org>; Sun,  5 May 2024 09:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714900525; cv=none; b=R0QLnP05qrGEQm4G/zhAVzBnUAVYMBIu2GIwDnb6lXygmkUSjR6hPIFuFnqd82xvDwWHeIVMvlM5xxEbYDAzIeqEswPk6EJI5T2fiV9yrMjM+sYeHblACeHLAoSZ4Kns74Xthb+wKSNMCz8UFr1hya82ifxh+Zqyee4A392FMPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714900525; c=relaxed/simple;
	bh=a0/Bhd8zTCS6Pf4Cue7MBMpFXoAwS0W8kMwIM2hgVeM=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=NZD7F1L3JWkzEN7mq93uoXDNLz/1/tjQ8MFLe2O7El+0fV/ZPgymO006oR5HlK8qc5QEk1TivGKTNrDYzYS5lbhdWg18ZfBaKGk1Uggi4g+AK/B0LIx/svMJ94YQcHJbfB8nNC2dpbAZLksWJcs+Ju0XIP/+TqJB095eeb3VdsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s3Xxn-00Aab9-20;
	Sun, 05 May 2024 17:15:20 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 05 May 2024 17:15:20 +0800
Date: Sun, 05 May 2024 17:15:20 +0800
Message-Id: <8d9afe982b262ddee001fcaca4bec5de5958ad91.1714900377.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1714900377.git.herbert@gondor.apana.org.au>
References: <cover.1714900377.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v3 PATCH 10/13] input: Always push in setinputfile
To: DASH Mailing List <dash@vger.kernel.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

Push the input file even in the case of "sh file".  This is because
the base parsefile will be used for read(1).

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/input.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/src/input.c b/src/input.c
index bedc581..1712e5f 100644
--- a/src/input.c
+++ b/src/input.c
@@ -61,6 +61,7 @@
 
 MKINIT struct parsefile basepf;	/* top level input file */
 MKINIT char basebuf[IBUFSIZ];	/* buffer for top level input file */
+MKINIT struct parsefile *toppf = &basepf;
 struct parsefile *parsefile = &basepf;	/* current input file */
 int whichprompt;		/* 1 == PS1, 2 == PS2 */
 
@@ -89,8 +90,8 @@ RESET {
 	popallfiles();
 
 	c = PEOF;
-	if (basepf.nextc - basebuf > basepf.unget)
-		c = basepf.nextc[-basepf.unget - 1];
+	if (toppf->nextc - toppf->buf > toppf->unget)
+		c = toppf->nextc[-toppf->unget - 1];
 	while (c != '\n' && c != PEOF && !int_pending())
 		c = pgetc();
 }
@@ -473,13 +474,11 @@ out:
 static void
 setinputfd(int fd, int push)
 {
-	if (push) {
-		pushfile();
-		parsefile->buf = 0;
-	}
+	pushfile();
+	if (!push)
+		toppf = parsefile;
 	parsefile->fd = fd;
-	if (parsefile->buf == NULL)
-		parsefile->nextc = parsefile->buf = ckmalloc(IBUFSIZ);
+	parsefile->nextc = parsefile->buf = ckmalloc(IBUFSIZ);
 	input_set_lleft(parsefile, parsefile->nleft = 0);
 	plinno = 1;
 }
@@ -560,5 +559,5 @@ void unwindfiles(struct parsefile *stop)
 void
 popallfiles(void)
 {
-	unwindfiles(&basepf);
+	unwindfiles(toppf);
 }
-- 
2.39.2

