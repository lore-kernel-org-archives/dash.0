From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [MAN] Fix description of getopts when last argument reached
Date: Thu, 11 Jun 2015 14:34:00 +0800
Message-ID: <20150611063400.GA14777@gondor.apana.org.au>
References: <87r3pt6dag.fsf@sperrhaken.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:38556 "EHLO
	helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbbFKGeG (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 11 Jun 2015 02:34:06 -0400
Content-Disposition: inline
In-Reply-To: <87r3pt6dag.fsf@sperrhaken.name>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Felix Dietrich <felix.dietrich@sperrhaken.name>
Cc: dash@vger.kernel.org

=46elix Dietrich <felix.dietrich@sperrhaken.name> wrote:
> ---
> When I read the getopts description in the man-page I got stumped by =
the
> following part:
>=20
>    getopts optstring var
>=20
>        [..]
>=20
>        If there are no remaining arguments, getopts will set var to
>        special option, =E2=80=9C--=E2=80=9D, otherwise, it will set v=
ar to =E2=80=9C?=E2=80=9D
>=20
>        [..]
>=20
> After I was unable to get getopts to store "--" in var, I asked for h=
elp
> on comp.unix.shell [1] where it was pointed out to me that actually t=
he
> POSIX description of getopts [2] does not include a special option "-=
-";
> dash's behaviour of setting var to "?" after the last argument is
> correct and that this is most likely an error in the documention.

Patch applied.  Thanks!
--=20
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
