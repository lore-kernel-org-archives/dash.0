Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2ECC7618E
	for <linux-dash@archiver.kernel.org>; Sat, 22 Apr 2023 15:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjDVPQ2 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 22 Apr 2023 11:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjDVPQ1 (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 22 Apr 2023 11:16:27 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAC2FA2
        for <dash@vger.kernel.org>; Sat, 22 Apr 2023 08:16:24 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 4A7F164CE
        for <dash@vger.kernel.org>; Sat, 22 Apr 2023 17:16:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1682176582;
        bh=oRmGJEx1/MhY4N2bq0OJLQcx9HwXEzuJOqjSJc54/pE=;
        h=Date:From:To:Subject:From;
        b=lgF4VN4YPtSTQFtiQKq3kwrP1Lmm5OtxM+9SBZ81pEC+Wku2unzInXI1YWnNw/qo/
         ZUbfV2GCwMpNoBwg2wjjs/TiLlgKXjNd/fSJ3jdOuh1MMUGvNMf03uQiV5XvA3yj68
         clMNFkjuqyP1IjtXtUS8TYKnwqhI/5ELhPWQKh596uMonOP2gsca1ZCpWFOBy9I6Q3
         Zyv6/W0JxBt4Snv3fJRBOQAhDq1MZOhe6w+Oslzd6uRtq+XT+4VF/rBv2AWY9fyN8P
         +gM+O916vOLiiMiLjyA8PuUWHbNjScVMRZefjNgSaH6dLLRFtMwDDgi6QH628Xz6+o
         E/vCQnfywf5Rg==
Date:   Sat, 22 Apr 2023 17:16:21 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     dash@vger.kernel.org
Subject: [PATCH] man: document what happens when IFS= (and when it's not)
Message-ID: <rgn7yvfaitifvmsx7tsu3bicrcrqjbhkai7jdj6q5ja3ccrq3o@musfjdmv7egg>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rcxsnmyovk424rr5"
Content-Disposition: inline
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--rcxsnmyovk424rr5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

A question I just got from a user was "how do I make while read -r l; do
=2E..; done < f not strip the initial tabs?". Turns out, the manual is
silent on this, and POSIX just about implies this behaviour.
(Indeed, our read is almost verbatim POSIX, and both defer to Field
 Splitting, but our Field Splitting isn't nearly as detailed,
 and thank god.)
Even POSIX spends just one line describing this pivotal behaviour
(Issue 8 Draft 2.1 line 75044-75045:
"2. If the value of IFS is null, field splitting shall have no effect,
    except that if the input is empty the result shall be zero fields.),"
and when I first encountered this it was also quite surprising to me.

Spell it out explicitly: IFS=3D means that input is preserved,
and the default value means whitespace is stripped from the front.
Drive it home with an example because it's esoteric (and I know from
 that user that they first tried searching for read in the manual,
 but it was not very helpful).

Reported-by: rozbrajaczpoziomow <rozbrajaczpoziomow@gmail.com>
---
 src/dash.1 | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/src/dash.1 b/src/dash.1
index d3893bc..bd4c662 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -1021,6 +1021,19 @@ .Ss White Space Splitting (Field Splitting)
 .Ev IFS
 as a delimiter and uses the delimiters to split the results of parameter
 expansion and command substitution into fields.
+.Pp
+If
+.Ev IFS
+is empty, field splitting yields no fields if the input string was empty,
+and one string with the unchanged value of the input otherwise.
+For example, with the default
+.Ev IFS ,
+.Dq Ic read Fl r Ev l
+will remove any initial whitespace,
+but
+.Dq Ev IFS Ns =3D Ic read Fl r Ev l
+will leave the entire line in
+.Ev l .
 .Ss Pathname Expansion (File Name Generation)
 Unless the
 .Fl f
--=20
2.30.2

--rcxsnmyovk424rr5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmRD+kQACgkQvP0LAY0m
WPEQPw/+O9oV1JYQglivLlilCf7DWkOrocIgC71PXNr+WoL+VjZkz4ICBHS5MFni
DcEXUOaGcnTSJqkrkig8bAyjH+nsywhksMFJHicQ1JDZg4Gg46BBNCju36X2YRL1
M999UJBZkJBlQYP99s/hHdNzOjyUmyutFrLOr7k+JBR9B3GxjfwJyZ0m6PV95FoY
ZKhxBag/DZpnRgBJ0mbamrzySmbWQlhb2o1lZGd5pj2R4ey+I9dZ6QN0hnaF11FE
9OhM+KKzXPG/7Mlr1Yxoj3SzqSnb3XPlhsMwAOZZnyZRSBFJcUgZm0KLOpYdaPWm
0Nt2EyTuH8f5gQKwy38aH0FdECl5j3Ou5HsXJx2hmamIhkEdPrkskcEoxXnNhxCC
HDtPrAFreT42YQfW7Uj9xsWVY3/1Gv20RuUTQyoB9LAA60ZXjT4Px40sKuurmjjU
LVHGbTy6+DuQUYjtiiHMYRIXn1rGh6wNW39+CzKdYdxkwIXLgJuYafCud4SF8rJj
M+VMRVgbGYGm2n/ri/WQIM4ZQXQj+qYyTpL/lTO6I788YT8MzIavw9mDjD+JyKog
tT89ZRdSxt2dCQknHZVqGvernHRyCfBVy6isRdM8PjBHZQsT8K5UvwaIuXRsbhct
KN4Gm2AB37QZHpvTDwsZtGmz1fJoAskxpMd55rDfPjoTybM0niY=
=4k66
-----END PGP SIGNATURE-----

--rcxsnmyovk424rr5--
