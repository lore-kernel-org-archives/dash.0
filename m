Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A719314AD20
	for <dash@vger.kernel.org>; Sat, 13 Jun 2026 02:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781317940; cv=none; b=DccsBOv62VDxR4OrkN4g5LzHxCdS+Ewqio43G1dCdyHbR5vodgg6sG6ENk/Q+H4ASxlAvicLjaQL+zUBXgy+sVVnPUhIe1nVg/f9IikJsIl49XiGNs8wFZXBhuppBbqVo7JY7ydSGNpXxfjoXjCmIrqSr5WLzJONR4KKBkKkX5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781317940; c=relaxed/simple;
	bh=dGT4lAFl3foNgn399V0ZOrhVW+OV32EtD16Tdm4QPEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgP+XhCi1+Ux6OlWHd8+0ceq8cS45QEXms3HkBRIkMY0y/aDT1+/hwON6CJmiwQq8aSrVojYXsCGgt9p+tDqHxjBJROOGvH0wD6ywrYCnj5k80/oQZ9Vf6ge2bLmgdNGn20kDG0Ucjlj9I5/fvTgnwTylLWnwz0Bh9YaL8pVhiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=hu40WBM1; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="hu40WBM1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=ujIk7r8tH3u19bff/caY1o1gJw84WXe1VwWUnFE7SKU=; 
	b=hu40WBM11Xvvgb9kXgQeSIQa3fedHQQUj3Md+OeOPOoMLieVRFLb06sbavY2JzxSkGsChZO5sxz
	BuKKV9QAnIrNWGbCC0uRqPqT20z2tBXbA/RLnLiw47F6RTCiEaGyioQdeU+sbQiJTDxJJNtZZ0p8i
	6yp5gd+SIK4VLTqr3l0io+UVyMUwolhtsCcuPxg7gA5VfId3j3tt0SBBJFyClpDlPq/Tpl27QJswq
	fyoeCK1RL7ozMGHUcINzGRrcjsumkS+ZxACN5TWGjGJyBn3Sf8NeCdcZvR+0Aky33nd1SsQPcM/UM
	GBJRiss5yhsZ8NhhyBnzqAp+nCasmdmIazCQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wYEAR-000000054tR-0Rqp;
	Sat, 13 Jun 2026 10:32:16 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 13 Jun 2026 10:32:15 +0800
Date: Sat, 13 Jun 2026 10:32:15 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Harald van Dijk <harald@gigawatt.nl>
Cc: Kerin Millar <kfm@plushkava.net>, calestyo@scientia.org,
	dash@vger.kernel.org
Subject: Re: [PATCH v2] exec: Print absolute paths for command location
 queries
Message-ID: <aizBLwgt79MG4945@gondor.apana.org.au>
References: <aiy2x_l6g42HktZh@gondor.apana.org.au>
 <2896088e-bd54-4ea1-a0ed-537ba78bf548@gigawatt.nl>
 <aiy40wo-3GTRyJ6A@gondor.apana.org.au>
 <d039d9e3-811e-4484-8107-7b0da7eb0827@gigawatt.nl>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d039d9e3-811e-4484-8107-7b0da7eb0827@gigawatt.nl>

On Sat, Jun 13, 2026 at 03:09:49AM +0100, Harald van Dijk wrote:
>
> Oh, I see. Currently, dash never converts paths to absolute. The patch
> changes it to do so whenever possible, both for the case where commands are
> looked up from PATH (which is required by POSIX) and the case where they
> aren't (where I think POSIX is ambiguous). Other shells (ksh, yash) do print
> an absolute path in all cases, but matching bash sounds reasonable too.

Reading the standard again it seems that bash might actually be
in the wrong here, as it specifically refers to "command_names
including a <slash>".

Since that precludes a PATH search, it is self-contradictory.  I'll
wait for the standard (or bash) to be fixed before taking this change.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
