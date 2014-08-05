From: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH dash] [BUILTIN] ensure LC_COLLATE is not overriden
Date: Tue, 05 Aug 2014 11:30:23 -0600
Message-ID: <53E114AF.9030307@redhat.com>
References: <1407256813-30944-1-git-send-email-chema@google.com>	<53E10FBA.5070905@redhat.com>	<CA+ZOOTOU31MTtLm13J2hiCmwMWMPPrvx6zjqZ_NQahjU31SqpA@mail.gmail.com>	<53E1110D.7050309@redhat.com> <CA+ZOOTPq58ft1EoRRtCEwQxkAXca9Wu58qGQ4UX=oMyJTzBkWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="B4hR3WR93sNHUgjdPsw797DlwvaT8V5Nd"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:13548 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753334AbaHERab (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 5 Aug 2014 13:30:31 -0400
In-Reply-To: <CA+ZOOTPq58ft1EoRRtCEwQxkAXca9Wu58qGQ4UX=oMyJTzBkWw@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Chema Gonzalez <chema@google.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B4hR3WR93sNHUgjdPsw797DlwvaT8V5Nd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/05/2014 11:19 AM, Chema Gonzalez wrote:
> On Tue, Aug 5, 2014 at 10:14 AM, Eric Blake <eblake@redhat.com> wrote:
>> On 08/05/2014 11:12 AM, Chema Gonzalez wrote:
>>>> Setting LC_ALL=3D to the empty string risks implementation-defined
>>>> behavior.  Also, LC_ALL overrides LANG and LC_COLLATE.  It should be=

>>>> sufficient to merely do:
>>>>
>>>>         }}' $temp | LC_ALL=3DC sort -k 1,1 | tee $temp2 | awk '{
>>>
>>> Maybe:
>>>     }}' $temp | LC_ALL=3DC LANG=3DC sort -k 1,1 | tee $temp2 | awk '{=

>>
>> No need to specify LANG=3DC when LC_ALL is set.  I stand by my shorter=
 line.
> I'd prefer to see if any FreeBSD user can confirm whether LC_ALL
> overrides LANG (as in Linux) or the other way around. The docs seems
> to suggest to use LANG instead of LC_ALL there.

Bug in the docs, then, as POSIX is quite clear that LC_ALL overrides
LC_* overrides LANG.  If FreeBSD ever got it backwards, even
temporarily, from what POSIX requires, it would be a lot more obvious.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--B4hR3WR93sNHUgjdPsw797DlwvaT8V5Nd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg

iQEcBAEBCAAGBQJT4RSvAAoJEKeha0olJ0NqraUIAKQDJuddQnRZo+Gt+AOqmZfO
xN3tmu3fUf+xFhDuiRCSkQq/2QyPyfR/8jCfOcbAzhX492FJQBItLq/4Shv9xPWM
Md2yUbRzu0DzBoRB7u7TQ26HcYN2aRTm7rrX5YC6bu5Q52EoOVDIYKmgGTjrzByA
Nrqqnlmnrh8WtDftLnmOKF/JcQxcbXFF0wrf+YQlNJ2k1Cd1nnk0WBLNdBXafF0A
J6+KAd6i5oGDHN7CKhKTRXvwhewnRzRlDzufyKzK40msR1xHgR1fc/hkgNkPrERM
CHWSEfyhSEbScBG1j/gq7kwsFpKJ5MAjRtS52SEaI8bwOgdicKmnGmqIJLLluUo=
=2/6m
-----END PGP SIGNATURE-----

--B4hR3WR93sNHUgjdPsw797DlwvaT8V5Nd--
