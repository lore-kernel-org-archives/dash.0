From: =?utf-8?B?U3TDqXBoYW5l?= Aulery <saulery@free.fr>
Subject: Re: Bug#501566: [MAN] Clarify two redirection mechanisms
Date: Mon, 8 Dec 2014 22:22:03 +0100
Message-ID: <20141208212203.GA13333@free.fr>
References: <20141208185005.GA11773@free.fr>
 <20141208203738.GC4010@chaz.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:49348 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754390AbaLHVY4 (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 8 Dec 2014 16:24:56 -0500
Content-Disposition: inline
In-Reply-To: <20141208203738.GC4010@chaz.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Stephane CHAZELAS <stephane.chazelas@gmail.com>
Cc: 501566@bugs.debian.org, dash@vger.kernel.org

Le lundi 08 d=C3=A9cembre 2014 =C3=A0 08:37:38, Stephane CHAZELAS a =C3=
=A9crit :
> 2014-12-08 19:50:05 +0100, St=C3=A9phane Aulery:
> >>>> [n1]>&n2    Redirect standard output (or fd n1) to the same "ope=
n
> >>>>             file description" as on fd n2.
> >>>>=20
> >>>> [n1]>&n2    Copy fd n2 as stdout (or fd n1)
> >>>>=20
> >>>> [n1]>&n2    Redirect standard output (or fd n1) to the same
> >>>>             resource as currently open on fd n2.
>=20
> > >> "Resource" is rather unwieldy, how about simply "file"?
> > >
> > > "file" could be misleading
> > >
> > > [...]
> > >
> > > IMO, "resource" is vague enough so as not to give the wrong idea
> > > and I like that wording because it conveys the intended
> > > mechanism clearly ("redirect to same thing as"). But I agree
> > > it's not ideal.
> >=20
> > It is true that "resource" is dissonant as "file" is too restrictiv=
e. The
> > term "file descriptor" is used above. Why not use it again?
> [...]
>=20
> If you say redirect fd n1 to fd n2, you confuse people (and I've
> seen a lot of people being confused in such a way) as they
> start thinking the fds become somehow linked (for instance that
> in 2>&1 > file, stderr goes to stdout and then both to "file"
> which is not the case). When you start thinking of "&" as
> "/address/ of" (yet another improper wording) or "resource
> currently open on", that clears that confusion.
>=20
> If you don't like the "resource" wording, you can always got for
> the "copy" one above or the POSIX wording:
> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.h=
tml#tag_18_07_05

As for me, I'm not bothered by the word "resource". It's ok for me as
"copy". But Herbert does not agree, so I can not force him:-)).

I wonder more and more if Herbert is willing to accept this tiny patch
or another. I would not be wasting his time if he does not want or can
not take care of that. This is free software, there is no obligation.

This is my last attempt, if there is no consensus I close the bug
regarding Debian.

Have a nice day.

--=20
St=C3=A9phane Aulery
