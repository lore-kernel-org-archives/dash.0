Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00B92DD5F6
	for <dash@vger.kernel.org>; Thu,  7 May 2026 07:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778139962; cv=none; b=c8lTZsv7MAzHxqNVGE81DDIpb65sD7ECfmwZq9++9HwerlA7oX8LTa5SXjQVy9kOopwbA7HLgqP1kuP6Pb5p6JJQt7Vydx32ZwbQnp4Bk8QoCCLozYrLVU1JkgEGyomQVdKQLPTR2EiSvchQbuEabcrAcWHRSDj8Yv2xu3pfAAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778139962; c=relaxed/simple;
	bh=64no8KZBoUOR7izKnOBI56VXPA+K6IrFT/Y/BXJpKqI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mfen/mM0w1A/XrUewJ+aFS26s0HEVhJAfuuFOGuGdOicc64hamXFWWVgCRItavyZUK8BZxeCRu3rrYZcaFCCk26BTFOgS+mCVNW5rux76mWftlRx6p8bgtM006iQT6EeQvGA4TXd/UTWC5k/ievw8ln/ueFhYBMAJQyaDOiOj/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=VwvWY6/D; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="VwvWY6/D"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:To:From:Date:cc:to:subject:message-id:date:from
	:content-type:reply-to; bh=9hnueKIGpr50XSw5W+74+vYvdd7Hab2TpOrBwk2IjNI=; b=Vw
	vWY6/DFuYDQsROHAOkeiIje9xW/FTvHl8rn60y2vAZ7bjHn12zVavsIRe34tV1h0GWJdFOKa/aJ+q
	gDJ1vzAazmEMFpDE3Q53viksbL8XBEtr8PU3yd+AszawMFfYWtDJor//G6jdMg/tSHoiQ9Luz3+Io
	bx0J/hbw23/MgplrU7XTowzIfmzYQ1WfP/DoYgvskSUTwC8Ow5jy5/UqJLTMXfjqlqR7beFs8tmO9
	Mq7yyYWrplUBMTJHv/qTT3I0aG72HNaTCvPdCQA1hohdsfKtA/8BQEo4uezIuGpL22yO7GdJUVuGz
	tfuYm6YVBioU062jDTJbiobpB1yOtrWA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wKtQh-00C0Wp-1F;
	Thu, 07 May 2026 15:45:56 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 07 May 2026 15:45:55 +0800
Date: Thu, 7 May 2026 15:45:55 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] parser: Fix multi-byte output in here-doc with quoted
 delimiter
Message-ID: <afxDM2AmON2ASbfT@gondor.apana.org.au>
References: <20260402-pks-tests-with-dash-v2-0-cd7ab11dabc0@pks.im>
 <20260402-pks-tests-with-dash-v2-1-cd7ab11dabc0@pks.im>
 <afwpyiK9mh23c-JV@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afwpyiK9mh23c-JV@gondor.apana.org.au>

On Thu, May 07, 2026 at 01:57:30PM +0800, Herbert Xu wrote:
> On Thu, Apr 02, 2026 at 08:51:18AM +0200, Patrick Steinhardt wrote:
> > When executing our test suite with Dash v0.5.13.2 one can observe
> > several test failures that all have the same symptoms: we have a quoted
> > heredoc that contains multibyte characters, but the final data does not
> > match what we actually wanted to write. One such example is in t0300,
> > where we see the diffs like the following:
> > 
> >   --- expect-stdout	2026-04-01 07:25:45.249919440 +0000
> >   +++ stdout	2026-04-01 07:25:45.254919509 +0000
> >   @@ -1,5 +1,5 @@
> >    protocol=https
> >    host=example.com
> >   -path=perú.git
> >   +path=perú.git
> >    username=foo
> >    password=bar
> 
> Thanks for the report.
> 
> This patch should fix the problem.  Please let me know if there are
> any more oustanding issues.

Resending again to dash mailing list with a fixed Subject line.

---8<---
For a here-document with a quoted delimiter, multi-byte characters
should be written out as is with no escaping.  Fix this by checking
for syntax == SQSYNTAX (the only time readtoken1 gets called with
SQSYNTAX is for such a here-document) before calling getmbc in
readtoken1.

Reported-by: Patrick Steinhardt <ps@pks.im>
Fixes: b12f136cc704 ("builtin: Process multi-byte characters in read(1)")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/parser.c b/src/parser.c
index bea4148..412e876 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -998,9 +998,13 @@ static char *dollarsq_escape(char *out)
 STATIC int
 readtoken1(int firstc, char const *syntax, char *eofmark, int striptabs)
 {
-	struct synstack synbase = { .syntax = syntax };
+	struct synstack synbase = {
+		.dblquote = syntax == DQSYNTAX,
+		.syntax = syntax,
+	};
 	int chkeofmark = checkkwd & CHKEOFMARK;
 	struct synstack *synstack = &synbase;
+	bool sqheredoc = syntax == SQSYNTAX;
 	struct nodelist *bqlist = NULL;
 	int dollarsq = 0;
 	int c = firstc;
@@ -1009,9 +1013,6 @@ readtoken1(int firstc, char const *syntax, char *eofmark, int striptabs)
 	size_t len;
 	char *out;
 
-	if (syntax == DQSYNTAX)
-		synstack->dblquote = 1;
-
 	STARTSTACKSTR(out);
 	loop: {	/* for each line, until end of word */
 #if ATTY
@@ -1035,7 +1036,8 @@ readtoken1(int firstc, char const *syntax, char *eofmark, int striptabs)
 				      out);
 			fieldsplitting = synstack->syntax == BASESYNTAX &&
 					 !synstack->varnest ? 4 : 0;
-			ml = getmbc(c, out, fieldsplitting);
+			ml = getmbc(c, out, fieldsplitting |
+					    (sqheredoc ? 2 : 0));
 			if (ml == 1) {
 				if (out == stackblock())
 					return TBLANK;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
