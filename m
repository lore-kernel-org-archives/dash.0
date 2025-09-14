Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F165C2C9D
	for <dash@vger.kernel.org>; Sun, 14 Sep 2025 00:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757810659; cv=none; b=H3c10TELVxrebn258AEg6lZqtWZeG8qugoIRCQT1c9R3VkOgaq7/r6nlaTBrN2g3TZqU3HUqSStT17Zi2wza+jbXxe/kf+okKnbT+S6Laja/rXUnmgF8i4mdMFwwqx70viYaF/I3wxVIxpCSzwpi4bZN/pDEmqt9OKaXWHsRj3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757810659; c=relaxed/simple;
	bh=OomLyeiYVeU19TkP+tG1PWucLTI+pAD6hOIJBbm3Qbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRmRu7IEGsDNq9+PN8n7TDpAk15sy4eKbviXg5rr4ep7dtZePC4X90jIYEaGy6zlTapiE0bDm9c6X48kWr0sQUBGysaz8x0IqvwH2RmtGh0pqaROfQAZPBcb6vVmIDLY70k5Py4MBog+TQxiobzi6Cgv13scYcxdt6R7naQhLCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=Kg/tWEBC; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="Kg/tWEBC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=JNNhSmO499URWLQyScLzxYdpvWAvloH2x5i6t0v4+eA=; b=Kg/tWEBCT+I9aAL6CR4xQY7AH1
	JppklhDeZt4ZQFpaWNdwwCVY+0Djz1ZTAs286qqrU5iLiI16+FYuf1wUsWjihxQgZ4boYy4nLds3f
	zJXshLqf3RV+Su5Y3oHS0VwkaHtYIS+kyrz4Y5iMmYO2/2kDCV/JF0dx01hKIEi/pGyMqDsRIoq/g
	Vs2U8GDJ2h2zbbMKSd9RnEmZ/bAVoyk5x4h2tMgffmu9kpEB6g2kVU44XKLyoCs0qD3vhlgqhVcMI
	sd+U1hD8/xLFhFeTsEOC/LYcrJmWNUeqve/F06K816Z/jA773flK9ZwQ6AWU4ls4/1KNZ6RfaVimh
	rIPIgvuw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uxabG-005EqB-0Y;
	Sun, 14 Sep 2025 08:44:11 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 14 Sep 2025 08:44:10 +0800
Date: Sun, 14 Sep 2025 08:44:10 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Harald van Dijk <harald@gigawatt.nl>
Cc: Nathan Mills <the.true.nathan.mills@gmail.com>,
	DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] expand: Do not use memcmp on strings
Message-ID: <aMYP2pMS30mYUYdx@gondor.apana.org.au>
References: <CALjJ9ccRuGV9fmydBvwzOua_om7QVoro-nSA-pv+9-nX1KLfGA@mail.gmail.com>
 <aMV6ZCrLe_v5XBJs@gondor.apana.org.au>
 <ddd331fe-b0cb-4575-9849-90a811df32fa@gigawatt.nl>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddd331fe-b0cb-4575-9849-90a811df32fa@gigawatt.nl>

On Sat, Sep 13, 2025 at 03:29:30PM +0100, Harald van Dijk wrote:
>
> Are you sure this is a false positive? memcmp isn't required to stop reading
> once it sees NUL and typical implementations read multiple bytes at a time.
> Reading past the NUL may crash.

You are right.  This patch should fix them up.

Thanks,

---8<---
Using memcmp past the end of a string may crash if it hits a page
boundary.  Fix this by calling strcmp/strncmp instead.

Reported-by: Nathan Mills <the.true.nathan.mills@gmail.com>
Reported-by: Harald van Dijk <harald@gigawatt.nl>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/expand.c b/src/expand.c
index 35481d6..19edc9d 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -354,8 +354,7 @@ start:
 			continue;
 		case CTLQUOTEMARK:
 			/* "$@" syntax adherence hack */
-			if (!inquotes && !memcmp(p, dolatstr + 1,
-						 DOLATSTRLEN - 1)) {
+			if (!inquotes && !strcmp(p, dolatstr + 1)) {
 				p = evalvar(p + 1, flag | EXP_QUOTED) + 1;
 				goto start;
 			}
@@ -1552,7 +1551,7 @@ expandmeta(struct strlist *str)
 
 		if (fflag)
 			goto nometa;
-		if (!strpbrk(str->text, "*?]") || !memcmp(str->text, "]", 2))
+		if (!strpbrk(str->text, "*?]") || !strcmp(str->text, "]"))
 			goto nometa;
 		savelastp = exparg.lastp;
 
@@ -1996,7 +1995,7 @@ static int pmatch(char *pattern, const char *string)
 					    chr >= c && chr <= *p)
 						found = 1;
 					p++;
-				} else if (!memcmp(mbs, q, mb))
+				} else if (!strncmp(mbs, q, mb))
 					found = 1;
 			} while ((c = *p++) != ']');
 			if (found == invert)
@@ -2011,7 +2010,7 @@ static int pmatch(char *pattern, const char *string)
 			q += mb & 0xff;
 			mb >>= 8;
 
-			if (memcmp(p - 1, q - 1, mb + 1))
+			if (strncmp(p - 1, q - 1, mb + 1))
 				return 0;
 
 			p += mb;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
