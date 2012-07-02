From: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] [BUILTIN] Allow SIG* signal names.
Date: Mon, 02 Jul 2012 13:07:22 -0600
Message-ID: <4FF1F16A.7010103@redhat.com>
References: <4ff0274f.c54fb40a.47e2.6814@mx.google.com> <4FF1A76F.6020307@redhat.com> <2D2FC58C-ACD5-4113-9A1D-C53A854C3CD7@aim.com> <4FF1AE9C.7040307@redhat.com> <CALqPu34=a629YmEiqk008a7aMF26ObEz=MCGA3vZBKTkr25hQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enigB296FBAC5421B26006F84B51"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46183 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751047Ab2GBTH1 (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 2 Jul 2012 15:07:27 -0400
In-Reply-To: <CALqPu34=a629YmEiqk008a7aMF26ObEz=MCGA3vZBKTkr25hQA@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Isaac Jurado <diptongo@gmail.com>
Cc: Paul Gilmartin <PaulGBoulder@aim.com>, dash <dash@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB296FBAC5421B26006F84B51
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/02/2012 12:53 PM, Isaac Jurado wrote:
> On Mon, Jul 2, 2012 at 4:22 PM, Eric Blake <eblake@redhat.com> wrote:
>> On 07/02/2012 08:11 AM, Paul Gilmartin wrote:
>>> On Jul 2, 2012, at 07:51, Eric Blake wrote:
>>>>
>>>> ... non-required bloat ...
>>>>
>>> The key phrase.  And one value of a shell lacking such
>>> extensions is that it provides an excellent test bed for
>>> code intended to be portable within the POSIX spec.
>>
>> That argues that we should drop our strcasecmp() for the much simpler
>> strcmp(), in order to remove the bloat we already have.
>=20
> I guess my patch has no chance to be accepted.

I'm not the maintainer, so my decision is not indicative of what the
dash maintainer will choose.  But my personal preference would be that
we change this area of code, either to:

1. be lighter-weight (drop strcasecmp, which is locale-dependent, and
replace it with strcmp)

2. be more user-friendly (accept optional case-insensitive SIG prefix)

Both approaches are permitted by POSIX, so it boils down to a judgment
call of whether providing useful extensions or providing a minimally
compliant shell is more important.

>  But I'm still curious
> about what kind of "bloat" you are referring to.  I'm assuming it's not=

> code bloat in terms of lines of code.

Even one byte larger in the final executable size has been deemed bloat
on this list in the past.  Dash prides itself on being minimalistic, but
you happened to point out an area of code that is not currently minimal.

>=20
> If the signal name to number conversion seems too expensive (linear
> search multiplied by the string lengths, wether it is case sensitive or=

> not), there is a much more elegant solution: perfect hashing.

Indeed, that would provide faster lookup, but it would also cost more
executable size (the storage requirements for a perfect hash table are
larger than the size of a loop comparison); I don't know whether the
preference is for speed, for minimal size, or for a hybrid of the two
(where larger size is okay only if it proves to have more speed).  So
hopefully the dash maintainer will chime in on the topic.

--=20
Eric Blake   eblake@redhat.com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org




--------------enigB296FBAC5421B26006F84B51
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJP8fFqAAoJEKeha0olJ0Nq6koIAIqrefPm0x3CGkrKbkwvNNQa
GqGmxTa1OF7MDdEwlj8IdoDMws+kpZnnJUGhVgFJGQGTJp00zqnUipGTuFLYlk3Q
4lEjdbgEjhGR7FF9k54eYRpbxQwSaUnhlBFZdmmUmEN2RBoYG+LsUMFLvjJREyZ8
UGcCVIghHPBKzG8cNubNoxd4U6PR4OFySg+ei3CWbTaOSs3+vE37vM9Qd1n5it58
/mFadCqkfTMpIlLqV9ybziIOz0KQ+9riWOBT190u1lTEiEGuDazgE34PG8pMcl5T
COQ/dMiHWsU3tOjmeUiiKi3tfvDKtfQZFj28n51IBqiotM5W71KlVSkxighqs84=
=CCoU
-----END PGP SIGNATURE-----

--------------enigB296FBAC5421B26006F84B51--
