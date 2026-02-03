Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847771D5174
	for <dash@vger.kernel.org>; Tue,  3 Feb 2026 05:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770096971; cv=none; b=rQgraukUM5pgZ2ygWvX3uFtwD86WSo0BCXBQbTlsmySznRnqectwMERUmhGkQhaUSPUCoo3GAAckIFwt+bRE6Yg1Yrlc2qDTwRiao2LwRT/UqbcqeT5PPSKMeGb3kqDxCRgM5YoSg3677l7g+WIrkwO2+ycu1vDOeGSVtaSZJEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770096971; c=relaxed/simple;
	bh=AfSgki9XwPQCSWJvLEz4PPBhGG1meOF6cjODirJSn3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APpHXPl4Uz88Lfuoxxcf0BpLvJVSBmPmZHQQodTRJVp/LawRSuhMi84ZBIXLOUCAV4HlOha43UDeNtI+k7BbqdYXn4vduABtrwvTof66N+QUMVIBZVV67XqRdR8aNF9hHV2DRtkQHnSbxUn1BmwiXyB4e06oKifrBaysBrEB79U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=sEcEiX4h; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="sEcEiX4h"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=+5tlRgnRfx0IVTbGE5mqp2xgNa2aI5mLyd2TonIaNlM=; 
	b=sEcEiX4hhG2A3k55WyPiV7ESzdehec946dEjkxTjdiueBMByZru1ttrGXoWxI3OB6NJ2WDkoKje
	lYSrsKMQkU8WHSzKLU4WLyo6Xkaa4p19g3eTtFOLoPLqyW64zz2mPQTBXYXg2ojkuoAEuIJnzkaGk
	5G83svRI1zSdHfDYtLs6kUIhF44BcMPSEB8Kh+NGXVHNzmJxi66jnT3rRmBsorm9H/qMAy0NAPWfQ
	H76GgS8K3uqLgt6WM5vXPQRP10+l3+8Bons6MYu9yNdwQPCBofxPNYfI/V2tA3Jp5kPhrg1bHjoVl
	KZw/m/yqzY/sU9zTTpCr0RPZzPs0c14n+wIA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vn951-004508-2D;
	Tue, 03 Feb 2026 13:36:04 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 03 Feb 2026 13:36:03 +0800
Date: Tue, 3 Feb 2026 13:36:03 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Hadrien LACOUR <h.lacour@sim-and-cure.com>
Cc: dash@vger.kernel.org
Subject: [PATCH] jobs: Fix here-document crash
Message-ID: <aYGJQ6uQGFLwcvVh@gondor.apana.org.au>
References: <CAKmiXcjdFDh_jMak8S0mq5SjWO4m5K67ZKMu5HPdhPby-uUTgw@mail.gmail.com>
 <aYFfc-uXWlN8Pbor@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYFfc-uXWlN8Pbor@gondor.apana.org.au>

When forkchild is called while expanding here-documents, the job
pointer is set to NULL.  If this is the case, there is no need
to free the job pointer and other outstanding jobs.  Simply return
if this is the case.

Reported-by: Hadrien LACOUR <h.lacour@sim-and-cure.com>
Fixes: 9881d00e939e ("jobs: Preserve parent jobs for simple commands")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/jobs.c b/src/jobs.c
index 6622bdd..36c6261 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -919,6 +919,9 @@ static void forkchild(struct job *jp, union node *n, int mode)
 	if (lvforked)
 		return;
 
+	if (!jp)
+		return;
+
 	freejob(jp);
 
 	if (issimplecmd(n, JOBSCMD->name))
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
