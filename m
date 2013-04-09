From: Eric Blake <eblake@redhat.com>
Subject: Re: Crash on valid input
Date: Mon, 08 Apr 2013 21:27:28 -0600
Message-ID: <51638AA0.4080701@redhat.com>
References: <CAPF-yOaPfWdK2c556eTcRuf-thaHEzUcMKa+xa8criaS8uFLUw@mail.gmail.com> <51638620.4030603@redhat.com> <CAPF-yOZmkcKSpU+jVMsSi6Q8harUYZ-hS5Ugn7SsbBwm-GzhiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="----enig2SBSSWOJWAHTCRLANQACO"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:9222 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934544Ab3DID1a (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 8 Apr 2013 23:27:30 -0400
In-Reply-To: <CAPF-yOZmkcKSpU+jVMsSi6Q8harUYZ-hS5Ugn7SsbBwm-GzhiQ@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Dan Kegel <dank@kegel.com>
Cc: dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2SBSSWOJWAHTCRLANQACO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/08/2013 09:12 PM, Dan Kegel wrote:
> Yes, my script was crap, I've fixed it.
>=20
> Here's the reproducer.  Called with foo unset.  I think it doesn't
> crash without -x.
>=20
> #!/bin/dash
> set -x
> test ! $foo

The 'set -x' was indeed the key to reproducing the problem.  In fact,
this is the shortest I could make it:

dash -cx 'test !'

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


------enig2SBSSWOJWAHTCRLANQACO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJRY4qgAAoJEKeha0olJ0NquHYH/jQu8RzJXX5s/vng/dZM3BqP
zRQ/PAW39z0qwYv6XXB5/MJok+cVowl4jqYXYPQEidpoH6BmwlcNQLvMxXBmlkvV
tkbXLoT9K9YuVdIR+8/9bXw1GgN70KYKX6wzQved5uKM77ElBv6cZSDtwWP07Nj3
6lk+3Z19wi1o3PQmdph6zQAMf4I0HYVnlQrHCvm6Z4dhMyGB3dV73C3f7wnSYeak
HLNJuMStgMQHbDIw9RzLdZPzzDe1SlHW05D0hqAnCd6kF+U2lhVUukwIIhAQuXdK
RHBX3gyldlkYWxVJoQy6JzPOKQheq55tWxOyB1v3+AQ2Chl+APXfofBr02MhpME=
=wron
-----END PGP SIGNATURE-----

------enig2SBSSWOJWAHTCRLANQACO--
