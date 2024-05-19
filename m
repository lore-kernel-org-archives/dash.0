Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F5F4437
	for <dash@vger.kernel.org>; Sun, 19 May 2024 05:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716096032; cv=none; b=bXTMjBqbJkd2ip7fbniRUY7V5u9MUXWDuo2zNIsVQFm2iS1eMK0kMBPh6aYkZXlwhXe/ivzBm2nTVNgj/Al7w/qqhBmraCMMSnVn6I42rdofrKAgY9Yb4KmP0hckEQO0O+IQwnZPMcRcc/BrQKP+C+T58ZIAnrQrPM0IVLywiMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716096032; c=relaxed/simple;
	bh=mDQ9ZCbicr5SFLv6A+EEB8nvfMcv5Am7kAM0I2z4Evs=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=EmUslaevXCTPGzG771zuhJu18lM65d69dvY62arrIPWdF9X5RGrMfI8GAkZ8q+sH2ESfOUByXRCPZRIF5lcO65MIzQT5iTsTVygDHLqxDCpkuI03f7OI/YKGSDLWiYs377FGZLjFJp7XBsUhP+Q8gtcSSSi29TIQxerbghnG+S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s8YyB-00HGD7-0k;
	Sun, 19 May 2024 13:20:28 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 19 May 2024 13:20:28 +0800
Date: Sun, 19 May 2024 13:20:28 +0800
Message-Id: <97c5c86c09bb88eb4f85a4fd8acf2c5f3cdaf22a.1716095868.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1716095868.git.herbert@gondor.apana.org.au>
References: <cover.1716095868.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v4 PATCH 09/13] input: Add pgetc_eoa
To: DASH Mailing List <dash@vger.kernel.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

This reintroduces PEOA in a limited way.  Instead of allowing pgetc
to return it, limit it to a new function pgetc_eoa so only specific
callers need to deal with PEOA.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/input.c | 8 +++++++-
 src/input.h | 3 ++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/input.c b/src/input.c
index e17e067..bedc581 100644
--- a/src/input.c
+++ b/src/input.c
@@ -157,7 +157,7 @@ static int __pgetc(void)
  * Nul characters in the input are silently discarded.
  */
 
-int pgetc(void)
+int __attribute__((noinline)) pgetc(void)
 {
 	struct strpush *sp = parsefile->spfree;
 
@@ -167,6 +167,12 @@ int pgetc(void)
 	return __pgetc();
 }
 
+int pgetc_eoa(void)
+{
+	return parsefile->strpush && parsefile->nleft == -1 &&
+	       parsefile->strpush->ap ? PEOA : pgetc();
+}
+
 static int stdin_clear_nonblock(void)
 {
 	int flags = fcntl(0, F_GETFL, 0);
diff --git a/src/input.h b/src/input.h
index 5b4a045..151b1c6 100644
--- a/src/input.h
+++ b/src/input.h
@@ -45,6 +45,7 @@
 #define PUNGETC_MAX (MB_LEN_MAX > 16 ? MB_LEN_MAX : 16)
 
 /* PEOF (the end of file marker) is defined in syntax.h */
+#define PEOA ((PEOF) - 1)
 
 enum {
 	INPUT_PUSH_FILE = 1,
@@ -102,7 +103,7 @@ extern struct parsefile *parsefile;
 #define plinno (parsefile->linno)
 
 int pgetc(void);
-int pgetc2(void);
+int pgetc_eoa(void);
 void pungetc(void);
 void pungetn(int);
 void pushstring(char *, void *);
-- 
2.39.2

