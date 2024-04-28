Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AA9818
	for <dash@vger.kernel.org>; Sun, 28 Apr 2024 01:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714268169; cv=none; b=fyErgMu8U0JpObYTEPedgNej3EhbwoJZ8fGfk7ZIhC02R7rBKOCy6JG+ffnQoPQiI/U/KysxmV300F3h3yakJHKSuyIO3K2PzxeYL/dI5Bc0IwOpD88MbwoY+R+YsXOswemqAJXeMsF2ogAxAXepaHMrZEeT1yinnVVlulxODoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714268169; c=relaxed/simple;
	bh=mYQzu9j5e9C0qWAVvZOxaA/4Nkgf1BYHJPKMFpKol6s=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=fvWWHcxvOkhvzumvbS6Kr4oM/uo1G6s4tMJOrdgDmepvEw+seqXCY/EPr7JV17b8lUanlPttkDbL+E28Rqy21CbpAAqc3iaZsHVb6Vnd8YtAs5LCXTQoL2iu1Nooj4baq91u7nEYVhrArlLe3NqB3anANKHmDahDWKD4XVmVKWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=larryv.me; spf=pass smtp.mailfrom=larryv.me; dkim=pass (2048-bit key) header.d=larryv.me header.i=@larryv.me header.b=I4FE2rI2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZO+rcLIH; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=larryv.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=larryv.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=larryv.me header.i=@larryv.me header.b="I4FE2rI2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZO+rcLIH"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 8EC5418000FE;
	Sat, 27 Apr 2024 21:36:06 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Sat, 27 Apr 2024 21:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=larryv.me; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1714268166; x=1714354566; bh=sTWiq/NaAo
	bCvc7wpodol5OMsoyuSrpu9ZGpJkYa3so=; b=I4FE2rI24GaZai/yVd4+Wv+pNL
	JUqrkBr2/zefTVTTiNzDBnr4DnMpafIr1i8qn6FvSwwLfnKL9AIvi/dbuKh3LSsB
	8NRWf8yQx1yhx+l3lq3AuE4FJ5FjQik0hyd1hQQylkHUgNZoZzOaeF+ODr8w4x3x
	t4RDVNaC6hU2bOQidvm0WQ7859Y5qdxpNFZ7tN8NH/6jPfYv/r769ieuHdFTvNld
	fqS0Coflom9sAMrWtB5DcCTWMJCQl7cM4zoi2ne4IAZS6hL9X30FIG4RUAwiRKdN
	tFM9kpzxH+p6uGxTW9biWXbc323nhCo79oQAVFPlDXh3YG8EJo6gXI2ai5Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714268166; x=1714354566; bh=sTWiq/NaAobCvc7wpodol5OMsoyu
	Srpu9ZGpJkYa3so=; b=ZO+rcLIH1hL56jLExmwhTCtCinyH/k3sT7r/aICR9Yyq
	oxkbXUEnYPchfrA0opYhriTMJGqs5wDG+WTeEf5xP47JUHa6SK3gl5Eb2Duk5T+i
	NIimaw3+KSylqAVD4a/A680Ap+dCNvjywnJwJ6+NATnPytMdPCFbvFyKfs8qlzUi
	27oJQRphd8Xayydxg32LYeNcfCAn8J/UzBLAADdUpEbVcGbKTqti10cdfhS6ixD6
	hzlhDsl/DJwJIobaokJ3EjgNK99uUzAXpICxP4twdZmWCgBcs/ItxeIpJqdNS91N
	AGrVYgkFibKlmAdBBEWUpPgRWzamgduDdFRgbAYH3A==
X-ME-Sender: <xms:BagtZoQkzn91LdT4Hi8FxM_4p8X6M2baxRUEr_XzwI3Xx7OkhHea8Q>
    <xme:BagtZlxAOgnKWQdVjSZd0PlPy8oHISRnz8h0NEbbpDf6OPSUdQ-_VODaO16rG9wfi
    j9KPoPVv6XuL22n8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtvddghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderreejnecuhfhrohhmpefnrgif
    rhgvnhgtvgcugggvlhojiihquhgviicuoehvqheslhgrrhhrhihvrdhmvgeqnecuggftrf
    grthhtvghrnhepfffhheeujeduudelfeeuveehteekgfegvdfgvdeuhfeiudeiteffheel
    jeevieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epvhhqsehlrghrrhihvhdrmhgv
X-ME-Proxy: <xmx:BagtZl1n0Ffeiv_ve5bXQ7y0t1YOYT9oHJExwoMsDKcxSucAHwPdoQ>
    <xmx:BagtZsD8ONXs8882xKEfgSLmxCgDPQW7jjTtLuTwL7z3htW4etQg3Q>
    <xmx:BagtZhjim7kY6ZZHPG26gbpZPma2vKSgOeD0WmGJD3t0nGYGKAqtEg>
    <xmx:BagtZopwh9P5aoJ4Qwi09n8tvfa6YMo5toEE7y2qjdxAeaKFg8tvzg>
    <xmx:BqgtZksayBBPxkwhp5mB-ND_5_niMOksH0QeGzJAB8prHAeAfcVBJr_O>
Feedback-ID: i0b2842c6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id AC93331A0066; Sat, 27 Apr 2024 21:36:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-386-g4cb8e397f9-fm-20240415.001-g4cb8e397
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ba1332c0-2029-4171-89b0-b2e6b33449d6@app.fastmail.com>
In-Reply-To: <e2d1d076a3a3d7f21bdb64b13cf9c4c3f4967bb2.camel@scientia.org>
References: <cover.1714215826.git.herbert@gondor.apana.org.au>
 <eb927eeff3d1da7406c998d0ce816d3b6a061fc7.camel@scientia.org>
 <Zi2dIJQcNVwJgxuN@gondor.apana.org.au>
 <e2d1d076a3a3d7f21bdb64b13cf9c4c3f4967bb2.camel@scientia.org>
Date: Sat, 27 Apr 2024 21:35:40 -0400
From: =?UTF-8?Q?Lawrence_Vel=C3=A1zquez?= <vq@larryv.me>
To: "Christoph Anton Mitterer" <calestyo@scientia.org>
Cc: "Herbert Xu" <herbert@gondor.apana.org.au>, dash@vger.kernel.org
Subject: Re: [PATCH 0/8] Add multi-byte support
Content-Type: text/plain

On Sat, Apr 27, 2024, at 9:19 PM, Christoph Anton Mitterer wrote:
> If someone assumes dash would always be LC_ALL=C, that any such
> operation where e.g. a byte is used that is part of a multi-byte
> character might, AFAIU, lead to unexpected results.

What's your point?  Do you think dash should not acquire multibyte
support, to avoid breaking scripts that make such assumptions?

-- 
vq
