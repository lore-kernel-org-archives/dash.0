Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCA543176
	for <dash@vger.kernel.org>; Sat, 27 Apr 2024 11:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714218460; cv=none; b=Okb7Nmg18BXJ41sb30vzXMJiMQj1JMUQrppP5QrXcsL5C7XOGxW1Q/AEL9QOykkCjui9zgB+sxxm8hf8HnXTgGdbS3iYQ12gU0HmGYaW5Fj4posoARkcAw8/Z0vb8PtLZMFKwbDCklS/ABEpEJQhYuR1/Vxap014dw78Ytq9B14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714218460; c=relaxed/simple;
	bh=MZI43GWVpsNGbDaEUDIzxIXIDwE8KLVgBM72U5lbsh8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LSJ8FsgbCEWTLAmswTZPbpaujVyFcqZqHeg1hzUx0fRWmO77d8MN/Xh8juvEFzg2rCDzqctCPTpA3BeUMwqw27BK9Djv+3ArJErWjnxvwvx0hj3T4a0uR+zdB9G2seRcRX1VM5nhgDEDxlmULXnDVecZqaMZuUHZcM/QLXUy1Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s0gWj-007Abi-0T;
	Sat, 27 Apr 2024 19:47:34 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 27 Apr 2024 19:47:51 +0800
Date: Sat, 27 Apr 2024 19:47:51 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Henrik =?iso-8859-1?Q?Lindstr=F6m?= <henrik@lxm.se>
Cc: dash@vger.kernel.org, henrik@lxm.se
Subject: Re: [PATCH] Generate signal names at runtime
Message-ID: <Zizl53et9J5Hg2D5@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240421204648.1156887-1-henrik@lxm.se>
X-Newsgroups: apana.lists.os.linux.dash

Henrik Lindström <henrik@lxm.se> wrote:
> They were previously generated at buildtime by mksignames.c, but that
> approach had two flaws:
> 1. The signal names were generated for the host system rather than the
>   target system, resulting in broken cross-compiled builds.
> 2. The SIGRTMIN and SIGRTMAX macros are usually implemented as
>   function calls and can only be surely known at runtime.
> 
> The new implementation has been tested to generate identical signal names
> as before on these systems:
> * Debian 12 (glibc, odd number of realtime signals)
> * Alpine 3.18 (musl, even number of realtime signals)
> * FreeBSD 14
> 
> Signed-off-by: Henrik Lindström <henrik@lxm.se>

Now that glibc has sigabbrev_np we should switch to using that
on Linux, perhaps with the existing code as a fallback.  BSD
has always had ways of getting the signal name, though it may
not be very portable so we'd need different flavours if people
cared enough to add them.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
