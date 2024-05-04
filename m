Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76DC57CB8
	for <dash@vger.kernel.org>; Sat,  4 May 2024 05:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714799891; cv=none; b=ANlahoS/DD0MVulJARsWIfv8hTSWOqGkchZp+/CGi1iaTp4LRWoaA3NBPy1OWMG/vBFFrCyVLY8BiWLi9JNUsk1uX1s5Y7rBVv8LNxaXtux3GgxN7Wm5EgeKBcymJL1CDpd5Y955Qoj6cVBtBckcIVAvrfUUCGlidRwIZIn3zEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714799891; c=relaxed/simple;
	bh=rI4yMo+x7ryHxOtF8M+TnKzOLLOkciIdx/AlFjQwGYY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BVrrmlSwD+aBMrrIDEGiR1ivul0mr5YzrdIdjX01t7IwI+4SZvLsD+dbBPpE4TF3OB03ib0qX1P5X4bUE8EfeKofAcgfNnI8kj0LLBGtDFlTMg6jidI5X1N0bGyf1b5pj7nH/9jz/dUDWd37pXBshfa4jgmFT2kETRHeZttIuDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s37mc-00AF0B-11;
	Sat, 04 May 2024 13:18:03 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 04 May 2024 13:18:02 +0800
Date: Sat, 4 May 2024 13:18:02 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] mystring: Add a few more uses of snlfmt
Message-ID: <ZjXFCpJ-ULp-HtIn@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use snlfmt in a few more places.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/alias.c     | 2 +-
 src/jobs.c      | 2 +-
 src/miscbltin.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/alias.c b/src/alias.c
index bacf10f..a443e05 100644
--- a/src/alias.c
+++ b/src/alias.c
@@ -204,7 +204,7 @@ freealias(struct alias *ap) {
 
 void
 printalias(const struct alias *ap) {
-	out1fmt("%s\n", single_quote(ap->name));
+	out1fmt(snlfmt, single_quote(ap->name));
 }
 
 STATIC struct alias **
diff --git a/src/jobs.c b/src/jobs.c
index 840e37c..4cf6b8c 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -345,7 +345,7 @@ usage:
 			pid = **argv == '-' ?
 				-number(*argv + 1) : number(*argv);
 		if (kill(pid, signo) != 0) {
-			sh_warnx("%s\n", strerror(errno));
+			sh_warnx(snlfmt, strerror(errno));
 			i = 1;
 		}
 	} while (*++argv);
diff --git a/src/miscbltin.c b/src/miscbltin.c
index e553f9e..8a0ddf4 100644
--- a/src/miscbltin.c
+++ b/src/miscbltin.c
@@ -237,7 +237,7 @@ umaskcmd(int argc, char **argv)
 				*ap++ = ',';
 			}
 			ap[-1] = '\0';
-			out1fmt("%s\n", buf);
+			out1fmt(snlfmt, buf);
 		} else {
 			out1fmt("%.4o\n", mask);
 		}
-- 
2.39.2

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
