Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F6A1A2C10
	for <dash@vger.kernel.org>; Sun, 19 May 2024 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716129385; cv=none; b=VOGRvoFaXdwunmu+6HZOkPcveMJnxxzDqv3TsXXX6JEn9JgVINtVR9V4sWmR0k35CjCG9O6VKbXvg26HX8sV9UIFOLFnVt4Vxt2yw5YHG8bRP8JBP859x5SWUsz8uw/+tTDFaoyZgHRNwiIv2fXrqWXb/XPygAM9A7WuruDGSqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716129385; c=relaxed/simple;
	bh=SFbaP7X4+tuKQ/qHlt7DGfSWCADw1jAP8ymCpI2rUvc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TxnhaK1Ei+0iJ5tlbAFCnNAQshAlj1uaRyvnnHj1e3B/Gipa/25upfa1p7/dJfs1PDeio1AEvxrHk576Dq4H8RTcv+Wt+iLvIuWSGRWREqPMKwXfZXJfmWESor4tW0SY3/dxk7OaCH06mfuXJIeiSvk5aDFDoT/hCo/bulwWuXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s8he5-00HMaq-2g;
	Sun, 19 May 2024 22:36:18 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 19 May 2024 22:36:19 +0800
Date: Sun, 19 May 2024 22:36:19 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] shell: Disable fnmatch by default
Message-ID: <ZkoOY9cWtv09aDjg@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

As fnmatch(3) is terribly slow with multi-byte strings, disable
it by default.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/configure.ac b/configure.ac
index 50effc0..338d5bd 100644
--- a/configure.ac
+++ b/configure.ac
@@ -37,8 +37,8 @@ if test "$enable_static" = "yes"; then
 	export LDFLAGS="-static"
 fi
 
-AC_ARG_ENABLE(fnmatch, AS_HELP_STRING(--disable-fnmatch, \
-				      [Do not use fnmatch(3) from libc]))
+AC_ARG_ENABLE(fnmatch, AS_HELP_STRING(--enable-fnmatch, \
+				      [Use fnmatch(3) from libc]))
 AC_ARG_ENABLE(glob, AS_HELP_STRING(--enable-glob, [Use glob(3) from libc]))
 
 dnl Checks for libraries.
@@ -122,7 +122,7 @@ if test "$enable_test_workaround" = "yes"; then
 		[Define if your faccessat tells root all files are executable])
 fi
 
-if test "$enable_fnmatch" != no; then
+if test "$enable_fnmatch" = yes; then
 	use_fnmatch=
 	AC_CHECK_FUNCS(fnmatch, use_fnmatch=yes)
 fi
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
