Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFB42D78A
	for <dash@vger.kernel.org>; Sun,  9 Mar 2025 09:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741514100; cv=none; b=KB2Zi7MttAnCpaVTgaU6MC5PhwrcbSkdFa+UoH9TRXFLo5fhf73HPnZAoI9nV3uHjwJAx7priQ2vMsFSoQ+iXraxMTrJb+xWblpihxpnLnFW+y9ChimgIrfdv1I1h3JxIBHHvU3cJivYv5SYFzg+WF9U034+z1kIzhUZCRZtYFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741514100; c=relaxed/simple;
	bh=nqkCJqPCcq3EDGzoPNL2YdxL3je1dsYk3I1cOGKcUBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=p7gofBDzJ+/d6TWQBCOVBlviMwS9R3t3ic+t7bYIuC9aXFq5ao/RruM84VkgRiSHFL3XdANqNicPK2/aSqvnRGc4Gv6kOKRAEJCalIdqxvt19gBgMdLyo1abRnbvZ7zK8daLxXbD9+LQfCMXWbbbf0JYFzhO1fkBB7kuw3kIIN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=ojkukak4; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="ojkukak4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=p6Ej6vCz4IahfZWACluBxVt9uXSS1Y0uKhliO+NkLz0=; b=ojkukak4PZAayC1rs2GsxrFCPg
	SSCB82Gig2VAd1i/BxwzXC/PrsIMFmFTCnRsT3VQ0qwELHUbUbHmznjLwmm3pu3piSOoH7seEgb41
	YwGTtnK6p7R1R6ErSVOPdwtgMZK+9XOzHGynu8gS5+yMSTx+J/ec6C91bf4JXbTP3untK81tO6mPe
	W4sMTAtbmF/Vp2GdTLtiBGD/gQEtHwJ/oXBIE+RxsjL2z6d71TcFElvp6GWiQlaUH18PUNdpf0Kw8
	JkTytq5TxDF3eyUtQlC11e6mx7hOPhXB6eos0XKNWFlTX1t3rZNjjZDAfVcHcN0nhsAGC9YygEnmG
	lL2RoWIA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1trDMy-0053KW-33;
	Sun, 09 Mar 2025 17:54:54 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 09 Mar 2025 17:54:52 +0800
Date: Sun, 9 Mar 2025 17:54:52 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Pablo Repetto <pablo.ernesto.repetto@gmail.com>
Cc: dash@vger.kernel.org
Subject: Re: bug: background jobs have their inputs bound to `/dev/null`,
 even in the face of explicit redirection
Message-ID: <Z81lbCfWHCoAipOM@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFKqKCrEXCkyFTx8SqOHx=LHYyKpfa6scjcrMCxA=Hoo0p9yMA@mail.gmail.com>
X-Newsgroups: apana.lists.os.linux.dash

Pablo Repetto <pablo.ernesto.repetto@gmail.com> wrote:
>
> # the following produces no output, both are erroneous
> echo x | { cat & wait; }

This is totally expected and correct.

> echo x | { <&0 cat & wait; }

This is expected too only because you're doing 0<&0 which is
a no-op.  To get what you want to happen,  you need to save the
zero fd before dash redirects it:

echo x | { { cat <&3& } 3<&0; wait; }

> # OTHER SUPPORTING EVIDENCE
> 
> bash received a closely related bug report in 2016. Both the discussion
> on whether a pipeline into a compound command counts as explicit redirection
> and the ultimate patch applied are extremely relevant.
> 
> https://groups.google.com/g/gnu.bash.bug/c/bgTSFM8UAek

I disagree.  If you like bash's behaviour, please get the standard
changed.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
