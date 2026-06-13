Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD36390C81
	for <dash@vger.kernel.org>; Sat, 13 Jun 2026 01:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781315802; cv=none; b=eINr5kVauhh+svqKzpYirDtODODboTj1ptJC+krzwuHsozYL3083Dq6oDvp/5RbOhfonBg8/6IByd1E1cDHexwfcHQKSzM4GUBesuHjwu3Uf8slx7VP9s7Fsa2+IQdnOYGIhoyUdk+do62GgJauT/Ldi/yDW2bJ4BzvMjdqG03I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781315802; c=relaxed/simple;
	bh=RZ5els9Y+E7AdSGozw+ZhEA+fRwddjG54KTh19lkyZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkZD7rJjVkPK4oOfOuM6Hw3I3xqEwv273+Tqp+0zPjxes0AWzZyxsB396Hf2qhcdhePrAN6RNtotlUestDxjXsjA99fQIK0xvbA4SYWCooZlzpzm5Wdig2cFNIWeCIVlRhLYEpHHyCZKEoepbji4qFFS5exKQxDEtLIICuUeN9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=ZH+kBdJD; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="ZH+kBdJD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=Y5kLPN6fAGn6T1C+OUnPP0PPFwzAPOiIei4XJp/6C8A=; 
	b=ZH+kBdJDAlxRb3X6Pc8RTbRFaOoSnJF2nI8LsB+IHKVnBNabvdLpDonhVynma0UO+f2uUhADBKA
	EZcmm+Oc/sruRkqi3hWDgZchRGAhIdlyzUkJerLvVysgIlRWy7PZKtRtWNvWgeNHCJy0psB0fFsQI
	yLmFY85ucr6ZtoZw96TDhov/J2Evu8fH8d7dUyqhsQ7lxfRwzyoXvIlSghEmP4LuYQ2yukkg7CoKN
	51RGN2N4X7xish4hPGrNvfuvoKbBUwWVoGU63gu42NTw9euifr5WcSql5Dt5deX+Bhj6+0kf/jqGV
	WT75BbB01z7WfylF/50e/pdUO0ZR/Ccucdvw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wYDbv-000000054dL-1ihF;
	Sat, 13 Jun 2026 09:56:36 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 13 Jun 2026 09:56:35 +0800
Date: Sat, 13 Jun 2026 09:56:35 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Harald van Dijk <harald@gigawatt.nl>
Cc: Kerin Millar <kfm@plushkava.net>, calestyo@scientia.org,
	dash@vger.kernel.org
Subject: Re: [PATCH v2] exec: Print absolute paths for command location
 queries
Message-ID: <aiy40wo-3GTRyJ6A@gondor.apana.org.au>
References: <aiy2x_l6g42HktZh@gondor.apana.org.au>
 <2896088e-bd54-4ea1-a0ed-537ba78bf548@gigawatt.nl>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2896088e-bd54-4ea1-a0ed-537ba78bf548@gigawatt.nl>

On Sat, Jun 13, 2026 at 02:52:29AM +0100, Harald van Dijk wrote:
>
> You're overlooking the "that are found using the PATH variable" from the
> spec. Because you included a / in the command, it is not looked up from
> PATH. Modifying your test to make sure PATH is used, we can see that bash
> does do this in POSIX mode:
> 
> $ bash -c 'cd /; PATH=bin command -v bash'
> bin/bash
> $ bash -o posix -c 'cd /; PATH=bin command -v bash'
> /bin/bash

But that's not what this patch does, is it?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
