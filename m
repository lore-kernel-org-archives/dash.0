Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B4B4596E
	for <dash@vger.kernel.org>; Sun, 19 May 2024 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716128522; cv=none; b=jywIm7dOa/1LSHVoEQ9H4gUS/pHrRc04kd8+M+ZFWlDBZ44TxjtUfgQJCXwY8Wklj2JJJyt83TWPmbE7lryFZoGRsrghqmvrUqldEJBNzWC5TfYwMkZzvcdRsqnNKg19I5Cna5C5eh7Zxwlu76MWeXG1eTzRtFjsTD8zysss/bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716128522; c=relaxed/simple;
	bh=YYmY+fXgqd/70yvPnqoiYdeZh8g8ZO+PuaE7KMZc+9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pukgz6RrC6uq04vMQ1UPt/Dmsn2/FKSz4LXIVmm2cnm1JrxzhybSUtE4FDTDKsVnL97fAuk6yBFqCJb3IdInetaXFl2dTdkMu7csZiR43CYxG3Q86Vv7YqdO5JpBHARtGGl68IUwKgtR+JzdMZK265WmVrJQOFOL00l1EN2CVA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s8hPx-00HMN6-22;
	Sun, 19 May 2024 22:21:42 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 19 May 2024 22:21:42 +0800
Date: Sun, 19 May 2024 22:21:42 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Harald van Dijk <harald@gigawatt.nl>
Cc: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
	dash@vger.kernel.org, 985478@bugs.debian.org
Subject: [v2 PATCH] options: Always reset OPTIND in getoptsreset
Message-ID: <ZkoK9vQYFz4vZ4wr@gondor.apana.org.au>
References: <20221214023130.u7pn4ca6ma4kuxot@tarta.nabijaczleweli.xyz>
 <Y7P33bSfbmpe7EI/@gondor.apana.org.au>
 <20230103122619.bhvn7lep5avoanji@tarta.nabijaczleweli.xyz>
 <Y7VOEx/cE4vQZ0zE@gondor.apana.org.au>
 <20230104125421.rmjbjzme7a6qbxhx@tarta.nabijaczleweli.xyz>
 <Y7WJVBPWsNhTvRuJ@gondor.apana.org.au>
 <20230104160526.7vuq3s2ivqaaot4l@tarta.nabijaczleweli.xyz>
 <b00cdaa5-0072-392c-3cf7-184aa8e45ae3@gigawatt.nl>
 <ZkngRVxkiUil_9aG@gondor.apana.org.au>
 <64b35f8d-32bc-4331-9e67-fc06305a2e34@gigawatt.nl>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64b35f8d-32bc-4331-9e67-fc06305a2e34@gigawatt.nl>

On Sun, May 19, 2024 at 02:23:23PM +0100, Harald van Dijk wrote:
>
> This interacts terribly with the not fully reliable but nevertheless fairly
> commonly used "local OPTIND". When the local OPTIND goes out of scope and
> the prior value of OPTIND is restored, the expectation is not that option
> processing restarts from the beginning.

Dash doesn't actually need "local OPTIND".  In fact, if you do
"local OPTIND" then dash will already be broken because even
if OPTIND is reset to the same value, the other internal state
optoff will end up being wrong.

However, it's not hard to make dash ignore "local OPTIND" and
make it work as if it wasn't there.

---8<---
Always reset OPTIND if it is modified by the user, regardless of
its value.

Do not call getoptsreset when returning from a function because
of "local OPTIND" as this simply trashes the caller's getopts
state.

Reported-by: наб <nabijaczleweli@nabijaczleweli.xyz>
Reported-by: Harald van Dijk <harald@gigawatt.nl>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/options.c b/src/options.c
index 4d0a53a..c74e4fe 100644
--- a/src/options.c
+++ b/src/options.c
@@ -393,7 +393,7 @@ setcmd(int argc, char **argv)
 
 void getoptsreset(const char *value)
 {
-	shellparam.optind = number(value) ?: 1;
+	shellparam.optind = 1;
 	shellparam.optoff = -1;
 }
 
diff --git a/src/var.c b/src/var.c
index df432b5..b06b36c 100644
--- a/src/var.c
+++ b/src/var.c
@@ -93,7 +93,7 @@ struct var varinit[] = {
 	{ 0,	VSTRFIXED|VTEXTFIXED,		"PS1=$ ",	0 },
 	{ 0,	VSTRFIXED|VTEXTFIXED,		"PS2=> ",	0 },
 	{ 0,	VSTRFIXED|VTEXTFIXED,		"PS4=+ ",	0 },
-	{ 0,	VSTRFIXED|VTEXTFIXED,		defoptindvar,	getoptsreset },
+	{ 0,	VSTRFIXED|VTEXTFIXED|VNOFUNC,	defoptindvar,	getoptsreset },
 #ifdef WITH_LINENO
 	{ 0,	VSTRFIXED|VTEXTFIXED,		linenovar,	0 },
 #endif
@@ -535,7 +535,7 @@ poplocalvars(void)
 				ckfree(vp->text);
 			vp->flags = lvp->flags;
 			vp->text = lvp->text;
-			if (vp->func)
+			if (vp->func && !(vp->flags & VNOFUNC))
 				(*vp->func)(varnull(vp->text));
 		}
 		ckfree(lvp);
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
