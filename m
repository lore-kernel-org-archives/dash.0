Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0978EC4332F
	for <linux-dash@archiver.kernel.org>; Wed, 14 Dec 2022 01:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237608AbiLNBFo (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 13 Dec 2022 20:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237605AbiLNBFn (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 13 Dec 2022 20:05:43 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 350B31D302
        for <dash@vger.kernel.org>; Tue, 13 Dec 2022 17:05:42 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 45C62141E;
        Wed, 14 Dec 2022 02:05:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1670979940;
        bh=hE+rR1oQhY6zssBkeivqf9vGGyhYvWuJ6mrAyHCHCAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K3OlXDqhPGuOyGr7udmiL/GixpPRHFN0kiyHB2+vvdMMpqbDLgTaIpL3KmwF9VD9A
         nUT3BHZM2vect7XQPwPQ+77TJMcJPEm9oKBCs8q65kGWY6E47mHwBtQuiLEMLz1iMU
         x4SuDbP40cwDpfvj2BppOpVrbFrlM+xXHixpoaQfHIWoeUJFDlTgtp4ufBjgANanxt
         u5i00UlqpE+7P+whw+GM1ct2YeVF/9jteBBX7EJO4OKk6LuGQGIfhSyVVoInu9uQF5
         qp6eDgrmDp2kXpcmtAN2FsDmUqjsjzFMo01tXJ2bUiIoslcQTsZwyer+Mze2o6Sxhu
         sCmE0QG8rIYhQ==
Date:   Wed, 14 Dec 2022 02:05:39 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     dash@vger.kernel.org
Subject: Re: [PATCH] input: preadfd: read standard input byte-wise
Message-ID: <20221214010539.g3zy2jtzdrhsyrrz@tarta.nabijaczleweli.xyz>
References: <20221213221732.6mvv22u7ktdozrbx@tarta.nabijaczleweli.xyz>
 <877c8c0d-c7a3-6c56-0564-55080837f0a1@gigawatt.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3k7cljebhjyfczu7"
Content-Disposition: inline
In-Reply-To: <877c8c0d-c7a3-6c56-0564-55080837f0a1@gigawatt.nl>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--3k7cljebhjyfczu7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Tue, Dec 13, 2022 at 10:37:12PM +0000, Harald van Dijk wrote:
> On 13/12/2022 22:17, =D0=BD=D0=B0=D0=B1 wrote:
> > Reading the standard input byte-by-byte is the obvious solution to this
> > issue, Just Works, and is how all other shells do it (we could,
> > theoretically, read regular files block-wise, then seek within them aft=
er
> > parsing, but the complexity out-weighs the rarity of running
> > sh < program; we could also do whole-line reads on teletypes in
> > icanon mode, but, again, the gain here is miniscule for an interactive
> > session, and the teletype mode can change at any time, so...).
> > Naturally, we keep reading block-wise for non-standard-input.
> There are a few things to consider here:
> - Not all shells do it this way. bash does do the block-wise read,
>   followed by a seek, when stdin is seekable. While I agree that it is
>   not necessary and not worth it, you specifically say that other shells
>   do not do this. That's simply not true.

Yeah, I wrote the parenthetical way after the rest and didn't think to
reassess them in consort (it appears that ksh93 seeks, zsh doesn't).

> - This patch breaks internal assumptions in dash that the buffer will
>   contain a full line, affecting error recovery. See below.
> > --- a/src/input.c
> > +++ b/src/input.c
> > @@ -195,7 +195,7 @@ retry:
> >   	} else
> >   #endif
> > -		nr =3D read(parsefile->fd, buf, IBUFSIZ - 1);
> > +		nr =3D read(parsefile->fd, buf, parsefile->fd =3D=3D 0 ? 1 : IBUFSIZ=
 - 1);
> >   	if (nr < 0) {
>=20
> With dash 0.5.12:
>=20
>   $ | echo bug
>   src/dash: 1: Syntax error: "|" unexpected
>   $
>=20
> With dash 0.5.12 + your patch:
>=20
>   $ | echo bug
>   src/dash: 1: Syntax error: "|" unexpected
>   $ bug
>   $
>=20
> I had implemented the same change in my fork, see <https://github.com/hvd=
ijk/gwsh/commit/d279523041c1c380d64b6dec7760feba20bbf6b5>
> for the additional changes I needed to get everything working.

It's interesting to see that the line error bug appears to blame back to
start-of-git(?), and the partial line consumption is triggerable =E2=80=92
with vastly more pathological input, admittedly =E2=80=92 on unpatched dash=
 as
well. I've imported the other fixes piece-meal, and the updated
series (in follow-up), passes all cases in your commit message as well.

Best,
=D0=BD=D0=B0=D0=B1

--3k7cljebhjyfczu7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmOZIWIACgkQvP0LAY0m
WPG+Ag//cRFBU3ZnQZOGn9U6S1v6FjkO8wg4Je0GM6s+MzkKrkuL46UsnCsfLp2z
OndsaoE/ow0JtF54FaX+4qQ3yKxWCU3iPeBanefOQFs96DSZq+6f97zkTSPCr0du
2wQlzpyRWd9ktU5KEDyIChQc6LnLHTEkR22QRl20/mb+kmRAsEj9G+2/FbOaLbxP
RQm6iU5Ud/Tc7pnXdwtW916DtqbeEZGV0a6lDH6vZcxuh9HIsdgJASt9UTw8oX1g
4DjdN4OPn2xlpTwjHJEO2tJ4RPDtvEINipg2bFY/dTUxXugkFi/IMIU+fSEgWUtF
oE6qxODvTutCWUtcBKI53wTygvgXKvXktKkWM/ud1SFpIuB6lg0z47gVIjYQVUOi
IWVKQlPRRyLBRm3Rc/Ax5l9LN2E2K1qa5FIhF+iOR9OLvnxr2gmmlpsm58b+pbmj
DtwwIfaBOtpgvT5q8Tc9xT0YSvaTUwXs6bDWFx5Vru1owfoFVDHWqBTN0373DOsY
LxmYQ8chFy7p2YW4hbiKWV9O00c0Omt/qNMppj6Fglm7QtAc1JbdXcMrqhU/QzEI
xNbn9CZ+oG84UsuKpRz7SFs3E+5lWTTWxw0GYZoErYZseL4BqPcWqSosblKiqRlz
FOIDyMI0CGamuiR0PbonTnHmkKZH4sWddXk1+i9Kyf5YRGNkwBY=
=nnQ9
-----END PGP SIGNATURE-----

--3k7cljebhjyfczu7--
