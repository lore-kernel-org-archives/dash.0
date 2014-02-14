From: Eric Blake <eblake@redhat.com>
Subject: Re: eval and export behave differently together in dash and ash than
 in bash, zsh, and ksh
Date: Fri, 14 Feb 2014 11:46:31 -0700
Message-ID: <52FE6487.7000202@redhat.com>
References: <CAPF-yOaxN0b3t-H8Vi3HirpAuV0gsdu9XWROws4o02JXAEdzAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0iOm77643NBiLdxkJm2XNWUU7Iau9ISOR"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:30224 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751385AbaBNSqf (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 14 Feb 2014 13:46:35 -0500
In-Reply-To: <CAPF-yOaxN0b3t-H8Vi3HirpAuV0gsdu9XWROws4o02JXAEdzAA@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Dan Kegel <dank@kegel.com>, dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0iOm77643NBiLdxkJm2XNWUU7Iau9ISOR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/14/2014 11:29 AM, Dan Kegel wrote:
> The script
>=20
> eval export dir=3D~$LOGNAME
> echo $dir

This has been discussed by the POSIX folks.  See:
http://austingroupbugs.net/view.php?id=3D351

The standard added the definition of a 'declaration utility', which can
evaluate its arguments in assignment context, and marked that 'export'
is one such utility:

>> At line 74276 (XCU export DESCRIPTION), add:
>> The export special built-in shall be a declaration utility. Therefore,=

>> if export is recognized as the command word of a simple command, then
>> subsequent words of the form name=3Dword shall be expanded in an
>> assignment context. See Section 2.9.1.

Meanwhile, 'eval' is not allowed to be a declaration utility.  Thus,
once this POSIX interpretation is made live in Issue 8 (currently still
unreleased), a conforming shell would have to evaluate this as:

eval export dir=3D~$LOGNAME      # not in assignment context
eval 'export' 'dir=3D~buildbot'  # actual arguments passed to eval
export dir=3D~buildbot           # declaration context, do tilde expansio=
n
dir gets /home/buildbot

ksh and bash are compliant, dash needs to be patched.

However, as Issue 8 POSIX is not yet released, dash is not yet
non-compliant, and you are correct that workarounds exist while waiting
for someone to write the patch for dash.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--0iOm77643NBiLdxkJm2XNWUU7Iau9ISOR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJS/mSIAAoJEKeha0olJ0NqkcUIAIpxPVD4s77Id/xXxFhnD+Yu
H5Pp0+LmOwIzPC8bVqjI+DqCTiqPSk3+nLm0u0tbgyOOCbx9wUrx0Atbi3zUtzOW
yFF1rFAyfc9yzrGIw4yYSseMboF06Tj8uv1b5YKV2s4H2dt7cB1BZPhSAbgu2EDT
hWvUnQMsNbd2oDWQixQWqTqf0BkJUwcqAcuXd0wD0Uyykgsd4blfWnwSrFlU5jST
LyP16ys7qADnybpl3ssgazuSCCjWzRszR43Bb6LP/znnQxMiL6bKNKBGzgigDxnm
WXbbDzATsZtRlbv1RV9Y9gDuBHSUa3YqHi5CYert0gl/GMUhdhfrrsasxQoUZPw=
=hEFh
-----END PGP SIGNATURE-----

--0iOm77643NBiLdxkJm2XNWUU7Iau9ISOR--
