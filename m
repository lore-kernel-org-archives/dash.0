Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11327D299
	for <dash@vger.kernel.org>; Sat,  8 Jun 2024 03:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717818182; cv=none; b=e4UVrGlHbbI4dtEs4RQfuKGMqaTQe3sc2t9rKyimrkIjcilcNAgso3pkJN6yJFiiMePC9u7Qa4CCMdmj6qflYSV3p9/nXuK3abVm8/egBOuDdDw1rkTfJ2nWQiIwtz1i3PGwQsN7eKzACW2C11tbqgH5EwcvpglVZG9IFbg1xLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717818182; c=relaxed/simple;
	bh=tpove1aBUDvXcY4LzowiyAiSEi2ydOqQbC9OOf92bt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9OURCPeMVyQUAC39Som9jfi44GogdutrM229VaFW7uL9WDlUu2wtd8mKmqMM0+3j6E7vInAyKUd57nrCeXGyqRHKtKxKPA28cJA6/b71drWyo6kU1vQ1pLco3Qk6C5onmXXr7yYiWYhKsxITgCpcxK0xPrejKbonlT/+uz9c7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sFmyh-0074Zu-0x;
	Sat, 08 Jun 2024 11:42:52 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 08 Jun 2024 11:42:53 +0800
Date: Sat, 8 Jun 2024 11:42:53 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jilles Tjoelker <jilles@stack.nl>
Cc: DASH Mailing List <dash@vger.kernel.org>
Subject: [v2 PATCH] expand: Check d_type in expmeta before recursing
Message-ID: <ZmPTPb1C0hZYZQPE@gondor.apana.org.au>
References: <ZlvMLrrmMR92Bbvq@gondor.apana.org.au>
 <20240604212835.GA6709@stack.nl>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604212835.GA6709@stack.nl>

On Tue, Jun 04, 2024 at 11:28:35PM +0200, Jilles Tjoelker wrote:
>
> Good idea, but DT_UNKNOWN might also be a directory or a symlink to one.

Thanks for catching this!

---8<---
If the directory pointer is not a directory, a symlink or an unknown
entity, do not recurse into expmeta.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/expand.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/expand.c b/src/expand.c
index 345c498..6912e39 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -1722,6 +1722,9 @@ static char *expmeta(char *name, unsigned name_len, size_t expdir_len)
 
 		if (*dname == '.' && !matchdot)
 			goto check_int;
+		if (c && dp->d_type != DT_DIR && dp->d_type != DT_LNK &&
+		    dp->d_type != DT_UNKNOWN)
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
