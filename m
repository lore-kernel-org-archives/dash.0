Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40C618FC97
	for <dash@vger.kernel.org>; Sun, 31 May 2026 04:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780200296; cv=none; b=c0gQs9X68/BBy3leXhWgZNKhAInzatgsUMvh0CcnKZIo8JETPfGlSsCseZRnUjfO70dvpEjw7NggArDssOr12H4BZnRZx1153yYZl00va3ZlIPnROeIY4KyPOiweF5+qB+ctsCN8XfGNVkULwFjQw6BQrmrJmo25ApHeslyPw4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780200296; c=relaxed/simple;
	bh=GqushGkeOJbFKkjcFqOvO0e+d2a1ry+TejM7ZGioe78=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kOF5H9glmY8ytPDKQP7Wk3AO8WCDkgA0TPZAsLYVjRLj1CZKLhDiMb1vZ9Jwo2F0nCI7MFwcUisb8VDNgWgKCp9Q1omymjKsIi6dSeWL+/qyuujE1O42uArSp0Qg/x26Rj9Ca7GoW26J2acXp6yEHOtazk99OWE8jevKlnILZYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=m5Vfam1J; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="m5Vfam1J"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=JgpQxSn9Hp0T+YQ3BqAygtoUaCwtEQrzGyhZpYiuVXE=; b=m5Vfam1JKQzNAXUB54vDvQzDB9
	RznOhlehoSA+UYp30estRkP94HJLymu2FtwwYbktPwzdCol6BCFE/Gxn8WgpA/o+QBxIk6RqqKn9U
	UjXuIEA2fsx1yqV/Nw22wC3CjADoeVKuXWw7Y5RwXITQpbEyYVXJA6gVo0t0QkI/qTb67eJNYk/XF
	Gj9cePs0eg5HfeUDhhnFBKLJUvSddOpmsw04+u4JWDOvEtTDdGEdY3fBz4ynLt5XSJWKEBLIypAgO
	agD0oAcoWVAx+WUkF4GYUAz/t003l1dqTf/+2N0K8S4UkhC2ZxRy/Ym/MgrrScJbKhCHk9VJ6865m
	wpaZMvKQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wTWjY-0015iz-1t;
	Sun, 31 May 2026 11:21:05 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 31 May 2026 11:21:04 +0800
Date: Sun, 31 May 2026 11:21:04 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Sebastien Peterson-Boudreau <seb@stien.dev>
Cc: dash@vger.kernel.org, seb@stien.dev
Subject: Re: (none)
Message-ID: <ahupIBR6nSoPOtJ0@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahYVy6WxQoNnb7ym@HQ>
X-Newsgroups: apana.lists.os.linux.dash

Sebastien Peterson-Boudreau <seb@stien.dev> wrote:
>
> Let me know if there is an issue with signing -- as you can see, I'm
> using a new email.
> src/dash.1 | 58 +++++++++++++++++++++++++++---------------------------
> 1 file changed, 29 insertions(+), 29 deletions(-)

Everything looks good except that your email has no Subject and
so it's been discarded by patchwork:

https://lore.kernel.org/dash/ahYVy6WxQoNnb7ym@HQ

Please resend with the correct Subject line.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
