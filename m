From: Thorsten Glaser <tg@mirbsd.de>
Subject: Re: test incorrectly rejecting valid expression with confusing !
 placement
Date: Mon, 26 Aug 2013 11:19:51 +0000
Message-ID: <Pine.BSM.4.64L.1308261117200.19888@herc.mirbsd.org>
References: <5218BCAD.2010107@gigawatt.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:41360 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751596Ab3HZLpH convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Mon, 26 Aug 2013 07:45:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcsd-dash@m.gmane.org>)
	id 1VDvEG-0003Yh-4i
	for dash@vger.kernel.org; Mon, 26 Aug 2013 13:45:04 +0200
Received: from static-87-79-237-121.netcologne.de ([87.79.237.121])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Mon, 26 Aug 2013 13:45:04 +0200
Received: from tg by static-87-79-237-121.netcologne.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Mon, 26 Aug 2013 13:45:04 +0200
In-Reply-To: <5218BCAD.2010107@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Harald van Dijk dixit:

>$ src/dash -c 'test ! ! =3D !'
>src/dash: 1: test: =3D: unexpected operator
>
>POSIX requires special behaviour for four-argument tests:

Right but=E2=80=A6

>There are also some cases where test gives incorrect results when
>combining ! with -o

=E2=80=A6 =E2=80=98-o=E2=80=99 is XSI, not POSIX. Do not expect=E2=80=A6

>$ src/dash -c 'test ! "" -o !'; echo $?

=E2=80=A6 this to work.

>This is covered by the special rule for four arguments, there ! as the
>first argument evaluates the remaining three-argument test and negates
>the result. In this special case, ! does not have higher precedence th=
an
>-o, so the correct exit status is 1, which bash's test gives.

Only for a shell implementing the XSI =E2=80=98-o=E2=80=99 for POSIX te=
st.
You shouldn=E2=80=99t use -o anyway as it=E2=80=99s deprecated.

bye,
//mirabilos
--=20
=46WIW, I'm quite impressed with mksh interactively. I thought it was m=
uch
*much* more bare bones. But it turns out it beats the living hell out o=
f
ksh93 in that respect. I'd even consider it for my daily use if I hadn'=
t
wasted half my life on my zsh setup. :-) -- Frank Terbeck in #!/bin/mks=
h

