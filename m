Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7386653
	for <dash@vger.kernel.org>; Sat, 27 Apr 2024 09:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714209080; cv=none; b=hlpP7OmoWJtbjHUvTZ0KhqWFVtXIcrcYbds3EoqaTfH+26LBEvtxkKSc1zpP49D3EE9F7zBTRaUPVoqpD6pp0xIyRRt1SC2Is3jZTY8A2tBp8mEQEswW4wLyOz1R/QYcO3kkISjn87GFqlMiukJWWVQCiYuqnm1ko1txC9TibDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714209080; c=relaxed/simple;
	bh=16aG5k1t/BOIjyKRaX1C5/esqkKLQKd2lr8/mpuTP+8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Agn8cgi43034XRd9IDnqLE5OX3IKVZJNarpE/hqYI8QqfgXg+c68AhBnJ9RBV8dvcwsrBDNoHY3QFYVDLD2g6KN6/tsanGTEcjIc+RJw5AFn6PPmmMkPneRZXQR4E5Opo+RWH/3Eb25e8E5t1gQd2jPIs0zYW/VGx4J8gAMq8ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s0e5R-00786E-2B;
	Sat, 27 Apr 2024 17:11:14 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 27 Apr 2024 17:11:31 +0800
Date: Sat, 27 Apr 2024 17:11:31 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: dash@vger.kernel.org
Subject: [PATCH] main: Fix profiling on longjmp exit paths
Message-ID: <ZizBQ4KYRqO4B3Bc@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Ensure that longjmp exit paths also write the profiling file.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/main.c b/src/main.c
index 5c49fdc..7beb280 100644
--- a/src/main.c
+++ b/src/main.c
@@ -112,7 +112,7 @@ main(int argc, char **argv)
 
 		s = state;
 		if (e == EXEND || e == EXEXIT || s == 0 || iflag == 0 || shlvl)
-			exitshell();
+			goto exit;
 
 		reset();
 
@@ -175,6 +175,7 @@ state3:
 state4:	/* XXX ??? - why isn't this before the "if" statement */
 		cmdloop(1);
 	}
+exit:
 #if PROFILE
 	monitor(0);
 #endif
-- 
2.39.2

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
