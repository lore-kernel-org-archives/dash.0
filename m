Received: from smtpout01-ext2.partage.renater.fr (smtpout01-ext2.partage.renater.fr [194.254.240.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A239626E179
	for <dash@vger.kernel.org>; Sat,  4 Oct 2025 13:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.254.240.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759584729; cv=none; b=d4Pvmz90j+zQjxpPh7HWdxXke3Zbc6fSSScsn07WdpglkDafQBxu/VWla2iQOi+RklBjY3RNQetcuY/uDD0IeAaajVlCrClp7M2QNZT1S4O2/9y3/dpLnPJIq8Tz6lNvOKXFor8g1JwUN3OzqBaKgdaQU33Qs2+Yri0AjzaVYNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759584729; c=relaxed/simple;
	bh=G6h14rhZnyMs5+eJTMEHCDLeMOJXxK4pzGnhL5cJw1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmFIlzO/4Jeq/sRrYTTV865NpLVt3C8m7/epnGi0zIqMxc0CAo/VaInGVAX03Znz3nBrWQ9SgMwUewbeO9o8m8XSYlcxMWFOr5z/WBXpYjGbull7V5mbn5my7gvBXHK6g17EvnSnoSuP9QgQ0gZQ6vNNEaCwP9WjT4ygL30LxhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unistra.fr; spf=pass smtp.mailfrom=unistra.fr; dkim=pass (2048-bit key) header.d=unistra.fr header.i=@unistra.fr header.b=anGMJOgd; arc=none smtp.client-ip=194.254.240.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unistra.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unistra.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unistra.fr header.i=@unistra.fr header.b="anGMJOgd"
Received: from zmtaauth01.partage.renater.fr (zmtaauth01.partage.renater.fr [194.254.240.25])
	by smtpout10.partage.renater.fr (Postfix) with ESMTP id A515C64DFB;
	Sat,  4 Oct 2025 15:31:59 +0200 (CEST)
Received: from zmtaauth01.partage.renater.fr (localhost [127.0.0.1])
	by zmtaauth01.partage.renater.fr (Postfix) with ESMTPS id 9CCE314001A;
	Sat,  4 Oct 2025 15:31:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zmtaauth01.partage.renater.fr (Postfix) with ESMTP id 8CF2414009B;
	Sat,  4 Oct 2025 15:31:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zmtaauth01.partage.renater.fr 8CF2414009B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unistra.fr;
	s=CF279DD4-6F58-4C59-BB33-73FDC6DFC1E3; t=1759584719;
	bh=q4u/e2Fu0Hw60ul6YDIdxKh5fJ+2jeuXwgdwXGExdkc=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=anGMJOgdrZE+eXCOlNR4UA2RkTVozVNnQzUhznCy7Xhgiud12XgXCvvrlDyVs598C
	 BB13bhlevYJx/05YC7TjjXageCwoCxpFgm1HSw17G27eE0xdh5jm7fGJyyBg4MVoaF
	 0IfcaNZB191WEwya4qCjP4yK9DXXFaKPvGZYpqdEhGnNHU+E/Z1RJoX58cABu/LTLE
	 qi8aqMBVStARGQKfmPEOJ72hL9W1loEMUnCB0dDHOI5AIVrpvwSB89GkIBCkOmJPP7
	 D3hY8afCAMT0sYwCAt/qOVP0Wxmn3EXyTgnliYmBA8SdnpsI0xHu1qSK0PI5zLo0U/
	 BYpa9FrOLkJQg==
Received: from zmtaauth01.partage.renater.fr ([127.0.0.1])
 by localhost (zmtaauth01.partage.renater.fr [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 8lKl3s3gKnxS; Sat,  4 Oct 2025 15:31:59 +0200 (CEST)
Received: from 82.64.190.187 (unknown [194.254.241.250])
	by zmtaauth01.partage.renater.fr (Postfix) with ESMTPA id 662CC14001A;
	Sat,  4 Oct 2025 15:31:59 +0200 (CEST)
Date: Sat, 4 Oct 2025 15:31:59 +0200
From: Marc Chantreux <mc@unistra.fr>
To: Harald van Dijk <harald@gigawatt.nl>
Cc: Lawrence =?iso-8859-1?Q?Vel=E1zquez?= <vq@larryv.me>,
	dash@vger.kernel.org
Subject: Re: < "$@" doesn't expand properly?
Message-ID: <aOEhz5PAKi-xYg28@prometheus>
References: <aOBSZYeG7UDIbOE6@prometheus>
 <5a1befb9-0617-40b0-9c53-7bf6452f0dcd@app.fastmail.com>
 <aODE8547kOvhQPIf@prometheus>
 <ab0f8c73-ffac-4817-bd87-dcebe21453bd@gigawatt.nl>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KmLbJmdmh8zd86/e"
Content-Disposition: inline
In-Reply-To: <ab0f8c73-ffac-4817-bd87-dcebe21453bd@gigawatt.nl>
X-Virus-Scanned: clamav-milter 0.103.12 at clamav01
X-Virus-Status: Clean


--KmLbJmdmh8zd86/e
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 04, 2025 at 12:42:30PM +0100, Harald van Dijk wrote:
> On 04/10/2025 07:55, Marc Chantreux wrote:
> > * it's a matter of consistency to me. why "$@" can't behave as "$@" ?

> The word that follows a redirection operator is one of the special contex=
ts
> where operations that split words into multiple fields are disabled for i=
t.
> Variable assignment is another. This is why
>=20
>   foo=3D'multiple words'
>   bar=3D$foo
>   echo $foo > $bar

wow ... another thing I ignored after more than 25 years of shell
scripting.

"case $foo" is another example I discovered recently (on this mailing
list AFAIR). The person who answered me talked about a "scalar context".

> It is this principle that dash follows when it expands "$@" as "$*" in th=
ese
> contexts. I agree with you that if users want that, they can just write "=
$*"
> instead, but I do think that when users do write "$@" anyway, treating it=
 as
> "$*" is the least questionable interpretation.

Well ... I see a lot of people who just recomends to quote (and even brace)
everything (so $foo becomes "${foo}" in their coding style) just because
they fear expansions. I try to explain that expansions are good and word
splitting is useful but you have to be carreful but the more we have
exceptions to a simples rules, the more people will try to avoid errors and
go on quoting, losing the benefits of expansions. They finally
claim that "we should rewrite in python instead because shell behavior
is hard to understand".

However un fully understand than when a behavior is still used,
implementors try to make it consistent.  Thank you so much for your explain=
ations.

regards.

--=20
Marc Chantreux
P=F4le CESAR (Calcul et services avanc=E9s =E0 la recherche)
Universit=E9 de Strasbourg
14 rue Ren=E9 Descartes,
BP 80010, 67084 STRASBOURG CEDEX
03.68.85.60.79


--KmLbJmdmh8zd86/e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQrhynLytp14smlCwy+er2aYc+1WAUCaOEhyQAKCRC+er2aYc+1
WI0wAPoD+Pcis637hbhnMsShVI4PmFPw/KR8DBfLt5itmGq/AAEAucCjZ/7ebIj8
6bRDFsXuQ7FeSlSA5g9nWDISlsTzpwo=
=jmSh
-----END PGP SIGNATURE-----

--KmLbJmdmh8zd86/e--
