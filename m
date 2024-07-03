Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DAD1DA319
	for <dash@vger.kernel.org>; Wed,  3 Jul 2024 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720021613; cv=none; b=aAQJFyn91wEbcmCoQhZeSxKCgA3pNaVsO6LwBvNdKg801OpgUylAD9A+2qvBnGmLObspS+WR2qeH+QccsucXSzTGMv5+OgEa9Mod90fofg1SLi0pV4lwAeWMbU9M6MPI/FzVcoW42XtrL/xozLrjBH4PmO88l4QloAxWt8wKndo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720021613; c=relaxed/simple;
	bh=hRGdNDVnguNOMLm4TBut1pGB4kLGmFXK0dG8hdcGric=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZALMrFUjYITCW4wSSsIqPXA173/cdC/90nbTfXtbILhbwJrNMAEG4Gol4lZFx+oPevAffp6lCo1DG015kCvMDcYFJ235EhG6XCThs/iCVeJTFh8Db2DdXv6kKId6h1gKnIF8RIsX81gLmUGuCbR0zVAzIrzK2IeqSWyMBlLl5kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=Zfh16ZmO; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="Zfh16ZmO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202405; t=1720021606;
	bh=hRGdNDVnguNOMLm4TBut1pGB4kLGmFXK0dG8hdcGric=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zfh16ZmOQ9df4uCdfRBwfMY26gcUGFnA1o24z25kmwg+C3gNTUB3JsQ5AW0RNLJd+
	 wGjOMrlqRBc5eQCvWCv7zQmgUw8yRvg+rsFkJwsdpIrw0DPosj+XBdl+QK+EakQQET
	 Je1cfVelNkbkKZMLstf7jnZx6fB+pt/Qe9Ljj1LYeSx9kTZEpOBiI0otzEmIjQQEij
	 5NR2yKKOh2tbp9bzrpeL6bU6hnMkq8AKedUPvhxCD1TUTzP68Tu6OLrGDZVEEkf1Cs
	 4S7qztNEYha5kz/7DJGT9DnfX+10cdfu3fpZeKdN8a8JEkzExzZO+iv2aSEJ5fNck2
	 JpW3jjgVV1tCw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 3A94E7DD8;
	Wed,  3 Jul 2024 17:46:46 +0200 (CEST)
Date: Wed, 3 Jul 2024 17:46:45 +0200
From: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org
Subject: Re: Broken: "parser: Add dollar single quote"
Message-ID: <nitniac3dtrvhs6jno73bfmh6uqi6ep4yjnzrxvp5owy6cjwxv@tarta.nabijaczleweli.xyz>
References: <gsb54jm2ankqb3ckx5b2renl2ndjlmdep3r7l2ohe6wlvs7hwd@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l4azl6ootdpxxkz6"
Content-Disposition: inline
In-Reply-To: <gsb54jm2ankqb3ckx5b2renl2ndjlmdep3r7l2ohe6wlvs7hwd@tarta.nabijaczleweli.xyz>
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--l4azl6ootdpxxkz6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Compare also:
-- >8 --
$ a=$'a\0b'





$ $ $ $ $ $
$ echo ${#a}
1
$ a=$'a\0b'asdasdasdasd
$ echo ${#a}
13
$ printf '%s\n' "$a"
aasdasdasdasd
-- >8 --
(the escaping behaviour is correct, the results are correct)

The minimum that doesn't hang is
  a=$'a\0b'aaaaa
and the five as match up thusly length-wise:
      a\0b'
      aaaaa
so, knowing nothing about the parser,
i'm gonna assume Some cursor isn't being properly advanced
while inside $'?

--l4azl6ootdpxxkz6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmaFcmMACgkQvP0LAY0m
WPEflRAAs3083U8EpHQ3W+Zvgl+uTjEOekF1rX6eGOW6jQeCEzKJV3jjZfECoW1z
eAwWT4kGVDIwG9vcwHK0cmhyjSrye9dfyfcYztaM1HIUrr03WfdOMfJgeqNI72mq
P16Q9TfExAXsBANlsDEuR+BICMPAuj4di1FBmwR66OkvSl30UieNmRxp6Ncm2q3r
X3oUJiNLhNMD7yrKtrBLwf9IpMEF+4OAmmlWE2uQUv5hkFMj5ggNvb3OJbag7jbD
AChlW/vIj9b976WWUXz6NTIDGlOsLYt77GaQJe664HaesaJrbYtfUw7pt38vRL6u
MJ3mpBQmO9LOXzGKSUOxvzPhTVTvP1v46ngkrUhupTEhm0doH/M5lWhRT580hv94
nK+732sv/bo+4GEtNZeBtkKN4vYp9nKy8ZiKaJAk1lQzNQxLpGIhuj6XhlNpf7ex
wM5gjs/ei0HilY7bwiCB/t7Bj/dslLx1B51KErKBJCmNawlMZ9LWPgOnnCeS10oM
Gq6q8GhiCN1UmAWBwjcDp0hFp5/DVjJwQyoDJNlXO+2BPBBYOPSpc/IjtTf8zCIC
xBokvuf/GDWdPdI1MwSPZyd6/GBqh0DAtByxEu9lj6Xrj6fgg3vUq29CRZOBbjsf
und7ThNzbc7yjiP6Ft0J/s8lW2hcrRL8T1fhmnt+qMFsyIOSxFA=
=LdzN
-----END PGP SIGNATURE-----

--l4azl6ootdpxxkz6--
