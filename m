From: Eric Blake <eblake@redhat.com>
Subject: Re: Crash on valid input
Date: Mon, 08 Apr 2013 21:08:16 -0600
Message-ID: <51638620.4030603@redhat.com>
References: <CAPF-yOaPfWdK2c556eTcRuf-thaHEzUcMKa+xa8criaS8uFLUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="----enig2RWLAOHOXKPGRLANEFDUJ"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34112 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934564Ab3DIDIS (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 8 Apr 2013 23:08:18 -0400
In-Reply-To: <CAPF-yOaPfWdK2c556eTcRuf-thaHEzUcMKa+xa8criaS8uFLUw@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Dan Kegel <dank@kegel.com>
Cc: dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2RWLAOHOXKPGRLANEFDUJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/08/2013 08:43 PM, Dan Kegel wrote:
> If I check for an empty string like this:
>=20
> + test ! $foo

You know, this is highly reliant on $foo expanding to either nothing (it
is empty, so you are really invoking the one-argument form 'test !'
which is true) or a single shell word (the two-argument form 'test !
nonempty' is false).  But if $foo has embedded whitespace, it expands to
more than one word after word-splitting, and you're hosed ('test ! one
two' can give interesting results, and probably not what you were
expecting).

You might want to fix your script to just use the safer:

! test "$foo"

which works even if $foo has embedded whitespace.  That said, you are
correct that dash should never crash.

>=20
> dash crashes.  This occurs both in the version shipped with ubuntu
> 10.04 and 12.04
> as well as with dash from git.
>=20
> Here's the stack:
>=20
> Program received signal SIGSEGV, Segmentation fault.
> __strcmp_sse4_2 () at ../sysdeps/i386/i686/multiarch/strcmp-sse4.S:221
> 221 ../sysdeps/i386/i686/multiarch/strcmp-sse4.S: No such file or direc=
tory.
> (gdb) bt
> #0  __strcmp_sse4_2 () at ../sysdeps/i386/i686/multiarch/strcmp-sse4.S:=
221
> #1  0x0805938a in getop (s=3D0x202b <Address 0x202b out of bounds>) at
> bltin/test.c:168
> #2  0x08059c91 in t_lex (tp=3D0x806581c) at bltin/test.c:431
> #3  0x080595cb in aexpr (n=3DUNOT) at bltin/test.c:260
> #4  0x08059557 in oexpr (n=3DUNOT) at bltin/test.c:243
> #5  0x080594ba in testcmd (argc=3D1, argv=3D0x8065814) at bltin/test.c:=
219
> #6  0x0804c526 in evalbltin (cmd=3D0x805da1c, argc=3D2, argv=3D0x806581=
0,
> flags=3D0) at eval.c:910

and given this part of the stack trace, it looks like you were invoking
'test ! word'?  But I was unable to reproduce a crash when I tried
dash.git, so it would be helpful to know exactly what $foo was in your
reproducer.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


------enig2RWLAOHOXKPGRLANEFDUJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJRY4YgAAoJEKeha0olJ0Nq0/AIAJ2/SxGzH5we7AQgJL9mNAt0
T/NxfcTYRW8FXxT/F2k/vfYJYQQxHj7JQolZRkMh1Vozh6TVLxCiMk3pMKtbkDfi
Senl/Nr2rKCs1mV/KH5WVe9nR+sbuZHpxHimFDPVaLIu/WDYSUIVFm5d7Sz048qx
g6lZt4vEPeLkA1pdGq+e6b9wgitSXNu8TmpnO0DF7/zKVSIkbnx14PhWg33Fmrot
WJSTTnUOOlWd/fMF7twg61/PdUxLEi0JaM2Zu6zzcal3wcjmqtzDKmm0N2hg8VqU
AsM9p25HXpi6KFuaNJBK7hHLnDcPtIG7rjR9wrU9cGjB2zXlO/lRC8Uu+HDOqOM=
=ZAqU
-----END PGP SIGNATURE-----

------enig2RWLAOHOXKPGRLANEFDUJ--
