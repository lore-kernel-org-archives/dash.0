Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE484C79
	for <dash@vger.kernel.org>; Sat,  4 May 2024 07:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714807289; cv=none; b=nusbD3yAy9crNhe6GEXbh88k2wFyKaq0NCta2Wq7AafnPDUApmIWanfo32hM7zxWfLQtehK0r/1wUKwMMAXCfklYQvWB8eXMuUwp5EYiK2+6bsR0DJrDtEkyE0cJgX9vK7x6P4x8lgCU0b3GLWSvkT9FhZqCwMN8OEfAFgNFu0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714807289; c=relaxed/simple;
	bh=friR1lC8i+dju+WpqwLLyJHxnn3hNZTMzSpKFXOkcjc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QjJ59UyMWMg0fCTP6syYg3iApZybIcvjNRuvayye5IxffW4/I5KkQpsbY0zbuuqOCMt/pbgrK4adBZsNT0CNcnqpgfoJjtWnCt7YyRLh5/i8+rSC4KzW2kG864Lr465KTHP41fsUi+4W/esnUudArnuO2WHrXQnKeaQJhxcO+/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s39hx-00AG3J-37;
	Sat, 04 May 2024 15:21:23 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 04 May 2024 15:21:22 +0800
Date: Sat, 4 May 2024 15:21:22 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] redir: Fix double close in dupredirect
Message-ID: <ZjXh8vLqXmA2BQR3@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

For a redirection like "> /dev/null" dupredirect will close the
newly opened file descriptor twice in a row because sh_dup2 also
closes the new file descriptor.

Remove the extra close in dupredirect.

Fixes: 509f5b0dcd71 ("redir: Use memfd_create instead of pipe")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/redir.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/src/redir.c b/src/redir.c
index bf5207d..2505d49 100644
--- a/src/redir.c
+++ b/src/redir.c
@@ -319,11 +319,9 @@ static void dupredirect(union node *redir, int f)
 				sh_dup2(f, fd, -1);
 			return;
 		}
-		f = fd;
+		close(fd);
 	} else
 		sh_dup2(f, fd, f);
-
-	close(f);
 }
 
 int sh_pipe(int pip[2], int memfd)
-- 
2.39.2

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
