Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E912C853
	for <dash@vger.kernel.org>; Wed,  1 May 2024 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714554737; cv=none; b=f/VDbmzZA5tsuAcVNul9oP4bpNUjz48m7FqFWCzvaPgPZ6d8VHEeHfEnGnFFxn7vFzOQVHkUr2IOBP8rnIbjjFmwCGc5zx2vQ8gLpXW3Mzy9Rg8NkYDdCER37W4MSzDDyTyAT9vMqsJPrhlu+FVAkQ8fANXOqO0M+TFUDnsMaL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714554737; c=relaxed/simple;
	bh=lQDwvFnZm0CT7A0NtD0C3nCnXO27r591ZocGEkWHCJs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FO+rhltGyeWFV/HAUJTnIQvc1lbG8ty7x4tugplTfndi+o8vnxEKf7I6yYvnN4UCauovE/hWwAxo8liwiwZ8hK/YSAkXc12ApoXoTqeYNH+mP7tkHtJZCQdgmSj6WogitORDuMu43T3QLAv8fBLaiKc3/xg7aQN/seZLAf/WEFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s260X-0093jJ-0N;
	Wed, 01 May 2024 17:12:10 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 01 May 2024 17:12:27 +0800
Date: Wed, 1 May 2024 17:12:27 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: DASH Mailing List <dash@vger.kernel.org>
Subject: [v2 PATCH] expand: Fix naked backslah leakage
Message-ID: <ZjIHe+fg42+MivAy@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

v2 adjusts qchars to skip the backslash.

---8<---
Naked backslashes in patterns may incorrectly unquote subsequent
wild characters that are themselves quoted.  Fix this by adding
an extra backslash when necessary.

Test case:

	a="\\*bc"; b="\\"; c="*"; echo "<${a##$b"$c"}>"

Old result:

	<>

New result:

	<bc>

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/expand.c   | 10 ++++++++--
 src/mystring.c |  1 +
 src/mystring.h |  2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/src/expand.c b/src/expand.c
index 2ed02d6..0db2b29 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -1658,6 +1658,7 @@ _rmescapes(char *str, int flag)
 	char *p, *q, *r;
 	int notescaped;
 	int globbing;
+	int inquotes;
 
 	p = strpbrk(str, cqchars);
 	if (!p) {
@@ -1692,16 +1693,17 @@ _rmescapes(char *str, int flag)
 			q = mempcpy(q, str, len);
 		}
 	}
+	inquotes = 0;
 	notescaped = globbing;
 	while (*p) {
 		if (*p == (char)CTLQUOTEMARK) {
 			p++;
-			notescaped = globbing;
+			inquotes ^= globbing;
 			continue;
 		}
 		if (*p == '\\') {
 			/* naked back slash */
-			notescaped = 0;
+			notescaped ^= globbing;
 			goto copy;
 		}
 		if (FNMATCH_IS_ENABLED && *p == '^')
@@ -1711,6 +1713,10 @@ _rmescapes(char *str, int flag)
 add_escape:
 			if (notescaped)
 				*q++ = '\\';
+			else if (inquotes) {
+				*q++ = '\\';
+				*q++ = '\\';
+			}
 		}
 		notescaped = globbing;
 copy:
diff --git a/src/mystring.c b/src/mystring.c
index f651521..5eace6c 100644
--- a/src/mystring.c
+++ b/src/mystring.c
@@ -63,6 +63,7 @@ const char snlfmt[] = "%s\n";
 const char dolatstr[] = { CTLQUOTEMARK, CTLVAR, VSNORMAL | VSBIT, '@', '=',
 			  CTLQUOTEMARK, '\0' };
 const char cqchars[] = {
+	'\\',
 #ifdef HAVE_FNMATCH
 	'^',
 #endif
diff --git a/src/mystring.h b/src/mystring.h
index 564b911..d0ec9dd 100644
--- a/src/mystring.h
+++ b/src/mystring.h
@@ -48,7 +48,7 @@ extern const char spcstr[];
 extern const char dolatstr[];
 #define DOLATSTRLEN 6
 extern const char cqchars[];
-#define qchars (cqchars + FNMATCH_IS_ENABLED)
+#define qchars (cqchars + FNMATCH_IS_ENABLED + 1)
 extern const char illnum[];
 extern const char homestr[];
 
-- 
2.39.2

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
