Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1957262A
	for <dash@vger.kernel.org>; Sat, 20 Jun 2026 09:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781947418; cv=none; b=OyOwr3M0RpIha7quz1lWDEhdD/2v5EQrenND5xAzAg9zIPqFtA/qn0UwaXAtiE1v6i9xImF22TdeIwwsObVaX/jlE0dMBU4BiUi/1DQrcgfOteIMSH3yfCrgIVbkaCekVOLpvklU+b+EVHHzRJq/o4Pu1hBXUIsn8LLSGTZNiH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781947418; c=relaxed/simple;
	bh=eQs4vMShWbFA5QcykVFHxNrRLEMx7BIlPJOqHKaPllc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duBD/liK3IrChD0X4V6Hv3wn1AbGukoYTmZzrjXVNUuuc2K9vndXnp0t+Jm2MVbanb8Y9Agx2zfK/jQJcm67sBOKRdVfck7Oe9Pjqj6bPjZ9AspKXgRbjOTW7y7D6aBvVcNUDc30+4eE8BAMffUa7osvxU5kneeD83G5VKJIX1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=H1IYF5tg; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="H1IYF5tg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=N9RAie4ALTQTHIOuIJMS1bTxR6Pnf3hWPftc3thvExI=; 
	b=H1IYF5tgVXQTaJMVLb9JRzBHCmcPMi/8edBD1FBd6FhOALI9NfDDn79Diu2vg6g/JLMjt9j+l8e
	yEF6oeDh/90gYNNC8XyiUUjA2onqYdsKDXfvzw22UZriPm/9bjaLKpOwi/Vh/3m4WE2DecF0yQ9Ya
	mqGvNoj1hpHAOXzVgpg7779ZrgOaIS+bNDRdMzYltkpvQri+mAI4F6P8+SxjPN/ib1uEeYAM09vig
	sPuKjc6YDqzPh3HsdtHqwunjqGWt3F87h1xy6qWNQTKkzpzB23KfN/5IZd/c2IyoM00eceV+N4nPw
	WzOu00MJEuG3rmEu42NjuuytBkEMa70372hA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1warvG-00000006qZI-1DvK;
	Sat, 20 Jun 2026 17:23:31 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 20 Jun 2026 17:23:30 +0800
Date: Sat, 20 Jun 2026 17:23:30 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kerin Millar <kfm@plushkava.net>
Cc: dash@vger.kernel.org, Sam James <sam@gentoo.org>
Subject: [PATCH] input: Fix overeager NUL deletion in SMALL mode
Message-ID: <ajZcEl4ySM87RjOS@gondor.apana.org.au>
References: <ajYkiqisEQHQtmf5@gondor.apana.org.au>
 <a6469aab-bcf8-4c36-9a2d-9bf30e7e6ae9@app.fastmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6469aab-bcf8-4c36-9a2d-9bf30e7e6ae9@app.fastmail.com>

On Sat, Jun 20, 2026 at 06:50:20AM +0100, Kerin Millar wrote:
> 
> Aye, that it be and no mistake.
> 
> https://git.kernel.org/pub/scm/utils/dash/dash.git/commit/?id=44b15ea09a9ee5872cf477e4ffc6b42ef37d1e46

OK this patch should fix the problem:

---8<---
NUL characters should not be removed from input lines that are
yet to be processed because they could become the input to the
next executed utility.

Fix this by moving the NUL deletion into pgetc when history support
is off (IS_DEFINED_SMALL).

Also fold __pgetc into pgetc since the only other caller of it
is preadbuffer and that logic can also be moved up.

Finally add a missing signed char cast for the unget characters.

Reported-by: Kerin Millar <kfm@plushkava.net>
Fixes: 44ae22beedf8 ("input: Disable lleft in SMALL mode")
Fixes: 2c92409145d0 ("input: Allow MB_LEN_MAX calls to pungetc")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/input.c b/src/input.c
index 0fb2f18..e9b9d33 100644
--- a/src/input.c
+++ b/src/input.c
@@ -217,26 +217,6 @@ static void freestrings(struct strpush *sp)
 }
 
 
-static int __pgetc(void)
-{
-	int c;
-
-	if (parsefile->unget) {
-		long unget = -(long)(unsigned)parsefile->unget--;
-
-		return parsefile->nextc[unget];
-	}
-
-	if (parsefile->nleft > 0) {
-		parsefile->nleft--;
-		c = (signed char)*parsefile->nextc++;
-	} else
-		c = preadbuffer();
-
-	return c;
-}
-
-
 /*
  * Read a character from the script, returning PEOF on end of file.
  * Nul characters in the input are silently discarded.
@@ -245,11 +225,39 @@ static int __pgetc(void)
 int __attribute__((noinline)) pgetc(void)
 {
 	struct strpush *sp = parsefile->spfree;
+	int c;
 
 	if (unlikely(sp))
 		freestrings(sp);
 
-	return __pgetc();
+again:
+	if (parsefile->unget) {
+		long unget = -(long)(unsigned)parsefile->unget--;
+
+		return (signed char)parsefile->nextc[unget];
+	}
+
+nextc:
+	if (likely(parsefile->nleft > 0)) {
+		parsefile->nleft--;
+		c = (signed char)*parsefile->nextc++;
+	} else if (unlikely(parsefile->strpush)) {
+		popstring();
+		/* The freestrings call must be delayed til the next
+		 * pgetc call for PEOA to work properly.
+		 */
+		goto again;
+	} else
+		c = preadbuffer();
+
+	/* delete nul characters */
+	if (IS_DEFINED_SMALL && unlikely(!c)) {
+		parsefile->nextc = memmove(parsefile->nextc - 1,
+					   parsefile->nextc, parsefile->nleft);
+		goto nextc;
+	}
+
+	return c;
 }
 
 int pgetc_eoa(void)
@@ -374,10 +382,6 @@ static int preadbuffer(void)
 	int more;
 	char *q;
 
-	if (unlikely(parsefile->strpush)) {
-		popstring();
-		return __pgetc();
-	}
 	if (parsefile->eof & 2) {
 eof:
 		parsefile->eof = 3;
@@ -408,6 +412,12 @@ again:
 		}
 	}
 
+	if (IS_DEFINED_SMALL) {
+		q += more;
+		more = 0;
+		goto done;
+	}
+
 	/* delete nul characters */
 	for (;;) {
 		int c;
@@ -422,9 +432,6 @@ again:
 
 		q++;
 
-		if (IS_DEFINED_SMALL)
-			goto check;
-
 		switch (c) {
 		case '\n':
 			goto done;
@@ -439,11 +446,8 @@ again:
 		}
 
 check:
-		if (more <= 0) {
-			if (!IS_DEFINED_SMALL)
-				goto again;
-			break;
-		}
+		if (more <= 0)
+			goto again;
 	}
 done:
 	input_set_lleft(parsefile, more);
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
