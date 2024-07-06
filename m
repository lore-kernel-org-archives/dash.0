Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB53C156
	for <dash@vger.kernel.org>; Sat,  6 Jul 2024 03:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720235385; cv=none; b=PpL4rM/qWRdgmbD7GZH/jcdb1Id2CFEKCoZC6SBLwNqXLQHL+vfsBnh5G3lTDc66AokgOzr6AFa+KwowUu6ODtEh3YeTNJ5kjGgo4dzebAEGlRDZrFJCq/12JilT6WOtjFoTksBo2p50+ALqkgEk6rRrCaqEDNVf2l2r+/5CgRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720235385; c=relaxed/simple;
	bh=qvQBXox/d0Pj66lSTXmy2ZMNF+mZwtO89Pp0DDZ7Jlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCma6qNAz+oeNFbGiANcdCHyZH9n4IaqwSwU2EVcXjzRjpTUZLy1ZhHkLIK77SBrOyssguzSskmrhAAggX3ImQrkuPUXvZyEEYUBQ5V42HuVT7MEJI8w7DOgOqVvThtFqWmFcXQ/OQaSvOFlq0AExtyyY9b+xI+X9uV49BAaQ4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=dWO0w+nL; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="dWO0w+nL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202405; t=1720235372;
	bh=qvQBXox/d0Pj66lSTXmy2ZMNF+mZwtO89Pp0DDZ7Jlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dWO0w+nLSD68qYoaQu9mBdKdO68xicgtcpzXSJMgpo0uZipyY0rp0VVEh7Kwblg+y
	 cW3Dc/rrRMwSWPXfXGQfLakqCMKtWupymZFMIiM+kYFJPN3nUui/Z3jhRZ4R9xQ7g2
	 w3CZWUFhlGgbUuQYmGHu8y2sN6eBPOW/cb0ZoJeIXJOJgRbr5oV4CGFVuAYxQClkLY
	 digXgQ1rFqgL3F2W1VEKkibrM0R4qj/WpxY36zK2JtkeayAUY7Jnpd5akKIJ72OzuG
	 kRWHbwZKnGiutYo/N52ulp3sA8IFYRKPV+CtHcwDrPbgRj9kbgj7A6OKJvmqJ/5R3+
	 7f5YMu2y65qXA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 2FF36862C;
	Sat,  6 Jul 2024 05:09:32 +0200 (CEST)
Date: Sat, 6 Jul 2024 05:09:31 +0200
From: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH] parser: Do not read past single quote in dollarsq_escape
Message-ID: <jbdj2lqrhxw2xkwvvrvdwu3nrcuikmfrng6a6j5o4iza6s7niv@tarta.nabijaczleweli.xyz>
References: <gsb54jm2ankqb3ckx5b2renl2ndjlmdep3r7l2ohe6wlvs7hwd@tarta.nabijaczleweli.xyz>
 <ZoifzAnPAKsEaVVl@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qxuh23hqmokaln5s"
Content-Disposition: inline
In-Reply-To: <ZoifzAnPAKsEaVVl@gondor.apana.org.au>
User-Agent: NeoMutt/20240329


--qxuh23hqmokaln5s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 06, 2024 at 11:37:16AM +1000, Herbert Xu wrote:
> The function dollarsq_escape may read past the current escape
> code in order to provide enough data to the underlying escape
> code processing function.  This is OK because we will call unget
> to return any unused characters.  However, if this occurs at
> the end of a quoted string, this may prompt the user for more
> input which is wrong.
>=20
> Fix this by terminating the loop whenever we see a single quote.
> Even if this is an escaped single quote and thus does not indicate
> the end of the whole quoted string, it's still OK because no single
> escape code can continue after a single quote.
Yeah, works for me.

--qxuh23hqmokaln5s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmaItWsACgkQvP0LAY0m
WPH8tBAAjJR7Gc+Nc4RAFrvhmgCMG3/VueTQXTbLVQHyz2MpolnbEWAK4RK+KyZn
/DPdvgq8wYPdjvt5uvJBvyKHSnxRPUHfIfR96vKAKEJHKxf4Ammr7vMnO8aoUBA+
9CG0JmQjsQ9c2vzi1IYkHBF8TdCsNpVNvlymitDBZufPNacxpHzSde5QzsALQikL
E/BZz4TGx7aEqNIgf8J/yEvZnElomKXiudDql7KkeJZAPvjGjQXn7AMuCv/McJc7
SCx16Yqo5pY8nKVDu5NMu3JlniEGyPUlNHzi6tev0cyF7n1p7a84PatsuiFi8PbO
vcdMoShcS1tmjiUobbVXQFrwcWA4xOnXI/xtCt0yMdb4clv+/l0JcK+YwbhK8KIX
l6ispj8bD1eBrx3zzFHEz+j1SBmT4mXjoPr/CWinQMYH3uyvNikaMBDEXUXf3sw9
s9KZ+1MU5YGVqJHkC3v5M+OTmBXQv9FEUCArWPzj8k2+/ltexTDwF04BgA28Kxrt
walo5mMfFyMcSoLTs4OGhAy7XUIcZS+VCLWXIoOoOvFCLIRZuIQ4VxK9eMY1WD0A
+6ngkveNieXKv86v1jGI2ESd9MaAO2Vk9ZDd763Hki6qGti5RLbzklMCTI5BITSO
4tek4VTn4GXok2XhqaMN6y+KlKH3yV2asVJcbCVtjMQ5NsXOiUI=
=HjhP
-----END PGP SIGNATURE-----

--qxuh23hqmokaln5s--
