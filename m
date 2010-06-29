From: Eric Blake <eblake@redhat.com>
Subject: Re: if then elif then else fi -- Problem report
Date: Tue, 29 Jun 2010 06:56:56 -0600
Message-ID: <4C29ED98.2020302@redhat.com>
References: <201006282226.22001.malcolm.kay@internode.on.net> <4C28A1FA.1090306@redhat.com> <201006291038.31206.malcolm.kay@internode.on.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig0AA881D15CDE3648394B3811"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:2086 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755824Ab0F2M6I (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 29 Jun 2010 08:58:08 -0400
In-Reply-To: <201006291038.31206.malcolm.kay@internode.on.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Malcolm Kay <malcolm.kay@internode.on.net>
Cc: dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0AA881D15CDE3648394B3811
Content-Type: text/plain; charset=ISO-8859-6
Content-Transfer-Encoding: quoted-printable

On 06/28/2010 07:08 PM, Malcolm Kay wrote:
> Eric,
> Thanks for the clarification.
>=20
> I had assumed that 'dash' aimed to be a faster replacement for=20
> the classical Bourne shell 'sh' as implemented in BSD systems,

Rather, 'dash' aims to be the fastest and smallest possible
POSIX-compliant shell; anywhere that POSIX disagrees with traditional
Bourne shell behavior, POSIX triumphs.  Not all BSD system /bin/sh are
POSIX compliant.  And while dash has some extensions over POSIX, the
goal of being smallest means that extensions are kept to a minimum
(contrast that with bash or zsh, which both have a goal of providing as
many useful extensions as possible at the expense of size and sometimes
speed).

> As it is I feel the man pages should not only be fixed in this=20
> respect, but also such differences to classical 'sh'=20
> implementations should be high lighted.

There are other existing online resources that describe differences
between Bourne shell and POSIX.  But it is a much bigger effort to
document how dash differs from non-POSIX shells than it is to just
document how dash itself behaves.

>=20
> On Mon, 28 Jun 2010 10:52 pm, Eric Blake wrote:
>> . . .
>>
>> Therefore, the bug is in the man page.  Per POSIX,
>> http://www.opengroup.org/onlinepubs/9699919799/utilities/V3_ch
>> ap02.html#tag_18_09_03 "A list is a sequence of one or more
>> AND-OR lists separated by the operators ';' and '&' and
>> optionally terminated by ';' , '&' , or <newline>."
>=20
> While I agree with your conclusions, I would note that POSIX
> defines "if ... else etc." in terms of 'compound_list' rather=20
> than 'list' so the above definition of 'list' is not really=20
> relevant. By my reading of your reference it seems POSIX defines=20
> 'list' and 'compound_list' independently but fails to clarify
> the difference if any.

POSIX defines compound_list quite clearly.  Read the grammar section:
http://www.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#t=
ag_18_10_02

compound_list    :              term
                 | newline_list term
                 |              term separator
                 | newline_list term separator

It also defines list:

list             : list separator_op and_or
                 |                   and_or

The difference between the two is how newlines serve to separate the
various and_or lists.

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enig0AA881D15CDE3648394B3811
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJMKe2gAAoJEKeha0olJ0Nq6GQIAK98AmsJcYPrNpdPhKIZ9VmV
9zvefJqn7Ql3MBJeH4zPVigRtleNogOBVxI+0sq2/T2RIxI9NdtFsj5xCRKhdiCz
IRnYs4zjRj8kZRWjQCJ+kVTJoyPz/8Id/4a9FvJPRJwzaVkZdaUgC/AcpZiJgU1U
6ZHMIbo4WoyrJAkeroHedupMKQ8+6wPr2W6Muemy77KU/55EdqVOfGWndzNvGDxN
119g3fzKw++uI7Vq0zzxh+NRRQx4mQhad0II97yLwzOG+HYkqPRdXPN67lyT6RWL
qQBrl7jgK/S916+QAY39T8rONQiZvwcEfD0sNvHeWvhqhcKmRyZfnECOg4Pvtf4=
=W26z
-----END PGP SIGNATURE-----

--------------enig0AA881D15CDE3648394B3811--
