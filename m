Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6055337A
	for <dash@vger.kernel.org>; Fri, 12 Apr 2024 09:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712915477; cv=none; b=KjzLq8S6i8E2BKuP+HNYWAV1D4smldIm+PNCw2+/8eqaI1w8VF+Vm0dMC52O0kX6wG7BtkF+4In85wHvNt+6MUQfANXxHMMsEk154gQdvNke7HDFnMd4A4cIRG5CHAy1wdgp9VmY932FpW+qgt4EArnlF4c08ovBBTZDpdktObY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712915477; c=relaxed/simple;
	bh=tdiydCE3+xtc/EjRQhkNC5k86y0vcemeKwrpzOjEyAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3LgRenJ3HXSTIEkvmMNbMkng9a9Q42gl9CCaXmiQmdQh2s2vder0+rmIMSz8w4EljwKpVFyqvEscIoV2GvQLYwn2MuSmA16kGUmHULsFK49O0pqVwH8HNBSmdYrLXKspDxJY4RdqhypZYvtKSBuBvzNLjhfy+wuWS9BMRJKkJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rvDYq-000pCo-Ca; Fri, 12 Apr 2024 17:51:09 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 12 Apr 2024 17:51:25 +0800
Date: Fri, 12 Apr 2024 17:51:25 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Harald van Dijk <harald@gigawatt.nl>
Cc: DASH shell mailing list <dash@vger.kernel.org>
Subject: [PATCH] alias: Disallow non-CWORD characters
Message-ID: <ZhkEHWODl9ZFKBhq@gondor.apana.org.au>
References: <444eaa61-35a8-15f4-5aeb-14a56aa38d07@gigawatt.nl>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <444eaa61-35a8-15f4-5aeb-14a56aa38d07@gigawatt.nl>

On Wed, Jan 11, 2023 at 02:01:03AM +0000, Harald van Dijk wrote:
>
> Supporting alias names containing non-ASCII characters, while not required
> by POSIX, seems desirable, and almost all other shells (mksh being the
> exception) do appear to support this. I am not yet seeing a good way of
> solving this.

I looked at supporting this properly by either adding or removing
quotes but the complexity is just not worth it.  Let's just ban
these characters.

---8<---
Alias names containing control characters may match words from
the parser that shouldn't be matched.  Disallow such characters
from appearing in an alias name.

Reported-by: Harald van Dijk <harald@gigawatt.nl>

diff --git a/src/alias.c b/src/alias.c
index cee07e9..3cd3413 100644
--- a/src/alias.c
+++ b/src/alias.c
@@ -41,6 +41,7 @@
 #include "mystring.h"
 #include "alias.h"
 #include "options.h"	/* XXX for argptr (should remove?) */
+#include "syntax.h"
 
 #define ATABSIZE 39
 
@@ -55,6 +56,11 @@ void
 setalias(const char *name, const char *val)
 {
 	struct alias *ap, **app;
+	const char *p;
+
+	for (p = name; *p; p++)
+		if (BASESYNTAX[(signed char)*p] != CWORD)
+			sh_error("Invalid alias name: %s", name);
 
 	app = __lookupalias(name);
 	ap = *app;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
