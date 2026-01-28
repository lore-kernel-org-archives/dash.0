Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED96C8CE
	for <dash@vger.kernel.org>; Wed, 28 Jan 2026 04:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769574701; cv=none; b=bY0L/vfwaL+dTS+4kTcODRdy9VEMvn4q4goXAvQ5dOojgSnSotZkzse6tRVOckWC1Dc1NxZKmVjmW4j5yPT+GvFs3YU/Sz+eCsEeWP5o1tfRtUH0HK5uooCymR2z3dFNcsJn55EPJQEGfQuuR3nZNxiGjz0JrjO5Fee02KIC6g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769574701; c=relaxed/simple;
	bh=tjxwxAmG7evPRMIJ0hdFBpxgm3Ef/i2/ua8weuvSOXA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JfFw1VsW/OtGqTxjatwcOP+9PSqaJAsTyWsMyM6k0+emjGtLmmmAuHI4J/SOnaMmZZOfTFaCdyhEVphG8ARQNE4xw/w7qOIp/poX6KhwOjLu4FMcbDR020vb2ed3si7dtgOE2XrIbvzzd5BAZSbxjgyIlV7VUxqAjO+ygXhT2Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=O6M6OYL7; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="O6M6OYL7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=Content-Type:MIME-Version:Message-ID:Subject:
	To:From:Date:cc:to:subject:message-id:date:from:content-type:in-reply-to:
	references:reply-to; bh=L1w7yh5aDEDKBrtdr7Re5hL+h67HAet5Si1LSHlWYgs=; b=O6M6O
	YL7La5iPRojUCihR4LnxZfMkqDpHoxsOb/Hq4MGFADRF5BIvi/PwJfwiTPFNia7J2HTmgQ7by7UAO
	Zg4pLozCA7KfvPZjX/t/AbstR4miavlFzCS1Rb+PfSuZgU6wOPBtve5o3yD2uUxKUhzfsNrqMJLm7
	Ibvq44zU6+oaAJqC60yzmmf5d+cvx7kUY07I23LPrjC+xpZKVUN4ABSln/MFb3YxaENB8XdQqYWqJ
	c+gKd5CNDhGStbAH/fOcG3GetRwVXo7kQXbxLTQni6FAX9ADkv6yrKbWebg2TggO/3+xqt56TMmlz
	aSmb1NtYVm7zNqo4qktDqZEbn5Qrg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vkxDL-002eaH-39;
	Wed, 28 Jan 2026 12:31:37 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 28 Jan 2026 12:31:35 +0800
Date: Wed, 28 Jan 2026 12:31:35 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] shell: Add support for building without tee(2)
Message-ID: <aXmRJ8t1fW6E-uin@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In order to test the fallback path when tee(2) is not available,
allow tee(2) to be disabled with --disable-tee.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/configure.ac b/configure.ac
index 5efd9e2..89759c5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -40,6 +40,7 @@ fi
 AC_ARG_ENABLE(fnmatch, AS_HELP_STRING(--enable-fnmatch, \
 				      [Use fnmatch(3) from libc]))
 AC_ARG_ENABLE(glob, AS_HELP_STRING(--enable-glob, [Use glob(3) from libc]))
+AC_ARG_ENABLE(tee, AS_HELP_STRING(--disable-tee, [Do not use tee(2)]))
 
 dnl Checks for libraries.
 
@@ -131,6 +132,12 @@ if test "$use_fnmatch" = yes && test "$enable_glob" = yes; then
 	AC_CHECK_FUNCS(glob)
 fi
 
+if test "$enable_tee" != no; then
+	AC_DEFINE([USE_TEE], [1], [Non-zero if tee(2) should be used])
+else
+	AC_DEFINE([USE_TEE], [0], [Non-zero if tee(2) should be used])
+fi
+
 dnl Check for klibc signal.
 AC_CHECK_FUNC(signal)
 if test "$ac_cv_func_signal" != yes; then
diff --git a/src/input.c b/src/input.c
index c36d120..06f1ecc 100644
--- a/src/input.c
+++ b/src/input.c
@@ -185,7 +185,7 @@ static int stdin_tee(void *buf, int nr)
 
 	flush_tee(buf, nr, stdin_state.pending);
 
-	err = tee(0, stdin_state.pip[1], nr, 0);
+	err = USE_TEE ? tee(0, stdin_state.pip[1], nr, 0) : -1;
 	stdin_state.pending = err;
 	return err;
 }
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
