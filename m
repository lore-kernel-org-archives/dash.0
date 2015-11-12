From: Kevin Korb <kmk@sanitarium.net>
Subject: Re: [bug?] echo -n does not work as described
Date: Thu, 12 Nov 2015 11:55:27 -0500
Message-ID: <5644C47F.2060008@sanitarium.net>
References: <5643F1B2.5050207@sanitarium.net>
 <20151112100329.GA1841@kralicek.brq.redhat.com>
 <5644BBDC.4000108@sanitarium.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from asylum.sanitarium.net ([24.173.162.174]:61895 "HELO
	asylum.sanitarium.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752878AbbKLQz2 (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 12 Nov 2015 11:55:28 -0500
In-Reply-To: <5644BBDC.4000108@sanitarium.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

=46or future reference, I did some reading in Gentoo's bugzilla...

Apparently the Gentoo devs broke dash's echo -n on purpose.  Their
intention is to cause any shell script that is called with /bin/sh to
fail if the script uses echo -n.  However, they didn't limit this
behaviour to dash as /bin/sh as it happens as /bin/dash too and they
didn't modify the man page and they didn't break bash this way.

So, I am calling this a stupid Gentooism and I am forking their ebuild
for my own systems with that patch commented out.

On 11/12/2015 11:18 AM, Kevin Korb wrote:
> AHA!  Now we are getting somewhere.  I compiled dash myself and it=20
> behaved properly.  I then tracked my problem to this Gentoo patch:=20
> https://gitweb.gentoo.org/repo/gentoo.git/tree/app-shells/dash/files/=
d
as
>
>=20
h-0.5.8.1-dumb-echo.patch
>=20
> So, apparently my problem is with Gentoo not dash.  Thanks for
> helping me figure that out.
>=20
> On 11/12/2015 05:03 AM, Petr =8Aabata wrote:
>> On Wed, Nov 11, 2015 at 08:56:02PM -0500, Kevin Korb wrote:
>>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>>>=20
>>> I am on dash version 0.5.8.2 on Gentoo Linux (USE=3Dlibedit=20
>>> -static).
>>>=20
>>> The echo builtin does not work as described.  In the man page:
>>>  echo [-n] args... Print the arguments on the standard output,=20
>>> separated by spaces. Unless the -n option is present, a
>>> newline is output following the arguments.
>>>=20
>>> However, in actual usage: % dash $ echo testing testing $ echo
>>> -n testing - -n testing $ /bin/echo -n testing testing$
>>>=20
>>> This is causing me problems when I attempt to switch /bin/sh
>>> from bash to dash.
>=20
>> Hmm, where does the 0.5.8.2 version come from, I wonder? The
>> latest release is 0.5.8 [0] and I cannot reproduce your issue
>> with it on Fedora [1] (and note that, afaik, Fedora doesn't apply
>> any special patches that could affect this behavior).
>=20
>> Try rebuilding dash with USE=3D-libedit and see if it changes=20
>> anything.  If not -- I would bug the Gentoo maintainers.
>=20
>> P
>=20
>> [0] http://gondor.apana.org.au/~herbert/dash/ [1]=20
>> dash-0.5.8-3.fc23.x86_64
>=20
>=20
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

iEYEARECAAYFAlZExH8ACgkQVKC1jlbQAQcWQACg92JXp/RNRl5Bw3qGeFzQF8hq
aXIAoK13wl6ELE9BEfFjRd1qJoWk26lC
=3DxFAp
-----END PGP SIGNATURE-----
