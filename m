From: =?utf-8?B?U3TDqXBoYW5l?= Aulery <saulery@free.fr>
Subject: dash: details of redirection/duplication in manpage are reversed
Date: Tue, 11 Nov 2014 21:46:00 +0100
Message-ID: <20141111204600.GA13252@free.fr>
References: <20141110111951.GA4185@free.fr>
 <20141110132409.GA8416@gondor.apana.org.au>
 <20141110134957.GA5664@free.fr>
 <CAEuPzf47pS0u+uY9-RUjOgGOuuGb6o9htY5Quu-B6dMuOVWA3Q@mail.gmail.com>
 <20141111150805.GA18820@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:64399 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751545AbaKKUrj (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 11 Nov 2014 15:47:39 -0500
Content-Disposition: inline
In-Reply-To: <20141111150805.GA18820@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Stephen Shirley <diamond@nonado.net>, dash@vger.kernel.org, 501566@bugs.debian.org

Hello,

Le mardi 11 novembre 2014 =C3=A0 11:08:05, Herbert Xu a =C3=A9crit :
> On Tue, Nov 11, 2014 at 02:23:21PM +0100, Stephen Shirley wrote:
> >
> > "[n1]>&n2    Redirect standard output (or n1) to n2."
> >=20
> > It doesn't cover the case where n2 is later changed, and how n1 doe=
s
> > not follow this, but it's the simplest fix i see.
>=20
> Yes that sounds much better.  Please send a patch.

Here is one. Stephen, the correction of the first line is abandoned?

[n1]<&n2    Duplicate standard input (or n1) from file descriptor n2.

Regards,

--=20
St=C3=A9phane Aulery
