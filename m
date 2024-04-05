Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37C613AD12
	for <dash@vger.kernel.org>; Fri,  5 Apr 2024 10:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712313260; cv=none; b=LdBr5jS9rysrkOjhvNweWOtUQsd30KQMAM1CU1D9ibl07us8sZxve155RsvG19tVa+22QLEMTDdG9TVy+Qu6++aWLeJjSanbushrnx5iZ05hib1cCwYIWZxF3N8yhKwpblSazxPsCYoRwfmucWQZMiws3GgUgwz+TU2bD/lD13o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712313260; c=relaxed/simple;
	bh=wiJxq0/YHG7kLmzGIGtxGmyvbUyHPIfKoGouFlmMoAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEx9ZdD4IhHB9G2Fv5Pc5ZKr7xUgtvsVP++v9cE50Ak63FS3zp1syFBq96iH1ec7KZN4ASRZWObDBu9ZaYqpZw5BE6Y9WROxnl6UcclLZaGRV3fXweymJos90mU7QU4/92eU9U2JZ2HKfqkRxHZ/Y9Dbs6cUZJ6GMB4eYNlknx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rsgth-00FXrU-AI; Fri, 05 Apr 2024 18:34:14 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Apr 2024 18:34:30 +0800
Date: Fri, 5 Apr 2024 18:34:30 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH] man: don't list unavailable built-ins and Command Line
 Editing section
Message-ID: <Zg/TtoaxrossgqT3@gondor.apana.org.au>
References: <20220506193434.sza4mvudzuytauoj@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220506193434.sza4mvudzuytauoj@tarta.nabijaczleweli.xyz>

On Fri, May 06, 2022 at 09:34:34PM +0200, наб wrote:
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
> ---
> I went for a complete removal of the Command Line Editing sexion,
> but it's possible doing something like "unavailable, configure with
> --with-libedit" is better?

I think it would be easier to just state in the manual that this
feature may be unavailable.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
