Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6947080E
	for <dash@vger.kernel.org>; Mon, 16 Mar 2026 04:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773635078; cv=none; b=klsJtTzPNI98odOUpNC0q6td2nN1EMpU7cQl+m8qaSf/yRRif1gR6x7aU4TB9aXXzLQpyS6bo/3ioTCYyTSuZZ9jx1xQp17hfIVE2ZZT8oZRY1k5F3BRNnWTPHImujYq0fxRfH7fqAUSUgQFWUJvh1og22pYR3VXk7L2Tq43Xjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773635078; c=relaxed/simple;
	bh=sUvUsw9k15usn4KLGVGcmqEN1SA+x5JBJGZ6Jh72+Fk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=juSPdgmp4ALFsD7whXWbhBkfJ7E257tVo0ZeQk+W9nj5z2YT98D2e8veEVPY5eypWMb3upoButmJZGVScVJr+unfkscFjKOhWehwOz0RTQKg2MG5+kGbcDRIM1jzGl5yDAhsUcsXthH5RH3x3NfQomRZHVipyUBePjyUVQUc2Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=FAIbnHc2; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="FAIbnHc2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=3wyiIx8FfA27t238XAtK5/fl7hxL9PhBeM/WEFU5vEA=; b=FAIbnHc2hmNcvKO2OPaiPbfLP5
	gi6FAwRW5v/9ICYJmBz+FWayERBZ35awSv2883RX22Z6X8MVgRetLuAe8ONrrFWhZPKWrZwwdsr7j
	fATf2M8uTvS0sI0DlLpi3pGlSVpjFPo7U/MZDiPOS7u5jeCapmZwHC/obQ7QU8CCOHUe3OvPEfCm4
	MmyaCnHgXROqJ8Ien47qVVge5TMhpvpijtE7B1iqORS/KmFCtWzs7/W1+udxdpsIs8SpApWK2M683
	hNaLXDknznRAk+NUaE+lEEqNApvPvK6qedFPt6GwNXi8tjJjjnN6qrib3rB3dc8zePP57iyxW8X5K
	uNHTlbAQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w1zVI-00EjNK-2l;
	Mon, 16 Mar 2026 12:24:33 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 16 Mar 2026 13:24:32 +0900
Date: Mon, 16 Mar 2026 13:24:32 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: dash@vger.kernel.org
Subject: [PATCH] jobs: Make stoppedjobs trivial if JOBS == 0
Message-ID: <abeGAGxKpxqCMdyl@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK1hOcPd4Lm6ixcQ_+NG5rsA5uP4A0-oHwWQWdqj3BCyJHJE7Q@mail.gmail.com>
X-Newsgroups: apana.lists.os.linux.dash

Denys Vlasenko <vda.linux@googlemail.com> wrote:
> Good day,
> 
> There is only one place where JOBSTOOPED can be set,
> and this place is conditional on #if JOBS:

Do you actually use dash with JOBS == 0?

I wonder how much testing this actually gets because I have never
used it.  We could do something like this for stoppedjobs.

---8<---
When job control is disabled or unavailable, stoppedjobs doesn't
need to do any work.

Reported-by: Denys Vlasenko <vda.linux@googlemail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/jobs.c b/src/jobs.c
index 36c6261..4aa65b6 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -1237,6 +1237,8 @@ stoppedjobs(void)
 	int retval;
 
 	retval = 0;
+	if (!JOBS)
+		goto out;
 	if (job_warning)
 		goto out;
 	jp = curjob;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
