Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821F81624C0
	for <dash@vger.kernel.org>; Mon, 13 Apr 2026 23:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776123923; cv=none; b=WiISMZqyBQ75Uv5dqmAXLOniyd8lK7ZJCO/SkxjFG6hSnRTGCsN591nCq0Cn2cWCNlf5lksztbcUt/BqszeuxUPj6JeKY0pltlOSeohpsWmih9+5Gu4skCqea4YwVt0IWnDPWr1zeCNGq3x6GrKBHEoYHLV0m7ZtNuznVlvnQ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776123923; c=relaxed/simple;
	bh=EV2mWOiwi5aehCXmWJ1MhUpTub3c2Zwr7ETAd7sKXbU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BJLV6CQGe1EFCAjjqNnR8/lKYGrQo8Et6ycwDBVl+nmDULegHLU0/Qb1+wfXBCApgxq5mQUdnm7sbNaqDdjeP0LeuXQgnMK6Edal4kE8RzmaFHGkvY1Yo/XvwYpODOgjOhhTT4ZLXy/VMnXFAlao8X/qNoEeaMTH1zMWXXkexuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=bZc8xaGC; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="bZc8xaGC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=s5Fvb+MAJ1t6qTQ9nm9bnv7U/nQmFCfSxiM4ePooErU=; b=bZc8xaGCkxxlJyajY5ZhCcR5JH
	HB+fk+h2xXN9E2ch4a+VdrSirME4SJX3Wx4QrLmeaSblg58tF2N6dEBRBrb+TKLsYAW+wzXa9EMKN
	xBDU2nVKd9QPCpoS57awEaW5Yga39tt66aV1UjEWqA0i1BnTc6fDGFp+AdhF0luxh5gOHLl1TZ0we
	9+Vfj7Gl/zKiNVmphC9ckCxxhtshkcZ/t+jWmQQ/XzrXjtQ3XJEE+sgdq2e3YJ7bMGHEuo+bmqDgI
	4Twr902ugKG80zuRD/unxjzikm9g9iwSes6OWdNoTBRhqHF1fAOdx7ceBVBBpY96ZLskbC0C7s/8u
	l07oJxaQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wCQYL-005sI4-2s;
	Tue, 14 Apr 2026 07:45:09 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 14 Apr 2026 07:45:08 +0800
Date: Tue, 14 Apr 2026 07:45:08 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: DASH Mailing List <dash@vger.kernel.org>
Cc: ignacy.gawedzki@green-communications.fr
Subject: [v4 PATCH] input: Fix EINTR handling when reading from a pipe
Message-ID: <ad2ABNCVXruuMNvQ@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adt1kl_3p0r4E7PG@gondor.apana.org.au>
X-Newsgroups: apana.lists.os.linux.dash

Restore the fallback tee definition so that it actually compiles.

---8<---
Errors from tee(2) should not lead to the fallback path in every
case.  In fact, only EINVAL should trigger an attempt to call
read(2).

Every other error (and zero == EOF) returned by tee(2) should be
treated as if it came from read(2).

Reported-by: Ignacy Gawędzki <ignacy.gawedzki@green-communications.fr>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/configure.ac b/configure.ac
index c37eefe..d749440 100644
--- a/configure.ac
+++ b/configure.ac
@@ -135,6 +135,10 @@ if test "$use_fnmatch" = yes && test "$enable_glob" = yes; then
 fi
 
 if test "$enable_tee" != no; then
+	AC_CHECK_FUNCS(tee, use_tee=yes)
+fi
+
+if test "$use_tee" = yes; then
 	AC_DEFINE([USE_TEE], [1], [Non-zero if tee(2) should be used])
 else
 	AC_DEFINE([USE_TEE], [0], [Non-zero if tee(2) should be used])
diff --git a/src/input.c b/src/input.c
index 71282fb..4e30010 100644
--- a/src/input.c
+++ b/src/input.c
@@ -183,7 +183,12 @@ static int stdin_tee(void *buf, int nr)
 
 	flush_tee(buf, nr, stdin_state.pending);
 
-	err = USE_TEE ? tee(0, stdin_state.pip[1], nr, 0) : -1;
+	if (USE_TEE)
+		err = tee(0, stdin_state.pip[1], nr, 0);
+	else {
+		errno = EINVAL;
+		err = -1;
+	}
 	stdin_state.pending = err;
 	return err;
 }
@@ -324,13 +329,13 @@ retry:
 	if (!fd && !stdin_bufferable()) {
 		nr = stdin_tee(buf, nr);
 		fd = stdin_state.pip[0];
-		if (nr <= 0) {
+		if (nr < 0 && errno == EINVAL) {
 			fd = 0;
 			nr = 1;
 		}
 	}
 
-	if (nr >= 0)
+	if (nr > 0)
 		nr = read(fd, buf, nr);
 
 	if (nr < 0) {
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
