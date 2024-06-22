Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C1215217E
	for <dash@vger.kernel.org>; Sat, 22 Jun 2024 12:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719059214; cv=none; b=gVT3g7QygQeWK30l8X6d6tkSJVfPPwK11NCzy0ExIIxhbbRcXhfk2w33+ivzpVyV9srbNuNKDPaWRsDlZr6iLXozVwMTe4+cduLkwY5iOphxT6r7S4bl7aidHXbmP7YcSBitRf/i5SSWSfUDTAgLKhE7oDQyHb2b6pCWp4pHuCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719059214; c=relaxed/simple;
	bh=iATjCgrwUESTiUQdmidrahfyQW3vyRQZuTqvMz4dolM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=svh+i1b1yGbDl82wPZ+0maBuIhzr1ox/OiPM9LJc1I8cajIDn6DonN3pWngvPXs6Qi+lkX3kNnAoNwnGsRW7+/mo2olz1g22hma0LshsJi/ARcU/t7zOiK8EFcXnA/OJ+loIr9NTF16HLCuNK8v9LbL2c7L1UEhZ+HCKCwTvvvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sKziE-002CHN-01;
	Sat, 22 Jun 2024 20:19:23 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 22 Jun 2024 20:19:22 +0800
Date: Sat, 22 Jun 2024 20:19:22 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Martijn Dekker <martijn@inlv.org>
Cc: dash@vger.kernel.org
Subject: [PATCH] expand: Fix leading white space regression in ifsbreakup
Message-ID: <ZnbBSnDM7aGUAb5L@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b19b7107-097e-4865-a0d9-26cdf316c1c4@inlv.org>
X-Newsgroups: apana.lists.os.linux.dash

Martijn Dekker <martijn@inlv.org> wrote:
> As of commit c0674f487c7aec2a3bdf6795cea7e60c9530c360, field splitting is 
> broken. Minimal-ish reproducer:
> 
> $ dash -c 'IFS=:; v=" :: :: "; set $v; echo $#'
> 5
> 
> Expected output: 2
> 
> FYI, this is a nice cross-platform script for testing for field splitting 
> regressions (on dash as well):
> 
> http://web.archive.org/web/20051225040851/http://www.research.att.com/~gsf/public/ifs.sh
> 
> Dash passes this prior to the referenced commit, and fails it after, in 
> informative ways.

Thanks for the report.  This patch should fix the problem:

---8<---
When leading white spaces are detected in ifsbreakup ifsspc needs
to be cleared.

Reported-by: Martijn Dekker <martijn@inlv.org>
Fixes: c0674f487c7a ("expand: Support multi-byte characters during field splitting")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/expand.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/expand.c b/src/expand.c
index 6912e39..5285b79 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -1282,7 +1282,7 @@ static char *ifsbreakup_slow(struct ifs_state *ifst, struct arglist *arglist,
 		/* Ignore IFS whitespace at start */
 		if (q == ifst->start && ifsspc) {
 			ifst->start = p;
-			return p;
+			goto out_zero_ifsspc;
 		}
 		if (ifst->maxargs > 0 && !--ifst->maxargs) {
 			ifst->r = q;
@@ -1297,6 +1297,7 @@ static char *ifsbreakup_slow(struct ifs_state *ifst, struct arglist *arglist,
 		return p;
 	}
 
+out_zero_ifsspc:
 	ifst->ifsspc = 0;
 	return p;
 }
-- 
2.39.2
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
