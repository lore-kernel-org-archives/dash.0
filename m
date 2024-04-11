Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645D813E03B
	for <dash@vger.kernel.org>; Thu, 11 Apr 2024 07:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821421; cv=none; b=frtMX5a0GF7iwazzQQJRVhrQeGu1WxM2Nn+TzQ8ATJU0dGEezygE3On7Jd950T6D96stLDZVxaZyr043LG7fulInSyGR4sC/MpYanJzr4Qde2CuLInGB6EYnQ+eJGyFLI6vu8wwNhrwhSar5dKA+mkCOCwiGU0xiXBLUAoeVKVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821421; c=relaxed/simple;
	bh=CHK0TBbukuvJzf3WSMTokB0DJ/Keh6Geh+EtO+HNU5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCdKM888OVDVVlB7ncs2T7BtA4wJ4fflr8eOj6/0DpBTTVkT94z41/KzWyraXligxQ0aKUEkqrBXBGR5LvcdgMY8SRMzR1DqjMqHboQAT1AJP042zxrfqxSXZIkNKr/I6ZFOEAGXHrTr5TP8K3FehTPIny59PuTTxT4tXvws1O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rup5q-000G5E-KK; Thu, 11 Apr 2024 15:43:35 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 11 Apr 2024 15:43:52 +0800
Date: Thu, 11 Apr 2024 15:43:52 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Christoph Anton Mitterer <calestyo@scientia.org>
Cc: DASH shell mailing list <dash@vger.kernel.org>,
	Harald van Dijk <harald@gigawatt.nl>
Subject: [PATCH] var: Fix unexporting of local variables using unset
Message-ID: <ZheUuMS9rReRzEY5@gondor.apana.org.au>
References: <43f0631aea36f6b49e5c3dfdfe481a5a2b1fec6c.camel@scientia.org>
 <ac893750-085d-421a-b296-a182ae51f1ec@gigawatt.nl>
 <0fd6f8b9-7175-4cc9-9d99-586beb3ede48@inlv.org>
 <252ec2b0-70dc-4621-96c2-285aa915cce0@gigawatt.nl>
 <4bcfdb66-c60f-4172-9f4c-cc25c3e99ddc@inlv.org>
 <6e4e70da-b137-44c9-944a-4b4eb4ef2174@gigawatt.nl>
 <d307bc34-f8f4-43d6-9c09-76e02df7d02f@inlv.org>
 <98c5a2b67554676839deded400d4669934b9cd07.camel@scientia.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98c5a2b67554676839deded400d4669934b9cd07.camel@scientia.org>

On Thu, Apr 11, 2024 at 03:26:53AM +0200, Christoph Anton Mitterer wrote:
> 
> With all the recently merged patches... any chance that we get this
> issue(s) here fixed?
> Or at least those, where it's clear what should happen?

Thanks for the reminder.  This patch should fix the problem.

---8<---
Local variables and other variables with the flag VSTRFIXED set
could not be unexported using the unset command.  Fix this by
adding a special case in setvareq for them.

Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
Fixes: e3c9a7dd7097 ("[VAR] Move unsetvar functionality into setvareq")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/var.c b/src/var.c
index 21e0abf..6f85be3 100644
--- a/src/var.c
+++ b/src/var.c
@@ -255,6 +255,8 @@ struct var *setvareq(char *s, int flags)
 	vpp = findvar(s);
 	vp = *vpp;
 	if (vp) {
+		unsigned bits;
+
 		if (vp->flags & VREADONLY) {
 			const char *n;
 
@@ -274,8 +276,11 @@ struct var *setvareq(char *s, int flags)
 		if ((vp->flags & (VTEXTFIXED|VSTACK)) == 0)
 			ckfree(vp->text);
 
-		if (((flags & (VEXPORT|VREADONLY|VSTRFIXED|VUNSET)) |
-		     (vp->flags & VSTRFIXED)) == VUNSET) {
+		if ((flags & (VEXPORT|VREADONLY|VSTRFIXED|VUNSET)) != VUNSET)
+			bits = ~(VTEXTFIXED|VSTACK|VNOSAVE|VUNSET);
+		else if ((vp->flags & VSTRFIXED))
+			bits = VSTRFIXED;
+		else {
 			*vpp = vp->next;
 			ckfree(vp);
 out_free:
@@ -284,7 +289,7 @@ out_free:
 			goto out;
 		}
 
-		flags |= vp->flags & ~(VTEXTFIXED|VSTACK|VNOSAVE|VUNSET);
+		flags |= vp->flags & bits;
 	} else {
 		if (flags & VNOSET)
 			goto out;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
