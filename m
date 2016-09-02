From: Eric Blake <eblake@redhat.com>
Subject: Re: Parameter expansion, patterns and fnmatch
Date: Fri, 2 Sep 2016 09:49:53 -0500
Message-ID: <dd9729a1-ce0d-8549-b52a-9d205740858c@redhat.com>
References: <20160902140437.GA12639@gondor.apana.org.au>
 <6f39229b-7196-afd9-8e8f-3db1c33bf80a@redhat.com>
 <20160902142928.GA13022@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PotW02dj35jnA6gHIoJwivW0J8E2pwH5w"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44116 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751454AbcIBOtz (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 2 Sep 2016 10:49:55 -0400
In-Reply-To: <20160902142928.GA13022@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Harald van Dijk <harald@gigawatt.nl>, olof@ethup.se, dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PotW02dj35jnA6gHIoJwivW0J8E2pwH5w
Content-Type: multipart/mixed; boundary="QajmSuqr1n2DLLgxPeV7fqNQHu36rlBF4"
From: Eric Blake <eblake@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Harald van Dijk <harald@gigawatt.nl>, olof@ethup.se, dash@vger.kernel.org
Message-ID: <dd9729a1-ce0d-8549-b52a-9d205740858c@redhat.com>
Subject: Re: Parameter expansion, patterns and fnmatch
References: <20160902140437.GA12639@gondor.apana.org.au>
 <6f39229b-7196-afd9-8e8f-3db1c33bf80a@redhat.com>
 <20160902142928.GA13022@gondor.apana.org.au>
In-Reply-To: <20160902142928.GA13022@gondor.apana.org.au>

--QajmSuqr1n2DLLgxPeV7fqNQHu36rlBF4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/02/2016 09:29 AM, Herbert Xu wrote:
> On Fri, Sep 02, 2016 at 09:25:15AM -0500, Eric Blake wrote:
>>
>>>> This also affects
>>>>
>>>>     case [a in [?) echo ok ;; *) echo bad ;; esac
>>>>
>>>> which should print ok.
>>>
>>> Even ksh prints bad here.
>>
>> So ksh is also buggy.
>=20
> Good luck writing a script with an unquoted [ expecting it to be
> portable :)

[ '' ] || echo empty

There, I just wrote a portable script with unquoted [ portably
interpreted as itself and not as a bracket filename expansion pattern.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--QajmSuqr1n2DLLgxPeV7fqNQHu36rlBF4--

--PotW02dj35jnA6gHIoJwivW0J8E2pwH5w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJXyZGRAAoJEKeha0olJ0NqMI0H/2q12c2ZVGAbGDo9t5OiJZJs
vmFSDA3seV57whcCmdJj4MzouKOEcFG/+TckYSi5spFa4Of4MbZl2t35BQv/Z62W
hvLnSsOQFEJyQXUAXNZyA+71UWtGKN7cHopINZOMrhA9dJ+Y9lq71zMSId61HMqg
H1OD395OU8pXzXQuu3rKllsO92HgcJSI/vfVc0Xm8WzQ+WXtKY54U1mxGszKZIh7
hwhipjzPtE18tMldmB1goSsD1Q+lBSAFE/PTXIQB4vSY/5yp1FKQSvtkMoyhi7Xy
7w6GeAfR8rBKmdhJbFrhU0AQRvZFxGjiIw7Eq/aGr4sZZwCrzrkj9x2f4CFIqy0=
=bssd
-----END PGP SIGNATURE-----

--PotW02dj35jnA6gHIoJwivW0J8E2pwH5w--
