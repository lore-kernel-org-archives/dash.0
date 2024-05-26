Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CC68F4E
	for <dash@vger.kernel.org>; Sun, 26 May 2024 10:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716720073; cv=none; b=Q+b3t70fSFcmdrVRHBH3+HW3BY/TnIw0H/S0+Tnpk4829O1XEKTnIn5ylXCDSpmbJZcJjFbUu0TJYbYmV/Wfip1eUdOSsUlFTpgzQ9hokphK7H6hcOGA7F/0OVriEHtReGFKzHgcSH/F6MW7gTe3UNE0RlWnlciW9pIQIDJQOyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716720073; c=relaxed/simple;
	bh=mQ8BZ/yKGd8Go11/eEyT7jGrU/0vTG3emutl/8EWRsw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZDkZ9Y9LL88GiZTGtmc+8eWFHwM+HdyIZpJ/7FJr8odhM/bgBw2iZ0ujhzUMOa9eeInE8F+Y8KV7m3XZYTPQaPmGln4lH9N1mt9fT8a3priOiw+F4ito5r1ukWBqmMskN7zKU9TR/tEr+qdPyK1ABzAodhqjUWPt5oBH4XZglZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sBBJI-002DxO-3C;
	Sun, 26 May 2024 18:41:06 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 26 May 2024 18:41:06 +0800
Date: Sun, 26 May 2024 18:41:06 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] mystring: Add dotdir
Message-ID: <ZlMRwiyOhfrIz2mY@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Merge all occurrences of "." into dotdir.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/cd.c       | 2 +-
 src/expand.c   | 2 +-
 src/mystring.c | 1 +
 src/mystring.h | 1 +
 src/var.c      | 2 +-
 5 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/cd.c b/src/cd.c
index 1ef1dc5..bcd1484 100644
--- a/src/cd.c
+++ b/src/cd.c
@@ -126,7 +126,7 @@ dotdot:
 		}
 	}
 	if (!*dest)
-		dest = ".";
+		dest = dotdir;
 	path = bltinlookup("CDPATH");
 	while (p = path, (len = padvance_magic(&path, dest, 0)) >= 0) {
 		c = *p;
diff --git a/src/expand.c b/src/expand.c
index d8b354c..e7e8ce0 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -1358,7 +1358,7 @@ expmeta(char *name, unsigned name_len, unsigned expdir_len)
 	cp = expdir;
 	expdir_len = enddir - cp;
 	if (!expdir_len)
-		cp = ".";
+		cp = dotdir;
 	if ((dirp = opendir(cp)) == NULL)
 		return;
 	if (*endname == 0) {
diff --git a/src/mystring.c b/src/mystring.c
index 978bbb5..7bf61e3 100644
--- a/src/mystring.c
+++ b/src/mystring.c
@@ -68,6 +68,7 @@ const char cqchars[] = {
 };
 const char illnum[] = "Illegal number: %s";
 const char homestr[] = "HOME";
+const char dotdir[] = ".";
 
 /*
  * equal - #defined in mystring.h
diff --git a/src/mystring.h b/src/mystring.h
index d178990..0857c32 100644
--- a/src/mystring.h
+++ b/src/mystring.h
@@ -57,6 +57,7 @@ extern const char cqchars[];
 #define qchars (cqchars + 1)
 extern const char illnum[];
 extern const char homestr[];
+extern const char dotdir[];
 
 #if 0
 void scopyn(const char *, char *, int);
diff --git a/src/var.c b/src/var.c
index bb5420a..e2102c3 100644
--- a/src/var.c
+++ b/src/var.c
@@ -143,7 +143,7 @@ INIT {
 
 	p = lookupvar("PWD");
 	if (p)
-		if (*p != '/' || stat64(p, &st1) || stat64(".", &st2) ||
+		if (*p != '/' || stat64(p, &st1) || stat64(dotdir, &st2) ||
 		    st1.st_dev != st2.st_dev || st1.st_ino != st2.st_ino)
 			p = 0;
 	setpwd(p, 0);
-- 
2.39.2

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
