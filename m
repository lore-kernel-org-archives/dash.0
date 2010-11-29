From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] fix two compile time warnings
Date: Mon, 29 Nov 2010 15:40:35 +0800
Message-ID: <20101129074035.GA16888@gondor.apana.org.au>
References: <1287568775-2556-1-git-send-email-zenczykowski@gmail.com> <20101128125710.GC11109@gondor.apana.org.au> <AANLkTikZ3_jFLM2nHVK0f+OSzHnAbRE-iZ9NG+qH0SLa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:58703 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275Ab0K2Hkj (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 29 Nov 2010 02:40:39 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikZ3_jFLM2nHVK0f+OSzHnAbRE-iZ9NG+qH0SLa@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Maciej =?utf-8?Q?=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc: dash@vger.kernel.org, maximillian attems <max@stro.at>

On Sun, Nov 28, 2010 at 11:18:45PM -0800, Maciej =C5=BBenczykowski wrot=
e:
> > Thanks for the patch. =C2=A0I've applied the second hunk.
> >
> > As for the first, if I get annoyed enough after upgrading my gcc
> > then I'll think about it :) It's a false positive as strsignal
> > should never return anything that requires "%s".
>=20
> That's unfortunate since it prevents a -Werror build of klibc (which
> includes dash) from succeeding.

And that's precisely why I would never use -Werror with gcc.

You can always apply this patch in klibc locally.

Cheers,
--=20
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
