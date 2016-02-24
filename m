From: Thorsten Glaser <t.glaser@tarent.de>
Subject: Re: heredoc and subshell
Date: Wed, 24 Feb 2016 09:46:24 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602240942580.2671@tglase-nb.lan.tarent.de>
References: <2978711456265264@web9h.yandex.ru> <20160223231843.GA55161@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from fb-n15-11.unbelievable-machine.net ([94.198.62.204]:1507 "EHLO
	tglase-nb.lan.tarent.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754486AbcBXIzY convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Wed, 24 Feb 2016 03:55:24 -0500
In-Reply-To: <20160223231843.GA55161@stack.nl>
Content-Language: de-DE-1901
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: Oleg Bulatov <oleg@bulatov.me>, dash@vger.kernel.org, miros-mksh@mirbsd.org

(Thanks to izabera for bringing this to my attention!)

On Wed, 24 Feb 2016, Jilles Tjoelker wrote:
> On Wed, Feb 24, 2016 at 01:07:44AM +0300, Oleg Bulatov wrote:

> > --- bash 4.3.42 output:

That=E2=80=99s the output I=E2=80=99d expect, from manually reading thi=
s.

> Interestingly, mksh parses this in yet another way. In unmodified for=
m,
> it fails with  here document 'XXX' unclosed.

Yeah, I noticed=E2=80=A6 yay another bug to fix (just had two last nigh=
t)=E2=80=A6

> After appending an XXX line, it outputs:

Ah okay, thanks for this hint, that should make debugging easier.

bye,
//mirabilos
--=20
Sometimes they [people] care too much: pretty printers [and syntax high=
ligh-
ting, d.A.] mechanically produce pretty output that accentuates irrelev=
ant
detail in the program, which is as sensible as putting all the preposit=
ions
in English text in bold font.	-- Rob Pike in "Notes on Programming in C=
"
