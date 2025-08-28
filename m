Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB212E093E
	for <dash@vger.kernel.org>; Thu, 28 Aug 2025 07:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366570; cv=none; b=j4Nvpfoq8KzBPTDy2eW9bDZm9MLyDSOaHB04eUx6Ssxy0lDIWsTo1DO3WNs6rwVQPOFPVBXAbO1yCU/xE4vYG/ccA7sG8vTPIzkIpg9OVWv3Jt28Ur6flo21qQ9wkORLdbgo5ZPhEEooUHGdqFOp2vPPEdJptTbrFcpMHxLJ5KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366570; c=relaxed/simple;
	bh=uWjMYu/AvI2dIFYtjuJQ6LX6HXCFac+MD+I3vah5SkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oHDAx2xPaYLl1ZDpEbBV4r/ouuJAMEHf8xBgQiqVjI1enFje88mB6w3gXOtr0fYMofws4S4GJnl9JO0gwu2wVR9UEx8esWFthIy8E5FpnT8nGgtGEWsnFq7s/E89+LeW7NrSs6wY8vkipilPBYvTmAMqD17te5+uaVJv+3AIzWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=sF8dpsU8; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="sF8dpsU8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=334znGo6ZwSE+nROWpDOx5uiEy84yXQ/eTiDtscq03g=; b=sF8dpsU8S7M57uEFQs+Cjiz4o8
	7cgJ4EMNYTXHEh5UNsWg70GOdwcAzUkHFKrSDepkUyoEji7R8J3DN+bhLFH28TTgwJs5rYKtbd/4Q
	8QOS0VA1V29+dNQwVitU0iMIm3lEXL6QCMXBKEifKFVz1cbZFej7qdpXIUZZFnHE+rjab7S3L7PDO
	EhjxzLPLUhEoCDpvkQiLAWJC4k2WwnjgxMPPDFE/fbYc+hMmOe4RHTTKCuiZChWAAP6DY3Z1KB4bm
	GS+SxHEuqq0WlayYS4z8ehemBLL1zgFNAV7Md9nz8v9l9jxoyPch5BiQzE2S5OiHD7q6CV/fRcC/s
	HmNPDi2g==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1urWvU-000Qfm-2h;
	Thu, 28 Aug 2025 15:36:02 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 28 Aug 2025 15:36:01 +0800
Date: Thu, 28 Aug 2025 15:36:01 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Aleksander Ushakov <aushakov@astralinux.ru>
Cc: dash@vger.kernel.org
Subject: [PATCH] builtin: Fix argv overrun in aexpr and oexpr
Message-ID: <aLAG4YtNOsfqcq1l@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52d97ed4-7c78-44ec-8c1b-60569491aa31@astralinux.ru>
X-Newsgroups: apana.lists.os.linux.dash

Aleksander Ushakov <aushakov@astralinux.ru> wrote:
>
> I think I fixed the problem here:

Thanks for the report.  I think the following patch should fix
it too:

---8<---
Abort aexpr and oexpr if t_wp hits a NULL at the start.

Link: https://lore.kernel.org/dash/52d97ed4-7c78-44ec-8c1b-60569491aa31@astralinux.ru/
Reported-by: Aleksander Ushakov <aushakov@astralinux.ru>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/bltin/test.c b/src/bltin/test.c
index 6d844f1..4a3b86c 100644
--- a/src/bltin/test.c
+++ b/src/bltin/test.c
@@ -250,6 +250,8 @@ oexpr(enum token n)
 
 	for (;;) {
 		res |= aexpr(n);
+		if (!*t_wp)
+			break;
 		n = t_lex(t_wp + 1);
 		if (n != BOR)
 			break;
@@ -266,6 +268,8 @@ aexpr(enum token n)
 	for (;;) {
 		if (!nexpr(n))
 			res = 0;
+		if (!*t_wp)
+			break;
 		n = t_lex(t_wp + 1);
 		if (n != BAND)
 			break;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
