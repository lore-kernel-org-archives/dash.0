Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286F87262B
	for <dash@vger.kernel.org>; Sun, 15 Mar 2026 09:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773567066; cv=none; b=BEWja/WQp20/oE+mgR0EN3FBojCuUlDKMClh6MN67ht91CMWY90yk4GdX1pcyDsH2BjfGK+weDaATJw18RH6aBxlrs3c6pEDwXj0GrDI9J3+xHqHQBjCJBhvrScgWxtRjFjAErUbUZx9SMwzIuOtxgm7s99aBNjkkNe5GzPCqfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773567066; c=relaxed/simple;
	bh=m0PZSHddwHSdgx4NiW/2zw8lzP5IpfaxavkCMfT6xOo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Vo8tbGtU1YFU8w4cP5CtCrYC5+gpJb2dFEDhHVuOxvJS5p5J5z4SInopK1mUXqH5pfjmQniPVeV7b2YzqTwLJs9hR+WfSW+3q+3MVpvcEftiRLKm792V94dh95M8NFv7wvUV4c/czl8LFBt4l8T9C0IgBonqsJa6F+IsX4y5m48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=cf7AOSGo; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="cf7AOSGo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=MI4XCQEkRmX1Ropp5pIyQZopUVInYN8nhNCSj7kkN7k=; b=cf7AOSGo2ydesuDTDOkF0rKqLx
	1B0QwOwRUV+To/Wh3ynqEBf7EG6suiDx6O8nVAepnInE/NL//IPxULnaoaEV7ZhlSsPbrs4PdrtTc
	zQpwkIKNN0U/unBRGTzcuEKmAMhn7hlGldF1k40ibgb/BH3TTKI4LfEJftug7GrDVGr+pXPPMQ1XQ
	cDR7h4aPqNzNxUPX9vrTTCj4gZp1KxHS73QS/DXvd2SZ6iDzxyu+YlVoW4vnxN4AUB9Z1YNNrkJv9
	39ZzgQIdJiQLtEFLdGjvSbxFhTSAoSd+n01QXB2N84Z+QxdnXmkxl5UG7xyi8l7WjS+aqG2U5BaWA
	VmhdsG6g==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w1hoJ-00EZUO-2v;
	Sun, 15 Mar 2026 17:31:01 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 15 Mar 2026 18:30:59 +0900
Date: Sun, 15 Mar 2026 18:30:59 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Aleksander Ushakov <retes672@gmail.com>
Cc: dash@vger.kernel.org
Subject: [PATCH] builtin: Fix read overflow in umaskcmd
Message-ID: <abZ8UznmkhG5YmQZ@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADdNFavvayk-kQPYNT0twBuWmGpqoiMTX+_RhRstNgC4AxM6uw@mail.gmail.com>
X-Newsgroups: apana.lists.os.linux.dash

Aleksander Ushakov <retes672@gmail.com> wrote:
>
> umask -S u=rwx,g good=r FOR A PARTICULAR PURPOSE.  See the

This is the minimal reproducer.

Thanks,

---8<---
If the first character after ugw is NUL, emit an error immediately
instead of continuing to read past the NUL.

Reported-by: Aleksander Ushakov <retes672@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/miscbltin.c b/src/miscbltin.c
index 5aa2b24..e66666c 100644
--- a/src/miscbltin.c
+++ b/src/miscbltin.c
@@ -274,7 +274,10 @@ umaskcmd(int argc, char **argv)
 					}
 				if (!positions)
 					positions = 0111; /* default is a */
-				if (!strchr("=+-", op = *ap))
+				op = *ap;
+				if (!op)
+					goto error;
+				if (!strchr("=+-", op))
 					break;
 				ap++;
 				new_val = 0;
@@ -314,6 +317,7 @@ umaskcmd(int argc, char **argv)
 					break;
 			}
 			if (*ap) {
+error:
 				sh_error("Illegal mode: %s", *argptr);
 				return 1;
 			}
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
