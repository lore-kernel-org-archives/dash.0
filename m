Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C033542E5
	for <dash@vger.kernel.org>; Sun, 10 May 2026 12:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778415530; cv=none; b=TNP6FqmDhXiUXy2TR5KVcckeHo/un/t8O6pWz18HuX298JkMvVxj0UWN4AStTobzT4rdwH9sPmOrpgDG+REBdB8GK93Y3SHNuxre3tkjUKzK63ESfdtPQoW8KsDE/hcSbydeCsnjl9Cf8JyALlvj/3A7TlUTf0/DzBEmsPMlkQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778415530; c=relaxed/simple;
	bh=LIbCJaiPPrJjSeAs4okzUFL1hJsM4kCROJTBmBVMBrY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=UML1C1fNWjAIA5olIA+fytmbaudd4iC0QQR9TpGme4w+75v8vCf0HHdQsaSTwOLFg0pEpLOY9Wt0TMGfMeD9aoOmOYblRButV2m3OSR4EJE0fqFzvRzf+1Tcwxx6IgmHTUQ2XrGavj+NET9+KWmBKp9WSQEk6ActYyfHOx9Yu14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (1.5.5.2.4.d.e.f.f.f.5.f.9.d.6.0.a.5.c.d.c.d.9.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:19dc:dc5a:6d9:f5ff:fed4:2551])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 77DEA341F60;
	Sun, 10 May 2026 12:18:47 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: dash-shell-80d677ffb5cf@mekboy.ru
Cc: dash@vger.kernel.org
Subject: Re: Can't build with GCC 16.1.0 - libatomic problem
In-Reply-To: <agBwF7x-EtgAZMXy@micropc>
Organization: Gentoo
User-Agent: mu4e 1.14.1; emacs 31.0.60
Date: Sun, 10 May 2026 13:18:44 +0100
Message-ID: <87y0hrqwyj.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This is a bug in the `musl-gcc` wrapper (other than possibly some
concern about the dash build system wrt flags):=20
https://gcc.gnu.org/PR125235

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEBBAEWCgCpFiEEJaa7iN2bdkxrVUHCc4QJ9SDfkZAFAmoAd6QbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25z
Lm9wZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXQyNUE2QkI4OEREOUI3NjRDNkI1NTQx
QzI3Mzg0MDlGNTIwREY5MTkwDxxzYW1AZ2VudG9vLm9yZwAKCRBzhAn1IN+RkK+k
AP48HoEL8+qkKoUPp0Ace3zQ9Kz33PYosfDWIxerq3nZowD/VNly+E8NCY6SiX2L
+H5VOqCM8aVVHN+ys9cEorHsoQM=
=UXx8
-----END PGP SIGNATURE-----
--=-=-=--
