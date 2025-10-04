Received: from smtpout01-ext2.partage.renater.fr (smtpout01-ext2.partage.renater.fr [194.254.240.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336B378C9C
	for <dash@vger.kernel.org>; Sat,  4 Oct 2025 06:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.254.240.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759560957; cv=none; b=M3fnpp9duYit1ZlLp6WEhlDkMJ8PGn8CAuSajeI5j9aCl9BiZwU6d9Qyf9bQCfnsHyJAdYuL5hvkNdf3qGj4XWmBOa0Wv/jnQ1WUBPkqLyhWE4wBHNo9rx9J4oWNR/T4ITW92yWaYbGILRvYr2OuS6jASylcYlWNm22BmSO8RqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759560957; c=relaxed/simple;
	bh=ByvPpO5XdsrAcTieWWjC7k8ERvPN9UH+aYrH0XjBxD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3rbtODG9GfrcLtal0pwo/N9HZTefOrs5uYQrsPPYOaa8rpJERm1D1w13a3v9Lplq4CGQJH5/j1NwcqCvI3fOioy0EFTaQcRrFRQKUFB7E2CphMaixYJJXGhDtWA/3fpuis1D2DgVxxpmBTGlBiqj5LS7h25P6WwzxMvl2YnFms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unistra.fr; spf=pass smtp.mailfrom=unistra.fr; dkim=pass (2048-bit key) header.d=unistra.fr header.i=@unistra.fr header.b=pRf0MhhK; arc=none smtp.client-ip=194.254.240.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unistra.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unistra.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unistra.fr header.i=@unistra.fr header.b="pRf0MhhK"
Received: from zmtaauth03.partage.renater.fr (zmtaauth03.partage.renater.fr [194.254.240.26])
	by smtpout10.partage.renater.fr (Postfix) with ESMTP id E406565E2E;
	Sat,  4 Oct 2025 08:55:47 +0200 (CEST)
Received: from zmtaauth03.partage.renater.fr (localhost [127.0.0.1])
	by zmtaauth03.partage.renater.fr (Postfix) with ESMTPS id DC9F08000B;
	Sat,  4 Oct 2025 08:55:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zmtaauth03.partage.renater.fr (Postfix) with ESMTP id CCD8B8010D;
	Sat,  4 Oct 2025 08:55:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zmtaauth03.partage.renater.fr CCD8B8010D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unistra.fr;
	s=CF279DD4-6F58-4C59-BB33-73FDC6DFC1E3; t=1759560947;
	bh=kM2ubC6gmLc7swQJQtt8rUmhJI+AZ8/EMAUi93N2XFs=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=pRf0MhhK2VCGnvsMN/hbmXeiSnmtahp/fvVI5lm7BnQgztReYVmnlCUvk4oGyatzg
	 ZnfPR46/oVTiVDaZJPAJtIjnny8j+Nck3LFgTQyHZl9qX23LiQIA9DEyKK0nVTxYEk
	 kymoFusm7z4KFMbdBjhlDZ4opN6aq7fwTSxTHdk7Y68B1QpTgOrRLu8Efl/8ELgAie
	 QeupYU20o8lGS3c6yOZnu3FJ8Va83LoVd+PjMUi/4uXcoYFcgcWBWz5JwYRGeEhGhV
	 NY05chQh1cmEi5Mc4LXLPf4wssDfEwQrtowjvWoUjmwkd9yNWqVuNAK9wW+4SJQRnN
	 BVRw76ojJVRrQ==
Received: from zmtaauth03.partage.renater.fr ([127.0.0.1])
 by localhost (zmtaauth03.partage.renater.fr [127.0.0.1]) (amavis, port 10026)
 with ESMTP id cVpCU7JHQmjc; Sat,  4 Oct 2025 08:55:47 +0200 (CEST)
Received: from 82.64.190.187 (unknown [194.254.241.251])
	by zmtaauth03.partage.renater.fr (Postfix) with ESMTPA id A2A0F8000B;
	Sat,  4 Oct 2025 08:55:47 +0200 (CEST)
Date: Sat, 4 Oct 2025 08:55:47 +0200
From: Marc Chantreux <mc@unistra.fr>
To: Lawrence =?iso-8859-1?Q?Vel=E1zquez?= <vq@larryv.me>
Cc: dash@vger.kernel.org
Subject: Re: < "$@" doesn't expand properly?
Message-ID: <aODE8547kOvhQPIf@prometheus>
References: <aOBSZYeG7UDIbOE6@prometheus>
 <5a1befb9-0617-40b0-9c53-7bf6452f0dcd@app.fastmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tVj3dCXpnXTEzNNM"
Content-Disposition: inline
In-Reply-To: <5a1befb9-0617-40b0-9c53-7bf6452f0dcd@app.fastmail.com>
X-Virus-Scanned: clamav-milter 0.103.12 at clamav02
X-Virus-Status: Clean


--tVj3dCXpnXTEzNNM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lawrence,

> POSIX leaves this unspecified.  Section 2.7 [1] says that field
> splitting is not performed on the word following a redirection
> operator, and section 2.5.2 [2] says that the expansion of "$@" is
> unspecified in that context.

wow ... thank you so much for digging this. this is the second time
this year where oppose POSIX standard against consistency and ease of
use.

I can understand why because most of the scripts I learned with were
postfixing the redirections so word splitting doesn't matter at this
point but prefixing the < is really a matter of easing the readability
and maintainance:

	< A B | C | D > E

is much better for your brain than

	B < A | C | D > E

> Almost no shell works the way you are expecting, except for zsh in
> native mode (which I suspect is where you first tried this syntax)

Not at all. Actually dash is not only the more lightweight shell I
know but also the one which behave as close as what I expect from a
POSIX shell so it became my first choice when it comes to scripting.

No shell behave the way I would like (for example, none but zsh
allow prefixed redirections to compound expressions) to but the closest
are by far rc, dash and zsh.

> 	% ./bash /tmp/x.sh a b
> 	% dash /tmp/x.sh a b
> 	% ksh /tmp/x.sh a b
> 	% mksh /tmp/x.sh a b
> 	% oksh /tmp/x.sh a b
> 	% yash /tmp/x.sh a b
> 	% zsh /tmp/x.sh a b

I see we have the same shells in the scope. I just dropped bash from my
radar because its competitor (heavy but feature oriented) is way better
so I keep telling people to use zsh instead.

when in comes to the ratio (needed_features / kb), dash is gold.

>   [1] https://pubs.opengroup.org/onlinepubs/9799919799.2024edition/utilit=
ies/V3_chap02.html#tag_19_07
>   [2] https://pubs.opengroup.org/onlinepubs/9799919799.2024edition/utilit=
ies/V3_chap02.html#tag_19_05_02

As the behavior is undefined, of course, I would like to propose to
behave the most helpful way when it makes sense because

* the other usecases are already doable:
	* if the expected behavior is "$*", so use "$*"
	* what's the point of A  < "$@" ? use "$1" instead
* it's a matter of consistency to me. why "$@" can't behave as "$@" ?

Again, thank you so much for such a precise and useful answer.
regards.


--=20
Marc Chantreux
P=F4le CESAR (Calcul et services avanc=E9s =E0 la recherche)
Universit=E9 de Strasbourg
14 rue Ren=E9 Descartes,
BP 80010, 67084 STRASBOURG CEDEX
03.68.85.60.79


--tVj3dCXpnXTEzNNM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQrhynLytp14smlCwy+er2aYc+1WAUCaODE7gAKCRC+er2aYc+1
WMQ8AP9dSi54mXkNXv96E0h5WNPZHFGjpB8bDc6oR4bFN1BeNQEA5HOk+agnyroS
Is7i5lB/HfVBT5voQeb2dglKR9oXuws=
=Izx/
-----END PGP SIGNATURE-----

--tVj3dCXpnXTEzNNM--
