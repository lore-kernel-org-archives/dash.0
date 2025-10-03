Received: from smtpout01-ext2.partage.renater.fr (smtpout01-ext2.partage.renater.fr [194.254.240.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A4D203710
	for <dash@vger.kernel.org>; Fri,  3 Oct 2025 22:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.254.240.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759532036; cv=none; b=hZqibYmSD2AtEWnz/fOyZgHzmG9XqiAzhSXOhOGqz/dmo6925zNpeaSZer8adqwLzcvnNvsJQB5jy3EaupbpbU0AEkaeoN9P9aNdEJqmby4nULfwRaTz3PXVhcdTMS8NW7Ufa38qAsxDuqjFLNI2xVkSgf5zMGBV2vXvyrCEop8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759532036; c=relaxed/simple;
	bh=TtVeRGTwovOGtooO/j/7gXczkPixTpYCEef+bVQIJ/w=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oyTs/K1VH87owhCxH2DhvOKF+mWqdlLQDpgMqRNZE0Qm+5fwzuY9B+ELtbHBw2kT/2WJl8PUnRWPgt4Uf5cWF1lC9Nv34F5hsP2zDztsKhIpnKtdzByujDMikNZNPxQ71ankEIqLvYbsNHbJf9fHRXjVOHQLa2V+7UyWy3EEsE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unistra.fr; spf=pass smtp.mailfrom=unistra.fr; dkim=pass (2048-bit key) header.d=unistra.fr header.i=@unistra.fr header.b=vxC6SZq4; arc=none smtp.client-ip=194.254.240.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unistra.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unistra.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unistra.fr header.i=@unistra.fr header.b="vxC6SZq4"
Received: from zmtaauth03.partage.renater.fr (zmtaauth03.partage.renater.fr [194.254.240.26])
	by smtpout10.partage.renater.fr (Postfix) with ESMTP id E7C846620D
	for <dash@vger.kernel.org>; Sat,  4 Oct 2025 00:47:03 +0200 (CEST)
Received: from zmtaauth03.partage.renater.fr (localhost [127.0.0.1])
	by zmtaauth03.partage.renater.fr (Postfix) with ESMTPS id D746E80023
	for <dash@vger.kernel.org>; Sat,  4 Oct 2025 00:47:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zmtaauth03.partage.renater.fr (Postfix) with ESMTP id C7B5B80076
	for <dash@vger.kernel.org>; Sat,  4 Oct 2025 00:47:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zmtaauth03.partage.renater.fr C7B5B80076
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unistra.fr;
	s=CF279DD4-6F58-4C59-BB33-73FDC6DFC1E3; t=1759531623;
	bh=TtVeRGTwovOGtooO/j/7gXczkPixTpYCEef+bVQIJ/w=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=vxC6SZq4O8DnI0k2rnmMFjSNVXZ1OpoZcM+j0HxkY/UAK723Z8aiIm7mbz2SQkJMv
	 AzKyZ4XOVHhmCKvyFpID58Wko6CVUqSMLlMH64/RTsWjPmRu93A3E1oSTFJG6LsPvq
	 7XGoPBr86HLsTGIxhKCn477iFf8ULiC9eXxau36AqQijj/B9UXvuCM1Sg4DnyISLXV
	 nRMszkBqD6pMxoBFJ1zRiJL0fOBDOsFsG4y3LdPilhHtFtTW8LrMxNP7UuungyI2An
	 6eAreLZJJq6kJWWl9I+wcwaavVXqXeCG6ZxCBHZl2J0GymKrP4B16pjC7vQs3hk+cs
	 gHr8NJfDqBg6g==
Received: from zmtaauth03.partage.renater.fr ([127.0.0.1])
 by localhost (zmtaauth03.partage.renater.fr [127.0.0.1]) (amavis, port 10026)
 with ESMTP id ArRWRU3oM4_g for <dash@vger.kernel.org>;
 Sat,  4 Oct 2025 00:47:03 +0200 (CEST)
Received: from 82.64.190.187 (unknown [194.254.241.250])
	by zmtaauth03.partage.renater.fr (Postfix) with ESMTPA id 9C5C780023
	for <dash@vger.kernel.org>; Sat,  4 Oct 2025 00:47:03 +0200 (CEST)
Date: Sat, 4 Oct 2025 00:47:01 +0200
From: Marc Chantreux <mc@unistra.fr>
To: Dash <dash@vger.kernel.org>
Subject: < "$@" doesn't expand properly?
Message-ID: <aOBSZYeG7UDIbOE6@prometheus>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+omWVax7Ms6Q9co7"
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 0.103.12 at clamav03
X-Virus-Status: Clean


--+omWVax7Ms6Q9co7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hello everyone,

I wrote a simple "inplace" script to be able to
work with commands that have no -i options.

The simplest way to do it (I thought) was

#!/bin/sh
set -eux
< "$@" | sponge "$1"

so inplace counter awk '{$0+=3D2}1' would be expanded
as

< 'counter' 'awk' '{$0+=3D2}1' | sponge 'counter'


but there is an error message

=2E/inplace: 3: cannot open counter awk {$0+=3D2}1: No such file

so it seems that the expansion leads to

< 'counter awk {$0+=3D2}1' | sponge 'counter'

is this an expected behavior?

regards

--=20
Marc Chantreux
P=F4le CESAR (Calcul et services avanc=E9s =E0 la recherche)
Universit=E9 de Strasbourg
14 rue Ren=E9 Descartes,
BP 80010, 67084 STRASBOURG CEDEX
03.68.85.60.79


--+omWVax7Ms6Q9co7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQrhynLytp14smlCwy+er2aYc+1WAUCaOBSYQAKCRC+er2aYc+1
WIUxAP91RIOI8W67hbrLQvkoZ9BspPHcDed6sIEoAX5gu9UHOgEAsueKem8Fazn7
+p98CzMZNQTsAHn5GGwHBjf9t4AUzQk=
=4Niw
-----END PGP SIGNATURE-----

--+omWVax7Ms6Q9co7--
