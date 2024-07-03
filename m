Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4485E17084B
	for <dash@vger.kernel.org>; Wed,  3 Jul 2024 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720014965; cv=none; b=DvvzjUkbPmzTaxW5e99LLYUNxBzwKXy8MgBuccNoXjbMMcP4mLT8aWRsrH1kRoZE1yMOX0fdq3FR1h35d0mQEZWT9lsfnIfYbq3Rlz//qV1YhBv6lJDa/PrJqIQg/7DK8l9YJGj8j9fwTY8uH+mJwU1vGeDpSRd5JyNjGZQ4hH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720014965; c=relaxed/simple;
	bh=IWCkDvh/77d0O2i2W4BZq/3IZYYzGZsuzdBnqxnpWzM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OrY97kswK1A17kf3BKam16UoF3qyiuryaCCYNWNyEPcNX5f0PDpQweuDRLAKckYSDztpFOHIL2EYa4XAT02yx17I9ZdnhzyqFQMKiQuXJKzDiwQSzvKalDhAEA51pjZHnUgXvKaIeu3F1lMwvavoTVhMFfdlibTefiUuyW4vdAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=RYRMA9bj; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="RYRMA9bj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202405; t=1720014950;
	bh=IWCkDvh/77d0O2i2W4BZq/3IZYYzGZsuzdBnqxnpWzM=;
	h=Date:From:To:Cc:Subject:From;
	b=RYRMA9bjyt69jQZCCenML2tn8kgS2ZUtenawGM0YnboHVGNliAwJ68CGRSSaMMhc8
	 wpDwejOtMUYBTAqzbyPTgMPV6Cg1MO69sB0pmAMwmBHJIO4OEqUrlcEDd1ytPjf4wO
	 1eJInLOpnZcS0Vd9PcWWOEERE+HF+47fqPZGP/hCYOKCeO99XtRzfgosi8wNa2DEiV
	 wSV0I6XE2CleyThDyqsK30j3QLtXy7nbzeLhhd282AE6zLT3OYLVa8HIATVywpNSFQ
	 EfvL3wpHgJqwzgBz3z/J6Z/t/a6nTZSl0URlBgBswfK+X5bKADSHbQli3ORv0U2IRs
	 xd7K8GoKtHASA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id D92C77FD8;
	Wed,  3 Jul 2024 15:55:50 +0200 (CEST)
Date: Wed, 3 Jul 2024 15:55:50 +0200
From: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org
Subject: Broken: "parser: Add dollar single quote"
Message-ID: <gsb54jm2ankqb3ckx5b2renl2ndjlmdep3r7l2ohe6wlvs7hwd@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xkkjxo2cziwivrex"
Content-Disposition: inline
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--xkkjxo2cziwivrex
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Current HEAD of 776424a8f9158bfe9f53aa55f931af9f73437caf
("parser: Add dollar single quote"):
  $ printf '%s\n' $'\123'
simply hangs.

strace shows
  read(0, printf '%s\n' $'\123'
  "printf '%s\\n' $'\\123'\n", 8192) = 22
  read(0,

Bisecting this says that this is the first problematic commit.

Actually writing around five bytes makes it write the S\n and continue
(and interpret those five bytes as-if typed at the prompt).

--xkkjxo2cziwivrex
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmaFWGEACgkQvP0LAY0m
WPEUyxAAqXihe2768jRfrWU5BPYc7PiODJdiovIpUz55Fm8esinvTjmqsFs+N38s
K1Y4Z/1NIYZfSv+0HMreKXmwpmX27T9zEdZO9K0lUMky8fFrBC5wg2m00I8AcGur
eMosAjc+9bmRkZ6W848b4xetM+fNUPm6op5AyJRVL/xgQLnAdaLwXc2yF352QRmV
nLsEZkNP3VDWqgmHuOPxsuRRzJT/3GJvuOyI1W1+g9lp4LwiMBsVm7/VF8FIBD2m
L8sShm110d3IGG9ayZUaBTD9jpyMq2YJhROfknheQ3aQ/wRlY62L4o4DTsFtC2Sj
qhWDbx6TzFNAWyeqZgvQwjr+ZK8M/AAD0HaKbqqkWnTF03OqzrQOPjpCNs9nAT9X
T2dStuDqlniDVBAbELKGP0qRBA5RXb5JG1oM6KUCo/NJ+cagmkdC9bDNwLFEqkvn
Z48sCazL8GhEocqc/qx0HLOHYFFJO38Nv2nmlU9ocgbMArJoFrs7aRNielGFS8kK
0BX2zrlhCA87+sTCKp0o29g90EKhl4L2jI358q6qkblPTKjGvQUD1WvfuaQxV9Tg
lQBD8QMUK6nFDb9C75K2258s0GiPa1+BnBs7faoKTvGsZPkXZ6Fav+s8I1vVm4yR
pxFQ8oSuZMctkWHmzohYZ1FDs23a/L+0d/Y3lD7rAMzrTiDCJiw=
=PZV8
-----END PGP SIGNATURE-----

--xkkjxo2cziwivrex--
