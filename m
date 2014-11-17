From: =?utf-8?B?U3TDqXBoYW5l?= Aulery <saulery@free.fr>
Subject: Re: 'man dash' typo: "the shell .... proceed onto"
Date: Mon, 17 Nov 2014 10:33:10 +0100
Message-ID: <20141117093310.GA1889@free.fr>
References: <20141110112045.GB4185@free.fr>
 <20141117051009.GA30888@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:15170 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751636AbaKQJfI (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 17 Nov 2014 04:35:08 -0500
Content-Disposition: inline
In-Reply-To: <20141117051009.GA30888@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: 576503@bugs.debian.org
Cc: dash@vger.kernel.org

Le lundi 17 novembre 2014 =C3=A0 01:10:09, Herbert Xu a =C3=A9crit :
> St=C3=A9phane Aulery <saulery@free.fr> wrote:
> >=20
> > Here is a small patch reported by a user of Debian [1]. Could you p=
lease
> > integrate? Thank you for your help.
> >=20
> Patch applied.  However, I had to manually apply it because you did
> not generate the patch from the top of the source tree with -p1.
>=20
> Please ensure future submissions are generated correctly.

Sorry. I did the first by hand with:

$diff -u

for others:

$git-format patch -k -s -1

--=20
St=C3=A9phane Aulery
