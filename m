From: Eric Blake <eblake@redhat.com>
Subject: Re: How to list functions?
Date: Tue, 22 Oct 2013 14:50:02 +0100
Message-ID: <5266828A.7060505@redhat.com>
References: <20131022120556.GD12206@yade.xx.vu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Li5kklThLhOU9dwoh3IfrErFFpuPQA4QF"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55439 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861Ab3JVOi7 (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 22 Oct 2013 10:38:59 -0400
In-Reply-To: <20131022120556.GD12206@yade.xx.vu>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Alexander Huemer <alexander.huemer@xx.vu>, dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Li5kklThLhOU9dwoh3IfrErFFpuPQA4QF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/22/2013 01:05 PM, Alexander Huemer wrote:
> Hi,
>=20
> posh has support for functions.

Wrong list.  posh is a different shell than dash, so there's nothing
this list can do to change posh.

>=20
> $ f() { echo foo; }
> $ f
> foo
> $=20
>=20
> Unfortunately I am unable to list the defined functions.
> I tried `typeset`, `declare` and `set` without success in posh 0.10.2 o=
n=20

posh tries hard to limit itself to POSIX (harder than dash), and POSIX
does not yet define 'typeset', lacks 'declare', and does not require
'set' to list function bodies.  Thus, as far as I can see, POSIX doesn't
require shells to be able to output function bodies.  For posh to
provide this, they'd have to give you an extension beyond POSIX; but
that goes against the goals of posh.  Sorry.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Li5kklThLhOU9dwoh3IfrErFFpuPQA4QF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJSZoKKAAoJEKeha0olJ0NqitkIAJ/xX0RXcjMZVlSH4vlnUlMu
oryHKHgp0Wt0ckvYxBwnwLJnZFhn8kshje8k6ZLgh3oEJ6Le5a3pSF0GCDRc86Q0
X6+greOu3pCOstRn2RqeC04oQLkJGFMI1wBYFNACPhMDmCr78eMNIYYFCHkORXRj
mu9m3s9SctD66JAjggUI+/Gd1NSA10ioC25MaWG5+fZS1w1NNjH2syYxrm32X0G3
QFRJtj9z2C+8CmrxZ/oykWDj0a1m+dkXm/vrRiS1YAIWVy3Z+DV16LRdfoHz9LLF
4rje2LLl6QKITq6UxXqkEtsLKGiEHApCBPVNVqjzv7oxHp+3s5w1ULBPVfG3rw8=
=DAXf
-----END PGP SIGNATURE-----

--Li5kklThLhOU9dwoh3IfrErFFpuPQA4QF--
