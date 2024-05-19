Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0929933D5
	for <dash@vger.kernel.org>; Sun, 19 May 2024 05:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716096037; cv=none; b=hS7TSR66pEtZ2CftyZvTj4biWVFIwAc+j/r8JWqYxE8GxDtoc2yFmY8UwoRBCeeG2wHmQo3wugzwJRuxXaz6W9RbjcjNGaaBke2m7yqSCVBoYJKsPh/ED+gYNQqwCQ48QuxF5zre2YLBypFxt/Ia0/Y9MnwME5TAkU4r+/AyntQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716096037; c=relaxed/simple;
	bh=a0/Bhd8zTCS6Pf4Cue7MBMpFXoAwS0W8kMwIM2hgVeM=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=r2ROTSbvKlhtdiUpjDSUd7ki0JR5JMe656Nb3cTupMMH0A4tOOzFa5OAXWm5OAvEBoCApuWVM8d4qQW7MMmAz5UNhsf03gpCw3PCDtNgkhXNG3rhpfwlqWsgBAwMRppe4YOMRum8rO2ItXaR6vEqny5yFl1vYGaqJVVl2ZGaxNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s8YyF-00HGET-2k;
	Sun, 19 May 2024 13:20:32 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 19 May 2024 13:20:33 +0800
Date: Sun, 19 May 2024 13:20:33 +0800
Message-Id: <766de45e4c736df75181acf705d45d3fffd478dc.1716095868.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1716095868.git.herbert@gondor.apana.org.au>
References: <cover.1716095868.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v4 PATCH 11/13] input: Always push in setinputfile
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

