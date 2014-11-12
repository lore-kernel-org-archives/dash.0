From: =?utf-8?B?U3TDqXBoYW5l?= Aulery <saulery@free.fr>
Subject: Re: dash: details of redirection/duplication in manpage are reversed
Date: Wed, 12 Nov 2014 12:09:28 +0100
Message-ID: <20141112110928.GA2791@free.fr>
References: <20141110111951.GA4185@free.fr>
 <20141110132409.GA8416@gondor.apana.org.au>
 <20141110134957.GA5664@free.fr>
 <CAEuPzf47pS0u+uY9-RUjOgGOuuGb6o9htY5Quu-B6dMuOVWA3Q@mail.gmail.com>
 <20141111150805.GA18820@gondor.apana.org.au>
 <20141111204600.GA13252@free.fr>
 <20141111204726.GA13651@free.fr>
 <20141112021204.GA23275@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:1940 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750850AbaKLLLP (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 12 Nov 2014 06:11:15 -0500
Content-Disposition: inline
In-Reply-To: <20141112021204.GA23275@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Stephen Shirley <diamond@nonado.net>, dash@vger.kernel.org, Stephane Chazelas <stephane.chazelas@gmail.com>

Hello,

Le mercredi 12 novembre 2014 =C3=A0 10:12:04, Herbert Xu a =C3=A9crit :
> On Tue, Nov 11, 2014 at 09:47:27PM +0100, St=C3=A9phane Aulery wrote:
> > Le mardi 11 novembre 2014 =C3=A0 11:08:05, Herbert Xu a =C3=A9crit =
:
> > > On Tue, Nov 11, 2014 at 02:23:21PM +0100, Stephen Shirley wrote:
> > > >
> > > > "[n1]>&n2    Redirect standard output (or n1) to n2."
> > > >=20
> > >=20
> > > Yes that sounds much better.  Please send a patch.
> >=20
> > Here is one. Stephen, the correction of the first line is abandoned=
?
>=20
> Please incorporate the comments by Stephane Chazelas.

I'm not subscribed to the list, I had missed the message of Stephane
Chazelas. What proposal do you want please?

[n1]>&n2    Redirect standard output (or fd n1) to the same "open
            file description" as on fd n2.

[n1]>&n2    Redirect standard output (or fd n1) to the same
            resource as open on fd n2.

[n1]>&n2    Copy fd n2 as stdout (or fd n1)

Thanks,

--=20
St=C3=A9phane Aulery
