From: ZelinskiyIS <ivze@bk.ru>
Subject: A probem with CTLESC, CTLQUOTEMARK and UTF-8.
Date: Mon, 07 Sep 2009 11:46:44 +0400
Message-ID: <4AA4BA64.1080405@bk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from hosting.cifracom.ru ([195.189.81.50]:57591 "EHLO
	hosting.cifracom.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbZIGH4e (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 7 Sep 2009 03:56:34 -0400
Received: from [192.168.1.10] (unknown [10.27.76.12])
	by hosting.cifracom.ru (Postfix) with ESMTP id F2B0C8B403A
	for <dash@vger.kernel.org>; Mon,  7 Sep 2009 11:46:13 +0000 (UTC)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Good day (or night)!

I am Ubuntu user, as for Jaunty 9.04 we have dash 0.5.4 installed as th=
e
default sh interpreter. Ubuntu uses multibute UTF-8 to represent local
symbols, these symbols are often to be found in file names.

I found a bug, when trying to find out why a python script, doing some
little work of converting music files, would fail on songs with Cyrilli=
c
names, containing letters =D1=81,=D1=88,=D0=81. The reason was sh in sy=
stem(...) call,
that created files with garbage in names when using "> $file_name"
redirection when $file_name contained these three letters.

=46or example, a sequence =D1=80=D1=81=D1=88=D0=81=D1=8A (byte-by-byte)
{d1 80 d1 81 d1 88 d0 81 d1 8a}
is turned into
{d1 80 d1 d1 d0 d1 8a}. Bytes hex 81 and hex 88 disappear from the file
name.

The reason for such behaviour is in expand.c:239-240 for dash 0.5.4. Th=
e
lines and bug look similar in dash 0.5.5.1, here the place is
expand.c:216-217.

The piece of code:
#######################################################################=
#
		if (flag & EXP_REDIR) /*XXX - for now, just remove escapes */
			rmescapes(p);
#######################################################################=
#
cuts bytes x81 and x88. The behaviour seems to be allways unwanted,
because according to UTF-8 specifications, x81 and x88 can not represen=
t
an individual symbol. Indeed, hex 81 =3D binary 10000001, hex 88 =3D bi=
nary
10001000; the upper two bits are 10, what means that the byte is
data-carrier and must always trail initiating byte (from
http://en.wikipedia.org/wiki/UTF-8#Description).

The problem, probably, do not occur when using a single-byte KOI8-R
encoding for Cyrillics, which is default for Debian.

I have also created a launchpad bug for Ubuntu,
https://bugs.launchpad.net/ubuntu/+source/dash/+bug/422298.

That's it, thanks for attention.
