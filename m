From: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] Set LC_ALL instead LC_COLLATE in mkbuiltins
Date: Thu, 21 May 2015 22:40:19 -0600
Message-ID: <555EB333.6000201@redhat.com>
References: <20150522042531.GA30829@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8KtCVU3oJm6Nh5t2HkFH8piaTe42qnorc"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60462 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932279AbbEVEkV (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 22 May 2015 00:40:21 -0400
In-Reply-To: <20150522042531.GA30829@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>, Fredrik Fornwall <fredrik@fornwall.net>
Cc: dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8KtCVU3oJm6Nh5t2HkFH8piaTe42qnorc
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/21/2015 10:25 PM, Herbert Xu wrote:
> Fredrik Fornwall <fredrik@fornwall.net> wrote:
>> In mkbuiltins LC_COLLATE is set, but since "The value of the LC_ALL
>> environment variable has precedence over any of the other environment
>> variables starting with LC_"
>> (http://pubs.opengroup.org/onlinepubs/7908799/xbd/envvar.html), this
>> has no effect when LC_ALL is set.
>>
>> This breaks when having e.g. LC_ALL=3Den_US.UTF-8 during make, which
>> causes the test case
>>    dash -c :
>> to fail, probably due to broken ordering in builtins.c. The patch
>> corrects that by setting LC_ALL instead of LC_COLLATE.
>=20
> This causes any errors printed by sort to come out in English.

Why do you care whether any errors printed by sort are in the "C" locale
(in English) rather than localized?  Ideally, there won't be any sort
errors in the first place, because this tool is run on controlled input
as part of the build process.

>=20
> Please fix this by simply setting LC_ALL to empty alongside
> LC_COLLATE=3DC.

Setting LC_ALL has the nice property that LC_COLLATE and LC_CTYPE are
guaranteed to be compatible; if you just set LC_COLLATE but leave
LC_CTYPE unchanged and unset LC_ALL, it is possible to attempt a
collation that assumes one character set while still living in a ctype
that assumes another, and get garbled results.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--8KtCVU3oJm6Nh5t2HkFH8piaTe42qnorc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJVXrMzAAoJEKeha0olJ0Nqko0H/1TswLfqb+4GTAO8ZOiwroaf
xUe6QTxbyfZwp8Jtsm8JZ43u5CDOb5ARQp6yu6EVZETmzYBtpxZ4DR3T3fqpW2PJ
TL92Zd27UxRCGjZzM9hBlG9zuq3u7bOc/lRFaimx7mZbE+KwjmzYU+KXN+RdP/Zu
AFCAja0SWo/CMA3UPYupKyLkZIfWG7XJFO/0AdqKg/TvRJdcjEuCTKvHwohtHVyn
rnMrAgWv5ecicJkgFkJOxThih5G0tIR/le4Eqyq06cSufIVc1A5YcxfgBHvIY2vT
BJGWfzO++A/i91lv6873YqKjHZuBKUdATqN6Jk1krKalBpkd4FuBVrwCsGKEwGU=
=qkqh
-----END PGP SIGNATURE-----

--8KtCVU3oJm6Nh5t2HkFH8piaTe42qnorc--
