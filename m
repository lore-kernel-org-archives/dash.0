Received: from smtpout02-ext4.partage.renater.fr (smtpout02-ext4.partage.renater.fr [194.254.241.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E90CB67A
	for <dash@vger.kernel.org>; Sun,  5 Oct 2025 07:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.254.241.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759649307; cv=none; b=RAPN6iNGwyXfyTrkVNm1V46M52p79fsFvdzYhhrVSDh0caz7TeRs4fxyOpjgzdEQIpcuAr5DyL1IlfKBDhyl7HmDEWY9x3bqIhUCz2hL2l05Qw+csHNHwcyvlKBFGzZl9W3iEyGaTIrzYwYhuvbE9nVcrx1EVNmPONlaf3c+0tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759649307; c=relaxed/simple;
	bh=5RHIcXbxuam2RCuq81lOnBMBZdP8s+VVBLSmwykDZko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDEhoIwRQzcrwzrDWh+ErJTzrYpUlswGNXSc2OQpFh62wPLczzM+KABiiEBCPHWbugjf8Mro8YaA0wkAPnZhZ8yjaXlZAv0bJx0QTlCBpdzS4UAUGvGoQJthDMcpb/ZYYkdn68D3AKkEgN0ItwL7H8GHuirXWAqzdv/V/qWpwnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unistra.fr; spf=pass smtp.mailfrom=unistra.fr; dkim=pass (2048-bit key) header.d=unistra.fr header.i=@unistra.fr header.b=DOFET2+K; arc=none smtp.client-ip=194.254.241.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unistra.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unistra.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unistra.fr header.i=@unistra.fr header.b="DOFET2+K"
Received: from zmtaauth04.partage.renater.fr (zmtaauth04.partage.renater.fr [194.254.241.26])
	by smtpout20.partage.renater.fr (Postfix) with ESMTP id BBD03C04DE;
	Sun,  5 Oct 2025 09:21:27 +0200 (CEST)
Received: from zmtaauth04.partage.renater.fr (localhost [127.0.0.1])
	by zmtaauth04.partage.renater.fr (Postfix) with ESMTPS id B4A691C0B81;
	Sun,  5 Oct 2025 09:21:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zmtaauth04.partage.renater.fr (Postfix) with ESMTP id A51631C0B90;
	Sun,  5 Oct 2025 09:21:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zmtaauth04.partage.renater.fr A51631C0B90
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unistra.fr;
	s=CF279DD4-6F58-4C59-BB33-73FDC6DFC1E3; t=1759648887;
	bh=dv44Gqz/C09Gp35wRk+pwPLRV5xcb5yUqasGCputPWg=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=DOFET2+KUi1FVsOG4fKTyDQKZQ1s+roA/pgel2+h6IKqkowkXnz60aICb4qqTmxKy
	 HXq2V/bOGqO7hpuqeBbsnSb777+FypRG8+uOPagXnqtvDeqXJPaczWdkGwdYdx2+8t
	 eGrqpVfVVJsqpjfX28N+B4CCiqnBZ5fZ+Cmpf203ItctKHw0wd7KkQx+oGYT2HD/0A
	 QWH2kjSpbI9PX9pWdTC+veLAmOEMc+7BjMIp+qPgwnk4WzhVw5RPkwBW9bpWMwmS5T
	 qzYAOQmOaznz7DQqZdl6yCUO5XHvuDfp5c3f15hUtpZQzB9Ck8ls7NsOnLDgsQM2Y3
	 ylnpuj5kymgOw==
Received: from zmtaauth04.partage.renater.fr ([127.0.0.1])
 by localhost (zmtaauth04.partage.renater.fr [127.0.0.1]) (amavis, port 10026)
 with ESMTP id nbH71iH2XcsN; Sun,  5 Oct 2025 09:21:27 +0200 (CEST)
Received: from 82.64.190.187 (unknown [194.254.241.249])
	by zmtaauth04.partage.renater.fr (Postfix) with ESMTPA id 7E8561C0B81;
	Sun,  5 Oct 2025 09:21:27 +0200 (CEST)
Date: Sun, 5 Oct 2025 09:21:27 +0200
From: Marc Chantreux <mc@unistra.fr>
To: Lawrence =?iso-8859-1?Q?Vel=E1zquez?= <vq@larryv.me>
Cc: dash@vger.kernel.org
Subject: Re: < "$@" doesn't expand properly?
Message-ID: <aOIcd2VviROi95Wj@prometheus>
References: <aOBSZYeG7UDIbOE6@prometheus>
 <5a1befb9-0617-40b0-9c53-7bf6452f0dcd@app.fastmail.com>
 <aODE8547kOvhQPIf@prometheus>
 <cff17249-7e9d-47f9-aca1-ef1bfa5cd32a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zxuhSumvvialgvWW"
Content-Disposition: inline
In-Reply-To: <cff17249-7e9d-47f9-aca1-ef1bfa5cd32a@app.fastmail.com>
X-Virus-Scanned: clamav-milter 0.103.12 at clamav01
X-Virus-Status: Clean


--zxuhSumvvialgvWW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lawrence,

On Sat, Oct 04, 2025 at 11:13:51AM -0400, Lawrence Vel=E1zquez wrote:
> Sure it does.  Redirections can be infixed, so these are all valid:
>=20
> 	<file cmd arg

my prefered one by far

> 	cmd arg <file

The one i kept using for years just because examples use it while isn't
now my most hated by far. a good demonstration about reading the man
pages even if you think you know the tool.

> 	cmd <file arg

> Someone who agrees with your argument should logically expect this
> to "work":
>=20
> 	set file arg
> 	cmd < "$@"

I have to admit I forgot this one because I considered it confusing and
useless but thanks to your example, I realize today is a convenient way to
place the data source in "$1" instead of the top of stack and that could
be useful in dash scripting because where is no simple/rubust way to get
this top (the equivalent of $argv[-1] in zsh). But as "$@" in not
expanded after <, this usecase is wasted as well.

fool() {
	local source=3D"$1"
	echo "content of $source:"
	cat < "$@"
}
fool mind -n

content of mind:
sh: 4: cannot open mind -n: No such file

> >> Almost no shell works the way you are expecting, except for zsh in
> >> native mode (which I suspect is where you first tried this syntax)
> > Not at all.
> Ah, well.  I guessed so because I know from the zsh mailing lists
> that you're a big zsh fan.

I'm also fan of rc and long time user of mksh, I also used tcsh at the end
of the last millenium and tested any other ones (including exotic ones
like zoidberg and elvish).

I once (~ 10 years ago?) wrote an email to Tom Duff to thank him for rc
ask him why there was no advanced variable expansions in rc (like
${foo#bar}, ${foo?oops} and so on). He answered me that nobody were using
them back then. He also wrote something that has a deep impact of the way
I think about shell scripting:

	=ABrc means "run commands" and should not do much more=BB

=66rom this day, I started to bet on external commands much more than
shell internals and realized my scripts where faster and more reliable.

As I didn't need all the zsh features anyore (and rc is sadly too
unknown to be used when you want to share your scripts), dash became my
almost only shebang (also almost all my scripts are working in a bare
busybox chroot, including CGIs).

I keep using zsh for interactive stuff because there is no competitor
on this part of the game thanks to

* "alternate syntax" for control statements
* advanced features like extended globs, list filtering, filename modifiers
* incredible zle widgets

> > As the behavior is undefined, of course, I would like to propose to
> > behave the most helpful way when it makes sense because
> >
> > * the other usecases are already doable:
> > 	* if the expected behavior is "$*", so use "$*"
> > 	* what's the point of A  < "$@" ? use "$1" instead
> > * it's a matter of consistency to me. why "$@" can't behave as "$@" ?
>=20
> One could easily make the same "consistency" argument from the
> perspective of the redirection operator.  POSIX disallows this
> expansion from producing multiple fields...
>=20
> 	var=3D'foo bar'
> 	cmd < $var
>=20
> ...so why should this one produce multiple fields?
> 	set foo bar
> 	cmd < "$@"

=66rom the POSIX perspective, it indeed shouldn't.

> In any case, the existing behavior conforms to POSIX and is far
> more portable, so it is not likely to change.

That's what I learnt from you (again: thank you so much) and
made me so sad: consistency on POSIX compliance avoid consistency around
useful behaviors. On the other hand, I totally support the idea that at
least one shell must be POSIX compatible flaw by flaw.

there is no perfect shell in this world :)

regards

--=20
Marc Chantreux
P=F4le CESAR (Calcul et services avanc=E9s =E0 la recherche)
Universit=E9 de Strasbourg
14 rue Ren=E9 Descartes,
BP 80010, 67084 STRASBOURG CEDEX
03.68.85.60.79


--zxuhSumvvialgvWW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQrhynLytp14smlCwy+er2aYc+1WAUCaOIccgAKCRC+er2aYc+1
WOIBAP9UhkeNZtoYrAsItnl7pveYEqR8l2z1CxnpP/RaeM1aHgEA9n7RQGUIQYP9
ciLeeZxs1JJGkUsKW6sVPl7wOxaoDg8=
=sKqF
-----END PGP SIGNATURE-----

--zxuhSumvvialgvWW--
