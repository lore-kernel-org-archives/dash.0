Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EC3C5479D
	for <linux-dash@archiver.kernel.org>; Wed,  4 Jan 2023 12:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjADMyn (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 4 Jan 2023 07:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbjADMy2 (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 4 Jan 2023 07:54:28 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8050813EA3
        for <dash@vger.kernel.org>; Wed,  4 Jan 2023 04:54:25 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id DDD813C2;
        Wed,  4 Jan 2023 13:54:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1672836862;
        bh=yYAuUiU/GTQ0K/JeKXNO/RrbhH4kPfN34boAYf6DVTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ros5IV5U0kmN4fdmvcjBOPq/NZGUNhbcKtSOewnvxOOkbaKdHLeCvUOgXAqHLiQzN
         fIKeO6xU2bp0snaZSLsyl/9PFD6N1X6qsQmY8Un+7Qg9KT0r72Vm5bASAEx33uSC+3
         EzSDIh7yg7FCiBlbc7CACaoSH1hezmDFV6XupVtGn/fIxi5+hFDUtHAvmaDCEJi/Us
         p5St7zBjvAM8S8dQM2qA3DoWS0z4FkMLV84cW63VK9brcVDSq6lxQ7/HP3xmPi+PXG
         mbUYkpUDf63gitT+zGTR2iOBSFVIffwE/19oyHsBsFL/WuAm7V1/AcBqW1lxsM4ke0
         /81vCRLe+sn9Q==
Date:   Wed, 4 Jan 2023 13:54:21 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     dash@vger.kernel.org
Subject: Re: [PATCH] var: Do not add 1 to return value of strchrnul
Message-ID: <20230104125421.rmjbjzme7a6qbxhx@tarta.nabijaczleweli.xyz>
References: <20221214023130.u7pn4ca6ma4kuxot@tarta.nabijaczleweli.xyz>
 <Y7P33bSfbmpe7EI/@gondor.apana.org.au>
 <20230103122619.bhvn7lep5avoanji@tarta.nabijaczleweli.xyz>
 <Y7VOEx/cE4vQZ0zE@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k2rep3bkp5bkrb6u"
Content-Disposition: inline
In-Reply-To: <Y7VOEx/cE4vQZ0zE@gondor.apana.org.au>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--k2rep3bkp5bkrb6u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Wed, Jan 04, 2023 at 05:59:47PM +0800, Herbert Xu wrote:
> On Tue, Jan 03, 2023 at 01:26:19PM +0100, =D0=BD=D0=B0=D0=B1 wrote:
> > > However, I don't think we need to pass the flags to the action
> > > function since none of them care about whether it's unset.  We
> > > just need to pass a pointer to an empty string rather than some
> > > bogus pointer.
> > This, unsurprisingly, produces the same error, because getoptsreset()
> > needs a valid number for OPTIND:
> >   $ src/dash -c 'unset OPTIND'
> >   src/dash: 1: unset: Illegal number:
> You get the same result with OPTIND=3D"" so I don't see the issue.
Which is an unrelated operation, and obviously nonsensical.
It's good that it fails.

> Am I missing something with respect to POSIX?
AFAICT, after trawling through the Issue 8 Draft 2.1,
there are no special provisions for unset/OPTIND,
like there are for readonly.
(See the other branch of this thread, but to summarise:
 setting LINENO, OLDPWD, OPTARG, OPTIND, or PWD readonly /must/ fail in:
 (a) readonly xor (b) the builtin that edits it xor (c) on assignment.)
This indicates that "unset OPTIND" must behave as-specified,
i.e. unset OPTIND and remove it from the environment.

In dash, this really only affects OPTIND, since the only other special
variable that parses an int is sethistsize(), which explicitly has
-- >8 --
        if (hist !=3D NULL) {
                if (hs =3D=3D NULL || *hs =3D=3D '\0' ||
                   (histsize =3D atoi(hs)) < 0)
                        histsize =3D 100;
                history(hist, &he, H_SETSIZE, histsize);
        }
-- >8 --
which considers HISTSIZE=3D and unset HISTSIZE to be equivalent;
the only other setter function that inspects the new value is for PATH,
and working out to the empty string works for that case.

We could also pass NULL when unsetting, I guess, since sethistsize() is
already equipped for it, if you prefer to not have a flags argument?

Best,
=D0=BD=D0=B0=D0=B1

--k2rep3bkp5bkrb6u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmO1dvsACgkQvP0LAY0m
WPFi1Q//SE7oESkDgdVNc0aoGiGTYZ94idhAU59Hwb5MIn19hbSEsOxFRC2Ycxfm
9WCaQAuTO4f9CUm25heQ0IW3PvPKt+46v54V69EAKU5zlKb57zQsqwJ4RB3geFS+
l+DgkEMVdtE0RIb1QGzwkzjaJd00Vn35v/yOfqZncjO8sDr6d7hgWuz5FI/zXb4e
O/Vhm/IRu8aMJDy5LIhR3UIMAVI9Um986T8PwaHkpt0TLilZrE0aGNDjcgLs2orY
28TiMtzompN0hMEo0eiowRv0Pw+ueDR4V3Q+Gp1QsDQ7YQuf6++VZA3Ag5U2cN//
6C72PicVAVJO81RoVl8K+RhucZDBFefqFRt5r95zTm1cjEalKkYhqs5e84WgA6Bl
OKvvD0N2dVYKLQPG5rAseah97TcD2HeuBgCs2mYSyIn+prPujiVlJ9sFtqVqEgy3
13l5b7hgSI5Oq8oBv+Dljm+qDHt/gX8q2zqQEXviuhppnaOUONUxA3k7H06TX+Ip
YnfCVxyS7AMCa+YCwBgTwyejgJ92cguj0bkkx8Ga20srfM3Rvson34MsxaCMOmMv
paEXB+66duzzYLP5uEcJXUfDpaeZ9iZFGEIG8nvdh5c4GpIb4+bGONjWSStOfHpA
/3r/rFBEMD/lyt7pqW0qrzlquWNdPfU2rA0eDf/U9ttWIWOy4/s=
=B6yB
-----END PGP SIGNATURE-----

--k2rep3bkp5bkrb6u--
