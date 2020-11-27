Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_20,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04054C64E7A
	for <linux-dash@archiver.kernel.org>; Fri, 27 Nov 2020 12:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF795208D5
	for <linux-dash@archiver.kernel.org>; Fri, 27 Nov 2020 12:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgK0MW3 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 27 Nov 2020 07:22:29 -0500
Received: from cas.cat ([51.68.173.168]:36846 "EHLO cas.cat"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727455AbgK0MW3 (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 27 Nov 2020 07:22:29 -0500
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Nov 2020 07:22:28 EST
To:     dash@vger.kernel.org
From:   Pedro <pedro@cas.cat>
Subject: [bug] dash eats one line
Message-ID: <54057fbc-b0c2-8b56-9194-e8384238f275@cas.cat>
Date:   Fri, 27 Nov 2020 13:16:14 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="46y3LvQWAO2cwSWI9yiaMPTV4gsDjBR7h"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--46y3LvQWAO2cwSWI9yiaMPTV4gsDjBR7h
Content-Type: multipart/mixed; boundary="QnwVDq1AeljPyKGbAKaSqO22fr9arvl69";
 protected-headers="v1"
From: Pedro <pedro@cas.cat>
To: dash@vger.kernel.org
Message-ID: <54057fbc-b0c2-8b56-9194-e8384238f275@cas.cat>
Subject: [bug] dash eats one line

--QnwVDq1AeljPyKGbAKaSqO22fr9arvl69
Content-Type: multipart/mixed;
 boundary="------------E2B73D3375AAEFD175684E23"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------E2B73D3375AAEFD175684E23
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

I am using dash on debian 10 buster (stable release) which according to=20
`dpkg -S dash` is `Version: 0.5.10.2-5`

evilham encountered a bug where dash eats one line but not in freebsd's=20
shell nor bash

attached you can find an example to reproduce it

execution of the example in my computer (enableUFWRules is not in new lin=
e):

  ./dash-bug.sh
# Enable UFW rules only if requested (it was)enableUFWRules

  $ bash dash-bug.sh
# Enable UFW rules only if requested (it was)
enableUFWRules

and as extra reference, here you have some workarounds to avoid the bug=20
in your dash script [1]

Salut,
Pedro

[1]

failed

https://git.sr.ht/~evilham/cdist-evilham/commit/bf65172c8291ec4be71257605=
0bf7a4bcf462017

failed

https://git.sr.ht/~evilham/cdist-evilham/commit/1aa8b012200b0160e78a65520=
175bb224ffc9899

worked

https://git.sr.ht/~evilham/cdist-evilham/commit/8996e2b66531e6b54b52207ea=
5bdf3b71c795656

--------------E2B73D3375AAEFD175684E23
Content-Type: application/x-shellscript;
 name="dash-bug.sh"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dash-bug.sh"

IyEvYmluL3NoCgpTRVRVUF9VRlc9J3knCgpjYXQgPDxFT0YKIyBFbmFibGUgVUZXIHJ1bGVz
IG9ubHkgaWYgcmVxdWVzdGVkIChpdCB3YXMkKGlmIFsgLXogIiR7U0VUVVBfVUZXfSIgXTsg
dGhlbiBwcmludGYgJyBub3QnOyBmaSkpCiQoaWYgWyAteiAiJHtTRVRVUF9VRld9IiBdOyB0
aGVuIHByaW50ZiAnIyAnOyBmaSllbmFibGVVRldSdWxlcwpFT0YK
--------------E2B73D3375AAEFD175684E23
Content-Type: application/pgp-keys;
 name="OpenPGP_0x9D64597C3A982DCA.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="OpenPGP_0x9D64597C3A982DCA.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBFwTT0gBCACpCcJSv4ADrV8f6puGEXyGRxLdARePpMhY1LNQ4JmvDE4UGbkSHHp0A/SMw=
FnK
vhkc9oPrIoqTIcgfRRzr1JtYTwU3lNGQCawmrBOt5PoyHxbzE1YCpTW2Kxs/tGaBOtfnCC6ic=
8Sj
1MPiuyUvjnCpb8dABE2CmsEPVT+zSt0nSCmPbj2hHv6azs4wdjHhlZnnTTBbbnGU3atAoZHDZ=
0fE
SSxyfV92U0dTn0dYa8tWnnQuYNBDKu5UdB3hFdF61dmL+8yZqFcWwohlySvxHnuqKKW7/80Rp=
lkb
p5QQT/uBP4Cyad/DoCRuNLKdHTz0nsb86KqwOXQwCttLYbusVwhlABEBAAHNFXBlZHJvIDxwZ=
WRy
b0BjYXMuY2F0PsLAlAQTAQgAPgIbLwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgBYhBLAblhazw=
wE6
Jn7qc51kWXw6mC3KBQJeDcwPBQkD27BHAAoJEJ1kWXw6mC3K7HIH/j6eeoXopO+fHB1j37+gs=
Zey
HI6RiuCkQzGx7Rb8kAomg0awU1XuuYbU69hoOTSqzdqmnvUsCqFZKBmTHMtb+Cs7+4oebRPdV=
pQB
91UuhypEm4XchWi6vY1OjuvlrwenfOp0ZUrDPHeWePmEa6V0l04BQcm+mfOXQBBZCkd5pCStz=
woD
oBeLJXtiaOGYe2DjLnLvDxQh77mrFfdFMfI3nVCM920ByEWS8nQ/g/NtTHUVtceNwGp+17M1X=
sNs
xlEswWH00Vx88BWo6gSqk2h+pD6kQG0zpgEJBinHvGvsvCPsKpa85awMvt8vBpp46bbqFQigX=
+O0
zhTA1nGHDmDuV60=3D
=3DdhI/
-----END PGP PUBLIC KEY BLOCK-----

--------------E2B73D3375AAEFD175684E23--

--QnwVDq1AeljPyKGbAKaSqO22fr9arvl69--

--46y3LvQWAO2cwSWI9yiaMPTV4gsDjBR7h
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEsBuWFrPDATomfupznWRZfDqYLcoFAl/A7g4FAwAAAAAACgkQnWRZfDqYLcr+
OQgAo3I8NdueyaM1DbNGl9p8qF2jBMSbBfrG45OUpXksqlTNKeZTyJfRvHoYrpCVIugCM5W4T36M
xiqDJghU1vsWl5qCAz7fNiBW3MBIBz0cZdI0eisf0hxvDz6cG1NqfAbJcJL2BoOFb82Am+k4b5cd
dAH3q/zP+aOgB72cZYkriJTXLf34rJ2T5/WvPcn0S38JjHbtEhjoGxL67tmozaKQfWIMxa14al/O
sAEyL/9YLay9BExvFng3uNj7bua+/BZxZ/VrWHTiQ0PB+738v4EJjD3QO5qbW7kXu3XAxmKQ0hIN
WKPV2xOjfjWtOYNJnQq1EISJFC/BtFAQLs6lOjt8UQ==
=1ZBB
-----END PGP SIGNATURE-----

--46y3LvQWAO2cwSWI9yiaMPTV4gsDjBR7h--
