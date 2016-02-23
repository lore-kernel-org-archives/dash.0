From: Eric Blake <eblake@redhat.com>
Subject: Re: heredoc and subshell
Date: Tue, 23 Feb 2016 15:49:07 -0700
Message-ID: <56CCE1E3.1060805@redhat.com>
References: <2978711456265264@web9h.yandex.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6AHagMHehBMUteSJdE1uApXVjnR5HMTPl"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35775 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752849AbcBWWtJ (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 23 Feb 2016 17:49:09 -0500
In-Reply-To: <2978711456265264@web9h.yandex.ru>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Oleg Bulatov <oleg@bulatov.me>, dash@vger.kernel.org, Austin Group <austin-group-l@opengroup.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6AHagMHehBMUteSJdE1uApXVjnR5HMTPl
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[adding the Austin Group]

On 02/23/2016 03:07 PM, Oleg Bulatov wrote:
> Hello,
>=20
> trying to minimize a shell code I found an unobvious moment with heredo=
cs and subshells.

Thanks for a cool testcase.

>=20
> Is it specified by POSIX how next code should be parsed? dash output fo=
r this code differs from bash and zsh.

XCU 2.3 says:

When an io_here token has been recognized by the grammar (see Shell
Grammar), one or more of the subsequent lines immediately following the
next NEWLINE token form the body of one or more here-documents and shall
be parsed according to the rules of Here-Document.

and 2.7.4 says:

The here-document shall be treated as a single word that begins after
the next <newline> and continues until there is a line containing only
the delimiter and a <newline>, with no <blank> characters in between.
Then the next here-document starts, if there is one.

but with no mention of what happens if you somehow manage to make the
next <newline> be part of an incomplete shell word on the line
containing the here-doc operator.

>=20
> --- code
> prefix() { sed -e "s/^/$1:/"; }
> DASH_CODE() { :; }
>=20
> prefix A <<XXX && echo "$(prefix B <<XXX
> echo line 1
> XXX
> echo line 2)" && prefix DASH_CODE <<DASH_CODE
> echo line 3
> XXX
> echo line 4)"
> echo line 5
> DASH_CODE
>=20
> --- bash 4.3.42 output:
> A:echo line 3
> B:echo line 1
> line 2
> DASH_CODE:echo line 4)"
> DASH_CODE:echo line 5

So, it looks like bash is interpreting this as "first newline that is
not in the middle of another shell word), and parses the entire $(...)
construct through line 2 as if there were no newlines, then treats the
newline after DASH_CODE as starting the heredoc, for outputting A: while
visiting line 3 as the lone line in that heredoc.  Then it moves on to
the second command in the && sequence, by processing the command
substitution (a heredoc outputting line 1, then the output of line 2;
then moves on to the third component of the && sequence as a final
heredoc delimited by DASH_CODE, with both lines 4 and 5 output with the
DASH_CODE: prefix.

>=20
> --- dash 0.5.8 output:
> A:echo line 1
> B:echo line 2)" && prefix DASH_CODE <<DASH_CODE
> B:echo line 3
> line 4
> line 5
>=20

Meanwhile, dash is taking the literal first newline as the start of the
first heredoc, and outputting A: with line 1; then consuming the next
heredoc as lines 2 and 3 before finding the end of the command
substitution on line 4, then outputting line 5 on its own and doing
nothing else for the DASH_CODE function call.

ksh 93u+ 2012-08-01 behaves even differently:

B:echo line 1
line 2 && prefix DASH_CODE <<DASH_CODE
echo line 3
XXX
echo line 4)
line 5

and I'm having a hard time explaining that one.  Even better, modify the
script a bit:

$ head -n1 foo
prefix() { echo " $1:"; sed -e "s/^/$1:/"; }

and now I see:

$ ksh ./foo
Segmentation fault (core dumped)

but only sometimes; other times I get:

 A:
 B:
B:echo line 1
line 2 && prefix DASH_CODE <<DASH_CODE
echo line 3
XXX
echo line 4)
line 5

so it looks like some data-dependent race is tickling a bug in ksh.

Maybe we need a defect against the standard that says behavior is
unspecified if the next <newline> after a here-doc operator occurs in
the middle of a shell word.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--6AHagMHehBMUteSJdE1uApXVjnR5HMTPl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJWzOHjAAoJEKeha0olJ0Nq5MkIAK5RcF6P3aOR0qPe54SYnIJq
crdPrT2PL/PNvzap7EZ8x7qCcED6qvjXl9PY+rLxkh/tNhIWCJqkQv84kmOx1Rpt
QgwqR6tsJs9yTk3rlvkbefXUF2jjTY+UwHBGQ+nZQRYIQw8kqH5iCd72kaq15H4C
H6zIrLfY7DNl7Ig/2E++foWRDi4pGJJ0j5tzNXK9WotOWYLE5NX5C6ZlRv01G9Mn
a8DPofFByx5ccfkHiR3Oeu3UHim7HDhc3hKVdOCY+qUf4h0aivqjOnFpb+b1EaYq
yeiBwjAXj7AJqtRGjOs6IQQxKTm/2jvWbc6cWnujF/PjChRkwi3NmFRnMP5c+rI=
=0wFT
-----END PGP SIGNATURE-----

--6AHagMHehBMUteSJdE1uApXVjnR5HMTPl--
