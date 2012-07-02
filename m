From: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] [BUILTIN] Allow SIG* signal names.
Date: Mon, 02 Jul 2012 07:51:43 -0600
Message-ID: <4FF1A76F.6020307@redhat.com>
References: <4ff0274f.c54fb40a.47e2.6814@mx.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig583DF45F957A741D9360EF08"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:27737 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751183Ab2GBNvs (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 2 Jul 2012 09:51:48 -0400
In-Reply-To: <4ff0274f.c54fb40a.47e2.6814@mx.google.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Isaac Jurado <diptongo@gmail.com>
Cc: dash <dash@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig583DF45F957A741D9360EF08
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/01/2012 04:12 AM, Isaac Jurado wrote:
> In other shells, both trap and kill builtins accept two form of signal =
names,
> i.e., TERM and SIGTERM.  Even /bin/kill allows the SIG* form.  Having d=
ash fail
> by not recognizing the SIG prefix introduces some confusion among users=
=2E
> ---
>  src/trap.c |    3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/src/trap.c b/src/trap.c
> index 17316c9..a64133c 100644
> --- a/src/trap.c
> +++ b/src/trap.c
> @@ -408,6 +408,9 @@ int decode_signal(const char *string, int minsig)
>  		return signo;
>  	}
> =20
> +	if (string[0] =3D=3D 'S' && string[1] =3D=3D 'I' && string[2] =3D=3D =
'G')
> +		string +=3D 3;
> +

POSIX says:

"Implementations may permit names with the SIG prefix or ignore case in
signal names as an extension."

>  	for (signo =3D minsig; signo < NSIG; signo++) {
>  		if (!strcasecmp(string, signal_names[signo])) {

And since we're already ignoring case in the rest of the name, you
should also ignore case for the SIG, if we decide to accept the
non-required bloat this patch provides.

--=20
Eric Blake   eblake@redhat.com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org




--------------enig583DF45F957A741D9360EF08
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJP8adxAAoJEKeha0olJ0NqJoYIAJUkXquHJSzvizGvo5MrXUS1
6Z8R+P9mIXByIisrNVYJ/Ey1TdqVAq0cmOcRj9vBVOQMVlW+zR8QxIwzvYfLkh9m
7InHeHAuK1ysSW9KdvH21wIDCMrYXztofVZ8N+vt/DBJXPUrv38kH4He8OS9Dacv
5ObfiZ5lHQXL+fnbDmQy/Ful8P4kpqf13QzElEmcBx4YDcuKCowhwvXdZ+dNAU2h
CND5XXGmcHpdMxlxtIWjFObGdTj/yUpzWRvb45w6sQFaeTdVsc+XKpwZpuRTFPUE
f1DUvYJHeh+4/i8xcfZJfmt1PN9s7jC5kud9W2rE+5lPMDxRo/bqfFGng9NE7Mk=
=NNpJ
-----END PGP SIGNATURE-----

--------------enig583DF45F957A741D9360EF08--
