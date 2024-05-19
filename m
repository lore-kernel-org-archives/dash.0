Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906F1442C
	for <dash@vger.kernel.org>; Sun, 19 May 2024 04:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716093328; cv=none; b=H6QvgVzUUsj4UHqVaxu70cDl3tiPk58h1B6wxGxyGxhjICgZrlXE4DGy8gw711EN67nsGjlIeteSzOG6mg82pdofJayQGA4ZnrU2F+vXV674+lcDDIYbQb3ta9ojfrcIgg2Xr/7VpXLAbDadbW7fsY4oaYse1g6yVAnexneZtwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716093328; c=relaxed/simple;
	bh=+gjk25bXa37XYB86FLYhQi0PRyqnaBZR+GOfuW8xe08=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hPMSN7yhTkMvVuQNo8Fej0jkZBz/iuNi3TAnyqKvhlLAtLlyFu/S6zJMhQvjAeXmoftMVIvBtbXk1mkYMzomkyFwbovvwJovJtsYhbCjfIBP+XRx0XtWB1a4xxQFc/+MRwwYhtwD9+5mPX8QOkbBlvZZwpn6qoaTOzXCiq0qY3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s8YGX-00HFq1-0H;
	Sun, 19 May 2024 12:35:22 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 19 May 2024 12:35:22 +0800
Date: Sun, 19 May 2024 12:35:22 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] expand: Add support for caret
Message-ID: <ZkmBivbgyEeKclKS@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Rather than making dash bigger by actively excluding carets when
fnmatch is enabled, add caret support when fnmatch is disabled.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/expand.c   | 5 +----
 src/mksyntax.c | 4 ++--
 src/mystring.c | 3 ---
 src/mystring.h | 2 +-
 4 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/src/expand.c b/src/expand.c
index 399a9e6..d8b354c 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -1580,7 +1580,7 @@ pmatch(const char *pattern, const char *string)
 
 			startp = p;
 			invert = 0;
-			if (*p == '!') {
+			if (*p == '!' || *p == '^') {
 				invert++;
 				p++;
 			}
@@ -1694,11 +1694,8 @@ _rmescapes(char *str, int flag)
 			notescaped ^= globbing;
 			goto copy;
 		}
-		if (FNMATCH_IS_ENABLED && *p == '^')
-			goto add_escape;
 		if (*p == (char)CTLESC) {
 			p++;
-add_escape:
 			if (notescaped)
 				*q++ = '\\';
 			else if (inquotes) {
diff --git a/src/mksyntax.c b/src/mksyntax.c
index da18f5d..4d7280b 100644
--- a/src/mksyntax.c
+++ b/src/mksyntax.c
@@ -178,14 +178,14 @@ main(int argc, char **argv)
 	add("$", "CVAR");
 	add("}", "CENDVAR");
 	/* ':/' for tilde expansion, '-' for [a\-x] pattern ranges */
-	add("!*?[=~:/-]", "CCTL");
+	add("^!*?[=~:/-]", "CCTL");
 	print("dqsyntax");
 	init();
 	fputs("\n/* syntax table used when in single quotes */\n", cfile);
 	add("\n", "CNL");
 	add("'", "CENDQUOTE");
 	/* ':/' for tilde expansion, '-' for [a\-x] pattern ranges */
-	add("!*?[=~:/-]\\", "CCTL");
+	add("^!*?[=~:/-]\\", "CCTL");
 	print("sqsyntax");
 	init();
 	fputs("\n/* syntax table used when in arithmetic */\n", cfile);
diff --git a/src/mystring.c b/src/mystring.c
index 5eace6c..978bbb5 100644
--- a/src/mystring.c
+++ b/src/mystring.c
@@ -64,9 +64,6 @@ const char dolatstr[] = { CTLQUOTEMARK, CTLVAR, VSNORMAL | VSBIT, '@', '=',
 			  CTLQUOTEMARK, '\0' };
 const char cqchars[] = {
 	'\\',
-#ifdef HAVE_FNMATCH
-	'^',
-#endif
 	CTLESC, CTLQUOTEMARK, 0
 };
 const char illnum[] = "Illegal number: %s";
diff --git a/src/mystring.h b/src/mystring.h
index 07d0c73..d178990 100644
--- a/src/mystring.h
+++ b/src/mystring.h
@@ -54,7 +54,7 @@ extern const char spcstr[];
 extern const char dolatstr[];
 #define DOLATSTRLEN 6
 extern const char cqchars[];
-#define qchars (cqchars + FNMATCH_IS_ENABLED + 1)
+#define qchars (cqchars + 1)
 extern const char illnum[];
 extern const char homestr[];
 
-- 
2.39.2

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
