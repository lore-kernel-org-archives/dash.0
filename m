From: Kevin Korb <kmk@sanitarium.net>
Subject: Re: [bug?] echo -n does not work as described
Date: Wed, 11 Nov 2015 22:40:14 -0500
Message-ID: <56440A1E.8070701@sanitarium.net>
References: <5643F1B2.5050207@sanitarium.net> <56440406.7000201@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from asylum.sanitarium.net ([24.173.162.174]:51469 "HELO
	asylum.sanitarium.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752908AbbKLDkP (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 11 Nov 2015 22:40:15 -0500
In-Reply-To: <56440406.7000201@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>, dash@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/11/2015 10:14 PM, Eric Blake wrote:
> On 11/11/2015 06:56 PM, Kevin Korb wrote:
>> I am on dash version 0.5.8.2 on Gentoo Linux (USE=3Dlibedit
>> -static).
>>=20
>> The echo builtin does not work as described.  In the man page:
>=20
> Which man page? Coreutils'?

I was quoting the dash man page.  I did quote the result of the
coreutils version of echo (/bin/echo) which worked correctly.

> Read it further:
>=20
>> NOTE: your shell may have its own version of echo, which usually
>> super=E2=80=90 sedes the version described here. Please refer to you=
r
>> shell's docu=E2=80=90 mentation for details about the options it
>> supports.
>=20
> By the way, 'echo -n' is non-portable, and POSIX says you should
> use 'printf' instead.

This isn't my problem.  I am trying to use dash as a replacement for
/bin/sh and it is failing horribly.  I am not the authors of the
problem scripts.  Plus, frankly, it is absurd to require printf where
echo [-n] should work correctly according to the dash documentation.

> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/echo.html
>
>  A string to be written to standard output. If the first operand
> is -n, or if any of the operands contain a <backslash> character,
> the results are implementation-defined.
>=20
>> $ echo -n testing -n testing
>=20
> Dash's implementation-defined behavior for -n is to treat it the
> same as every other string.  Thus, this is not a bug in dash, at
> least according to POSIX.

Either this is a bug in dash or in dash's man page.  The man page is
clear about how echo and echo -n should work.  But the reality is very
different.

>> This is causing me problems when I attempt to switch /bin/sh from
>> bash to dash.

This isn't stuff I have written.  This is stuff that I am tired of
modifying to be dash compatible.

Either dash's echo command should operate as documented or the
documentation should be corrected.

> It's probably not the only bashism you've been relying on.  You may
> want to try using checkbashisms=20
> (http://sourceforge.net/projects/checkbaskisms/) to help you find
> other portability pitfalls.
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

iEYEARECAAYFAlZECh4ACgkQVKC1jlbQAQfK3ACeN1EC20BVyzwnSXTndBCchYS0
tHkAoKANsc2eL1imSW6u8oSpJ9VaerOc
=3D20HJ
-----END PGP SIGNATURE-----
