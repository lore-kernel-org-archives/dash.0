From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] man: Document ulimit -v
Date: Thu, 21 Jan 2016 13:03:23 +0800
Message-ID: <20160121050323.GA4908@gondor.apana.org.au>
References: <87fuxs5dtk.fsf@ritchie.wxcvbn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:54627 "EHLO
	helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbcAUFDd (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 21 Jan 2016 00:03:33 -0500
Content-Disposition: inline
In-Reply-To: <87fuxs5dtk.fsf@ritchie.wxcvbn.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: =?iso-8859-1?Q?J=E9r=E9mie_Courr=E8ges-Anglas?= <jca@wxcvbn.org>
Cc: gioele@svario.it, dash@vger.kernel.org

J=E9r=E9mie Courr=E8ges-Anglas <jca@wxcvbn.org> wrote:
> Gioele Barabucci <gioele@svario.it> writes:
>=20
>> Document that `ulimit` can set the `RLIMIT_AS` limit (virtual memory=
) with
>> the `-v` flag.
>=20
> I don't know much about RLIMIT_AS, but I know that it isn't supported=
 on
> all systems where dash runs, eg OpenBSD.  Maybe is it Linux-specific?
>=20
> Anyway, it would be better if the manpage said that the -v flag may n=
ot
> be implemented on all platforms.
>=20
> The same could be said about ulimit -w. (I did not check the other fl=
ags).

Rather than doing that we could just pass the manpage through
cpp or some similar mechanism so that this becomes conditional.

Cheers,
--=20
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
