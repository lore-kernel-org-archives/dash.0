From: Eric Blake <eblake@redhat.com>
Subject: Re: [bug-diffutils] bug#24116: [platform-testers] new snapshot
 available: diffutils-3.3.50-0353
Date: Fri, 5 Aug 2016 10:21:20 -0600
Message-ID: <57A4BD00.1080900@redhat.com>
References: <CA+8g5KEOBs=AtZoBZw7CJ5wW8=Yw88KrvjJK1PeEqK3uj_1wEg@mail.gmail.com>
 <9C56E56C-4D31-46AB-AC75-1AA8A759BF4D@gmail.com>
 <CA+8g5KGack9X8ByfoJEtbQHj-44iG6bvQ0yhguVqQ4vqZh4geA@mail.gmail.com>
 <2e1ea9a1-278e-8979-023b-72f77d677f5f@intel.com>
 <90e016d1-e0be-83c8-d0ee-ecb5665318ef@gigawatt.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WpCi8Wkvk7b18FHwg7Snb6dkwdsdRVhpT"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44986 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759941AbcHEQWE (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 5 Aug 2016 12:22:04 -0400
In-Reply-To: <90e016d1-e0be-83c8-d0ee-ecb5665318ef@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>, Dave Gordon <david.s.gordon@intel.com>, Jim Meyering <jim@meyering.net>, Assaf Gordon <assafgordon@gmail.com>
Cc: 24116@debbugs.gnu.org, dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WpCi8Wkvk7b18FHwg7Snb6dkwdsdRVhpT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/05/2016 07:13 AM, Harald van Dijk wrote:

>=20
> Unfortunately, POSIX currently requires the export command to not have
> any magic quoting, and any POSIX-conforming shell will make
>=20
>     a=3D"b c=3Dd"
>     export a=3D$a
>=20
> set a to b, and c to d. Not so with bash, but that's because bash simpl=
y
> isn't POSIX-conforming, even if invoked as sh.

Not quite so fast.

>=20
> POSIX will require special quoting rules for the export command in the
> future, similar to what bash does today. When it does, dash is likely t=
o
> change to match that, and the local command will likely be changed to
> work the same way.

POSIX has already issued an interpretation request, and therefore, any
CURRENT implementations (including bash) that already behave as
permitted by the interpretation ARE conforming.  Dash is still currently
conforming per the current version of POSIX, but will be non-conforming
when the interpretation request goes live in the next revision of POSIX,
while bash is already conforming both now and in the future revision,
without change.  So I would suggest that dash make the change to
implement assignment context to 'export', 'readonly', and 'local'
sooner, rather than later.

http://austingroupbugs.net/view.php?id=3D351

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--WpCi8Wkvk7b18FHwg7Snb6dkwdsdRVhpT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJXpL0AAAoJEKeha0olJ0Nqk4QH/jYNanus773AZYEmL+hnFtNl
vSP7xXRWMyW2OpL9oL2mPTOaJ38McBPaE6rLj264S81Zu5WPKYebay6noJsYVpok
a1+EF+UC8wy8gJz/Qsw/BmS18Q2Nr9t9zj5/vQ48IMBXEDdiOwqlOtc7nH7tckwa
cQczlAYQV/rlVW1g7kPkcOMJzMKLRHjqYLI6POg06WHExC/T2vMt4i+9MW5eoM81
jf9yRNtBOzJ3Lx3Si1+CCMb7x/Qkuq5hpaFimOY4Z8X6wcKWB3BgjlyQCZl7Nee2
CjQWW8Vzd7wc12zrBAjZMIRg7jQgL+MuAB1ZP1ZyUUa298eaC4nsLkOG2DtwQI0=
=JUKJ
-----END PGP SIGNATURE-----

--WpCi8Wkvk7b18FHwg7Snb6dkwdsdRVhpT--
