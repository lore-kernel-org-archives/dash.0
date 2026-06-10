Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2472C11CA
	for <dash@vger.kernel.org>; Wed, 10 Jun 2026 03:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781062885; cv=none; b=c44RhyaH4n8G6r2ZxJwQweMsY/OSqbFKPnnVDna1aFSIvcvgevalGlY8H+6v38lSLpuLstanBq+UjtqA1E01siuwt7qJxHDP7x/iu6fm6Jx1u1j46ggKIaQ0gBIdJHUpV1/HBzGYx4Mw708GIWoBM4X0TPxr996ZM5skBrRdFc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781062885; c=relaxed/simple;
	bh=h+4QSCcZoua585ng0kdjjbFpyJNT6FPaJZwhd3rvjYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LonMVg4X0q8LAnInfEBwNzsOc0qfjHhoI31EnZbMbU8haclhZa+ff3wnlOmZA7Mc1KTWQzByIySmsoUPeBJOCe07rYk5LmyTvyv7ZLIyZbeXPVxT6fiYiI7/JS6h8ZH3/ka9gHxWEhDBmjERTvdVoMTv7E/jSb+TyfjNJmNcwXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=dfwbjDjY; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="dfwbjDjY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=IKHq1R8iCF4ZoOrdW6OglmdNXTl8vXgnIzIeV4Gm99Q=; 
	b=dfwbjDjYxoXi7VC8YZ9JOA4aO5S4e/dAbF6g6AD3b5qbZPTbj5bW24dfKuKEMSvdIcOz0IRNa3l
	m8849BKUIW4mMAcq0BZ1G6LVh6D+B203XfhcgwSWZGV8r+FXFlKIfynLa4+uKibtUSsfX+Fag/ib4
	RmF2DKPHrrXIrpo6jy2F/FzXiI9pLH0so85HWeJTUxk2CakusQ3w0hrAy9yPDa3pkIoBeuChnEcPS
	PbF8JK6hjeVWe1eF3L+oCUAQA48G7tzks4BWMvbnvz6+kfVUK928tBkDffyR3k7ilGRyqhnqQSBH+
	5biiXEVxqrNurPL3z6dWDXTfqvUNzvez+jBA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wX9oa-000000049mP-3dlq;
	Wed, 10 Jun 2026 11:41:17 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 10 Jun 2026 11:41:16 +0800
Date: Wed, 10 Jun 2026 11:41:16 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jilles Tjoelker <jilles@stack.nl>
Cc: 733852@bugs.debian.org, Vincent Lefevre <vincent@vinc17.net>,
	DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] parser: Do not print prompt if input buffer is not empty
Message-ID: <aijc3HAfGgzoVPqT@gondor.apana.org.au>
References: <20140301144245.GA34436@stack.nl>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140301144245.GA34436@stack.nl>

On Sat, Mar 01, 2014 at 03:42:45PM +0100, Jilles Tjoelker wrote:
>
> I expect that the extra ugliness caused by this incomplete check will
> not be worth it. It would be better to enable libedit or to use a
> version of linenoise (link it statically to avoid the impact on fork()
> performance).

I'm feeling generous so this patch works for me.

> By the way, you can also have a "spurious" "$ ":
> $ echo a^Jecho b
> a
> $ b
> $ 

It fixes this problem too.

Thanks,

---8<---
Do not print a prompt if there is still input left over in the
input buffer.

Add a noinline attribute to setprompt while doing this as otherwise
gcc will produce horrendous output.

Reported-by: Vincent Lefevre <vincent@vinc17.net>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/parser.c b/src/parser.c
index 412e876..4e8daf7 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -1705,8 +1705,7 @@ synerror(const char *msg)
 	/* NOTREACHED */
 }
 
-STATIC void
-setprompt(int which)
+static void __attribute__((noinline)) setprompt(int which)
 {
 	struct stackmark smark;
 	int show;
@@ -1719,7 +1718,7 @@ setprompt(int which)
 #else
 	show = !el;
 #endif
-	if (show) {
+	if (show && !parsefile->nleft) {
 		pushstackmark(&smark, stackblocksize());
 		out2str(getprompt(NULL));
 		popstackmark(&smark);
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
