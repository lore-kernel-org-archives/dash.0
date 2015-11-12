From: Kevin Korb <kmk@sanitarium.net>
Subject: Re: [bug?] echo -n does not work as described
Date: Wed, 11 Nov 2015 22:46:02 -0500
Message-ID: <56440B7A.4040508@sanitarium.net>
References: <5643F1B2.5050207@sanitarium.net> <56440406.7000201@redhat.com>
 <56440A1E.8070701@sanitarium.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from asylum.sanitarium.net ([24.173.162.174]:57354 "HELO
	asylum.sanitarium.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752839AbbKLDqD (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 11 Nov 2015 22:46:03 -0500
In-Reply-To: <56440A1E.8070701@sanitarium.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>, dash@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/11/2015 10:40 PM, Kevin Korb wrote:
> On 11/11/2015 10:14 PM, Eric Blake wrote:
>> On 11/11/2015 06:56 PM, Kevin Korb wrote:
>>> I am on dash version 0.5.8.2 on Gentoo Linux (USE=3Dlibedit=20
>>> -static).
>>>=20
>>> The echo builtin does not work as described.  In the man page:
>=20
>> Which man page? Coreutils'?

no, /usr/share/man/man1/dash.1.xz on my box

> I was quoting the dash man page.  I did quote the result of the=20
> coreutils version of echo (/bin/echo) which worked correctly.
>=20
>> Read it further:
>=20
>>> NOTE: your shell may have its own version of echo, which
>>> usually super=E2=80=90 sedes the version described here. Please ref=
er
>>> to your shell's docu=E2=80=90 mentation for details about the optio=
ns
>>> it supports.
>=20
>> By the way, 'echo -n' is non-portable, and POSIX says you should=20
>> use 'printf' instead.

If dash refuses to supply a compatible version of echo then dash must
not include a builtin version of echo.  If dash didn't have a broken
embedded version of echo I wouldn't have a problem.

> This isn't my problem.  I am trying to use dash as a replacement
> for /bin/sh and it is failing horribly.  I am not the authors of
> the problem scripts.  Plus, frankly, it is absurd to require printf
> where echo [-n] should work correctly according to the dash
> documentation.
>=20
>> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/echo.html
>
>>  A string to be written to standard output. If the first operand=20
>> is -n, or if any of the operands contain a <backslash>
>> character, the results are implementation-defined.
>=20
>>> $ echo -n testing -n testing
>=20
>> Dash's implementation-defined behavior for -n is to treat it the=20
>> same as every other string.  Thus, this is not a bug in dash, at=20
>> least according to POSIX.

Then why does the man page say otherwise?

> Either this is a bug in dash or in dash's man page.  The man page
> is clear about how echo and echo -n should work.  But the reality
> is very different.
>=20
>>> This is causing me problems when I attempt to switch /bin/sh
>>> from bash to dash.
>=20
> This isn't stuff I have written.  This is stuff that I am tired of=20
> modifying to be dash compatible.
>=20
> Either dash's echo command should operate as documented or the=20
> documentation should be corrected.
>=20
>> It's probably not the only bashism you've been relying on.  You
>> may want to try using checkbashisms=20
>> (http://sourceforge.net/projects/checkbaskisms/) to help you
>> find other portability pitfalls.

> -- To unsubscribe from this list: send the line "unsubscribe dash"
> in the body of a message to majordomo@vger.kernel.org More
> majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

- --=20
~*-,._.,-*~'`^`'~*-,._.,-*~'`^`'~*-,._.,-*~'`^`'~*-,._.,-*~'`^`'~*-,._.=
,
	Kevin Korb			Phone:    (407) 252-6853
	Systems Administrator		Internet:
	FutureQuest, Inc.		Kevin@FutureQuest.net  (work)
	Orlando, Florida		kmk@sanitarium.net (personal)
	Web page:			http://www.sanitarium.net/
	PGP public key available on web site.
~*-,._.,-*~'`^`'~*-,._.,-*~'`^`'~*-,._.,-*~'`^`'~*-,._.,-*~'`^`'~*-,._.=
,
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlZEC3oACgkQVKC1jlbQAQfJawCeIdQetXk4zloxdAWk0+ZmreeQ
bX4AniCxpW0lwUSzkcO80nAru1xU5RQr
=3Dbelp
-----END PGP SIGNATURE-----
