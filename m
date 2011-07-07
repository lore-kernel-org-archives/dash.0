From: Eric Blake <eblake@redhat.com>
Subject: Re: 'continue' does not work in files sourced with dotcmd
Date: Thu, 07 Jul 2011 07:26:50 -0600
Message-ID: <4E15B41A.9020601@redhat.com>
References: <AANLkTimiFku8Uj9haYAxXWyJQOGSV7Uz3i2k75+aMvTU@mail.gmail.com> <20110707033749.GB16157@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig4D9329238278EC9F4CE13B95"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:18803 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755650Ab1GGN05 (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 7 Jul 2011 09:26:57 -0400
In-Reply-To: <20110707033749.GB16157@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.hengli.com.au>
Cc: "Taylan Ulrich B." <taylanbayirli@gmail.com>, dash <dash@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4D9329238278EC9F4CE13B95
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/06/2011 09:37 PM, Herbert Xu wrote:
> On Sat, Feb 26, 2011 at 06:23:54PM +0000, Taylan Ulrich B. wrote:
>> Using latest dash from git.
>> Transcript:
>>
>> $ echo continue > foo
>> $ for i in 1; do . ./foo; echo foobar; done
>> foobar
>> $
>=20
> While this does look inconsistent, this behaviour is not confined
> to dash.  pdksh also does the same thing.

I've asked on the Austin Group whether this is a hole in POSIX, since
the standard appears to be silent on whether a for loop around a dot
script is visible to commands within the dot script.

>=20
> So I'm not particularly keen on changing this.

Unfortunately, I argue that dash DOES have a bug.  Compare the zsh behavi=
or:

$ zsh -c 'emulate sh; printf "continue\\necho \$?" > f; for i in 1; do .
=2E/f; echo "$? hi"; done; rm f'
=2E/f:continue:1: not in while, until, select, or repeat loop
1 hi

zsh rejected the continue statement (no containing loop within the
current scoping of the dot script), and as a result also aborted the
overall dot script - but in doing so, it properly emitted an error messag=
e.

Unless the Austin Group rules otherwise, I'm okay with dash rejecting
the continue command and aborting the dot script - but only on the
condition that the error is diagnosed, rather than silently papered
over.  But it may be worth waiting for the Austin Group ruling, to see
if the bash/ksh behavior of continuing on to the loop that is enclosing
the dot script is required, or merely one possible alternative, before
changing dash behavior (that is, no point wiring up an error message
unless we know that issuing an error message complies with the standard).=


--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enig4D9329238278EC9F4CE13B95
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJOFbQaAAoJEKeha0olJ0NqzXwIAJLD9Ob0k/KFekR7YsdsXCkX
fCQrtJrqQqmqaCyLjQaG+UUCzlO6E3d5gp8BZoB360zOGCwyMIhSzLuEXbZz3HWH
UDZ8Ts60Y7zENopyCRfvoqc9jxMfm+o818o04yJ1j2j1KiQugYAW53ywsjs13POH
xmnquHo+2ZQINg3gsYN0BnNR+zyxop5ISnjkHZvntX1gFj0WFXMz0/mQnZcl/9gf
3YT8PzPiXwj9W+jNT3hsvnau6v5dZWA5/93lMLxv+mt07DJfZpBPNZqtfG/c/Ez9
lxST5zU3Roqgt5e34F+Wkl5T7UuZtS4iaMrKPGHyGOAHD2yZJWASeT2RTTJRD6M=
=yaEF
-----END PGP SIGNATURE-----

--------------enig4D9329238278EC9F4CE13B95--
