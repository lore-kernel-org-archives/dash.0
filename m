Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080EF35B651
	for <dash@vger.kernel.org>; Sun, 15 Mar 2026 12:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773578716; cv=none; b=T91GDDT/ax+1nK5E5F4yVNFkLWfjNpvJKiOPnnph4c/ukP0QxAXtU3zo1/HeT5s8Vv4LvYjMfJQ4MEdO8kndSu+R0PatzQOnoRQXu8CIKupFy9XRTpj8FQ2PSC46P+m3AFZ6croRXWCfSby/Gysi6y2us6MOz5WXFiXMIdZDhAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773578716; c=relaxed/simple;
	bh=x30HW9hs85qGn0hxXxAhpqFsZgCmz/LXQTi3ipc4O7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=m7hM52Y9i3zeVZcB1RMl3z67MXOmUbSjick/OyZk9fUWmgH2ors234xo3CoFcJlRSUGhhHvYuh+1jVtR5+V3TK1u/5BU7IFR25wZbk9kMm9FHUcaRbw2oL4Rl+YzukdQeMbFDH2DOeKCBPtxyr3MQ3zlAAE1YZgxkhPrU98d2cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=ikCHvekU; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="ikCHvekU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=RJyjW5WewdS5cKYQhbd7CITKsJYpX+nIWnKy0g7gbKk=; b=ikCHvekUWgR4sfmj02BjGxttdg
	arguqctIrjCWfmE95UqF4KMG2zK0JUi6bmCZiGimuCrrLAbFTXIlBcemgJ0ggLwZ00Eul3mhKY614
	evVIfG7IW/ax+lOjm4GvmHbJMK8Gq3kRz0AJl1bFfPHxbWVsWwTmVNLBMXbKMNixoICUQh8ULD5Bx
	DKdTpcFNiGUiVM5k4G/vXF4GyhY4/g0a+8/q7HxAdiSzlkx+E2cgiHTAiqHAwAW8V94zpf38airA+
	KWk4l+0uKkG3kjy2z1dbsiWy0sUSKFsU3AAIfxyuJxCD8A78+vUoYTINV64xb6yLvz0X/M6jjcHJy
	/xdlKFig==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w1kqC-00Eb9U-2v;
	Sun, 15 Mar 2026 20:45:09 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 15 Mar 2026 21:45:08 +0900
Date: Sun, 15 Mar 2026 21:45:08 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Aleksander Ushakov <retes672@gmail.com>
Cc: dash@vger.kernel.org
Subject: [PATCH] expand: Use memmove when copying multi-byte chars in
 rmescapes
Message-ID: <abap1Nxtvh2bkoNM@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADdNFauVF91SguPkBT7FUPuKLBbwTod=EeLAibqosujYRv01BQ@mail.gmail.com>
X-Newsgroups: apana.lists.os.linux.dash

Aleksander Ushakov <retes672@gmail.com> wrote:
> Dear Dash maintainers,
> 
> I encountered a bug in Dash 0.5.13 and would like to report
> it. The behaviour is the same for ASAN error in Dash 0.5.12 and I
> reported it here (https://www.spinics.net/lists/dash/msg02856.html).
> So steps to reproduce are similarly for 0.5.12 and 0.5.13. The ASAN
> errors have some differences but the problem may be the same. The
> details are  provided below.
> 
> ==4385==ERROR: AddressSanitizer: memcpy-param-overlap: memory ranges
> [0x5e9360717719,0x5e936071771c) and [0x5e936071771b, 0x5e936071771e)
> overlap
>    #0 0x5e935fced469 in __asan_memcpy
> (/upstream/z/dash-0.5.13/src/dash+0xd6469) (BuildId:
> e987025fc7a0e719d6f6413a475e27117a9dee0e)
>    #1 0x5e935fd40db9 in _rmescapes /upstream/z/dash-0.5.13/src/expand.c:2129:8

Thanks for the report.  I'll change the memcpy to memmove.

---8<---
Use memmove instead of mempcpy in rmescapes as the two regions
can indeed overlap when escaps are removed in place.

Fixes: 990bbd15346d ("expand: Process multi-byte characters in subevalvar")
Reported-by: Aleksander Ushakov <retes672@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/expand.c b/src/expand.c
index eed8150..bbf8454 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -2128,7 +2128,8 @@ _rmescapes(char *str, int flag)
 				tail = 0;
 			}
 
-			q = mempcpy(q, p, ml);
+			memmove(q, p, ml);
+			q += ml;
 			p += ml + tail;
 			goto setnesc;
 		}
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
