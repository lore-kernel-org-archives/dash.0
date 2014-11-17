From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v2] [BUILTIN] Fix "test -x" as root on FreeBSD 8
Date: Mon, 17 Nov 2014 22:49:46 +0800
Message-ID: <20141117144946.GA1778@gondor.apana.org.au>
References: <20110926211636.GA6645@elie>
 <20110926221648.GF5629@elie>
 <20110927134517.GA30958@gondor.apana.org.au>
 <20110927231906.GC19549@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:53430 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887AbaKQOtw (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 17 Nov 2014 09:49:52 -0500
Content-Disposition: inline
In-Reply-To: <20110927231906.GC19549@elie>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: dash@vger.kernel.org, Christoph Egger <christoph@debian.org>, Petr Salinger <Petr.Salinger@seznam.cz>

On Tue, Sep 27, 2011 at 06:19:06PM -0500, Jonathan Nieder wrote:
> POSIX.1-2008 =A74.4 "File Access Permission" sayeth:
>=20
> 	If execute permission is requested, access shall be granted
> 	if execute permission is granted to at least one user by the
> 	file permission bits or by an alternate access control
> 	mechanism; otherwise, access shall be denied.
>=20
> For historical reasons, POSIX unfortunately also allows access() and
> faccessat() to return success for X_OK if the current process is
> privileged, even when the above condition is not fulfilled and actual
> execution would fail.  On the affected platforms, "test -x <path>" as
> root started returning true on nonexecutable files when dash switched
> from its own emulation to the true faccessat in v0.5.7~54
> (2010-04-02).
>=20
> Work around this by checking the permissions bits when mode =3D=3D X_=
OK
> and geteuid() =3D=3D 0 on such platforms.
>=20
> Unfortunately the behavior seems to vary from one kernel version to
> another, so we cannot just check the behavior at compile time and rel=
y
> on that.  A survey of some affected kernels:
>=20
>  - NetBSD's kernel moved to the sane semantics in 1997
>  - OpenBSD's kernel made the same change in version 4.4, three years
>    ago
>  - FreeBSD 9's kernel fixes this but hasn't been released yet
>=20
> It seems safe to only apply the workaround on systems using the
> FreeBSD kernel for now, and to push for standardization on the
> expected access()/faccessat() semantics so we can drop the workaround
> altogether in a few years.
>=20
> To try it on other platforms, use "./configure --enable-test-workarou=
nd".
>=20
> Reported-by: Christoph Egger <christoph@debian.org>
> Analysis-by: Petr Salinger <Petr.Salinger@seznam.cz>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

This patch seems to have slipped through the cracks.  Nevertheless
it is now applied.

Thanks,
--=20
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
