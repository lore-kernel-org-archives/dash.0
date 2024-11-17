Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6D5DF78
	for <dash@vger.kernel.org>; Sun, 17 Nov 2024 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731834975; cv=none; b=iz41PCyPXVvp4co2xaphuBqjPt2iKgSrNW/RX883pl1sctjv0NZHaKO8IhkgN5UyJdptAgR+ngHDePvnQ6yaCpVhJsVHdl0K0eWv5HjRqVWu8Gq13xX2G8d1WP6HBwOxPDgLv22r4O40FKCNlFOiV4vHTKL+Qjred2Q+MXYpdRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731834975; c=relaxed/simple;
	bh=C8Ebp5WCsge3CvSMgxm7xCqC5hf88ITgmB2bI6EcxC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuarPo0RhZzGmhu7YWhwHtdg261oZeB1Osac2uTVRgEdOfjC3iVUg+B6EnNEkH8uVih/UguWOvhegztWGoG6rxur9CWFKpMRr3ImnD9D4DdtPtD1NWqTlk05a2AfaQni+CsbmsCk2bsZhfwOd9Hf35ZQ7IsRhLlePYbhTrtROpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=l7Ew2r8g; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="l7Ew2r8g"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=srM+J3uZxmv7dPS9BoK8d2D76Y8bsIxOAFdCncWi1w0=; b=l7Ew2r8g0F94MM8c9IWt81824v
	8eLAE/hezNXxuIZXAJNHGw2GlE03cYR9bY0fsJytC5nTN8nLbWvYFzGC4etS2t8Yj/osdBALiVUKd
	HokodjjihpxSptoc+u9Kzo5l9uME9KPMrM7q8o9FwpZQdn52IEUHF6UMhAfMio3wof4/ibX3Nf9s8
	0wkuk7rYe3V7EGo/iQHHx9R3clYTnGlcwW5cDWAhhT5Xa2w4aX3PgzW4d0WkME7i+UEkG5E0/k/Eu
	8/+9UysjoSrloSc4bDAg3C28QMZGivqpW1xr2/gRNGqUG/TPUapN1W4s0iGuNr/9rkL/daKp8yEP9
	Cc1vrzmg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tCbO5-00HP7u-06;
	Sun, 17 Nov 2024 17:16:10 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 17 Nov 2024 17:16:09 +0800
Date: Sun, 17 Nov 2024 17:16:09 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Alain Knaff <alain@knaff.lu>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH] Portability of dash to legacy systems, such as AT&T Unix
 PC : 01-remove-extraneous
Message-ID: <Zzm0WZ6NsRxjZhWe@gondor.apana.org.au>
References: <ZzlScuJIC8G1gcjJ@gondor.apana.org.au>
 <9dda0a2f-efda-4ba0-93ed-ea683256446e@knaff.lu>
 <Zzmz7xY_4HM6hpgG@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zzmz7xY_4HM6hpgG@gondor.apana.org.au>

On Sun, Nov 17, 2024 at 05:14:23PM +0800, Herbert Xu wrote:
>
> No it still didn't work.  I know a pet peeve of patchwork is the
> Subject line and it treats identical Subjects as comments instead
> of new patches.

Yes that's exactly what happened.  All your patches are here:

https://patchwork.kernel.org/project/dash/patch/aa0e9215-622a-17e0-327b-f0233ed32ad8@knaff.lu/

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
