Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B268DB652
	for <dash@vger.kernel.org>; Sun, 17 Nov 2024 02:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731809922; cv=none; b=LTPMCmnUmSW6S9H4NPHHgwvXlWzK6B1QtOS7DafP38DVf7M7C1ER0SvX8xzLt3i6hoO2UccgaVM19IsuHjB36SKl5tCyv3FRtg2I7CtfnLDYUqPUrSM2akJOsY0V9mmgQodD6Y3ivU/ht41HTWunbQnF/Q4ChcP5AzWbMvEOywk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731809922; c=relaxed/simple;
	bh=Ef4q0TjDuj3efIrgId8+yCC4FQipuHi+lCOVyZvCaVI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AKXaBfDM6p5SkOktoxsFDcaelFub04oe5tHz4+AsUFQIFYINtHkAb2mokz4aIPgH/LYM2Ft+0gZBoEl82PXimAA+zL/fPelwfy/E0SqSSWpblfrMVV41TT3Kku+FiFTF+EkB/+gF8TK7b0EYFDkaTrj2o2syJgoxB7MdJt00GYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=tQ4AAqkJ; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="tQ4AAqkJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=woZ4P0Np9Jzb+s5y7iTL7up7fBYFm75wqibDHtpMtLw=; b=tQ4AAqkJu/yvp/H2plNV99zzIf
	d+Oz2vK0KylizY12FSOcaTqn+8KufqEpYkYtsTzlYhxopoUF8Q5NGTYUzvH/PkNTh9AkAfCaRMYw2
	/suunU9+Df0+tkuIKBxpQMip9LW3noDEXF9riZGSlnbRZKoGz69npvks7y2WYWKqHFllJzvoVgRrv
	SKjSB7ugyiOKcialaI/r58GK3VE60wIjZUkGA3Ht5CTlt79ZZ36XLbxlS8ckn7pjHa2iSKt6Vmt/a
	quFxQaR76EQqy6IhkDhuU93v+niRJzYj5zkQJvvzJfCTD+UsvTbtohk9f+OlXYhnv5lxrUo0nXcv9
	rHLmWaUg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tCUrq-00HMmA-0I;
	Sun, 17 Nov 2024 10:18:27 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 17 Nov 2024 10:18:26 +0800
Date: Sun, 17 Nov 2024 10:18:26 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Alain Knaff <alain@knaff.lu>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH] Portability of dash to legacy systems, such as AT&T Unix
 PC : 01-remove-extraneous
Message-ID: <ZzlScuJIC8G1gcjJ@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73d307f8-7769-4a73-b4d0-467800010252@knaff.lu>
X-Newsgroups: apana.lists.os.linux.dash

Alain Knaff <alain@knaff.lu> wrote:
>
> I've now split up the patch into parts. In addition to just the
> splitting, the patch set contains the following changes/improvements:
> - adapted it to dash 0.5.12 which has been released in the meantime,
> - some cleanup,
> - it now also compiles & works on Solaris 10 & 11

I'm sorry but something has gone wrong.  None of your patches have
been picked up by patchwork:

https://patchwork.kernel.org/project/dash/list/

Perhaps try resending just one small patch to debug the problem
before you do the whole thing again?

One thing to try would be to send the patch inline instead of as
an attachment.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
