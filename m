Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6540014EC73
	for <dash@vger.kernel.org>; Sat, 14 Mar 2026 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773480203; cv=none; b=YF9pPGOe62de8PX1hngZAbImaQFuNtCM11QejzpWvG+8snVZrKZ1arK3uaWoBjXCacFCB6oaw+757w+rYP32byHTTWrfGdHx0q8UZOR4DF/r9QFsZ0ofA0FvlTeijoYjdfIm0enEdlMdcDBVaL2ktLqMD+5SuTElhG+6YDhdcBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773480203; c=relaxed/simple;
	bh=Y9dWA5V4cOblsYnAjBYsuRAYWb+odEDFvvVffXxRWa8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nGAEkphrpjSbbdjE+bNu+CF/VOpK5LvvBIekO91RfN5dYDIoUeg/jcILlJKucNQzmmlJi39s8bldsBrxpQcU2R3DF6pV19bBhKtXqHu6ROoups/5vvTf5nyL6dB2EOkQ02yk5A3r3LcE/+gBUVdGdphyC6ZEMcjb4xIDFIx/Fdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=Y2Z1d6Bn; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="Y2Z1d6Bn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=zFY81rfocBhcHL4+w4XQ5zBX0bGRXBFu6ORm4vffvs4=; b=Y2Z1d6BnGM53Y9GtHArEEG+q2+
	eI94uCGbDuLlefS4e7vhB6xdh47oCwcfi69SNS0a4CYgAjUGWzxHIghQd7xBxtsM3ZsXa+uQk+VsI
	hKBnQVaumIvm5eAGdCZPMnAnXHeZgDhbv8s5uAdYmjcLUeHfOzflaTJ25Mw0aqb4l2EDu98XgYKxf
	l7GY9uI4xQ+9d+P6cVZDml3khhzQoeOWpmKThe0wUuIBU3b+TOISJwRrEAWz5ff+HmY3is0yN9pdy
	ieXsS5aAKGL0CNfsIiJXmY+R9DCtrOhqz78QEKWJo3koXRrJUetq5Se8QzKLAJHx0XgeZjITv3pEQ
	rVyMG38w==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w1LDI-00EN7m-35;
	Sat, 14 Mar 2026 17:23:18 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 14 Mar 2026 18:23:16 +0900
Date: Sat, 14 Mar 2026 18:23:16 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Natanael Copa <ncopa@alpinelinux.org>
Cc: dash@vger.kernel.org, ncopa@alpinelinux.org
Subject: Re: [PATCH v2] expand: fix SIGBUS due to unaligned access
Message-ID: <abUpBCffo_0SiXUd@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116205645.19074-1-ncopa@alpinelinux.org>
X-Newsgroups: apana.lists.os.linux.dash

Natanael Copa <ncopa@alpinelinux.org> wrote:
> Replace direct uint64_t dereference with memcpy() to avoid
> SIGBUS on armv7 when p is not 8-byte aligned.
> 
> Fixes crashes in dash during IFS splitting on strict-alignment
> architectures.
> 
> Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>
> ---
> src/expand.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
> 
> v2:
> - Added a couple more instances of unaligned access.

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
