Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02D6327BFA
	for <dash@vger.kernel.org>; Sun,  7 Jun 2026 12:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780837068; cv=none; b=JVrYjU7TESxLZpVYAqeG1Y/+VH0rJSt9pTdKSSL69GGA9qnyyYs+txiq8qjZv/iCa9bM0XThoo1janYaazsoIg+gKwJ8F0PZKRdfLgCsTLblQR50ox+KPcsWGeM07KTMIN6ZsPHeLizwXyvIse/bcWEMjHWCrjxzs5iUq6wva64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780837068; c=relaxed/simple;
	bh=PHbTQbjEFX/xYNt2Kpy2w/TRnjm3/kHwROcJAAaON88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1sdRjsCfpwIBBMpRDBjgb/q8Bbu7LWaTzCzND/E0sfhUGtQEs0UFUHTzhM6o5WWuB1MY+j8Gketu57RVmDH98IHCGstTqedk0ZriPkrkPya8pYAK3Kb8K41fWrId2Qr+gzp+pQsl0QGDwbBmG/P51UPk/dZ5zV96pU6cf2brws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=CVCgSQyH; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="CVCgSQyH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=usrwLvBamSx94/0361cKEufkmURa/KPEWbt4lYbi+NM=; 
	b=CVCgSQyH7yvyV32ZyYjHZJTHoruAj/gXVGLV2FrkEq13k4KsyYHTpKlQ9L6ULNsvhv41bnR7XTv
	DmVxY/1KYItTKFnn6o8C54uTuvQ2BDtA72pXLZr2Rpx+JQjPc+pdNJt9iG3sPTFl7WQShO/RWSB9c
	PKjmf9Za9w51yq118TrnkvjyfdnwPPOg7aAeW3e3+d4XTdU4uiviewu8EqRCsbUEYw4Wz1qvU7Mgl
	dR+HqC/5esrQMbs1Y0ZvNHJdMqz9qRNjBjJ0vKiNbe1EJ1qoH7ooMeoqe/fy4ifcy4lnsFBxxSs8Y
	tnrcVITFuXeXnBfHRw18AebK6DQosi+WqRoQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wWD4P-003GH2-2o;
	Sun, 07 Jun 2026 20:57:42 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 07 Jun 2026 20:57:41 +0800
Date: Sun, 7 Jun 2026 20:57:41 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Nathan Mills <the.true.nathan.mills@gmail.com>
Cc: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] parser: Clamp backslash-c sequences to 7 bits
Message-ID: <aiVqxUU1-tmOQySI@gondor.apana.org.au>
References: <CALjJ9ccF26JgGbQmAf5OLdjRSRC-cKjXYLYhOi0wTJTChFEZ=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALjJ9ccF26JgGbQmAf5OLdjRSRC-cKjXYLYhOi0wTJTChFEZ=Q@mail.gmail.com>

On Sat, Jun 06, 2026 at 02:34:07PM -0700, Nathan Mills wrote:
>
> ** Crash #0: illegal instruction **
> Base64'd:
> 
> JCQkXERdLwovCiQgJC4kJCS4uAwkJFwyXU//AD8KJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQk
> JCUlJCQkJCQnJCQkuLgMJCRcY8TE0V0vCiQkJCclJSW4uAwkJFxEXS8KJCQkJyQkJCQX
> 
> Minimal base64'd:
> 
> JCdcY8Qn
> 
> Minimal reproducer: src/dash -c $'$'\''\\c\xC4'\'''

This is caused by dollar-sq with \c producing 8-bit characters:

---8<---
Ensure that \c does not produce an 8-bit character by clamping
it with 0x7f.

Reported-by: Nathan Mills <the.true.nathan.mills@gmail.com>
Fixes: 776424a8f915 ("parser: Add dollar single quote")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/parser.c b/src/parser.c
index 412e876..65c5fd6 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -968,7 +969,7 @@ static char *dollarsq_escape(char *out)
 
 		p += !((c ^ *p) | (c ^ '\\'));
 
-		conv_ch = (c & ~((c & 0x40) >> 1)) ^ 0x40;
+		conv_ch = (c & ~((c & 0x40) >> 1) & 0x7f) ^ 0x40;
 		USTPUTC(conv_ch, out);
 	}
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
