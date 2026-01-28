Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9A326E709
	for <dash@vger.kernel.org>; Wed, 28 Jan 2026 04:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769575911; cv=none; b=X/qaGRw8SpbDBBLXBhu1V//WDe3aYFtHApg55bA2xEmTFqTOLS25/sBPxaxFpiq/RvZbCyN1fik8Bss9GJNaSX0ug8f2vcAHAqHsd7qJ+rZ8Nqxf+o50iEHfbqrFPs3toGBW8waFHrFtgDg9Fl75X9I1guOLdxgl6vEXVOWu5L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769575911; c=relaxed/simple;
	bh=yNn/hL9lKs1c3U3hUDyXVnlVn98zWfpGEOmV2oRkhQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mHiAbQKyaC02NpSlCx/BRpCvuq6M01ml6JrTDTiJaRqmVpcmVl5RoTaZEuP+I6xK0r3SI0U4GCizQGpxLA4IAJVWpY3tFv9OYXo1kls+059CDoggS5A/GjoFcLGAmdSAMf2reQCwGZZ2px4HkDaIabpWDY5nL1GfMHEwo7KdEEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=EBjO1q0l; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="EBjO1q0l"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=Ph/GJTUuA2yELUVapsaIt033yFDEpVOEIwbHK+GvV4o=; b=EBjO1q0lmhF31B6B3FRlY2R+mZ
	Oup1I8MIco0ZBBJjIc4UVioGhtGoXrONzLBZ+r8OqHlvxQV/5bj9s1rDxmz3kCVWtyrZ8ZuXh3EQT
	ngswZPumwb4tBu7+Y5QEgpEQJFnee2gsVTGS0FxbC94KvUSBVCBB1m0J1kZYNJb0w9LMMtVIDBOZf
	nCSQMzjYojmjx3lOezh8/HTvbe9yk8BMmO4mcTqAwniaIuwX/YhKZFJ3IwkcRWuFWL7Yak7IJ9Q6S
	V6SPfhQu3A5qDDjA/isKPpz7ZKprrhFYwUziJytM7pCfCOhntYKzKlK+mXb2lERqshyY3ICok4zLq
	Hpp1fpKQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vkxWr-002ei4-1n;
	Wed, 28 Jan 2026 12:51:46 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 28 Jan 2026 12:51:45 +0800
Date: Wed, 28 Jan 2026 12:51:45 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Fabian Rast <fabian.rast@tum.de>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH] main.c: obviously initialize smark
Message-ID: <aXmV4e8vmoezchID@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DFHM744ATISY.1T8SIZ5DGCL1C@tum.de>
X-Newsgroups: apana.lists.os.linux.dash

Fabian Rast <fabian.rast@tum.de> wrote:
> [-- text/plain, encoding quoted-printable, charset: UTF-8, 73 lines --]
> 
> Otherwise an optimizing compiler (with LTO) might conclude that an
> undefined value is used in the popstackmark call in the setjmp handler,
> causing undefined behavior.
> ---
> src/main.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for the patch.  But I think this is really a compiler bug.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
