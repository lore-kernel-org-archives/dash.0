From: =?utf-8?B?U3TDqXBoYW5l?= Aulery <saulery@free.fr>
Subject: Re: Bug#501566: dash: details of redirection/duplication in manpage
 are reversed
Date: Wed, 19 Nov 2014 00:27:19 +0100
Message-ID: <20141118232718.GA9223@free.fr>
References: <20141110111951.GA4185@free.fr>
 <20141110132409.GA8416@gondor.apana.org.au>
 <20141110134957.GA5664@free.fr>
 <CAEuPzf47pS0u+uY9-RUjOgGOuuGb6o9htY5Quu-B6dMuOVWA3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:44697 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754751AbaKRX3Q (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 18 Nov 2014 18:29:16 -0500
Content-Disposition: inline
In-Reply-To: <CAEuPzf47pS0u+uY9-RUjOgGOuuGb6o9htY5Quu-B6dMuOVWA3Q@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Stephen Shirley <diamond@nonado.net>
Cc: 501566@bugs.debian.org, dash@vger.kernel.org

Hello Stephen,

Le mardi 11 novembre 2014 =C3=A0 02:23:21, Stephen Shirley a =C3=A9crit=
 :
> On 10 November 2014 14:49, St=C3=A9phane Aulery <saulery@free.fr> wro=
te:
> > Le lundi 10 novembre 2014 =C3=A0 09:24:09, Herbert Xu a =C3=A9crit =
:
> >> St=C3=A9phane Aulery <saulery@free.fr> wrote:
> >> >
> >> > [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D501566
> >>
> >> I'm sorry but this patch looks wrong and the text looks correct
> >> to me as is.
> >
> > Ok. I passed the information but I'm not really able to judge its
> > pertinence. In this case I close this bug.
>=20
> So, i finally managed to figure out what the problem is. The wording
> is ambiguous (or maybe just insufficiently clear).
>=20
> "[n1]>&n2    Duplicate standard output (or n1) to n2."


Herbert rejected both corrections. Your new proposal is better but
incomplete. St=C3=A9phane Chazelas tried to complete it. Moreover you h=
ave
not made a new proposal for the first correction.

As I am not dash user, I do not have a good knowledge of the matter. Ca=
n
you complete your answer / choice, please?

Thank you in advance for your help.


Original version:

1)  [n1]<&n2    Duplicate standard input (or n1) from file descriptor n=
2.

2)  [n1]>&n2    Duplicate standard output (or n1) to n2.


Version on Debian bug tracker and refused by H. Xu:

1)  [n1]<&n2    Duplicate standard input (or n1) to file descriptor n2.

2)  [n1]>&n2    Duplicate standard output (or n1) from n2.


Second version of the patch refused by H. Xu:

2)  [n1]>&n2    Redirect standard output (or n1) to n2.


St=C3=A9phane Chazelas proposals:

1a) [n1]>&n2    Redirect standard output (or fd n1) to the same "open
                file description" as on fd n2.

1b) [n1]>&n2    Redirect standard output (or fd n1) to
                the same resource as open on fd n2.

1c) [n1]>&n2    Copy fd n2 as stdout (or fd n1)


Regards,

--=20
St=C3=A9phane Aulery
