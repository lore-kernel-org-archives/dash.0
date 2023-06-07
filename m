Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF6DC77B7A
	for <linux-dash@archiver.kernel.org>; Wed,  7 Jun 2023 13:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239338AbjFGN0g (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 7 Jun 2023 09:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240400AbjFGN0e (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 7 Jun 2023 09:26:34 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DFE595
        for <dash@vger.kernel.org>; Wed,  7 Jun 2023 06:26:28 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 6FFB2A080
        for <dash@vger.kernel.org>; Wed,  7 Jun 2023 15:26:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1686144384;
        bh=qA5FPyyuIeeDO+I/iZN3cOt7KypErfXukYIEi8tZ8NQ=;
        h=Date:From:To:Subject:From;
        b=RXUXf5zmmOll1KeqBg+VTAQkxe7S2YLV1TMutP9FbbvdzB/i1r7KYkjff1SyWYchm
         hVmoVMm9E345dPXpVP+Dy9+N4zpgawnaINJ+TzlNO3DhykCVtqgBU/WZTzswbcd/Wx
         F1dSuZRa8pPKUVKe9+RgdMW0u1fmpWudDh8fjibWxX2ZS/GmhHhH49gi5M3GU2JTbV
         h/Ey/Ll160hdwEbR1S6fuxFWGsxK3AnDwy5Puy0Fhv6ZQXJwN/T5JBnMk1TEqyKD4y
         F9krZHsSp/tZ01xAT1Ib7AhR440BzkhNfJhP8Rp37uKGg7Ru5pK2h5q7kcEka+93qM
         h7FLUz8+GUChA==
Date:   Wed, 7 Jun 2023 15:26:23 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     dash@vger.kernel.org
Subject: [Debian#1037195] dash: $(here-doc in <<substitution) is always
 empty, must consume subsequent lines per POSIX?
Message-ID: <7ygxq63mk22evfzirlilu4eexc2q44uul6zsade73om5hgbvj7@a6er2aqswli7>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="42knarkebbhvxtwz"
Content-Disposition: inline
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--42knarkebbhvxtwz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Forwarding from Debian #1037195:

bullseye (0.5.11+git20200708+dd9ef66-5),
sid (0.5.12-2) and
git (b00288fd28c1b39d0f1531b6e6d86de59de4be8d)
dash observe the following:
  $ cat -n boment
        1  echo "$(head -n1 <<EOF)"
        2  # 2
        3  # 3
        4  EOF
  $ sh boment
 =20
  boment: 4: EOF: not found
  $ sh -x boment
  + head -n1
  + echo
 =20
  + EOF
  boment: 4: EOF: not found
  $=20
This agrees with bullseye bash (5.1-2+deb11u1) but not sid bash
(5.2.15-2+b2), which outputs "# 2" (and a warning);
I believe that bash is correct here (sans the warning).

POSIX Issue 7, XCU, 2. Shell Command Language says
   2.7.4 Here-Document
 =20
  The redirection operators "<<" and "<<-" both allow redirection of subseq=
uent lines read by the shell to the input of a command. The redirected line=
s are known as a "here-document".
 =20
  The here-document shall be treated as a single word that begins after the=
 next <newline> and continues until there is a line containing only the del=
imiter and a <newline>, with no <blank> characters in between. Then the nex=
t here-document starts, if there is one. The format is as follows:
and its counterpart in Issue 8 Draft 3
  80601  2.7.4 Here-Document
  80602  The redirection operators "<<" and "<<-" both allow redirection of=
 subsequent lines read by
  80603  the shell to the input of a command. The redirected lines are know=
n as a ``here-document=E2=80=99=E2=80=99.
  80604  The here-document shall be treated as a single word that begins af=
ter the next NEWLINE token=20
  80605  and continues until there is a line containing only the delimiter =
and a <newline>, with no
  80606  <blank> characters in between. Then the next here-document starts,=
 if there is one. For the
  80607  purposes of locating this terminating line, the end of a command_s=
tring operand (see sh) shall be
  80608  treated as a <newline> character, and the end of the commands stri=
ng in $(commands) and=20
  80609  `commands` may be treated as a <newline>. If the end of input is r=
eached without finding the
  80610  terminating line, the shell should, but need not, treat this as a =
redirection error. The format is as
  80611  follows:

That is, as I understand it:
  echo "$(head -n1 <<EOF
  abc
  def
  EOF
  )"
and
  echo "$(head -n1 <<EOF)"
  abc
  def
  EOF
are always required to work, and Issue 8 allows shells to have
  echo "$(head -n1 <<EOF
  abc
  def
  EOF)"
work as well.

Either way, this looks to me like a POSIX violation?

Best,
=D0=BD=D0=B0=D0=B1

--42knarkebbhvxtwz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSAhX4ACgkQvP0LAY0m
WPEaxw//c5eZnG/0R9MH7p8EBbojkL1jm6UhlBAvpwSMucZijmYV12zuozgrz1HU
B1Iw1vlH8wm9mA51V8cc+4fl96HlLz3ZH6+2P7yTd623JefuJC/ZnHXptOEuY1F3
h1YleOGJMxDjgwHNpSYaXuyVb8kO5tI3GOh6efEY8ZO17MHIBWJpJFsK+8Etl5M9
tYt7PlIC8Zdehvn0d2oItNauXFuc9Khe8cCehp+kMy/Q/BdktigQDEiCpUgwVuSu
LPJ7qorwntc+HuCYLY33RRUxO//VN/SY2LVL9vEw2jikbYy0u19YHHbiVFGQml6d
P68KLTjC1eAIfp9JASlpIZOb9hB64u70DNTovvz+rqHy4PRhuiasH3ydRdTx0OaG
DHom2ry137xVs85jGTHNlWT+B2YPDQcPUfBNYPfKCalKsDY/NlHHrgQy1bJ2sAFA
+F39ZDMJnaBGJgcpUiA2pucG8dMRGZL3frtMIWikJP+gyngWjU9rygSkj2/x+23m
eiYgHOQtQE4ajfIZiojv0SYiE96anpGvIyuC2JNwlzUctj1xldjalk28/e+Nnvxq
mihGUGDugnK4zhWa02ApBMJ3Kil7GO/zlltywBiAyNOvEszqLV51g3rACgADzrJi
DtnfBYP8eAzFpeXQ2eYAZqAhTjS+IFjgJQ61k6TrA3fCopCgp9U=
=zjYs
-----END PGP SIGNATURE-----

--42knarkebbhvxtwz--
