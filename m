Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC38126BE1
	for <dash@vger.kernel.org>; Sun, 17 Nov 2024 09:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731834873; cv=none; b=GYjYtlVYy7yukhaiff45kOII/l1f/kPsEbnMxE0tG10CklXKpNw3+FSDF7JfOl7yXQzMXC4Hhd3FqvvdCN2sw3Ncu4V67cIZJRJG74HDu9k+6JawV3Ut49F4ILfO+j4DRFXH/BLV0UFmeKsO+6IN2PU86iu0xMy901GLpZWaIFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731834873; c=relaxed/simple;
	bh=lLLoXkHgq1DbAzNuroWe2nCDj6lis+e8eeNpbTwXckk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lqq51Ps6zuj1yB8YD5LiWLRdf1pa36PjPKCMpqBKkLySuJVeipp+CPn0Vwue8mckTT3pHrEYoP3HKdAZTbPmpmNrAzAdc+qIsMsbo+ePClaJpfxe31ZeishulI0HLt++elzWNGQC3oS40qxnPXcCcGaB+7FOpHaF9R6QrU219S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=ax6H97al; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="ax6H97al"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ML2N/b30PMAJuUTm03pU49NUkmwtt9Hm3aL7PM7yd4g=; b=ax6H97al8UkeabEY5jLtoRGxes
	GPIzecK4yHIq+z/5JCtYHWsyaQUCmXmiQKXyfJBGkJQz+zYWTtTkM5H4YLlPbTP/6/WpPblQ2L86b
	RRcXqk4U756EK0jAPjHadqmBVSaKjhpxwYFvNLkpW97w0oIPVB2Q0SaCaNoFRa+XPTsX3RkQvQEDX
	dZoVHHCNVbUyc3L1h8q86Vx1ob3zzBBNkKq6UGbk/XCaRxM7TcxKzfFIolH598Nj51cpXLBWINcfB
	SRwwQ/50Ye/g8U04NJuxJwbG4ni+Gcs15LONtb6mPEDvLJpR3i0PGc79/Z/vGP7InGxs0MQfu5BjI
	hPACVYsA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tCbMN-00HP6y-0F;
	Sun, 17 Nov 2024 17:14:24 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 17 Nov 2024 17:14:23 +0800
Date: Sun, 17 Nov 2024 17:14:23 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Alain Knaff <alain@knaff.lu>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH] Portability of dash to legacy systems, such as AT&T Unix
 PC : 01-remove-extraneous
Message-ID: <Zzmz7xY_4HM6hpgG@gondor.apana.org.au>
References: <ZzlScuJIC8G1gcjJ@gondor.apana.org.au>
 <9dda0a2f-efda-4ba0-93ed-ea683256446e@knaff.lu>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dda0a2f-efda-4ba0-93ed-ea683256446e@knaff.lu>

On Sun, Nov 17, 2024 at 09:58:01AM +0100, Alain Knaff wrote:
>
> Ok, so here goes 01. Please tell me how it goes, and if ok, I'll send 
> the others.

No it still didn't work.  I know a pet peeve of patchwork is the
Subject line and it treats identical Subjects as comments instead
of new patches.

So perhaps try sending this one with a completely new Subject
that does not have the 'Portability ...' prefix?

Something like

	Subject: [PATCH] Remove extraneous...

Please also make the Subject line meaningful as it will become
the git commit title.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
