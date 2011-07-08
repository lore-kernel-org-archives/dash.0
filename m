From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Porting dash to OpenBSD
Date: Fri, 8 Jul 2011 16:58:36 +0800
Message-ID: <20110708085836.GF28449@gondor.apana.org.au>
References: <223511309054739@web103.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:52114 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352Ab1GHI6k (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 8 Jul 2011 04:58:40 -0400
Content-Disposition: inline
In-Reply-To: <223511309054739@web103.yandex.ru>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Mike Korbakov <mike-kmv@yandex.ru>
Cc: dash@vger.kernel.org

On Sun, Jun 26, 2011 at 02:18:59AM +0000, Mike Korbakov wrote:
> Hello!
>=20
> Unfortunatly,=A0not=A0all=A0systems=A0(like=A0OpenBSD)=A0has=A0built-=
in=A0texttools=A0like=A0nl,
> that=A0makes=A0it=A0difficult=A0to=A0port=A0dash,=A0with=A0minimum=A0=
troubles.

Hmm, nl is part of POSIX and dash is supposed to be a POSIX shell.

Cheers,
--=20
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
