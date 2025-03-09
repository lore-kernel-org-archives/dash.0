Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4730E1B422A
	for <dash@vger.kernel.org>; Sun,  9 Mar 2025 09:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741514260; cv=none; b=qvANV5VRp5wULWIwFbscnvKLFmdfwDKYgrNCycfXGOcBuvPKlVju48rUiU5Ga3BqkkkPXv6VVWrUGH3Np5zgdKTDs9AsBhOBzLcpcv+aJd1dglpus/HFbi8kU0cSjtE9uu+rm3wprssEXkXTnwWbpLzPZwNHQg5/uZAK4Ank2qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741514260; c=relaxed/simple;
	bh=rhz3JyEB91luowY/PArESwd4aAhPAHzHTn6w8wVBaIU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Yb85ODWuC9zxQRxbNXCsYupLYykgt4aUuYiK0B9CLbhY7J/CcXgF3LbWVsbwBSe/2Xdawi5xhlPprSWif9JsTMY904qD1W56xNXhZ4ebEtPY/yEGbire9VKnGMxuq1rGghIylSqX7hT85gqqq1CpelsRgF6mNeEevfoc4vBfqy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=jvMY+sui; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="jvMY+sui"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xDHHs9PChw6G5ZKZWT58JmrK65mpoFeHsVbyQOG235E=; b=jvMY+suigf468bSP4s+ucPzbio
	rNEcd7ENqCYU+/q7wyi1BjAySmIx4TBNTrCvPM+Zs8pt+u6zFVLtdKw7chrnavtd4aLHZIbl9Tukp
	asw15hDEV4M4Otu6UDY9y+z6UAdQNfS2eHA3c34h0EChvVXJw0SvBjIK+s0m0s83mUnWEbXm91RAc
	UqXyhxZWDYjt8AoA8rx1CTYy2YeCLZnEDRKkNPBMmd5pI9A664G5oSuWs3Tss5duO1So7htcXwZWA
	x9uCU1s3crU0fcQznWZpZUpqeXLitV64NnxTUG4Q/9uBFPQp1Hvs2ZewLrB+LUIZ+K+fkmGCwE5UW
	l7jt/M6A==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1trDBA-0053C9-1J;
	Sun, 09 Mar 2025 17:42:41 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 09 Mar 2025 17:42:40 +0800
Date: Sun, 9 Mar 2025 17:42:40 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jan Pechanec <Jan.Pechanec@oracle.com>
Cc: dash@vger.kernel.org
Subject: [PATCH] expand: Add bypass for literal "]" in expandmeta
Message-ID: <Z81ikFIDPKfySXN2@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z73cCB4Xm89Y5AuT@len49>
X-Newsgroups: apana.lists.os.linux.dash

Jan Pechanec <Jan.Pechanec@oracle.com> wrote:
> 
> thank you for working on dash.  I was testing it recently and it worked
> really well.
> 
> However, I noticed the dash code from github does filename pattern
> matching even for code like "[ x = x ] && echo ok".  I believe the
> unquoted space after '[' should not trigger pattern matching but rather
> only to invoke the test/[ utility, as before.  It seems it works fine
> though and only doing some extra unneeded work which may not be
> immediatelly noticeable.
> 
> dash installed on my Oracle Linux 9:
> 
> janp:len49:~/_INST/dash$ strings /usr/bin/dash | grep dash
> dash-0.5.11.5-4.el9.x86_64.debug
> janp:len49:~/_INST/dash$ time dash -c 'i=0; while :; do : $((i=i+1)); [ $i -eq 500000 ] && break; done'
> 
> real    0m0.752s
> user    0m0.748s
> sys     0m0.002s
> 
> dash from github (commit b3e38adf6718801e7f06267b438c45caec9523bb) take
> way more time to do the same thing:
> 
> janp:len49:~/_INST/dash$ time ./src/dash -c 'i=0; while :; do : $((i=i+1)); [ $i -eq 500000 ] && break; done'
> 
> real    0m4.202s
> user    0m1.361s
> sys     0m2.804s
> 
> For the latter, strace shows open, fstat, getdents*, and close system
> calls for each iteration and it depends on number of files in the
> current directory.  With more files, it takes more time:
> 
> janp:len49:/etc$ time ~/_INST/dash/src/dash -c 'i=0; while :; do : $((i=i+1)); [ $i -eq 500000 ] && break; done'
> real    0m15.591s
> user    0m5.704s
> sys     0m9.828s
> 
> If I change [ to test, the dash github version behaves as before, and
> possibly even faster:
> 
> janp:len49:~/_INST/dash$ time ~/_INST/dash/src/dash -c 'i=0; while :; do : $((i=i+1)); test $i -eq 500000 && break; done'
> 
> real    0m0.662s
> user    0m0.659s
> sys     0m0.002s
> 
> Even bash would be faster than the current github version of dash:
> 
> janp:len49:~/_INST/dash$ time bash -c 'i=0; while :; do : $((i=i+1)); [ $i -eq 500000 ] && break; done'
> real    0m1.943s
> user    0m1.939s
> sys     0m0.002s

Fix performance regression for idiomatic "[ ... ]" expression by
adding a bypass for a literal "]" in pathname expansion.

Reported-by: Jan Pechanec <Jan.Pechanec@oracle.com>
Fixes: 8d0eca2d9fb5 ("expand: Rewrite expmeta meta detection")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/expand.c b/src/expand.c
index 7a30648..5114646 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -1555,7 +1555,7 @@ expandmeta(struct strlist *str)
 
 		if (fflag)
 			goto nometa;
-		if (!strpbrk(str->text, "*?]"))
+		if (!strpbrk(str->text, "*?]") || !memcmp(str->text, "]", 2))
 			goto nometa;
 		savelastp = exparg.lastp;
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
