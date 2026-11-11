Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.181.231.80
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794385442;
	b=JXI8FBgDICFLrmWl6oWGQJyQ80TVS3z7xCep/iSsETlaToyTT8OvhXCyehoeT/93hNL1
	 pTzM21AIu65hohpBE9XUMCHSBeqGz2DA3rSIxM2/mGx5qZvSrylcZco/y0Au1MdtlPzc+
	 eFHywn2IGEm2bnt6vVxm8mxSNM9hONVKtzD1J9OD5fnrMM7CH+TsGr0E4hCGtWGG5/I4u
	 kdWJzPuj6VQId6tjrL6kYWcw45IJL/Ou020Qo076fcR2Szl6UNRdPgts4ql2flZeWo+QR
	 p5sHC1+CkTf/+LuCE7YXxuzHFapHJbSRpddP8eaUm7UDtKy2Ple/f+zhifzVVxX3BYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385442;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ID2HD4aOMZseiZv6oW9qk6w9QBwu7Y4+BmhO4vGNQJ0=;
	b=iax9+1TJ4o5R9trZXsk4p2c3PuXXmL7tb8gcnQJv6SKpt2PxBZJRLsSbErhiM/5VCC/e
	 4L/E1cJDCh2bsF4cp5YgwjAXAy9EvArLP2KXDFkE0YSSqos2m0tAvlh4IxGrzeIRu2Jym
	 I36wUz0dRXQNa7caLOJ5gMYtHNVyTAjqk7YsWkMAmWjAP6mFztmpyG9vsRKPJkDTLs6a8
	 jyL125ug+W57dSGdakvzAb2/cqb51GrR2d5CkOvd2l96x1671EtwLDQG8MscLyDfpfc5c
	 zOp4eyYFI0jL941PDNqlnqUrrt8jI9WxHP4VwGbBjFMurtA+Y63KBxWW62YQ+b5FHyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gondor.apana.org.au;
	spf=pass smtp.mailfrom=gondor.apana.org.au;
	dkim=pass header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=Je5egoOr;
	arc=none smtp.remote-ip=180.181.231.80
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBAC606A31C
	for <dash@vger.kernel.org>; Wed, 11 Nov 2026 08:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DBAC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=Je5egoOr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=ID2HD4aOMZseiZv6oW9qk6w9QBwu7Y4+BmhO4vGNQJ0=; 
	b=Je5egoOr/NEwR9Zx7oUuyCf4IDKhjBWQVlgR44KKFX/3kNCjR/Gart26LWS8IxU3LcDdzVzwNkZ
	LS2fMdIwyikMpW4GLN3ZxAyWhRmeTxjXg/uGlcBNbESKA1+0halQ9jFXy1fFfF+yG7TSdrpbMl7x6
	uWfiXt+C2JH5m3dmNqXSZUPxiD+jYM8zCCKMVUOpsFnC4zB6A2OzTYT/zIB3fzZFH4/unvtPVr5UA
	KDkpWm6dhX12fQoOXq4ekOJ3xWOefgifRu8fQulb0yybMeYElWt4acPyc8RTLHpvHEIfCpWanWhA6
	aF5lYxL7Q8lRfrJ9aSwV1tUlqoBH6FCyyvcw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1xR3cU-0000000DiZo-3yqW;
	Wed, 11 Nov 2026 16:23:52 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 11 Nov 2026 16:23:50 +0800
Date: Wed, 11 Nov 2026 16:23:50 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: vvkj <lueqit@gmail.com>
Cc: dash@vger.kernel.org
Subject: Re: [BUG] dash: command substitution leaks 0x81 (CTLESC) across
 128-byte boundaries
Message-ID: <avQmFhHfN3ijdQKZ@gondor.apana.org.au>
References: <CALwy4xJPUYmHJkBvwAr02zp9HfMp0h2upeRxc4NnyXT5ELn4CA@mail.gmail.com>
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Post: <mailto:dash@vger.kernel.org>
List-Help: <mailto:dash+help@vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
List-Owner: <mailto:dash+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALwy4xJPUYmHJkBvwAr02zp9HfMp0h2upeRxc4NnyXT5ELn4CA@mail.gmail.com>

On Tue, Nov 10, 2026 at 07:34:31AM +0800, vvkj wrote:
> Command substitution in dash corrupts multi-byte UTF-8 strings by
> injecting an uncleaned 0x81 (CTLESC) byte across 128-byte boundaries.
> 
> Tested on dash 0.5.13.4-1 (Arch Linux x86_64, LANG=en_US.UTF-8).

I cannot reproduce this on 0.5.13.5.  Please try that version.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
