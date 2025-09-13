Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F59191484
	for <dash@vger.kernel.org>; Sat, 13 Sep 2025 09:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757757576; cv=none; b=r2qaSEOOlbLSjjOxhnpZby6y52wK2jmEnINSyeSr9YKBOLn/pY+2/6Db4tzkGWLeeZ2Roh9Ukws7EM8yhN1VQ501JUEnb7d27pPmgxhrWCiG4BAF40rvaB0fn0cZN8NA83Gngz7ysnD/sJRXTxCYk8emGhOETPuFaoKwZ+bVzQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757757576; c=relaxed/simple;
	bh=Zqw/txKURrX++hmI68XWsMUjEsuaYvP7jaFX6qKW7So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4sC+auWL8EydPKMZZrPH7iqCsl9Gxf7ShalxqzzGMQwDNj2nX0k1e/t2cBU+5jKOuvY5fYJqaZcq6l6G5jv6MIZGcCcpsEqtBkgp+Zj0YOSQ5m1c0glIBHydO5NF2JZPLIDaYJMjIYFvPSt0ZcuN/h4mqsmd3Ol2kLJgpSwg/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=H8zlCNrI; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="H8zlCNrI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=F43RuTMAqlQPy5WN2q7Dgn5I7hYdgUlTiWlSnxYvgqc=; b=H8zlCNrIKBcADAKSYeutVi3c8P
	pZrkEGGtTzGc9M7jjbj287VNpSrz8mtWCojZ9DNBtEOVbxMhGPAGlNTbBXMEUgbbN0DBzdKNJxU8P
	QghJjTuw2AejSTb1UHwNpeBYHfNus32c9k6A+VrPt5qW/rjJHNBqF9qo5Zsk9oWPEREbRyfe9Yyuw
	BGkHmTUBnkS+KEj3VJxp7PkQcqTCshhaItxHruyRZu8+DMUMh2DKh0q9N1DzW47fNzftdt5AZXfFy
	BTnVB8Md1mfLv1XYG74nF3dLhP7G9SY41yiCj4Cy0exAVC8l62WdLtQ//WxgJIM+WMjZHf4Tfcxl0
	+Ezk7bJw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uxMn6-0056Ed-1o;
	Sat, 13 Sep 2025 17:59:30 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 13 Sep 2025 17:59:28 +0800
Date: Sat, 13 Sep 2025 17:59:28 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Nathan Mills <the.true.nathan.mills@gmail.com>
Cc: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] parser: Skip parsing of old-style command substitution
 here-doc marker
Message-ID: <aMVAgFADRgG33XlG@gondor.apana.org.au>
References: <CALjJ9ccRuGV9fmydBvwzOua_om7QVoro-nSA-pv+9-nX1KLfGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALjJ9ccRuGV9fmydBvwzOua_om7QVoro-nSA-pv+9-nX1KLfGA@mail.gmail.com>

On Fri, Aug 29, 2025 at 07:40:16PM -0700, Nathan Mills wrote:
>
> * Crash #0 is a null-pointer-dereference. I haven't found the fix yet
> but it is probably simple.
> 
> redir->nhere.doc is NULL. The global variable **heredoclist** is also
> NULL and parseheredoc does nothing when heredoclist is NULL.
> 
> 1. readtoken1
> 2. parseheredoc (heredoclist equals heredoc which is the same as the
> value in the next step)
> 3. parseheredoc (heredoclist is NULL, heredoc is 0x5555560bb6a8 <stackbase+232>)
> 4. parsefname
> 5. parseheredoc (heredoclist->here->nhere.doc->narg.text equals the
> empty string)
> 6. **SIGSEGV** openhere (redir->nhere.doc is **NULL**)
> 
> ** Crash #0: null pointer dereference **
> 
> Base64'd
> 
> dmVzjHdyPDwAAACAYAAAAHd3cjw8AAAAgGAAAACA/38zZGlsaQ==
> 
> Minimized:
> 
> src/dash -c $(echo -c "<<\`<<\0\`")

This is caused by the unnecessary recursive parsing of old-style
command substitution which then gets confused by the embedded
here-document.

Fix this by skipping the recursive parsing of command substitution
if it is old-style and a here-document marker.

Reported-by: Nathan Mills <the.true.nathan.mills@gmail.com>
Fixes: 7a11b3e330a3 ("parser: Extend coverage of CHKEOFMARK")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/parser.c b/src/parser.c
index a3b004b..975cf89 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -1510,7 +1510,6 @@ parsebackq: {
 	int uninitialized_var(saveprompt);
 	struct heredoc *saveheredoclist;
 	struct nodelist **nlpp;
-	size_t psavelen;
 	size_t savelen;
 	union node *n;
 	unsigned ml;
@@ -1521,24 +1520,28 @@ parsebackq: {
 		STADJUST(oldstyle - 1, out);
 		out[-1] = CTLBACKQ;
 	}
-	str = stackblock();
-	savelen = out - (char *)stackblock();
-	grabstackblock(savelen);
+	if (!chkeofmark || !oldstyle) {
+		str = stackblock();
+		savelen = out - (char *)stackblock();
+		grabstackblock(savelen);
+		STARTSTACKSTR(out);
+	}
         if (oldstyle) {
                 /* We must read until the closing backquote, giving special
                    treatment to some slashes, and then push the string and
                    reread it as input, interpreting it normally.  */
-                char *pout;
+		bool done = false;
+		char *pout = out;
                 int pc;
 
-                STARTSTACKSTR(pout);
-		for (;;) {
+		while (!done) {
 			if (needprompt) {
 				setprompt(2);
 			}
 			switch (pc = pgetc_eatbnl()) {
 			case '`':
-				goto done;
+				done = true;
+				break;
 
 			case '\\':
                                 pc = pgetc();
@@ -1564,9 +1567,11 @@ parsebackq: {
 			}
 			STPUTC(pc, pout);
                 }
-done:
-                STPUTC('\0', pout);
-                psavelen = pout - (char *)stackblock();
+		if (chkeofmark) {
+			out = pout;
+			goto parsebackq_oldreturn;
+		}
+		pout[-1] = 0;
 		pstr = grabstackstr(pout);
 		setinputstring(pstr);
         }
@@ -1608,10 +1613,6 @@ done:
 		 * parsing.
 		 */
 		tokpushback = 0;
-		if (chkeofmark) {
-			pstr[psavelen - 1] = '`';
-			out = stnputs(pstr, psavelen, out);
-		}
 		goto parsebackq_oldreturn;
 	} else {
 		if (chkeofmark) {
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
