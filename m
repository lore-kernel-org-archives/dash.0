Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244CBC00140
	for <linux-dash@archiver.kernel.org>; Thu, 18 Aug 2022 15:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343978AbiHRPCW (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 18 Aug 2022 11:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343960AbiHRPCV (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 18 Aug 2022 11:02:21 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 601C5BD134
        for <dash@vger.kernel.org>; Thu, 18 Aug 2022 08:02:18 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 07DE8143C;
        Thu, 18 Aug 2022 17:02:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1660834936;
        bh=DbONsGOHHKumrzURwmi1pwt3qyEE5xWPZjzTaxuQtOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nnHTwnX1UhFAmL0OwZHbcXDhAe8m/risOSrnj/xxJKTnAxuXmZ81Kic1/fPzJ5J9I
         VE19SPjPw6mUdicpFaxdC4yG89Kzuj+6J2GU0pIWzuE8De9qgIA/iQ5c5XQQ3Oq8iE
         K+aRQujoVdTjMZrp32QCRxHYwk7vDLb8UAhnqEPbJJ/XQpg/jX42+IHgJg4CAXMnul
         tABmn7JbiuyYzYppYAFiXpII3hGuQ0KtzVE76bqOB9d5qENgdhbrhWXctLTG1mdo58
         C3uTyjgCkskJQClT7WFAnJK/yMzajvQx9EMtMhAb6c4mAzkohF831ep8yyRNybwiT3
         3cntYcwGM1APQICxM7n5TN0MukbcUwth6GZc9Xf31yB1PX/7Jn3Ey9MSarsmpV8aue
         D7AlVMxqxc8c+IurBRje9Fla4vpBqN7V3Y0uAihAYeZWuUk5BUGea8H1dldhUlP7KV
         OCSMSvDcCw2TPpd2ggr7Sr7hWDuQZ5mSjoDCUOBmuQwOvtpbTeMvsE5Rq+CGh7kiTM
         2LgKmEydXbav9TcKOHhnGmrr/QD/Hh2EyFjVYGcaBcOFgjdCVRVUMzey6MLAtQ3SDp
         g4PRNisNc8CGpfxMUkJw6sTiwp34MI9Ro30Z0DJbkfoLN7shmuGGuxUGR3Fl6Mgx7+
         3C5rU8LATLB8UOUV3RMZWN3g=
Date:   Thu, 18 Aug 2022 17:02:14 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Michael Greenberg <michael@greenberg.science>
Cc:     dash@vger.kernel.org
Subject: Re: Fwd: Bug#1017531: dash: for/while/if suppress errors from
 redirections with -e
Message-ID: <20220818150214.opbaqiyam7zpnmad@tarta.nabijaczleweli.xyz>
References: <20220818114412.zeqv5auujpuvfskk@tarta.nabijaczleweli.xyz>
 <m2sfltskbi.fsf@greenberg.science>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hmhuzdixovwn645i"
Content-Disposition: inline
In-Reply-To: <m2sfltskbi.fsf@greenberg.science>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--hmhuzdixovwn645i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 18, 2022 at 10:22:25AM -0400, Michael Greenberg wrote:
> Also: what version of bash are you running? I suspect the fix to this in
> bash is fairly recent.
5.1-* off Debian; a simple default-config build+./bash -ec ... check
across the distribution tarballs shows that 4.4.18 and 5.0 are broken
in the same way as dash (and like your transcripts show),
but 5.1 produces the correct output.

=D0=BD=D0=B0=D0=B1

--hmhuzdixovwn645i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmL+VHQACgkQvP0LAY0m
WPHh1BAAmpKbhsbperOJ2ZUzWl35lDjbcbZYtzdzk98jSNEzJlQe29R88v9qQuec
E3PVcjSPYsEgy30dLnjudqPIRNOLzlt29zVh0LkaC/1eIkrcDUG2gN77o6+vg+S3
psf4HZnpLNTL+RhzYI4w3vN18dwQq4zxP3pE9WFqQw8YVQhCERkN538I6MQ2YBKS
A3FvpGtcjLUkaL3yhwjF7AGqu0vg+Cr/xPJpYXQjNpiEne8OwbNL+j1DynF7D5BJ
I2XvKckWLwNGi/5pdNYwBLTWNqgdRi0njHi97Ii/G+XWxkIOGIEi9Rsa41wZr206
jvttngRsI7wJ9QXZ/Z1sYEPQxefqmPcjkDeA3HAW1VvACEvu6o/Wk1eNG4mYjo/m
bA8y81DCoAIcUeanHNStAvk5IhXUECaEXG5Trlsl74u/BF+b64Aq+Ym3OFwM9DYE
1sKyVQHhbh8JocpVQMd30zQqknJmmaDlthaaNc3j5UkCkHlzZe8N23L+t4eF1ntY
xh4zQZQ1WFWjI9MdVn2/ZX3jXXkqKd4tDMPYGaemuLiCPLojhH4ICA4QBCfw/gPl
EnZNPA+KNIfCRoh4HILBBwp6C9KR29T8aFUrNTin28KqKhB8YmCHMXUOwiyX7v73
6+Mggx3gpXfawBUBSnjkcBjK9b9owM+Ief3YzP2NQPRi9cgxyrE=
=C4/y
-----END PGP SIGNATURE-----

--hmhuzdixovwn645i--
