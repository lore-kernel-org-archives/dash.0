Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAB54A35
	for <dash@vger.kernel.org>; Tue,  3 Feb 2026 05:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770095069; cv=none; b=PV3FQwbej3YNGYIunUOSQqMZNYBm2g+k+T6F1hbza94fO0L2ZC4ijyoVkYOlKDgoxFsW/kSCz0ybDWKfIcXWlzeoY084WYJZjaFpl0uJoMEEfuNAcK2lTtrwcHAjCgNWEjRMd3E2ripQIDP3t4E3bazoQzH2i7IVfsYnMG6CGLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770095069; c=relaxed/simple;
	bh=qN5cu76djxpaNqgC69B1w5T+nhrosaD2/xijKbJBRNE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pOZ+OrQxtLQtQYb/dike+V1kVuFYGnXnEq40q1aYP9S6INvULTKw1Yb5qn4gP6Fayuj/FLAxvs5KHoBpqzoDjDyuMY6gZuDA5yPadY6Cxn2MGMOOHuuAXKzpZ3a4xHx4aMhN26CaHTbNpkeXtw3U+U+hVPQ5IIE9gKWZ3yfT0Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=LgmHTyG0; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="LgmHTyG0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=Content-Type:MIME-Version:Message-ID:Subject:
	To:From:Date:cc:to:subject:message-id:date:from:content-type:in-reply-to:
	references:reply-to; bh=dXg5gatvgWhQcMDGco+1O3c/r4q+wTAi1WYR5b1LzgA=; b=LgmHT
	yG0efvxsCxk0AiDWct2uSK2My7Nn8ro7GfDjt+g6KTZCdboyUJVmisR9zdooqd9pHCJbki52kgxeq
	cwwuy/3QmJVU3YZ81R/iV8byiVTxbKyvPw3fv2yR7haleuOy67HYPJL7omo75pltEb9/iV7z5/UAd
	YS9qHq/gTMighKbilov6dGtvsi0WVUQTiXJz6fzi9fHOum5Apu2JHpMfbgfBM27EUo9h+O2uc7J+T
	K7BeL5/uusxjRBmy3C4ijmKLjzDSkxZzYUYYwtXlX046liaZSGGxaNmkwxy/qqs3NOOVMlL+h6a8J
	+7oJs9C1jg9iLLZB8dgdTiB7jwmqQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vn8aL-0044hz-1O;
	Tue, 03 Feb 2026 13:04:22 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 03 Feb 2026 13:04:21 +0800
Date: Tue, 3 Feb 2026 13:04:21 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] shell: Add support for disabling memfd_create(3)
Message-ID: <aYGB1YPmh0vh8UKL@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In order to test the fallback path for systems without memfd_create(3),
add a --disable-memfd-create argument to the configure script.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/configure.ac b/configure.ac
index 5efd9e2..bdcb339 100644
--- a/configure.ac
+++ b/configure.ac
@@ -40,6 +40,8 @@ fi
 AC_ARG_ENABLE(fnmatch, AS_HELP_STRING(--enable-fnmatch, \
 				      [Use fnmatch(3) from libc]))
 AC_ARG_ENABLE(glob, AS_HELP_STRING(--enable-glob, [Use glob(3) from libc]))
+AC_ARG_ENABLE(memfd_create, AS_HELP_STRING(--disable-memfd-create,
+					   [Do not use memfd_create(3)]))
 
 dnl Checks for libraries.
 
@@ -131,6 +133,14 @@ if test "$use_fnmatch" = yes && test "$enable_glob" = yes; then
 	AC_CHECK_FUNCS(glob)
 fi
 
+if test "$enable_memfd_create" != no; then
+	AC_DEFINE([USE_MEMFD_CREATE], [1],
+		  [Non-zero if memfd_create(3) should be used])
+else
+	AC_DEFINE([USE_MEMFD_CREATE], [0],
+		  [Non-zero if memfd_create(3) should be used])
+fi
+
 dnl Check for klibc signal.
 AC_CHECK_FUNC(signal)
 if test "$ac_cv_func_signal" != yes; then
diff --git a/src/redir.c b/src/redir.c
index 8d1c8f6..e61d3da 100644
--- a/src/redir.c
+++ b/src/redir.c
@@ -331,7 +331,7 @@ static void dupredirect(union node *redir, int f)
 int sh_pipe(int pip[2], int memfd)
 {
 	if (memfd) {
-		pip[0] = memfd_create("dash", 0);
+		pip[0] = USE_MEMFD_CREATE ? memfd_create("dash", 0) : -1;
 		if (pip[0] >= 0) {
 			pip[1] = sh_dup2(pip[0], -1, pip[0]);
 			return 1;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
