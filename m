Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB0217545
	for <dash@vger.kernel.org>; Sun, 14 Apr 2024 03:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713064079; cv=none; b=o6RE0dD02XbwezfCC2hen82HBSgPWt3VyDfi/xbCU/wTvF2LfR+UWY5EkFpja9KGZOzdmvQF1N8S+RNXLQ63SHsP9RJvblPyIErr0NZBUlGU6x3+yOPeGo8UbLSgTdOCXTNt+Zdp8qsqhCtaBDgT90LqKDWeG04iF5uOOy+uTzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713064079; c=relaxed/simple;
	bh=jzo6aYoD4xd+vbozorCYWtW+W8wl36WPxxrgtSkys+g=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=E6fTRoEkhhBf7GkpCxbatyh/Lt6LFXlu3oOFpmFbb7VzwlWG3t6J96f7R+UzUhm+OaPV4ZS80vDCCeO+0xntWgsyIS0AZcOl0Q6AKq/V2c9MZTNpRqM90kFuqeenIYGEYk5rhQYrYZSzfQoUUCtQ3i2OyeNNNPQ/v3pcpgyM3Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rvqDY-001OIA-Uf; Sun, 14 Apr 2024 11:07:46 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 14 Apr 2024 11:08:02 +0800
Date: Sun, 14 Apr 2024 11:08:02 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: dash@vger.kernel.org
Subject: [PATCH] expand: Fix here-document file descriptor leak
Message-ID: <ZhtIkl3b3GhYVqAJ@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Swap the order of here-document expansion and pipe creation as
otherwise the pipe file descriptors will become accessible in the
expanded text.

Fixes: f4ee8c859c3d ("[EXPAND] Expand here-documents in the...")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/redir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/redir.c b/src/redir.c
index d74602c..bcc81b4 100644
--- a/src/redir.c
+++ b/src/redir.c
@@ -335,15 +335,15 @@ openhere(union node *redir)
 	int pip[2];
 	size_t len = 0;
 
-	if (pipe(pip) < 0)
-		sh_error("Pipe call failed");
-
 	p = redir->nhere.doc->narg.text;
 	if (redir->type == NXHERE) {
 		expandarg(redir->nhere.doc, NULL, EXP_QUOTED);
 		p = stackblock();
 	}
 
+	if (pipe(pip) < 0)
+		sh_error("Pipe call failed");
+
 	len = strlen(p);
 	if (len <= PIPESIZE) {
 		xwrite(pip[1], p, len);
-- 
2.39.2

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
