From: Eric Blake <eblake@redhat.com>
Subject: Re: 'continue' does not work in files sourced with dotcmd
Date: Thu, 07 Jul 2011 09:18:12 -0600
Message-ID: <4E15CE34.40403@redhat.com>
References: <AANLkTimiFku8Uj9haYAxXWyJQOGSV7Uz3i2k75+aMvTU@mail.gmail.com> <20110707033749.GB16157@gondor.apana.org.au> <4E15B41A.9020601@redhat.com> <20110707144635.GA21272@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig3E476F2C0B1459DAF60008B6"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42783 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756639Ab1GGPSV (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 7 Jul 2011 11:18:21 -0400
In-Reply-To: <20110707144635.GA21272@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.hengli.com.au>
Cc: "Taylan Ulrich B." <taylanbayirli@gmail.com>, dash <dash@vger.kernel.org>, zsh-workers@zsh.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3E476F2C0B1459DAF60008B6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

[adding zsh list]

On 07/07/2011 08:46 AM, Herbert Xu wrote:
> On Thu, Jul 07, 2011 at 07:26:50AM -0600, Eric Blake wrote:
>>
>> zsh rejected the continue statement (no containing loop within the
>> current scoping of the dot script), and as a result also aborted the
>> overall dot script - but in doing so, it properly emitted an error mes=
sage.
>=20
> dash does not warn in this case because it never prints a warning
> on continue anywhere.
>=20
> This behaviour (not warning) is consistent with that of ksh.

Interesting!  And bash indeed behaves differently: in POSIX mode it is
silent, while in bash mode it issues a warning but does not affect exit
status - in line with the fact that in POSIX mode, bash obeys the rule
that if an application is diagnosing something to stderr, then the exit
status should be non-zero (and warnings don't affect exit status, hence
warnings should not be issued in POSIX mode).

Zsh is treating it as a syntax error, which is different from all the
other shells:

$ bash -c 'continue; echo $?'
bash: line 0: continue: only meaningful in a `for', `while', or `until' l=
oop
0
$ bash --posix -c 'continue; echo $?'
0
$ dash -c 'continue; echo $?'
0
$ ksh -c 'continue; echo $?'
0
$ zsh -c 'emulate sh; continue; echo $?'
zsh:continue:1: not in while, until, select, or repeat loop
$ echo $?
1

POSIX states "If n is greater than the number of enclosing loops, the
outermost enclosing loop shall be exited."  But this is admittedly
silent on the behavior when there is no outermost enclosing loop, so I'm
not sure whether zsh treating this as a syntax error is appropriate.

Meanwhile, I still have to wonder about dash behavior - if dash is _not_
treating continue as a syntax error, then why is it aborting the dot
script?  Compare:

$ dash -c 'continue
echo $?'
0
$ dash -c 'printf "continue\\necho 0.\$?\\n" > f; for i in 1; do . ./f;
echo 1.$?; done; echo 2.$?'
1.0
2.0

In isolation, execution after an un-nested continue resumed with the
next statement, but in the dot script, execution after the "un-nested"
continue (at least, from the dot script perspective) aborted the dot
script, but without affecting exit status.

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enig3E476F2C0B1459DAF60008B6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJOFc40AAoJEKeha0olJ0Nqt1UH/iSlybwwlCcWFDT7QKnFY0mG
DqHwSTBjXmy9DDZxOqGRcEshR1Kb3DvP7qRv0tS8iipJnEuce4jJ64l0AjZoIB5F
dD4qErcTdwMd9A0XepHAHaYNaD7TeqJ5wg2chlYqvNQbm9KaH7vYxpB+Jyu7oObs
G/Y4+F5h8ZT0l5Q+7TjNBBCN5VZEzJMz5wuGTuiWubbgd9l4fGuG8bvt/uFDxKIV
J8YAZo/Sti2mzPSiA4xsE0v6PIIpo4WU8Ck7wwQFhbPFdPaLm6R4oFX8DLhCs0C9
yxB4RYv79xxokkvPRTL66BXv19hNmmJGYC1OAIJzRglIQbiAHLEdCdiBhDVZVFo=
=fbFD
-----END PGP SIGNATURE-----

--------------enig3E476F2C0B1459DAF60008B6--
