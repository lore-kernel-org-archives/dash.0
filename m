Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3AE11CA0
	for <dash@vger.kernel.org>; Sun, 28 Sep 2025 03:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759031125; cv=none; b=bPgWIj0qi5tbUGi37Rv8/cuz6lhUQJla65tn2f5mD40UJ/kvTkQUupklkGw57nvIAT+di2m6o//a2ITf9d1IvvQxUuWBp4HhLUK8TimGXSjd5Dcd8yUGZzYz/xNs5v1piHdMwZ7ljLp0jJ49yAwK9r0oB0iGIH526NUYRLy3abo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759031125; c=relaxed/simple;
	bh=y2beXJwb6nAuHxyi4ib8Vfi27iev0COllwmCXeXYgeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enN1QW3R+joF6FuIMvgzZL9H4MFZAZCFKJC39zaMQ+G3MkKyVGrZAfADNrX5v92msibgamHMQdI/0ooFYEENglltkK1q9bT3AEIBaOJhVjDp8VQ9rAAxY7kHXzmvCNewBbluEL1VICsWrzki6AjvOZzmdZGJhCTTKzNvLztRU3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=MJlFeXU9; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="MJlFeXU9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:cc:to:subject:message-id:date:from:reply-to;
	bh=rdP0CsE8xjpGhGpNvq0aYdynDg2TOTKfNcFy78X3//M=; b=MJlFeXU91E3mxciYDfu3YLqXtE
	YLaizSJm09IVVtx5Rka4aTeoBX6Amh3M5laDfgxo9x45VB2KexAKS2OHNWaDVSqNBN5Y08fdhwS8L
	bMrqVeIf4r7iPAO1uyyHNSczE9zMrYJvNQDz/c2q1tINtXAYjyEcjOe4PYRGk34b+OHukOBkg5ck7
	+gef+5FVhPuOG0tFyEcBQYT4eUKBVphNOnJvb9UvB19LAN/2/dsetUGYl4gAlYg7mMzBLNJr657cT
	vD38ZrD6NujaL1g9beffcQLu0dJ/mcp0jA5k4TqotFNJMifS6Q4UVmI/EtAsSG7g50aza0uE2ioQy
	7ISSuCkQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1v2iLe-008qH3-18;
	Sun, 28 Sep 2025 11:45:19 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 28 Sep 2025 11:45:18 +0800
Date: Sun, 28 Sep 2025 11:45:18 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Reilly Brogan <reilly@reillybrogan.com>
Cc: dash@vger.kernel.org
Subject: [PATCH] expand: Fix off-by-one bug in expmeta
Message-ID: <aNivTiVPAJAgHDDH@gondor.apana.org.au>
References: <d3a79537-be6a-4e5d-afe6-8b8d9dd57955@reillybrogan.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3a79537-be6a-4e5d-afe6-8b8d9dd57955@reillybrogan.com>

On Fri, Sep 26, 2025 at 04:15:15PM +0000, Reilly Brogan wrote:
>
> ../configure: 9961: .: cannot open ../gcc/cp/config-lang.in���M�U: No such
> file
> ```

This was caused by the failure to include the terminating NUL
character when expanding path names.

---8<---
Ensure the terminating NUL character is included when expanding
path names.

Reported-by: Reilly Brogan <reilly@reillybrogan.com>
Fixes: a9012f4078be ("expand: Process multi-byte characters in expmeta")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/expand.c b/src/expand.c
index 1fab394..912384d 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -1686,7 +1686,7 @@ static char *expmeta(char *name, unsigned name_len, size_t expdir_len)
 			goto out_opendir;
 		enddir = expmeta_rmescapes(enddir, name);
 		if (lstat64(cp, &statb) >= 0)
-			cp = addfnamealt(enddir, expdir_len);
+			cp = addfnamealt(enddir + 1, expdir_len);
 		goto out_opendir;
 	}
 	start = memrchr(name, '/', p - name);
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
