Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B24D1CA8D
	for <dash@vger.kernel.org>; Sun,  9 Mar 2025 08:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741509244; cv=none; b=C7RlZQD3gmEWEmWLejWIwvpiiC4uBY6zz1A04s7mieTFyPqIOLtRRRIT7DvvqzhzhisuA67Off+rND+NOTDj17Pg6QUfaHPUAt9DaRdUYphp6fD/aTJLR+j0iq+E8mOcHv38eMRXJ90stJfWN7H3qPFx8oIlMw8N0Jvhegd+Cuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741509244; c=relaxed/simple;
	bh=HI3U3zuSqR12GQVu0YbKKtWq0cWB6OH3DN1VLgmw/f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D98S07MyODDiHgVgDuAcAGjN2oWhlwyP8qKfDGLZpA+b4SNqy9bAWBGnGmMvMhOL37xuJPk3PmH0aiGl8fYtf1UQIwQH2uNRAd4RzOySbr8HoAbXll+G4PvsB543K1Mng0TL1wa/YbIef590GmpYeNVmMAs1ux4wTknrT4Rne2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=XV2ihbV1; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="XV2ihbV1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=FT25phd470SNb5SgQ7R/M5LDf80JhPvC25kXCdSUJ28=; b=XV2ihbV1qpyWI8MW1nSUuhfpQA
	p75fcC237J9vj/Vb8rjc2hOkQBHeUl12OtZ4SRYgQkKAY/HOERSGRrhFKqSTiw6Gwyh+1vlrxgzCt
	IhTYG6Eftddico2MY/ZoXMzEtv1WwdXfVa4y/txSL1bApNJj/NQ8+W/yLkuD+b2yt54v/HDcbE3T9
	9HldLHM7rBtQz3wDKsZ3w3fsNVjA52nFVytQK7kn8k317P8iAqXYBxNWrTlM1C5GPGHDRaK5aSd9O
	JKsr86fWsIwbzL+C4N/1hd5vp8QecytJAdR3LLnoEPZI0w95DYk2d+/1RMAhCWcFpe8rzclgAZ7G7
	YejJvFaw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1trC6f-00524E-1t;
	Sun, 09 Mar 2025 16:33:58 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 09 Mar 2025 16:33:57 +0800
Date: Sun, 9 Mar 2025 16:33:57 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Alain Knaff <alain@knaff.lu>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH] Portability of dash to legacy systems, such as AT&T Unix
 PC : 12-sigaction
Message-ID: <Z81SdaZNw0nSpRbC@gondor.apana.org.au>
References: <aa0e9215-622a-17e0-327b-f0233ed32ad8@knaff.lu>
 <6ea7da38-204f-54bf-7156-085a1589c40b@knaff.lu>
 <6cacf608-326e-211a-7d37-164041710980@knaff.lu>
 <ZhDq9L88eTrLxlWW@gondor.apana.org.au>
 <2e4212b9-a8cf-465d-b925-77d7ab93fbcd@knaff.lu>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e4212b9-a8cf-465d-b925-77d7ab93fbcd@knaff.lu>

On Tue, Nov 12, 2024 at 11:45:07PM +0100, Alain Knaff wrote:
> 
> The 12th patch tests for availability of sigaction, and uses signal
> instead if not available.
> 
> Without sigaction, signals have to be re-activated once triggered,
> because signal does an implicit SA_RESETHAND on SYSV platforms.

Look I appreciate your work but I think this patch-set is taking
dash in the wrong direction.  I do not see enough value in supporting
legacy systems for dash when it means making the code-base less
maintainable and potentially more buggy.

So I won't be applying these patches.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
