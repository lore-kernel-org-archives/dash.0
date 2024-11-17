Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DAEB661
	for <dash@vger.kernel.org>; Sun, 17 Nov 2024 02:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731810313; cv=none; b=t0jKzNqmEXwB9RkWe9sjZZQMVehFWbNOJwjsFHvwlX0Xj2H6Q+YKnZ+9X+qNlLkVP9X3n8TRIRQ42QUwmoMVXWxShaca+htt+BRCUepzKIvEg57p0lpEakp13GN4uyFGbLV6ryudsCFf0quHf7drGlSbnwTAaCgay7VtqrXpxzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731810313; c=relaxed/simple;
	bh=p4F8pU2R+vbv0k8UuYex5WoVrn9NP0fs9uqt+ydtkgc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RIG0r9Di28ICK/O017hlcLQQT0ZRUnhctbsEmzh2IS6ybF96wQwHePMRtWeZSyaUxlRTSXtU2Iz+bqd6WaOZdr65gYTIPwkYACuKDaOQ3wZv41Ew16jkQZwjJNb2UgTxL4jfJ/bRYN6rnqdVrnZ1y2srWQUa015uMvxWnv4cMIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=crhuO3Zz; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="crhuO3Zz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZPqiEX7hETLLAJEd45UUgiYLPLWpupVeBNFgmz8bm1I=; b=crhuO3ZzB5cNntPMUUEf0GWCf6
	GNIwXPXs5FCyJRnQcr6vjgaBR+tWeayI8QmHlBvBpzfcWarv3xouZ2pYWN2wHDLK+Idxst6WfTI6z
	me4WsUrZp4AEVTHiOphzHGl5Db6EZxnhQXSAHoZZFa0qUWENRPOWyPS99LWmTm+Ggj576YWt/BzI5
	OjQxcJ4JWZKW+wiU/GLcjlJuzVqHFRG4o3BouFbS/aOJxCcRrD1bs9/lvPF/uinQNbXlkN5UT7IVr
	FSvyKmd1z7xLsWbtO5fOEf4gvBXHhgUBFH5oqK/bv94Tjb7Tj2dd+OXvSv7L/bas3Agw88qlSW6vt
	hRCJKFZw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tCUyF-00HMp9-1L;
	Sun, 17 Nov 2024 10:25:04 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 17 Nov 2024 10:25:03 +0800
Date: Sun, 17 Nov 2024 10:25:03 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Johannes Altmanninger <aclopte@gmail.com>
Cc: dash@vger.kernel.org
Subject: [PATCH] expand: Fix scanleft/right for !FNMATCH_IS_ENABLED && quotes
Message-ID: <ZzlT_1CY5AjxtqAs@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuS3PI7He-T7pugf@gmail.com>
X-Newsgroups: apana.lists.os.linux.dash

Johannes Altmanninger <aclopte@gmail.com> wrote:
> I'm hitting an easily reproducible crash.
> It bisects to c5bf970 (expand: Add multi-byte support to pmatch, 2024-06-02).
> 
> After bisecting I reduced it to this example (probably not minimal)
> 
>        echo \\ | dash -c 'foo=$(cat; printf .); foo=${foo%.}'

Thanks for the report.  This patch should fix the problem:

---8<---
When our own pmatch is used, loc2 is unused in scanleft/right
when quotes is true.  However, it is still needed when quotes
is false.

Fix the scanleft/right code so that loc2 is always updated (so
it will be garbage when quotes is true) but only returned depending
on the value of quotes.

Fixes: c5bf9702ea11 ("expand: Add multi-byte support to pmatch")
Reported-by: Johannes Altmanninger <aclopte@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/expand.c b/src/expand.c
index d73f29c..7a30648 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -621,18 +621,15 @@ static char *scanleft(char *startp, char *endp, char *rmesc, char *rmescend,
 		match = pmatch(str, s);
 		*(FNMATCH_IS_ENABLED ? loc2 : loc) = c;
 		if (match)
-			return FNMATCH_IS_ENABLED && quotes ? loc : loc2;
+			return quotes ? loc : loc2;
 
 		if (!c)
 			break;
 
 		mb = mbnext(loc);
 		loc += (mb & 0xff) + (mb >> 8);
-		if (unlikely(FNMATCH_IS_ENABLED || !quotes)) {
-			ml = (mb >> 8) > 3 ? (mb >> 8) - 2 : 1;
-			loc2 += ml;
-		} else
-			loc2 = loc;
+		ml = (mb >> 8) > 3 ? (mb >> 8) - 2 : 1;
+		loc2 += ml;
 	} while (1);
 	return 0;
 }
@@ -645,8 +642,7 @@ static char *scanright(char *startp, char *endp, char *rmesc, char *rmescend,
 	char *loc;
 	char *loc2;
 
-	for (loc = endp, loc2 = rmescend;;
-	     FNMATCH_IS_ENABLED ? loc2-- : (loc2 = loc)) {
+	for (loc = endp, loc2 = rmescend;; loc2--) {
 		char *s = FNMATCH_IS_ENABLED ? loc2 : loc;
 		char c = *s;
 		unsigned ml;
@@ -659,7 +655,7 @@ static char *scanright(char *startp, char *endp, char *rmesc, char *rmescend,
 		match = pmatch(str, s);
 		*(FNMATCH_IS_ENABLED ? loc2 : loc) = c;
 		if (match)
-			return FNMATCH_IS_ENABLED && quotes ? loc : loc2;
+			return quotes ? loc : loc2;
 		if (--loc < startp)
 			break;
 		if (!esc--)
@@ -676,8 +672,7 @@ static char *scanright(char *startp, char *endp, char *rmesc, char *rmescend,
 		loc -= ml + 2;
 		if (*loc == (char)CTLESC)
 			loc--;
-		if (FNMATCH_IS_ENABLED)
-			loc2 -= ml - 1;
+		loc2 -= ml - 1;
 	}
 	return 0;
 }
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
