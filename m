From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: dash: details of redirection/duplication in manpage are reversed
Date: Wed, 12 Nov 2014 10:12:04 +0800
Message-ID: <20141112021204.GA23275@gondor.apana.org.au>
References: <20141110111951.GA4185@free.fr>
 <20141110132409.GA8416@gondor.apana.org.au>
 <20141110134957.GA5664@free.fr>
 <CAEuPzf47pS0u+uY9-RUjOgGOuuGb6o9htY5Quu-B6dMuOVWA3Q@mail.gmail.com>
 <20141111150805.GA18820@gondor.apana.org.au>
 <20141111204600.GA13252@free.fr>
 <20141111204726.GA13651@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:52001 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752885AbaKLCML (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 11 Nov 2014 21:12:11 -0500
Content-Disposition: inline
In-Reply-To: <20141111204726.GA13651@free.fr>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: =?iso-8859-1?Q?St=E9phane?= Aulery <saulery@free.fr>
Cc: Stephen Shirley <diamond@nonado.net>, dash@vger.kernel.org, Stephane Chazelas <stephane.chazelas@gmail.com>

On Tue, Nov 11, 2014 at 09:47:27PM +0100, St=E9phane Aulery wrote:
> Hello,
>=20
> Le mardi 11 novembre 2014 =E0 11:08:05, Herbert Xu a =E9crit :
> > On Tue, Nov 11, 2014 at 02:23:21PM +0100, Stephen Shirley wrote:
> > >
> > > "[n1]>&n2    Redirect standard output (or n1) to n2."
> > >=20
> > > It doesn't cover the case where n2 is later changed, and how n1 d=
oes
> > > not follow this, but it's the simplest fix i see.
> >=20
> > Yes that sounds much better.  Please send a patch.
>=20
> Here is one. Stephen, the correction of the first line is abandoned?
>=20
> [n1]<&n2    Duplicate standard input (or n1) from file descriptor n2.

Please incorporate the comments by Stephane Chazelas.

Thanks,
--=20
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
