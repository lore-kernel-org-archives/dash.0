From: =?utf-8?B?U3TDqXBoYW5l?= Aulery <saulery@free.fr>
Subject: Re: dash.1 - Confusion between two pages c[h]sh
Date: Tue, 11 Nov 2014 21:54:29 +0100
Message-ID: <20141111205429.GA13797@free.fr>
References: <20141110132742.GA8481@gondor.apana.org.au>
 <5460D391.2090603@gigawatt.nl>
 <20141111072046.GA15725@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:20172 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306AbaKKU4I (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 11 Nov 2014 15:56:08 -0500
Content-Disposition: inline
In-Reply-To: <20141111072046.GA15725@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org, 646847@bugs.debian.org

Le mardi 11 novembre 2014 =C3=A0 03:20:46, Herbert Xu a =C3=A9crit :
> On Mon, Nov 10, 2014 at 04:02:41PM +0100, Harald van Dijk wrote:
> >=20
> > Even if csh is intentionally in the "See also" section despite not
> > being referenced anywhere else, is it also intentional that chsh is
> > not in that section despite the earlier reference? Would a patch
> > that leaves csh but also adds chsh be more appropriate, or do you
> > prefer to leave it as it is now?
>=20
> The see also section is not meant to be an exhaustive list of
> all commands referred to in the manual.  It's meant to be a list
> of manual entries related to dash.  So no I'm not going to add
> chsh there just because there was an earlier reference.

Ok, I leave the bug open because it also relates to the numbering of
file descriptors.

Cheers,

--=20
St=C3=A9phane Aulery
