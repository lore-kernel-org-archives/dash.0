From: Eric Blake <eblake@redhat.com>
Subject: Re: The behavior of `jobs -p` is definitely, without a doubt, a bug
Date: Wed, 18 May 2016 19:51:23 -0600
Message-ID: <573D1C1B.5020803@redhat.com>
References: <154a7ddad4a.edbc789338466.8966956162476476079@geoff.codes>
 <573CD8BF.9080404@gigawatt.nl>
 <154c6533dbf.f33a196d271361.3835032381744891755@geoff.codes>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7qoeg4EnF7PHEA9m5ttVLcg7AQwU6ufI1"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33636 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753433AbcESBvZ (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 18 May 2016 21:51:25 -0400
In-Reply-To: <154c6533dbf.f33a196d271361.3835032381744891755@geoff.codes>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Geoff Nixon <geoff@geoff.codes>, Harald van Dijk <harald@gigawatt.nl>
Cc: "dash@vger.kernel.org" <dash@vger.kernel.org>, "482999@bugs.debian.org" <482999@bugs.debian.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7qoeg4EnF7PHEA9m5ttVLcg7AQwU6ufI1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/18/2016 06:03 PM, Geoff Nixon wrote:
> Again, speaking for myself, I think the standard is actually pretty cle=
ar here.
> Referring again to the "Shell Command Language" page:
>=20
>     The format for grouping commands is as follows:
>     (compound-list)
>     Execute compound-list in a *subshell environment*...
>=20
> That is, I believe the behavior of bash and busybox does not fully adhe=
re to the
> the standard; pdksh, ksh93, mksh, yash, and oksh are compliant.
>=20
>> Personally, I feel that even if your interpretation is wrong (and I'm =

>> not saying it is), it is still less undesirable than dash's current=20
>> behaviour. If there's a reasonable chance a patch for it would be=20
>> accepted, I'd be willing to try to make it so.=20
>=20
> Agreed. I'd very much like to see a patch for this; and I certainly hop=
e it
> would be accepted!
>=20
> At the *very, very least*, I think the fact that `jobs -p` can have std=
out
> redirected to a file, yet cannot be used in a pipeline, is most definit=
ely=20
> bug. Can you think of any other command where stdout can be redirected =
to a file
> but cannot be piped?

http://austingroupbugs.net/view.php?id=3D53

The trap command is in the same boat as jobs, where redirecting to a
file is different than execution in a subshell, and where the shell may
special case (but perhaps by lexical analysis only) that if a subshell
is about to run where only the single command is being executed, then it
can behave as if that single command were in the context of the parent
instead of being a true subshell, precisely for the purpose of giving
output that would otherwise be lost.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--7qoeg4EnF7PHEA9m5ttVLcg7AQwU6ufI1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJXPRwbAAoJEKeha0olJ0NqgXAH/j0Z4Zan1j6qFcQ6QZAtWBta
ho5UcGgCkJnrPkQNKKQz0dt5qzQnsOTX2JLmiw+AEPxYvwUySxJ7ddDJvjow5oPv
NjCJL1UWke37cwaS4tERyvYqi/3vDQkqOV1zsFzW5pCnkXmqPD44xI0LIgrOpWtO
gK62JT7dqJqJaoAkuMcSw1k/jmz6kV6hpLeUwXOzoQw3rZTpFA5zz+4Rx8BtwuQT
2K5H13s83kMY9h0S7+O1KGmg58rnZ2MZlJot8ws96/uwp1YmHW+hvKXKmogKflx8
0ncI9IOvU3aqnBzOVLyQQPt1LfxxLzQiNFSnxk2EhFkbe1yrLl0EXorv6hvCq6s=
=XUSh
-----END PGP SIGNATURE-----

--7qoeg4EnF7PHEA9m5ttVLcg7AQwU6ufI1--
