Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EA883CBA
	for <dash@vger.kernel.org>; Mon, 29 Apr 2024 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.132.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714411044; cv=none; b=f1jXIG+wgKk/dmmokcXp5gMptLmzjPM0vyseBO0NBkjaal8x0sAcqkW2YzN6RO1HW6b8SszZrBDRepPcbfbCPA9nZlkUjxcpykbHxnRwkMJNwEWqpgpjKM3FtojMKHNlLyuwFdRog1XVkZStugXVg/uzx/FRuGfcLRyy/NVa7aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714411044; c=relaxed/simple;
	bh=hRLCTp8EJHY7JYu65CIvt4T+UHTHpeNWhs1oHukdQ1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nt/x71ax6hUyq3EOEpWBcLp8RFE0m34e1l8DgKpLuHwEs404Zt3TONXdj1SxuCCxTtxfoqskPBj4x5KscyU3OD9/H0MD6xNxT61ByTeGZBKlyj9Jxb8jpil+9INdOxIJ1kp4wGQ1kaCyyr6IbzGMqsBZn0DvY+7O4Fi3vH2rfTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu; spf=none smtp.mailfrom=sdaoden.eu; dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=QbjpZU7h; dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=ACgjW6Ii; arc=none smtp.client-ip=217.144.132.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="QbjpZU7h";
	dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="ACgjW6Ii"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=citron; t=1714411032; x=1715077698; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:openpgp:blahblahblah:mime-version:
  content-type:content-transfer-encoding:author:from:subject:date:to:cc:
  resent-date:resent-from:resent-to:resent-cc:in-reply-to:references:
  mime-version:content-type:content-transfer-encoding:message-id:
  mail-followup-to:openpgp:blahblahblah;
 bh=F4RGg6Nqk9nWbLQrp/Q+wQdKc1Ex3oNBxvK5u95LiEQ=;
 b=QbjpZU7hejdezEkd8Idjs+b6nQhWzBP5k8GIUiAZL0DCgC5ft++nU8m8D4LSLauQf50V7KMF
  YAxXQMjODuLeScqfEfdSCBgKGJSjZVvCSNusFuFF0yrR6Tz0MZq8xBkKSlcP/YSGrB3/YvHtaE
  JQiRuXoMpEuKEKBSw4NYY2/HVnxgNrtRjorxvJSFM6TiS0piT6ZCE0v7xyRDcum8FnzrGlO7HG
  JB+/sZOTiNhQlXVxLLlDrIs3EFoUMwrknWhX173dm6+tNnHd0DJZn7O6xy1cn1iDSR46IhiImv
  vQRKM9uB29MJND8DJziubsNeiUGseDRoysiVkfxbdoae+Daw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=orange; t=1714411032; x=1715077698; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:openpgp:blahblahblah:mime-version:
  content-type:content-transfer-encoding:author:from:subject:date:to:cc:
  resent-date:resent-from:resent-to:resent-cc:in-reply-to:references:
  mime-version:content-type:content-transfer-encoding:message-id:
  mail-followup-to:openpgp:blahblahblah;
 bh=F4RGg6Nqk9nWbLQrp/Q+wQdKc1Ex3oNBxvK5u95LiEQ=;
 b=ACgjW6IisrnWecIC6P9wqX+PMweSUTTbazh4UXR2EwBxaNyto1E+ubHdeuYw71rKJ8wE/lC3
  czJdaRM6T4TbBw==
Date: Mon, 29 Apr 2024 19:17:11 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
To: Henrik =?utf-8?Q?Lindstr=C3=B6m?= <henrik@lxm.se>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org
Subject: Re: [PATCH] Generate signal names at runtime
Message-ID: <20240429171711.YftL0yTa@steffen%sdaoden.eu>
In-Reply-To: <d28c0015-3fff-412a-bdb2-39cae101e57f@lxm.se>
References: <Zizl53et9J5Hg2D5@gondor.apana.org.au>
 <d28c0015-3fff-412a-bdb2-39cae101e57f@lxm.se>
User-Agent: s-nail v14.9.24-621-g0d1e55f367
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Henrik Lindstr=C3=B6m wrote in
 <d28c0015-3fff-412a-bdb2-39cae101e57f@lxm.se>:
 |Getting the names from libc sounds ideal, but i don't think there's any w=
ay
 |to do that with musl, which is what i'm trying to cross compile to. That's
 |why i attempted a more universal solution in my patch, but perhaps there
 |would be interest in musl to add sigabbrev_np instead.
 |
 |As for a fallback, shouldn't the goal be something more similar to my
 |attempt rather than the existing code? Silently building a broken version
 |of dash when cross compiling isn't ideal.

People, adjust that fucking if that is possible on an american
list script of mine (or take it as-is), it requires nothing but
a C compiler (preprocessor) and POSIX (Solaris: xpg4) tools, and
it generates a superset of exactly what you want.  Bug reports
welcome.  I have the same for errno values, too.

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
