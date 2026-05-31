Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9931DE4EF
	for <dash@vger.kernel.org>; Sun, 31 May 2026 05:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780205776; cv=none; b=QL6Tiz5V11lI0lcRLXQHV7Ss7w64p6gBBQDgJK0eOUxXKzkETLvRKimHc3+FCdMtP935iWlpnE4B/pfwRJB837DQIv6rSxTV5REwWK8y4qqjRDR7w+2PNRAJgURP2X+c6JnZyBii327IOXgN19UY2wiRxIl91z11M1H+K+2EGA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780205776; c=relaxed/simple;
	bh=6K6xK7uiBLyOgsTJCLU4oO7tQwD41j7ov6W68vFBXT4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=K2fU3Dq7h5OCNwioCgRpk5iVVuPzW9BEPDnF9hWxFMvirUr82xsf85fBErz7aWVsNr38TX8YU4YD9RIVB7GHJYrjAX/Lgb8Ou3Ox/Cjk9UCQYF1g0y+vn/6tQQAUlrRrHciaHU8Bx3wauGWaPsCpja+PY18f9ZjDXHAnva2Cbro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=NBhtiDGU; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="NBhtiDGU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=vRBEZ6hThN24xJK5MtzTM7agtrtTL4Ds26roooD8iD4=; b=NBhtiDGUtcoSRsfTLd35M+fCdB
	/ZOVTuQxDDXrqRncKYNfrj3Y6T8BCjnK8Arfe+mOtVjbKBue7++cDToEIyeQBg2BLR6n4PfOteysZ
	ELCSJFMqR0Z5zhSbaIWwhnr2PFBnR1eRzsr1bl33rI5dnbUk+r3yQCVa7MWop+lA6oC7+IR+mqylH
	jZR59GE2GqzBrdyeMG8+Lmvs3nDQH9GC3WrXkSZLsnFYv+TMP7scANX2Fq7Xe+ppEisjMiYLlWw5Y
	CudPMPGZ0fPMidXfBn+PUB+xmWZlNeK+bJWf8SkU/XihctVFYJ1vQjWT9+D5InSlzqEeRp3Z+TIsS
	Cz5+oL/Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wTYqH-0016YJ-0d;
	Sun, 31 May 2026 13:36:10 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 31 May 2026 13:36:09 +0800
Date: Sun, 31 May 2026 13:36:09 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kerin Millar <kfm@plushkava.net>
Cc: dash@vger.kernel.org, sam@gentoo.org
Subject: [v2 PATCH] builtin: Fix octal escapes in dollar-single-quotes
Message-ID: <ahvIyXWD_5RQk0eT@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b08b2521-82a6-4b23-a5fc-f1922979222e@app.fastmail.com>
X-Newsgroups: apana.lists.os.linux.dash

Kerin Millar <kfm@plushkava.net> wrote:
> 
> The test suite of the gentoo-functions project recently uncovered a bug whereby octal sequences within dollar-single-quotes are evaluated as internal control characters, resulting in faulty decoding at best, and segmentation faults at worse. The attached patch rectifies this bug.

Thanks for the patch.

While looking at this I found out that the logic for \x is broken
as it always produces a multi-byte character even for the value of
\x81.

So here is a rolled-up patch which fixes both problems.

---8<---
From: Kerin Millar <kfm@plushkava.net>

The test suite of gentoo-functions recently uncovered a bug concerning
the handling of octal escape sequences within dollar-single-quotes.
Here is a reproducer:

    $ dash -c "x=\$'\\201'; printf '%s' \"\$x\"" | od -An -tx1
    88

That is, despite the input being 0x81, the output is 0x88. Indeed, any
input between 0x81..0x88 is adversely affected and some - such as 0x82 -
induce a segfault.

I noticed the following macros in src/parser.h:

    #define CTL_FIRST -127 /* first 'special' character */
    #define CTLESC    -127 /* escape next character */
    #define CTL_LAST  -120 /* last 'special' character */

Reinterpreted as unsigned char, the CTL_FIRST..CTL_LAST range maps
exactly to 0x81..0x88:

    $ perl -e 'printf "%x\0", $_ & 0xFF for -127..-120' | xargs -0
    81 82 83 84 85 86 87 88

From this, I was able to deduce that all of these bytes must be preceded
by CTLESC in order to be taken literally. Make it so.

Link: https://gitweb.gentoo.org/proj/gentoo-functions.git/commit/?id=947090fb7704
Signed-off-by: Kerin Millar <kfm@plushkava.net>

The escape should also be applied to \x sequences.  In fact \x81
was totally broken as it produced a multi-byte character.  Fix this
by merging these two code paths.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/bltin/printf.c b/src/bltin/printf.c
index 106aecd..671e781 100644
--- a/src/bltin/printf.c
+++ b/src/bltin/printf.c
@@ -332,6 +332,7 @@ unsigned conv_escape(char *str0, char *out0, bool mbchar)
 	char *out = out0;
 	char *str = str0;
 	unsigned value;
+	int och;
 	int ch;
 
 	ch = *str;
@@ -359,12 +360,18 @@ unsigned conv_escape(char *str0, char *out0, bool mbchar)
 		}
 
 		str--;
+
+check_value:
+		if (mbchar && (signed char)value >= CTL_FIRST &&
+		    (signed char)value <= CTL_LAST)
+			USTPUTC(CTLESC, out);
 		break;
 
 	case 'x':
 		ch = 2;
 
 hex:
+		och = ch;
 		value = 0;
 		do {
 			int c = *++str;
@@ -391,6 +398,9 @@ hex:
 		if (value < 0x80)
 			break;
 
+		if (och <= 2)
+			goto check_value;
+
 		if (value < 0x110000) {
 			int mboff = (mbchar - 1) * 2;
 			unsigned uni = value;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
