Received: from norbury.hmeau.com (helcar.hmeau.com [216.24.177.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8003F17C202
	for <dash@vger.kernel.org>; Wed,  3 Jul 2024 10:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.24.177.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003915; cv=none; b=dLF2jt7IQUtQGjMayTgLHqptWib6YlghEDqigkHXkWiFRMeSMSJ7qT+Cxp7AhR2NaITYvrQq0NwOsXLKPc1NOafN4MCPqXRAcIwSBloMkmIYpycwD4PoI8u0Fw0hS1yBu6MWe7N8pd4rijVtQmfNwqknsCQlmCnzfX8oNfGZI2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003915; c=relaxed/simple;
	bh=rN/M29tRSJ8t4Z0q/XCZw/HT/alNjtXb6vNnZkjxB3U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AVMnSPpKR1O6dclXuC8T1l+FZN1EABCMQ5c1lE1Mnc5XcEh32I4WmW/FgEb3TSu/vwM6UHHi1KV9W1o4NseHIufraHOWJXUiy+ASLQVE4jJfnaqBI+YiSh/cXwVbFcFUCHoqjy8GK4SM0t8m/DspUBCfMpmCJPQ9aXWCeE7LqIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=216.24.177.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
	by norbury.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sOxaI-005ib5-0i;
	Wed, 03 Jul 2024 20:51:35 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 03 Jul 2024 20:51:34 +1000
Date: Wed, 3 Jul 2024 20:51:34 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Martijn Dekker <martijn@inlv.org>
Cc: dash@vger.kernel.org
Subject: [PATCH] expand: Preserve MBCHAR in argstr when EXP_MBCHAR is set
Message-ID: <ZoUtNluFpgNqGzXB@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6bf6cd67-7125-4d1f-8673-110e026fbaa5@inlv.org>
X-Newsgroups: apana.lists.os.linux.dash

Martijn Dekker <martijn@inlv.org> wrote:
>
> ...'case' is broken for multi-byte characters. The following test script, when 
> saved in UTF-8, outputs 'BUG' instead of 'ok':
> 
> case "ρ" in
> ( "ρ" ) echo ok ;;
> ( * )   echo BUG; exit 1 ;;
> esac

Thanks for the report.  This patch should fix it:

---8<---
MBCHAR should be preserved in argstr if the EXP_MBCHAR bit is
set.  This broke case statements.

Reported-by: Martijn Dekker <martijn@inlv.org>
Fixes: 6c44f4ee0c2b ("parser: Add support for multi-byte characters")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/expand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/expand.c b/src/expand.c
index 5285b79..93bb9a3 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -371,7 +371,7 @@ addquote:
 			c = (signed char)*p--;
 			mb = mbnext(p);
 			ml = (mb >> 8) - 2;
-			if (flag & QUOTES_ESC) {
+			if (flag & (QUOTES_ESC | EXP_MBCHAR)) {
 				length = (mb >> 8) + (mb & 0xff);
 				if (c == (char)CTLESC)
 					startloc += length;
-- 
2.39.2

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
