From: Eric Blake <eblake@redhat.com>
Subject: Re: Crash on valid input
Date: Mon, 08 Apr 2013 21:34:42 -0600
Message-ID: <51638C52.50206@redhat.com>
References: <CAPF-yOaPfWdK2c556eTcRuf-thaHEzUcMKa+xa8criaS8uFLUw@mail.gmail.com> <51638620.4030603@redhat.com> <CAPF-yOZmkcKSpU+jVMsSi6Q8harUYZ-hS5Ugn7SsbBwm-GzhiQ@mail.gmail.com> <51638AA0.4080701@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="----enig2RJUMLQMIOWOMWUHQVNLD"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:64000 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759595Ab3DIDen (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 8 Apr 2013 23:34:43 -0400
In-Reply-To: <51638AA0.4080701@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
Cc: Dan Kegel <dank@kegel.com>, dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2RJUMLQMIOWOMWUHQVNLD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/08/2013 09:27 PM, Eric Blake wrote:
> On 04/08/2013 09:12 PM, Dan Kegel wrote:
>> Yes, my script was crap, I've fixed it.
>>
>> Here's the reproducer.  Called with foo unset.  I think it doesn't
>> crash without -x.
>>
>> #!/bin/dash
>> set -x
>> test ! $foo
>=20
> The 'set -x' was indeed the key to reproducing the problem.  In fact,
> this is the shortest I could make it:
>=20
> dash -cx 'test !'

If it helps, dash -cx '[ ! ]' does not crash.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


------enig2RJUMLQMIOWOMWUHQVNLD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJRY4xSAAoJEKeha0olJ0NqGeEH/A7Sxv4GI+VL5EwTkvLgo/Nc
O3zkFkrxzLX1VK+RHQZlO1V570dh5BFOYycZsIdz+bC/qZ4urD/G3zudzJdpadvN
1wzTJjYoGMdQxPZPFBso5O2BgqQUguwA9AKxzz9u8LfMlhHXjZikS7l7xFxxwWag
9206jMnzb6+sfQIpO6Bcc5M3RTwXxLkwcpI5ELO1Hzdhej0dQjVX1QU4bc5iCxO2
EqWVGpCZpMv5aOfVjtdrdhn0QUz5iYVYLRqm7oh9VglC00fChcswAfWo0KcLN+KP
cUWC4xvlUl81/SCQUMAWVUgZoMXQsw1thqmDnktNoeHq/DLAZYdvYle7Y7Zn4xM=
=CiAe
-----END PGP SIGNATURE-----

------enig2RJUMLQMIOWOMWUHQVNLD--
