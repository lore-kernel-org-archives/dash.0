Received: from norbury.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BA833F9
	for <dash@vger.kernel.org>; Sat,  6 Jul 2024 01:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720229856; cv=none; b=V1CnYWzCC9C31zUzPiKT5HBEtgxwnCHwIntAYtGB5rNLTkvOtba6P0M0HwM22r6VaJFhRG87zR+AGx0UCJK5qkbijyUzWsto0vJ8C5+caoOuI8Wn2tMIaZNENiwoSpIQcwtazmYF6CRiBLpw/GfLX7HnH7tEwsipzo3np9EoGpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720229856; c=relaxed/simple;
	bh=HLOS7fF0/SkQ+55ZvFPTEmfzMnqruAC/6aSxkBSkYbs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lui8hH/ToSWS8amldnFEmwTEKhKMoMeLoI4gpPhUm34czr4tRbTD9o7gblkzXq39aL4S+OJxGict1WTzOmHP9JLLhyL/T7ba4EnfSqpn9JEX+PzHVp635qyKrPXp2rjdxlYh43EVN62H9+Bt+Wx3S6mkbMEqnA9NYFzYKyPu9aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
	by norbury.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sPuMj-006hY0-2s;
	Sat, 06 Jul 2024 11:37:30 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 06 Jul 2024 11:37:16 +1000
Date: Sat, 6 Jul 2024 11:37:16 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: dash@vger.kernel.org
Subject: [PATCH] parser: Do not read past single quote in dollarsq_escape
Message-ID: <ZoifzAnPAKsEaVVl@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <gsb54jm2ankqb3ckx5b2renl2ndjlmdep3r7l2ohe6wlvs7hwd@tarta.nabijaczleweli.xyz>
X-Newsgroups: apana.lists.os.linux.dash

наб <nabijaczleweli@nabijaczleweli.xyz> wrote:
> 
> Current HEAD of 776424a8f9158bfe9f53aa55f931af9f73437caf
> ("parser: Add dollar single quote"):
>  $ printf '%s\n' $'\123'
> simply hangs.
> 
> strace shows
>  read(0, printf '%s\n' $'\123'
>  "printf '%s\\n' $'\\123'\n", 8192) = 22
>  read(0,
> 
> Bisecting this says that this is the first problematic commit.
> 
> Actually writing around five bytes makes it write the S\n and continue
> (and interpret those five bytes as-if typed at the prompt).

Thanks for the report.  This patch should fix the problem:

---8<---
The function dollarsq_escape may read past the current escape
code in order to provide enough data to the underlying escape
code processing function.  This is OK because we will call unget
to return any unused characters.  However, if this occurs at
the end of a quoted string, this may prompt the user for more
input which is wrong.

Fix this by terminating the loop whenever we see a single quote.
Even if this is an escaped single quote and thus does not indicate
the end of the whole quoted string, it's still OK because no single
escape code can continue after a single quote.

Reported-by: наб <nabijaczleweli@nabijaczleweli.xyz>
Fixes: 776424a8f915 ("parser: Add dollar single quote")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/parser.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/parser.c b/src/parser.c
index d1bec58..aecc18f 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -938,13 +938,16 @@ static char *dollarsq_escape(char *out)
 	unsigned len;
 	char *p;
 
-	for (len = 0; len < sizeof(str) - 1; len++) {
+	for (len = 0; len < sizeof(str) - 1;) {
 		int c = pgetc();
 
 		if (c <= PEOF)
 			break;
 
-		str[len] = c;
+		str[len++] = c;
+
+		if (c == '\'')
+			break;
 	}
 	str[len] = 0;
 
-- 
2.39.2

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
