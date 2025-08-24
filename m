Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC194CA5A
	for <dash@vger.kernel.org>; Sun, 24 Aug 2025 01:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756000285; cv=none; b=hNAy2q/f8ckZX39Noovy8/2NBy+kUxg/1rN3JpxgI4UNEtu0LD31LfAt4kA41ZCIeiPkKWdEluIdyB+21qf1e/DQM9y8tNsu7JchgiZXPc82yHcBfSvQhQVHgsQ/PbX1WbhnC0bO4P6bsauUGaTT0Isifk8ZU4JDITe2hlJ+2lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756000285; c=relaxed/simple;
	bh=DxjFjMPSkSWFznJ525nQDVYVXFR7fSQRd8qFnSreiTk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FdKZUi78MtxzCuydTmfKjqZ8+dfzxFvwBGC132py6t8s0vRrOqg7YpBqxsCE4SEKebvDuup2/JiVAQBzKgP6WEm5ZfYsKHrLwV6pNDD01zFzmDA3dNnMBEvdFxIaH3MGvE5bcM+oioVUtfhc45PswQDO52tbLaNL4cOutKmZDTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=cAX5htM6; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="cAX5htM6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:
	Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/XhQKkL5WsZU2aVCRWP28QFvKLQA3MXORp7o30cfloA=; b=cAX5htM6uBJdIzv/9jXp0pSgCc
	pqGh8hKsjQnX9t6xMOXWbVd1trGAqDgJjd/qv7epwMZ3IVjluuNXrA8LPJBojZG/nnNye3pUASQVV
	lQs8rLppj286nSjRH4oo+wslu2IWC4fzSIJASz1dSzfSOMoBHlwuQuQXOcmiztMZJQ9KiPz1qXXmf
	lbyqqv9X4/2iOx0jj72eCwFMLvDvSJtlAHWyY0elQGVF30CZTYdUJ/Ke8PNX0nMekwAy5B9tAIR5H
	haoCfQ459KeCve9PU9GzgLSdCtJp42f5h25H9NV/PW12iWRqIVNGONj0Vq9WGCCl7zkM4mpDnhGBp
	Ds0FPLiw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1upzdU-00GjbL-0w;
	Sun, 24 Aug 2025 09:51:05 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 24 Aug 2025 09:51:04 +0800
Date: Sun, 24 Aug 2025 09:51:04 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] input: Call input_init on first use
Message-ID: <aKpwCDa3lp4DVT4o@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When the shell is used to execute another utility, it makes no
sense to initialise stdin, which costs up to two system calls.

Since the input layer can already handle first-use initialisation
because of reset_init, simply make this always the case.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/input.c b/src/input.c
index 1aff3d4..c36d120 100644
--- a/src/input.c
+++ b/src/input.c
@@ -77,7 +77,7 @@ MKINIT struct parsefile *toppf = &basepf;
 MKINIT struct stdin_state stdin_state;
 struct parsefile *parsefile = &basepf;	/* current input file */
 int whichprompt;		/* 1 == PS1, 2 == PS2 */
-int stdin_istty;
+int stdin_istty = -1;
 
 MKINIT void input_init(void);
 
@@ -99,8 +99,6 @@ INCLUDE "syntax.h"
 INIT {
 	basepf.nextc = basepf.buf = basebuf;
 	basepf.linno = 1;
-
-	input_init();
 }
 
 RESET {
--
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
