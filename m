Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D6F4AEF8
	for <dash@vger.kernel.org>; Sat, 27 Apr 2024 11:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714217554; cv=none; b=RW5f7wH68527B/HmS5eVxQzHYrsjtKFqla6eYk5w/hyOrrtY7SJPH5nwZ9p1YXeer5EvRNr0Wf5o+xf2bKqrO1ravKJ3O2gZHAh7UO/AAteDVHWcQnlN0u/vWKJb4+gUdOvlBTzGjLy0NQ46vrjVLIQkuPpubFK1PxGTp1mRFkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714217554; c=relaxed/simple;
	bh=5GTHrZv1n+ol0fUP4U63nkseMZ2Bg6kc4VSvAcQr0gQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F4i2v4pYu6nJccExF5g/i2gpaf8iaWqnTiAPiZljqhmNUgL09u+uIrp5f+cvHHURMKAc8lmqDkcSzOuh5+pHIsBMskJAXd6T73W5cfBHyMmuYJw4cUTAcuF51Q7i0qnhNJxJ89DDnu6v8xyEDCNNfdVxyz4zDk8bDfUUvekBUbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s0fpH-0079fC-0B;
	Sat, 27 Apr 2024 19:02:40 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 27 Apr 2024 19:02:57 +0800
Date: Sat, 27 Apr 2024 19:02:57 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] expand: Fix naked backslah leakage
Message-ID: <ZizbYRti9EydVOg4@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

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
 2 files changed, 9 insertions(+), 2 deletions(-)

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
-- 
2.39.2

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
