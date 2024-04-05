Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0F54CB3D
	for <dash@vger.kernel.org>; Fri,  5 Apr 2024 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712306268; cv=none; b=NfBoBXhSUhJ2k2NDTjeet0EcCcQtr1khrKTZqBetE28jxYPzBrpkhWndqukEBpc5RjNmRCRJ/Imq+3jMliT1gSgJdmqgxfftlow1p5QQB9YlNhfOE2B+W8E139ib9alQVHXEZ0aHCAnKbGVOwBkjlZ0jW4OXvq0L1hjutHTK9nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712306268; c=relaxed/simple;
	bh=7F2zdL73+CGy+zLbi0CVlhL8hqnGTWhfOrVx+B2uRuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpQ36eq0IwBd0cYfoXDpss4GEtnhEHVEeThtEoEmZ11Z+3TCtMLn7rLE6z3AuoeRU7fDQQCZ+flIzgWOzJ1uuOQcRgmn9IivGjFr/TLu/HIRYCK8mPG0LnbkfGNPFNXsCq5xYKQ99B7RHjIS/JuGCKPXtMkoPuOqVpNoaImDMeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rsf4w-00FV2l-8b; Fri, 05 Apr 2024 16:37:43 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Apr 2024 16:37:59 +0800
Date: Fri, 5 Apr 2024 16:37:59 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "Vladimir N. Oleynik" <dzo@simtreas.ru>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH]: allow recursive variable inderection in arith
Message-ID: <Zg+4Z9R7bT1nYoGf@gondor.apana.org.au>
References: <08178d03-1912-76e7-0733-75e8f1d691af@simtreas.ru>
 <ecf90382-e5b9-9b0c-c73b-c564a660ee20@simtreas.ru>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecf90382-e5b9-9b0c-c73b-c564a660ee20@simtreas.ru>

On Sun, Jan 31, 2021 at 01:29:36PM +0400, Vladimir N. Oleynik wrote:
> 
> My patch for allow recursive variable inderection in arith
> and simplify allow $(( )). Originaly from my arith in busybox
> 
> Before patch:
> $ a=b b=2; echo $((a))
> dash: 1: Illegal number: b
> 
> After patch:
> $ a=b b=2; echo $((a))
> 2
> a=b b="a*2"; echo $((a))
> ./dash: 4: arithmetic expression: expression recursion loop detected: "a"

Again this does not belong in dash because one of the principal
goals is to be minimal.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
